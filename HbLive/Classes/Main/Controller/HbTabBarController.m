//
//  HbTabBarController.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "HbTabBarController.h"
//#import "TJPCameraLivingController.h"
#import "HbNavigationController.h"

#import "UIImage+TJPImage.h"
#import "HbTabBar.h"

@interface HbTabBarController ()

@end

@implementation HbTabBarController

+ (instancetype)shareInstance
{
    static HbTabBarController *tabBarC;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tabBarC = [[HbTabBarController alloc] init];
    });
    return tabBarC;
}

+ (instancetype)tabBarControllerWitnAddChildVCBlock:(void (^)(HbTabBarController *))addVCBlock
{
    HbTabBarController *tabBarVC = [[HbTabBarController alloc] init];
    if (addVCBlock) {
        addVCBlock(tabBarVC);
    }
    return tabBarVC;
}


- (void)addChildVC:(UIViewController *)vc normalImageName:(NSString *)normalImageName selectedImageName:(NSString *)selectedImageName isRequiredNavController:(BOOL)isRequired
{
    if (isRequired) {
        HbNavigationController *nav = [[HbNavigationController alloc] initWithRootViewController:vc];
        nav.tabBarItem = [[UITabBarItem alloc] initWithTitle:nil image:[UIImage originImageWithName:normalImageName] selectedImage:[UIImage originImageWithName:selectedImageName]];
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 0, -5, 0);
        
        [self addChildViewController:nav];
    }else {
        [self addChildViewController:vc];
    }
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTabBar];
}

- (void)setupTabBar
{
    HbTabBar *tabbar = [[HbTabBar alloc] init];
    [self setValue:tabbar forKey:@"tabBar"];
    [tabbar setCenterBtnClickBlock:^{
        //[self presentViewController:[TJPCameraLivingController new] animated:YES completion:nil];
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
