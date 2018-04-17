//
//  UITabBarItem+XHExtension.m
//  NiHao
//
//  Created by Walkman on 16/6/1.
//  Copyright © 2016年 NewLineWow. All rights reserved.
//

#import "UITabBarItem+XHExtension.h"

@implementation UITabBarItem (XHExtension)
+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    [button setExclusiveTouch:YES];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[self alloc] initWithCustomView:button];
}

@end
