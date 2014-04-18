//
//  ExtensionUiViewFrame.m
//  MOToolProduct
//
//  Created by Matic Oblak on 18/04/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import "ExtensionUiViewFrame.h"

@implementation UIView(ExtensionUIViewFrame)
- (void)setLeft:(CGFloat)left {
    self.frame = CGRectMake(left, self.bottom, self.width, self.height);
}
- (CGFloat)left {
    return self.frame.origin.x;
}
- (void)setRight:(CGFloat)right {
    self.frame = CGRectMake(right-self.width, self.bottom, self.width, self.height);
}
- (CGFloat)right {
    return self.width+self.left;
}

- (void)setTop:(CGFloat)top {
    self.frame = CGRectMake(self.left, top, self.width, self.height);
}
- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setBottom:(CGFloat)bottom {
    self.frame = CGRectMake(self.left, bottom-self.height, self.width, self.height);
}
- (CGFloat)bottom {
    return self.top+self.height;
}

- (void)setWidth:(CGFloat)width {
    self.frame = CGRectMake(self.left, self.top, width, self.height);
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (void)setHeight:(CGFloat)height {
    self.frame = CGRectMake(self.left, self.top, self.width, height);
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.left, self.top, size.width, size.height);
}
- (CGSize)size {
    return self.frame.size;
}
- (CGPoint)internalCenter {
    return CGPointMake(self.width*.5f, self.height*.5f);
}
@end
