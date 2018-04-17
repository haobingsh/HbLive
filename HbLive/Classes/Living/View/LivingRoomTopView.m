//
//  LivingRoomTopView.m
//  HbLive
//
//  Created by 郝兵 on 2018/4/17.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "LivingRoomTopView.h"
#import "LiveRoomTopUserItem.h"
#import "HotLiveItem.h"
#import "CreatorItem.h"

static CGFloat BgViewH = 34;
static CGFloat AttentionBtnH = 23;
static CGFloat TicketBgViewH = 23;
static CGFloat ScrollViewMargin = 20;
static CGFloat HeadImageViewWidth = 32;
static CGFloat HostBgViewW = 128;



#define CblowViewColor                  [UIColor colorWithWhite:0.0 alpha:0.2]


@interface LivingRoomTopView()

@property (nonatomic, weak) UIView *hostBgView; //256*64



/** 头像*/
@property (nonatomic, weak) UIImageView *headImageView;
/** 映票文字*/
@property (nonatomic, weak) UILabel *ticketCountLabel;
/** 直播数量*/
@property (nonatomic, weak) UILabel *liveCountLab;
/** 直播*/
@property (nonatomic, weak) UILabel *liveLab;
/** 关注按钮*/
@property (nonatomic, weak) UIButton *attentionBtn;



@property (nonatomic, weak) UIView *ticketBgView; //240*46
/** 头像滚动视图*/
@property (nonatomic, weak) UIScrollView *headImageScrollView;
/** 映票ImageView*/
@property (nonatomic, weak) UIImageView *ticketImageView;
@property (nonatomic, weak) UIImageView *rightImageView;


/** 映客号*/
@property (nonatomic, weak) UILabel *yingKeNumLab;
/** 日期*/
@property (nonatomic, weak) UILabel *dateLabel;

@property (nonatomic, weak) NSTimer *timer;



@end

@implementation LivingRoomTopView

static int randomNum = 0;
static int randomPeopleNum = 0;




- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}


- (void)setLiveItem:(HotLiveItem *)liveItem {
    _liveItem = liveItem;
    //头像
    NSURL *imageUrl;
    if ([liveItem.creator.portrait hasPrefix:@"http://"]) {
        imageUrl = [NSURL URLWithString:_liveItem.creator.portrait];
    }else {
        imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",_liveItem.creator.portrait]];
    }
    [self.headImageView setURLImageWithURL:imageUrl placeHoldImage:[UIImage imageNamed:@"default_head"] isCircle:YES];
    
    self.liveCountLab.text = [NSString stringWithFormat:@"%lu", (unsigned long)_liveItem.online_users];
    
    self.yingKeNumLab.text = [NSString stringWithFormat:@"映客号:%lu", (unsigned long)_liveItem.creator.ID];
    
    self.dateLabel.text = [self getDate];
    //开启定时器
    [self timer];
}

- (void)setTopUsers:(NSMutableArray *)topUsers {
    _topUsers = topUsers;
    [self dealWithTopUserImageView];
    
}



- (void)updateNumber {
    randomNum += rand() % 20 + (-1);
    randomPeopleNum  = rand() % 5 + (-1);
    
    self.ticketCountLabel.text = [NSString stringWithFormat:@"%ld", [self.ticketCountLabel.text integerValue] + randomNum];
    self.liveCountLab.text = [NSString stringWithFormat:@"%ld", [self.liveCountLab.text integerValue] + randomPeopleNum];
    
    
    //更新父视图宽度
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont fontWithName:@"Georgia" size:15.f]};
    CGSize size=[_ticketCountLabel.text sizeWithAttributes:attrs];
    CGFloat viewW = _ticketImageView.tjp_width + size.width + _rightImageView.tjp_width + kDefaultMargin * 2;
    [self.ticketBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(viewW);
    }];
    
}


//处理顶部视图
- (void)dealWithTopUserImageView {
    CGFloat width = HeadImageViewWidth;
    
    self.headImageScrollView.contentSize = CGSizeMake((width + kDefaultMargin) * self.topUsers.count, 0);
    CGFloat x;
    for (int i = 0; i < self.topUsers.count; i++) {
        x = 0 + (kDefaultMargin + width) * i;
        UIImageView *userView = [[UIImageView alloc] initWithFrame:CGRectMake(x, 1, width, width)];
        userView.layer.cornerRadius = width * 0.5;
        userView.layer.masksToBounds = YES;
        LiveRoomTopUserItem *userItem = _topUsers[i];
        NSURL *imageUrl;
        if ([userItem.portrait hasPrefix:@"http://"]) {
            imageUrl = [NSURL URLWithString:userItem.portrait];
        }else {
            imageUrl = [NSURL URLWithString:[NSString stringWithFormat:@"http://img.meelive.cn/%@",userItem.portrait]];
        }
        [userView setURLImageWithURL:imageUrl placeHoldImage:[UIImage imageNamed:@"default_head"] isCircle:YES];
        
        //添加监听
        userView.userInteractionEnabled = YES;
        [userView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickHeadImageView:)]];
        userView.tag = i;
        [self.headImageScrollView addSubview:userView];
    }
}



- (void)clickHeadImageView:(UITapGestureRecognizer *)gesture {
    if (gesture.view == self.headImageView) { //点击的是主播头像
        
    }else {
        //点击的是顶部头像
        NSDictionary * userInfo = @{@"info" : self.topUsers[gesture.view.tag]};
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationClickUser object:nil userInfo:userInfo];
    }
}


- (void)attentionBtnClick:(UIButton *)button {
    if (self.followBtnClickBlock) {
        self.followBtnClickBlock(button);
    }
}


- (NSString *)getDate {
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [NSDate date];
    return [dateFormat stringFromDate:date];
}



//布局子控件
- (void)layoutSubviews {
    
    [super layoutSubviews];
    WS(weakSelf)
    [self.hostBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HostBgViewW, BgViewH));
        make.top.offset(5);
        make.left.offset(10);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(HeadImageViewWidth, HeadImageViewWidth));
        make.left.and.top.offset(1);
    }];
    
    [self.liveLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(4);
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(10);
        
    }];
    
    [self.liveCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.liveLab.mas_bottom).offset(3);
        make.left.equalTo(weakSelf.headImageView.mas_right).offset(10);
    }];
    
    //    [self.attentionBtn sizeToFit];
    [self.attentionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(36, AttentionBtnH));
        make.top.offset(5);
        make.right.offset(-6);
    }];
    
    [self.ticketBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.size.mas_equalTo(CGSizeMake(120, TicketBgViewH));
        make.height.offset(TicketBgViewH);
        make.width.greaterThanOrEqualTo(@100);//设置最小宽度
        make.top.equalTo(weakSelf.hostBgView.mas_bottom).offset(7);
        make.left.mas_equalTo(weakSelf.hostBgView);
    }];
    [self.ticketImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(5);
        make.left.offset(9);
    }];
    [self.ticketCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(2);
        make.left.equalTo(weakSelf.ticketImageView.mas_right).offset(1);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(6);
        make.left.equalTo(weakSelf.ticketCountLabel.mas_right).offset(5);
    }];
    
    //更新父视图宽度
    NSDictionary *attrs = @{NSFontAttributeName : [UIFont fontWithName:@"Georgia" size:15.f]};
    CGSize size = [_ticketCountLabel.text sizeWithAttributes:attrs];
    CGFloat viewW = _ticketImageView.tjp_width + size.width + _rightImageView.tjp_width + kDefaultMargin * 2;
    [self.ticketBgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.offset(viewW);
    }];
    
    [self layoutIfNeeded]; //必须手动刷新才能拿到frame
    
    //头像滚动视图
    [self.headImageScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.hostBgView);
        make.left.equalTo(weakSelf.hostBgView.mas_right).offset(10);
        make.size.mas_equalTo(CGSizeMake(kScreenWidth - weakSelf.hostBgView.tjp_width - ScrollViewMargin, BgViewH));
    }];
    
    [self.yingKeNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.headImageScrollView.mas_bottom).offset(5);
        make.right.offset(-10);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.yingKeNumLab.mas_bottom).offset(3);
        make.right.mas_equalTo(weakSelf.yingKeNumLab);
    }];
    
}






#pragma mark - lazy
- (UIView *)hostBgView {
    if (!_hostBgView) {
        UIView *hostBgView = [[UIView alloc] init];
        hostBgView.backgroundColor = CblowViewColor;
        hostBgView.layer.cornerRadius = BgViewH * 0.5;
        hostBgView.clipsToBounds = YES;
        [self addSubview:hostBgView];
        _hostBgView = hostBgView;
    }
    return _hostBgView;
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        UIImageView *headImageView = [[UIImageView alloc] init];
        [self.hostBgView addSubview:headImageView];
        _headImageView = headImageView;
    }
    return _headImageView;
}

- (UILabel *)liveLab {
    if (!_liveLab) {
        UILabel *liveLab = [[UILabel alloc] init];
        liveLab.text = @"直播";
        liveLab.textColor = [UIColor whiteColor];
        liveLab.font = [UIFont systemFontOfSize:10.f];
        [self.hostBgView addSubview:liveLab];
        _liveLab = liveLab;
    }
    return _liveLab;
}

- (UILabel *)liveCountLab {
    if (!_liveCountLab) {
        UILabel *liveCountLab = [[UILabel alloc] init];
        liveCountLab.text = @"99999";
        liveCountLab.textColor = [UIColor whiteColor];
        liveCountLab.font = [UIFont systemFontOfSize:10.f];
        [self.hostBgView addSubview:liveCountLab];
        _liveCountLab = liveCountLab;
    }
    return _liveCountLab;
}

- (UIButton *)attentionBtn {
    if (!_attentionBtn) {
        UIButton *attentionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [attentionBtn setTitle:@"关注" forState:UIControlStateNormal];
        [attentionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        attentionBtn.titleLabel.font = [UIFont systemFontOfSize:10.f];
        [attentionBtn setBackgroundColor:TJPColor(48, 221, 209)];
        attentionBtn.layer.cornerRadius = AttentionBtnH * 0.5;
        attentionBtn.clipsToBounds = YES;
        [attentionBtn addTarget:self action:@selector(attentionBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        //        [attentionBtn setImage:[UIImage imageNamed:@"live_guanzhu_"] forState:UIControlStateNormal];
        [self.hostBgView addSubview:attentionBtn];
        _attentionBtn = attentionBtn;
    }
    return _attentionBtn;
}

- (UIView *)ticketBgView {
    
    if (!_ticketBgView) {
        UIView *ticketBgView = [[UIView alloc] init];
        ticketBgView.backgroundColor = CblowViewColor;
        ticketBgView.layer.cornerRadius = TicketBgViewH * 0.5;
        ticketBgView.clipsToBounds = YES;
        [self addSubview:ticketBgView];
        _ticketBgView = ticketBgView;
    }
    return _ticketBgView;
}

- (UIImageView *)ticketImageView {
    if (!_ticketImageView) {
        UIImageView *ticketImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_yp_icon1-1_"]];
        [ticketImageView sizeToFit];
        [self.ticketBgView addSubview:ticketImageView];
        _ticketImageView = ticketImageView;
    }
    return _ticketImageView;
}

- (UILabel *)ticketCountLabel {
    if (!_ticketCountLabel) {
        UILabel *ticketCountLabel = [[UILabel alloc] init];
        ticketCountLabel.text = [NSString stringWithFormat:@"%d", (arc4random() % 80000) + 100000];
        [ticketCountLabel setFont:[UIFont fontWithName:@"Georgia" size:15.f]];
        ticketCountLabel.textColor = [UIColor whiteColor];
        [self.ticketBgView addSubview:ticketCountLabel];
        _ticketCountLabel = ticketCountLabel;
        
    }
    return _ticketCountLabel;
}
- (UIImageView *)rightImageView {
    if (!_rightImageView) {
        UIImageView *rightImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"me_yp_btn_n_"]];
        [rightImageView sizeToFit];
        [self.ticketBgView addSubview:rightImageView];
        _rightImageView = rightImageView;
    }
    return _rightImageView;
}

- (UIScrollView *)headImageScrollView {
    if (!_headImageScrollView) {
        UIScrollView *headScrollView = [[UIScrollView alloc] init];
        headScrollView.showsVerticalScrollIndicator = NO;
        headScrollView.showsHorizontalScrollIndicator = NO;
        //        headScrollView.backgroundColor = [UIColor darkGrayColor];
        [self addSubview:headScrollView];
        _headImageScrollView = headScrollView;
    }
    return _headImageScrollView;
}


- (UILabel *)yingKeNumLab {
    if (!_yingKeNumLab) {
        UILabel *yingKeLab = [[UILabel alloc] init];
        yingKeLab.text = @"映客号:6666666";
        yingKeLab.textColor = TJPColor(242, 238, 234);
        yingKeLab.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:yingKeLab];
        _yingKeNumLab = yingKeLab;
    }
    return _yingKeNumLab;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *dateLabel = [[UILabel alloc] init];
        dateLabel.text = @"2016.01.01";
        dateLabel.textColor = TJPColor(242, 238, 234);
        dateLabel.font = [UIFont systemFontOfSize:14.f];
        [self addSubview:dateLabel];
        _dateLabel = dateLabel;
    }
    return _dateLabel;
}

- (NSTimer *)timer {
    if (!_timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:1.0 target:self selector:@selector(updateNumber) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:timer forMode:NSDefaultRunLoopMode];
        _timer = timer;
    }
    return _timer;
}

@end
