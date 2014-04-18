//
//  ExtensionUiViewFrame.h
//  MOToolProduct
//
//  Created by Matic Oblak on 18/04/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIView(ExtensionUIViewFrame)
@property CGFloat left;
@property CGFloat right;
@property CGFloat top;
@property CGFloat bottom;

@property CGFloat width;
@property CGFloat height;
@property CGSize size;
@property (readonly) CGPoint internalCenter;
@end
