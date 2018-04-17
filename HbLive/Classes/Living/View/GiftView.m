//
//  GiftView.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "GiftView.h"
#import "GiftItem.h"
#import "GiftCollectionViewFlowLayout.h"
#import "GiftCollectionViewCell.h"

#define SCREENW [UIScreen mainScreen].bounds.size.width
#define SCREENH [UIScreen mainScreen].bounds.size.height
#define SCREEN_SCALE ([ UIScreen mainScreen ].bounds.size.width/320)

static const CGFloat kGiftView_H =  265;
static const NSTimeInterval duration = 0.25;
static NSString * const giftCollectionViewCell = @"giftCollectionViewCell";

@interface GiftView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, weak) UIView * actionSheetView;
@property (nonatomic, weak) UICollectionView *giftCollectionView;
@property (nonatomic, weak) UIButton *sendBtn;


@end

@implementation GiftView

#pragma mark - lazy
- (UIView *)actionSheetView {
    if (!_actionSheetView) {
        UIView *actionSheetView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kGiftView_H)];
        actionSheetView.userInteractionEnabled = YES;
        actionSheetView.backgroundColor = ActionViewBgColor;
        [self addSubview:actionSheetView];
        _actionSheetView = actionSheetView;
    }
    return _actionSheetView;
}

- (UICollectionView *)giftCollectionView {
    if (!_giftCollectionView) {
        GiftCollectionViewFlowLayout *layout = [[GiftCollectionViewFlowLayout alloc] init];
        //设置item尺寸
        CGFloat itemW = kScreenWidth * 0.253;
        layout.headerReferenceSize = CGSizeMake(1, 1);
        layout.itemSize = CGSizeMake(itemW,itemW + 20);
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        UICollectionView *giftCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kGiftView_H - kDefaultMargin * 3) collectionViewLayout:layout];
        [giftCollectionView registerClass:[GiftCollectionViewCell class] forCellWithReuseIdentifier:giftCollectionViewCell];
        giftCollectionView.showsVerticalScrollIndicator = NO;
        giftCollectionView.showsHorizontalScrollIndicator = NO;
        giftCollectionView.pagingEnabled = YES;
        giftCollectionView.dataSource = self;
        giftCollectionView.delegate = self;
        giftCollectionView.backgroundColor = [UIColor clearColor];
        
        [giftCollectionView registerClass:[GiftCollectionViewCell class]
               forCellWithReuseIdentifier:giftCollectionViewCell];
        [self.actionSheetView addSubview:giftCollectionView];
        _giftCollectionView = giftCollectionView;
    }
    return _giftCollectionView;
}

- (UIButton *)sendBtn {
    if (!_sendBtn) {
        UIButton *sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        sendBtn.frame = CGRectMake(kScreenWidth - 75, _giftCollectionView.tjp_bottom + 4, 70, 22);
        [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
        sendBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [sendBtn setBackgroundColor:kGlobalLightBlueColor];
        sendBtn.layer.cornerRadius = sendBtn.tjp_height * 0.5;
        [self.actionSheetView addSubview:sendBtn];
        _sendBtn = sendBtn;
    }
    return _sendBtn;
}

#pragma mark - instancetype
+ (instancetype)giftViewWithFrame:(CGRect)frame {
    GiftView *giftView = [[GiftView alloc] initWithFrame:frame];
    return giftView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initialization];
    }
    return self;
}


- (void)initialization {
    //背景视图层
    self.backgroundColor = [UIColor clearColor];
    self.userInteractionEnabled = YES;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    [self topView];
    
    [self actionSheetView];
    [self giftCollectionView];
    
    [self sendBtn];
    
}

- (void)topView {
    UIView * topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kGiftView_H)];
    topView.userInteractionEnabled = YES;
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel)];
    [topView addGestureRecognizer:tapGesture];
    [self addSubview:topView];
}

#pragma mark - method
- (void)setGiftData:(NSMutableArray<GiftItem *> *)giftData {
    _giftData = giftData;
    
    [self.giftCollectionView reloadData];
}

- (void)actionSheetViewShow {
    [UIView animateWithDuration:duration animations:^{
        _actionSheetView.tjp_y = kScreenHeight - kGiftView_H;
    }];
    
}



#pragma - mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _giftData.count;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:giftCollectionViewCell forIndexPath:indexPath];
    cell.giftItem = [_giftData objectAtIndexChecked:indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GiftItem *giftItem = _giftData[indexPath.row];
    NSString *urlStr;
    if ([giftItem.image hasPrefix:@"http://"]) {
        urlStr = giftItem.image;
    }else {
        urlStr = [NSString stringWithFormat:@"%@%@", kCommonServiceAPI, giftItem.image];
    }
    
    if (self.sendGiftBlock) {
        self.sendGiftBlock(@"Adobe", giftItem.name, urlStr);
    }
}



#pragma mark - UITapGestureRecognizer
- (void)tappedCancel {
    [UIView animateWithDuration:duration animations:^{
        _actionSheetView.tjp_y = kScreenHeight;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            [self removeFromSuperview];
        }
    }];
}


@end
