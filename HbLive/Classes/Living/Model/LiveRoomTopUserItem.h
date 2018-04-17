//
//  LiveRoomTopUserItem.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LiveRoomTopUserItem : NSObject

@property (nonatomic, copy) NSString *birth;
@property (nonatomic, copy) NSString *Description;
@property (nonatomic, copy) NSString *emotion;
@property (nonatomic, assign) NSUInteger gender;
@property (nonatomic, assign) NSUInteger gmutex;
@property (nonatomic, copy) NSString *hometown;

@property (nonatomic, assign) NSUInteger ID;
@property (nonatomic, assign) NSUInteger inke_verify;
@property (nonatomic, assign) NSUInteger level;
@property (nonatomic, copy) NSString *location;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *portrait;

@property (nonatomic, copy) NSString *profession;
@property (nonatomic, assign) NSUInteger rank_veri;
@property (nonatomic, assign) NSUInteger sex;
@property (nonatomic, assign) NSUInteger third_platform;
@property (nonatomic, copy) NSString *veri_info;

@end

/*
 "birth" : "2015-11-21",
 "description" : "有时候最好的安慰就是无言的陪伴",
 "emotion" : "",
 "gender" : 0,
 "gmutex" : 0,
 "hometown" : "&",
 "id" : 69755198,
 "inke_verify" : 0,
 "level" : 29,
 "location" : "成都市",
 "nick" : "娜星人的世界你不懂",
 "portrait" : "http://img2.inke.cn/MTQ4MTAzNDMwOTEyMCM2NzgjanBn.jpg",
 "profession" : "无业游民",
 "rank_veri" : 5,
 "sex" : 0,
 "third_platform" : "0",
 "veri_info" : "小公举",
 "verified" : 0,
 "verified_reason" : ""
 
 */

