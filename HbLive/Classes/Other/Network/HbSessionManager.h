//
//  TJPSessionManager.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/9.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum{
    
    RequestTypeGet,
    RequestTypePost
    
}RequestType;

@interface HbSessionManager : NSObject


- (void)request:(RequestType)requestType urlStr:(NSString *)urlStr parameter:(NSDictionary *)param resultBlock:(void(^)(id responseObject, NSError *error))resultBlock;


@end
