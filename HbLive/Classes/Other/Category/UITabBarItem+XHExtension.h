//
//  UITabBarItem+XHExtension.h
//  NiHao
//
//  Created by Walkman on 16/6/1.
//  Copyright © 2016年 NewLineWow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITabBarItem (XHExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action;

@end
