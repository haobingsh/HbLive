//
//  TJPUserView.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/16.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LiveRoomTopUserItem;
@interface UserView : UIView


+ (instancetype)userView;

@property (nonatomic, strong) LiveRoomTopUserItem *userItem;


@property (nonatomic, copy) void(^closeViewBlock)();



@end
