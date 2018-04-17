//
//  GiftCollectionViewCell.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "GiftCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "GiftItem.h"

@interface GiftCollectionViewCell ()

@property (nonatomic, weak) UILabel *titleLab;
@property (nonatomic, weak) UIImageView *giftImageView;


@end

@implementation GiftCollectionViewCell

- (UILabel *)titleLab {
    if (!_titleLab) {
        UILabel *titleLab = [[UILabel alloc] initWithFrame:CGRectMake(15, _giftImageView.tjp_bottom + kDefaultMargin, self.tjp_width - 30, 15)];
        //        titleLab.backgroundColor = TJPColor(170, 170, 170);
        titleLab.textColor = [UIColor whiteColor];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
    }
    return _titleLab;
}

- (UIImageView *)giftImageView {
    if (!_giftImageView) {
        UIImageView *giftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.tjp_width * 0.5, self.tjp_height * 0.5)];
        giftImageView.center = CGPointMake(self.center.x, self.center.y - 10);
        [self.contentView addSubview:giftImageView];
        _giftImageView = giftImageView;
    }
    return _giftImageView;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = [UIColor clearColor];
    [self giftImageView];
    [self titleLab];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    
    // 设置collectionView cell的边框
    //    self.layer.cornerRadius = 4;
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = TJPColor(255, 202, 0).CGColor;
    self.layer.masksToBounds = YES;
}


- (void)setGiftItem:(GiftItem *)giftItem {
    _giftItem = giftItem;
    
    NSString *urlStr;
    if ([giftItem.image hasPrefix:@"http://"]) {
        urlStr = giftItem.image;
    }else {
        urlStr = [NSString stringWithFormat:@"%@%@", kCommonServiceAPI, giftItem.image];
    }
    TJPLog(@"%@", urlStr);
    [_giftImageView sd_setImageWithURL:[NSURL URLWithString:urlStr]];
    _titleLab.text = giftItem.name;
}


@end
