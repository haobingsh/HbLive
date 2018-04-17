//
//  GiftModel.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "GiftModel.h"

@implementation GiftModel

- (instancetype)initWithSenderName:(NSString *)senderName senderIcon:(NSString *)senderIcon giftIcon:(NSString *)giftIcon giftName:(NSString *)giftName {
    if (self = [super init]) {
        _senderName = senderName;
        _senderIcon = senderIcon;
        _giftIcon = giftIcon;
        _giftName = giftName;
    }
    return self;
}

//重写系统的isEqual方法 用来判断
- (BOOL)isEqual:(id)object {
    //将object转成model
    if (![object isKindOfClass:[GiftModel class]]) {
        return NO;
    }
    GiftModel *model = (GiftModel *)object;
    //比较礼物和用户
    if ([model.senderName isEqualToString:_senderName] && [model.giftName isEqualToString:_giftName]) {
        return YES;
    }
    
    return NO;
}

@end
