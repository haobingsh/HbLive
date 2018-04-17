//
//  TJPCreatorItem.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CreatorItem : NSObject
/** 主播名 */
@property (nonatomic, strong) NSString *nick;
/** 主播头像 */
@property (nonatomic, strong) NSString *portrait;
/** 映客号*/
@property (nonatomic, assign) NSUInteger ID;



@end
