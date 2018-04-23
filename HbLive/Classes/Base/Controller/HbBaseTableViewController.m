//
//  HbBaseTableViewController.m
//  jvms
//
//  Created by 郝兵 on 2018/4/20.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "HbBaseTableViewController.h"

@interface HbBaseTableViewController ()<UITableViewDelegate,UITableViewDataSource,UITableViewEventDelegate>

@end

@implementation HbBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initViews];
    // 判断是否有上级页面，有的话再调用
    if ([self.navigationController.viewControllers indexOfObject:self] > 0) {
        [self setupLeftBarButton];
    }
}

- (void)initViews {
    // 设置应用的背景色
    self.view.backgroundColor = [UIColor lightGrayColor];
    // 不允许 viewController 自动调整，我们自己布局；如果设置为YES，视图会自动下移 64 像素
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.baseTableView = [[HbBaseTableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 64)];
    self.baseTableView.dataSource = self;
    self.baseTableView.delegate = self;
    self.baseTableView.eventDelegate = self;
    self.baseTableView.isDiyRefresh = NO;
    
    [self.view addSubview:self.baseTableView];
}

#pragma mark - 自定义返回按钮
- (void)setupLeftBarButton {
    // 自定义 leftBarButtonItem ，UIImageRenderingModeAlwaysOriginal 防止图片被渲染
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]
                                             initWithImage:[[UIImage imageNamed:@"Back-蓝"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                             style:UIBarButtonItemStylePlain
                                             target:self
                                             action:@selector(leftBarButtonClick)];
    // 防止返回手势失效
    self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

#pragma mark - 返回按钮的点击事件
- (void)leftBarButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - UITableViewDelegate
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.baseTableView.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}


/**
 *  下拉刷新
 *
 *  @param tableView 传入的tableView
 */
- (void)pullDown:(HbBaseTableView *)tableView{
    
}
/**
 *  上拉加载
 *
 *  @param tableView 传入的tableView
 */
- (void)pullUp:(HbBaseTableView *)tableView{
    
}



@end
