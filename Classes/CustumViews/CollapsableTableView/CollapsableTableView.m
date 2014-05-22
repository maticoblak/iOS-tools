#import "CollapsableTableView.h"

@interface CollapsableTableView() {
    UITableView *_tableView;
    NSMutableArray *_headers;
}
@property (readonly) NSMutableArray *headers;
@end
@interface CollapsableTableViewHeader() {
    BOOL _collapsed;
    NSInteger _index;
}
@property (weak) CollapsableTableView *owner;
- (void)setCollapsed:(BOOL)collapsed;
- (void)setIndex:(NSInteger)index;
@end


////////////////////////////////////////////////////////
///           ---CollapsableTableView---
///
///
#pragma mark - CollapsableTableView
////////////////////////////////////////////////////////
@implementation CollapsableTableView
///////////////////////////////////////////////////
///       Initializers
#pragma mark Initializers
///////////////////////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(.0f, .0f, frame.size.width, frame.size.height) style:UITableViewStyleGrouped];
        _tableView.sectionHeaderHeight = 0.0;
        _tableView.sectionFooterHeight = 0.0;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [self addSubview:_tableView];
    }
    return self;
}
///////////////////////////////////////////////////
///       Handles
#pragma mark Handles
///////////////////////////////////////////////////
- (void)reload {
    [self.headers removeAllObjects];
    NSInteger count = [self.dataSource headerCountForCollapsableTableView:self];
    for(int i=0; i<count; i++) {
        [_headers addObject:[self.dataSource collapsableTable:self headerForIndex:i]];
    }
    [_tableView reloadData];
}
- (void)openAll {
    for(CollapsableTableViewHeader *header in self.headers) {
        [header setCollapsed:NO];
    }
    [_tableView reloadData];
}
- (void)collapseAll {
    for(CollapsableTableViewHeader *header in self.headers) {
        [header setCollapsed:YES];
    }
    [_tableView reloadData];
}
- (void)openAtIndex:(NSInteger)index {
    CollapsableTableViewHeader *header = [self _headerForIndex:index];
    if(header.boundView == nil) return;
    [_tableView beginUpdates];
    [header setCollapsed:NO];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:index]] withRowAnimation:UITableViewRowAnimationMiddle];
    [_tableView endUpdates];
}
- (void)collapseAtIndex:(NSInteger)index {
    CollapsableTableViewHeader *header = [self _headerForIndex:index];
    if(header.boundView == nil) return;
    [_tableView beginUpdates];
    [header setCollapsed:YES];
    [_tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:index]] withRowAnimation:UITableViewRowAnimationMiddle];
    [_tableView endUpdates];
}
- (void)insertHeader:(CollapsableTableViewHeader *)header atIndex:(NSInteger)index {
    if(header == nil) return;
    if(index < 0) index = 0;
    if(index > self.headers.count) index = self.headers.count;
    [_tableView beginUpdates];
    [self.headers insertObject:header atIndex:index];
    [_tableView insertSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationRight];
    [_tableView endUpdates];
}
- (void)removeHeaderAtIndex:(NSInteger)index {
    if(self.headers.count < 1) return;
    if(index < 0) index = 0;
    if(index > self.headers.count-1) index = self.headers.count;
    [_tableView beginUpdates];
    [self.headers removeObjectAtIndex:index];
    [_tableView deleteSections:[NSIndexSet indexSetWithIndex:index] withRowAnimation:UITableViewRowAnimationLeft];
    [_tableView endUpdates];
}
- (void)refreshItemAtIndex:(NSInteger)index {
    CollapsableTableViewHeader *header = [self _headerForIndex:index];
    if(header.collapsed || header.boundView == nil) return;
    [_tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:0 inSection:index]] withRowAnimation:UITableViewRowAnimationMiddle];
}
- (CollapsableTableViewHeader *)headerForIndex:(NSInteger)index {
    return (index<0||index>=self.headers.count)?nil:self.headers[index];
}
///////////////////////////////////////////////////
///       Protocol
#pragma mark Protocol
///////////////////////////////////////////////////
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.headers.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return [self _headerForIndex:section].frame.size.height;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    CollapsableTableViewHeader *header = [self _headerForIndex:section];
    header.owner = self;
    return header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CollapsableTableViewHeader *header = [self _headerForIndex:section];
    return (header==nil || header.collapsed || header.boundView == nil)?0:1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollapsableTableViewHeader *header = [self _headerForIndex:indexPath.section];
    return (header==nil || header.collapsed || header.boundView == nil)?.0f:header.boundView.frame.size.height;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CollapsableTableViewHeader *header = [self _headerForIndex:indexPath.section];
    UITableViewCell *toReturn = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    if(header.boundView)[toReturn addSubview:header.boundView];
    toReturn.selectionStyle = UITableViewCellSelectionStyleNone;
    return toReturn;
}
///////////////////////////////////////////////////
///       Internal
#pragma mark Internal
///////////////////////////////////////////////////
- (NSMutableArray *)headers {
    if(_headers == nil) {
        _headers = [[NSMutableArray alloc] init];
    }
    return _headers;
}
- (CollapsableTableViewHeader *)_headerForIndex:(NSInteger)index {
    if(index < self.headers.count && index >= 0) {
        CollapsableTableViewHeader *header = self.headers[index];
        header.index = index;
        return header;
    }
    return nil;
}
@end
////////////////////////////////////////////////////////
///           ---CollapsableTableViewHeader---
///
///
#pragma mark - CollapsableTableViewHeader
////////////////////////////////////////////////////////
@implementation CollapsableTableViewHeader
///////////////////////////////////////////////////
///       Initializers
#pragma mark Initializers
///////////////////////////////////////////////////
- (instancetype)initWithFrame:(CGRect)frame {
    if((self = [super initWithFrame:frame])) {
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(toggleCollapsed:)]];
    }
    return self;
}
///////////////////////////////////////////////////
///       Handles
#pragma mark Handles
///////////////////////////////////////////////////
- (BOOL)collapsed {
    return _collapsed;
}
- (NSInteger)index {
    return _index;
}
///////////////////////////////////////////////////
///       Internal
#pragma mark Internal
///////////////////////////////////////////////////
- (void)setIndex:(NSInteger)index {
    _index = index;
}
- (void)setCollapsed:(BOOL)collapsed {
    _collapsed = collapsed;
    if(self.owner.delegate && [self.owner.delegate respondsToSelector:@selector(collapsableTableView:setHeader:collapsed:)]) {
        [self.owner.delegate collapsableTableView:self.owner setHeader:self collapsed:collapsed];
    }
}
- (void)toggleCollapsed:(id)sender {
    if(self.owner.delegate && [self.owner.delegate respondsToSelector:@selector(collapsableTableView:selectedHeader:)]) {
        [self.owner.delegate collapsableTableView:self.owner selectedHeader:self];
    }
    if(self.boundView == nil) return;
    if(self.collapsed) {
        [self.owner openAtIndex:self.index];
    }
    else {
        [self.owner collapseAtIndex:self.index];
    }
}
@end