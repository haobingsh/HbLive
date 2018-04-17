//
//  PublicHeader.h
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#ifndef PublicHeader_h
#define PublicHeader_h

/**    尺寸类    **/
#define kScreenWidth                        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight                       [UIScreen mainScreen].bounds.size.height
#define kStatusBarHeight                    20
#define kDefaultMargin                      10
#define kNavigationBarHeight                64

#define kTagViewHeight                      20



/**    颜色     **/
#define TJPColorA(r, g, b, a)               [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
#define TJPColor(r, g, b)                   TJPColorA((r), (g), (b), 1.0)

#define kGlobalLightBlueColor               TJPColorA(0, 216, 201, 1)
#define ActionViewBgColor                   [UIColor colorWithWhite:0 alpha:0.8]

/**    通知     **/
#define kNotificationClickUser              @"kNotificationClickUser"     //点击用户



/**    文件操作     **/
#define UserDefaults                        [NSUserDefaults standardUserDefaults]
#define User_Login                          @"user_login"
#define AdImage_Name                        @"AdImage_Name"
#define AdImage_Link                        @"AdImage_Link"


#endif /* PublicHeader_h */
