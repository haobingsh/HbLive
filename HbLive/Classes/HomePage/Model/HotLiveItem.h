//
//  TJPHotLiveItem.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CreatorItem;
@class ExtraItem;
@interface HotLiveItem : NSObject


/** 直播流地址 */
//@property (nonatomic, copy) NSString *stream_addr;
/** 分享地址*/
//@property (nonatomic, copy) NSString *share_addr;
/** 观看人数 */
//@property (nonatomic, assign) NSUInteger online_users;
/** 城市 */
//@property (nonatomic, copy) NSString *city;
/** ID号*/
//@property (nonatomic, assign) NSUInteger ID;
/** 主播信息 */
//@property (nonatomic, strong) CreatorItem *creator;
/** 扩展属性*/
//@property (nonatomic, strong) ExtraItem *extra;

/** 直播间名称*/
//@property (nonatomic, copy) NSString *name;


@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *portrait;
@property (nonatomic, copy) NSString *nick;
@property (nonatomic, copy) NSString *liveid;
@property (nonatomic, assign) NSUInteger online_users;


/*
 {
 "city" : "伦敦",
 "creator" : {
 "gender" : 0,
 "id" : 116569346,
 "level" : 80,
 "nick" : "敏儿姐姐💤",
 "portrait" : "http://img2.inke.cn/MTQ4ODUwNDMxNjc5NiMxMzcjanBn.jpg"
 },
 "extra" : {
 "cover" : null,
 "label" : [
 {
 "cl" : [
 0,
 216,
 201,
 1
 ],
 "tab_key" : "气质",
 "tab_name" : "气质"
 },
 {
 "cl" : [
 0,
 216,
 201,
 1
 ],
 "tab_key" : "清纯",
 "tab_name" : "清纯"
 },
 {
 "cl" : [
 0,
 216,
 201,
 1
 ],
 "tab_key" : "活泼开朗",
 "tab_name" : "活泼开朗"
 },
 {
 "cl" : [
 0,
 216,
 201,
 1
 ],
 "tab_key" : "伦敦",
 "tab_name" : "伦敦"
 }
 ]
 },
 "group" : 0,
 "id" : "1488649302699851",
 "landscape" : 0,
 "link" : 0,
 "live_type" : "",
 "multi" : 0,
 "name" : "",
 "online_users" : 11619,
 "optimal" : 0,
 "rotate" : 0,
 "share_addr" : "http://mlive9.inke.cn/share/live.html?uid=116569346&liveid=1488649302699851&ctime=1488649302",
 "slot" : 3,
 "stream_addr" : "http://pull99.a8.com/live/1488649302699851.flv",
 "version" : 0
 }, */

@end
