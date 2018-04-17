//
//  GiftModel.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GiftModel : NSObject

@property (nonatomic, copy) NSString *senderName;
@property (nonatomic, copy) NSString *senderIcon;
@property (nonatomic, copy) NSString *giftIcon;
@property (nonatomic, copy) NSString *giftName;



- (instancetype)initWithSenderName:(NSString *)senderName senderIcon:(NSString *)senderIcon giftIcon:(NSString *)giftIcon giftName:(NSString *)giftName;

@end
