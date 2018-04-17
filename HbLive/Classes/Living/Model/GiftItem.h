//
//  GiftItem.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftItem : NSObject


@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger gold;
@property (nonatomic, strong) NSArray *cl;
@property (nonatomic, strong) NSArray *gift_icon_id;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, assign) NSUInteger dyna;
@property (nonatomic, assign) NSUInteger exp;
@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, copy) NSString *icon;

@end

/*
 "name": "樱花雨",
 "gold": 1,
 "cl": [
 255,
 255,
 255
 ],
 "gift_icon_id": [
 100
 ],
 "image": "OTc4MzYxNDUxODkzMDk4.jpg",
 "dyna": 0,
 "exp": 10,
 "type": 1,
 "id": 131,
 "icon": "NTg4MzMxNDUxODkzMDkw.jpg"
 },
 */
