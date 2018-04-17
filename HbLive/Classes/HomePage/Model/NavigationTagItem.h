//
//  TJPNavigationTagItem.h
//  TJPYingKe
//
//  Created by Walkman on 2017/3/3.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationTagItem : NSObject
@property (nonatomic, assign) NSInteger offline_time;
@property (nonatomic, copy) NSString *selected;
@property (nonatomic, copy) NSString *sort;
@property (nonatomic, copy) NSString *tab_id;
@property (nonatomic, copy) NSString *tab_key;
@property (nonatomic, copy) NSString *tab_title;


@end
