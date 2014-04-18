//
//  CollapsableTableView.h
//  MOToolProduct
//
//  Created by Matic Oblak on 18/04/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import <Foundation/Foundation.h>


@class CollapsableTableView;
@class CollapsableTableViewHeader;

@protocol CollapsableTableViewProtocol <NSObject>
- (NSInteger)headerCountForCollapsableTableView:(CollapsableTableView *)sender;
- (CollapsableTableViewHeader *)collapsableTable:(CollapsableTableView *)sender headerForIndex:(NSInteger)index;
@end
@protocol CollapsableTableViewItemProtocol <NSObject>
@optional
- (void)collapsableTableView:(CollapsableTableView *)sender selectedHeader:(CollapsableTableViewHeader *)header;
- (void)collapsableTableView:(CollapsableTableView *)sender setHeader:(CollapsableTableViewHeader *)header collapsed:(BOOL)collapsed;
@end

////////////////////////////////////////////////////////
///           ---CollapsableTableView---
///
///
#pragma mark - CollapsableTableView
////////////////////////////////////////////////////////
@interface CollapsableTableView : UIView<
UITableViewDataSource,
UITableViewDelegate
> {
}
@property (readonly) UITableView *tableView;
@property BOOL exclusiveOpen;
@property (weak) id<CollapsableTableViewProtocol> dataSource;
@property (weak) id<CollapsableTableViewItemProtocol> delegate;
- (void)openAll;
- (void)collapseAll;
- (void)openAtIndex:(NSInteger)index;
- (void)collapseAtIndex:(NSInteger)index;
- (void)reload;
- (void)insertHeader:(CollapsableTableViewHeader *)header atIndex:(NSInteger)index;
- (void)removeHeaderAtIndex:(NSInteger)index;
- (void)refreshItemAtIndex:(NSInteger)index;
@end
////////////////////////////////////////////////////////
///           ---CollapsableTableViewHeader---
///
///
#pragma mark - CollapsableTableViewHeader
////////////////////////////////////////////////////////
@interface CollapsableTableViewHeader : UIView {
}
@property (strong) UIView *boundView;
@property (readonly) BOOL collapsed;
@property (readonly) NSInteger index;
@end
