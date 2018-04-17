//
//  GiftContainerView.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "GiftContainerView.h"
#import "UIView+GiftExtension.h"
#import "GiftComboView.h"
#import "GiftModel.h"

static NSInteger const galleryRoadNum = 2;   //默认栈道数量为2

@interface GiftContainerView ()
@property (nonatomic, strong) NSMutableArray <GiftComboView *>*comboViews; //做缓存用
@property (nonatomic, strong) NSMutableArray <GiftModel *>*cacheGiftModels;


@end


@implementation GiftContainerView

- (NSMutableArray<GiftComboView *> *)comboViews {
    if (!_comboViews) {
        _comboViews = [NSMutableArray array];
    }
    return _comboViews;
}

- (NSMutableArray<GiftModel *> *)cacheGiftModels {
    if (!_cacheGiftModels) {
        _cacheGiftModels = [NSMutableArray array];
    }
    return _cacheGiftModels;
}


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


#pragma mark - UI
- (void)setupUI {
    //根据栈道数 创建GiftComboView
    CGFloat viewW = self.tjp_width;
    CGFloat viewH = 40;
    CGFloat viewX = 0;
    for (int i = 0; i < galleryRoadNum; i++) {
        CGFloat viewY = (viewH + 10) * i;
        GiftComboView *comboView = [GiftComboView loadGiftComboView];
        comboView.frame = CGRectMake(viewX, viewY, viewW, viewH);
        comboView.alpha = 0.0;
        [self addSubview:comboView];
        [self.comboViews addObject:comboView];
        
        WS(weakSelf)
        [comboView setAnimationFinishedCompletion:^(GiftComboView *comboView) {
            NSLog(@"动画执行完成");
            //判断缓存中是否有数据
            NSLog(@"%@", weakSelf.cacheGiftModels);
            if (weakSelf.cacheGiftModels.count == 0) {
                return;
            }
            //取出第一条
            GiftModel *firstGiftModel = weakSelf.cacheGiftModels[0];
            [weakSelf.cacheGiftModels removeObjectAtIndex:0];
            
            //反向遍历数组  此处如果正向遍历会造成数组越界
            __block NSInteger cacheNumber = 0;
            [weakSelf.cacheGiftModels enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(GiftModel * _Nonnull obj, NSUInteger index, BOOL * _Nonnull stop) {
                GiftModel *model = weakSelf.cacheGiftModels[index];
                if ([model isEqual:firstGiftModel]) {
                    //如果缓存里的礼物有跟第一个元素同样的
                    cacheNumber += 1;
                    [weakSelf.cacheGiftModels removeObjectAtIndex:index];
                }
            }];
            
            //设置好缓存
            comboView.cacheNum = cacheNumber;
            //让comboView执行firstGiftModel的动画
            comboView.giftModel = firstGiftModel;
        }];
        
    }
}

/** 添加礼物*/
- (void)addGift:(GiftModel *)giftModel {
    NSLog(@"%@", _cacheGiftModels);
    //1.判断是否有相同的人送了相同的礼物正在执行动画
    if ([self checkoutSameGift:giftModel]) {
        GiftComboView *comboView =  [self checkoutSameGift:giftModel];
        //添加缓存
        [comboView addOnceAnimationToCache];
        return;
    }
    
    //2.判断是否有闲置的栈道用于执行动画
    if ([self checkoutIdleComboView]) {
        GiftComboView *comboView =  [self checkoutIdleComboView];
        comboView.giftModel = giftModel;
        return;
    }
    //3.将礼物添加缓存
    [self.cacheGiftModels addObject:giftModel];
    
    
    
}

#pragma mark - privite
- (GiftComboView *)checkoutSameGift:(GiftModel *)newGift { //检测同礼物同人
    
    for (GiftComboView *comboView in self.comboViews) {
        if ([newGift isEqual:comboView.giftModel] && comboView.state != GiftComboViewStateEnding) { //相同的人和相同的礼物
            return comboView;
        }
    }
    return nil;
}

- (GiftComboView *)checkoutIdleComboView { //检测闲置栈道
    for (GiftComboView *comboView in self.comboViews) {
        if (comboView.state == GiftComboViewStateIdle) {
            return comboView;
        }
    }
    return nil;
}


@end
