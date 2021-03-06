#import <Foundation/Foundation.h>

////////////////////////////////////////////////////////
///           ---ViewPositionTrace---
///
///
#pragma mark - ViewPositionTrace
////////////////////////////////////////////////////////
@interface ViewPositionTrace : NSObject {
    CGPoint *_buffer;
    NSTimeInterval *_intervals;
    NSInteger _internalBufferSize;
    NSInteger _pointCount;
}
@property NSInteger maximumBufferSize;
@property (readonly) CGFloat traceLength;
@property (readonly) CGPoint traceSpeed;
@property (readonly) CGPoint swipeDirection;
@property CGFloat swipeTrashold;
- (void)begin:(CGPoint)point;
- (void)push:(CGPoint)point;
- (void)end:(CGPoint)point;
@end
