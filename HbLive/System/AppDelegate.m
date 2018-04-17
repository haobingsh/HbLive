//
//  AppDelegate.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/12.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "AppDelegate.h"
#import "HomePageViewController.h"
#import "LoginViewController.h"
#import "MineViewController.h"
#import "HbTabBarController.h"
#import "AdvertiseView.h"
#import "HbTabBarController.h"


@interface AppDelegate ()


@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    //设置按钮的排他性
    [[UIButton appearance] setExclusiveTouch:YES];
    
    
    if (![UserHelper isLogin]) {
        [self loginViewControllerShow];
    }else {
        [self homePageViewControllerShow];
    }
    
    [self.window makeKeyAndVisible];
    
    //广告
    AdvertiseView *advertiseView = [AdvertiseView AdvertiseViewWithType:AdvertiseViewTypeFullScreen];
    //    advertiseView.localImageName = @"defaultAd.jpg";   //本地图片
    [self.window addSubview:advertiseView];
    //    [advertiseView cleanAdvertiseImageCache];
    [advertiseView advertiseShow];
    advertiseView.clickBlock = ^(NSString *link) {
        TJPLog(@"广告链接:%@", link);
    };
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/** 主页*/
- (void)homePageViewControllerShow {
    HbTabBarController *rootVC = [HbTabBarController tabBarControllerWitnAddChildVCBlock:^(HbTabBarController *tabBarVC) {
        [tabBarVC addChildVC:[[HomePageViewController alloc] init] normalImageName:@"tab_live" selectedImageName:@"tab_live_p" isRequiredNavController:YES];
        [tabBarVC addChildVC:[[MineViewController alloc] init] normalImageName:@"tab_me" selectedImageName:@"tab_me_p" isRequiredNavController:YES];
    }];
    
    self.window.rootViewController = rootVC;
}

/** 登录*/
- (void)loginViewControllerShow {
    LoginViewController *loginVC = [LoginViewController new];
    self.window.rootViewController = loginVC;
}


@end
