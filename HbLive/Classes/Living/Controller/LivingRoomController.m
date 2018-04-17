//
//  LivingRoomController.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "LivingRoomController.h"
#import "HbNavigationController.h"
#import "LiveRoomFlowLayout.h"
#import "LivingRoomCell.h"
#import "UserView.h"

static CGFloat const kDurationTime = 0.25;

@interface LivingRoomController ()

@property (nonatomic, weak) UserView *userView;


@end

@implementation LivingRoomController

static NSString * const CellID = @"LiveRoomCell";


- (instancetype)init
{
    return [super initWithCollectionViewLayout:[[LiveRoomFlowLayout alloc] init]];
}


#pragma mark - lazy
- (UserView *)userView {
    if (!_userView) {
        UserView *userView = [UserView userView];
        userView.hidden = YES;
        userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [self.view addSubview:userView];
        _userView = userView;
        WS(weakSelf)
        [userView setCloseViewBlock:^{
            [UIView animateWithDuration:kDurationTime animations:^{
                weakSelf.userView.hidden = YES;
                weakSelf.userView.transform = CGAffineTransformMakeScale(0.01, 0.01);
            } completion:nil];
        }];
        
    }
    return _userView;
}




#pragma mark - 生命周期
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    HbNavigationController *nav = (HbNavigationController *)self.navigationController;
    [nav setupBackPanGestureIsForbiddden:YES];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[LivingRoomCell class] forCellWithReuseIdentifier:CellID];
    //添加通知
    [self addObserve];
    
}


#pragma mark <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LivingRoomCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellID forIndexPath:indexPath];
    cell.parentVc = self;
    cell.liveItem = self.liveDatas[self.currentIndex];
    
    return cell;
}



#pragma mark - 通知相关
- (void)addObserve {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(clickUser:) name:kNotificationClickUser object:nil];
    
}


- (void)clickUser:(NSNotification *)notification {
    
    if (notification.userInfo[@"info"]) {
        LiveRoomTopUserItem *userItem = notification.userInfo[@"info"];
        self.userView.userItem = userItem;
        [UIView animateWithDuration:kDurationTime animations:^{
            self.userView.hidden = NO;
            self.userView.transform = CGAffineTransformIdentity;
        }];
    }
}


- (void)removeObserve {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


#pragma mark - 布局
- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    [self.userView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.offset(302);
        make.height.offset(410);
    }];
}



- (void)dealloc {
    [self removeObserve];
}

@end
