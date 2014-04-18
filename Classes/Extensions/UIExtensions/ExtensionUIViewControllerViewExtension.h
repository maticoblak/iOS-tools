//
//  ExtensionUIViewControllerViewExtension.h
//  MOToolProduct
//
//  Created by Matic Oblak on 18/04/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ExtensionUiViewFrame.h"

@interface UIViewController(ExtensionUIViewControllerViewExtension)
@property CGFloat left;
@property CGFloat right;
@property CGFloat top;
@property CGFloat bottom;

@property CGFloat width;
@property CGFloat height;
@property CGSize size;
@property (readonly) CGPoint internalCenter;

- (void)addSubview:(UIView *)subview;
@end
