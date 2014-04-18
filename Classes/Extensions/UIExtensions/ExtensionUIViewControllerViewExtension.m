//
//  ExtensionUIViewControllerViewExtension.m
//  MOToolProduct
//
//  Created by Matic Oblak on 18/04/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import "ExtensionUIViewControllerViewExtension.h"

@implementation UIViewController(ExtensionUIViewControllerViewExtension)
- (void)setLeft:(CGFloat)left {
    self.view.left = left;
}
- (CGFloat)left {
    return self.view.left;
}
- (void)setRight:(CGFloat)right {
    self.view.right = right;
}
- (CGFloat)right {
    return self.view.right;
}

- (void)setTop:(CGFloat)top {
    self.view.top = top;
}
- (CGFloat)top {
    return self.view.top;
}

- (void)setBottom:(CGFloat)bottom {
    self.view.bottom = bottom;
}
- (CGFloat)bottom {
    return self.view.bottom;
}

- (void)setWidth:(CGFloat)width {
    self.view.width = width;
}
- (CGFloat)width {
    return self.view.width;
}
- (void)setHeight:(CGFloat)height {
    self.view.height = height;
}
- (CGFloat)height {
    return self.view.height;
}
- (void)setSize:(CGSize)size {
    self.view.size = size;
}
- (CGSize)size {
    return self.view.size;
}
- (CGPoint)internalCenter {
    return self.view.internalCenter;
}

- (void)addSubview:(UIView *)subview {
    [self.view addSubview:subview];
}
@end
