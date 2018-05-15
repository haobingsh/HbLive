//
//  HbNavigationController.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/16.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "HbNavigationController.h"
#import "HbNavigationBar.h"

@interface HbNavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation HbNavigationController
{
    BOOL _isForbidden;
}

- (instancetype)initWithRootViewController:(UIViewController *)rootViewController
{
    if (self = [super initWithRootViewController:rootViewController]) {
        [self setValue:[HbNavigationBar new] forKey:@"navigationBar"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBackPanGestureIsForbiddden:NO];
    
    self.navigationBar.translucent = NO;
    [HbNavigationBar setGlobalBarTintColor:kGlobalLightBlueColor];
    [HbNavigationBar setGlobalTextColor:[UIColor whiteColor] andFontSize:17.0f];
    
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    //更新状态栏风格
    [self setNeedsStatusBarAppearanceUpdate];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

//返回状态栏风格
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)setupBackPanGestureIsForbiddden:(BOOL)isForBidden {
    _isForbidden = isForBidden;
    //设置手势代理
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    // 自定义手势 手势加在谁身上, 手势执行谁的什么方法
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:gesture.delegate action:NSSelectorFromString(@"handleNavigationTransition:")];
    //为控制器的容器视图
    [gesture.view addGestureRecognizer:panGesture];
    
    gesture.delaysTouchesBegan = YES;
    panGesture.delegate = self;
    
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    //需要过滤根控制器   如果根控制器也要返回手势有效, 就会造成假死状态
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        
        if (self.childViewControllers.count == 1 ) {
            return NO;
        }
        
        if (_isForbidden) {
            return NO;
        }
        
        if (self.interactivePopGestureRecognizer &&
            [[self.interactivePopGestureRecognizer.view gestureRecognizers] containsObject:gestureRecognizer]) {
            
            CGPoint tPoint = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
            
            if (tPoint.x >= 0) {
                CGFloat y = fabs(tPoint.y);
                CGFloat x = fabs(tPoint.x);
                CGFloat af = 30.0f/180.0f * M_PI;
                CGFloat tf = tanf(af);
                if ((y/x) <= tf) {
                    return YES;
                }
                return NO;
                
            }else{
                return NO;
            }
        }
    }
    
    return YES;
    
}

#pragma mark - 重写父类方法拦截push方法
- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //判断是否为第一层控制器
    if (self.childViewControllers.count > 0) { //如果push进来的不是第一个控制器
        UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [backButton setImage:[UIImage imageNamed:@"title_button_back"] forState:UIControlStateNormal];
        [backButton addTarget:self action:@selector(leftBarButtonItemClicked) forControlEvents:UIControlEventTouchUpInside];
        [backButton sizeToFit];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        
        //当push的时候 隐藏tabbar
        viewController.hidesBottomBarWhenPushed = YES;
    }
    //先设置leftItem  再push进去 之后会调用viewdidLoad  用意在于vc可以覆盖上面设置的方法
    [super pushViewController:viewController animated:animated];
}


- (void)leftBarButtonItemClicked
{
    [self popViewControllerAnimated:YES];
}



@end
