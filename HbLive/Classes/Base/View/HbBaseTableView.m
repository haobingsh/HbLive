//
//  HbBaseTableView.m
//  jvms
//
//  Created by 郝兵 on 2018/4/19.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import "HbBaseTableView.h"
#import <MJRefresh.h>
#import "RefreshGifHeader.h"

@interface HbBaseTableView()
{
    
    UILabel *_noDataLab;// 没有数据的提示
    UIImageView *_noDataImageV;// 没有数据的图片
    MJRefreshHeader *_header;//下拉刷新的头文件
    
}

@end

@implementation HbBaseTableView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //self.dataSource = self;
        //self.delegate = self;
        [self initView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame and:(BOOL)isDiyMoreRresh
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _isDiyRefresh = isDiyMoreRresh;
        //self.dataSource = self;
        //self.delegate = self;
        [self initView];
    }
    return self;
}
- (void)awakeFromNib
{
    [super awakeFromNib];
    //self.dataSource = self;
    //self.delegate = self;
    [self initView];
}
#pragma mark 懒加载一下data
-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray arrayWithCapacity:0];
    }
    return _dataArray;
}


- (void)initView
{
    
  
    

    
    if (_isDiyRefresh) {
        
        WS(weakSelf)
        RefreshGifHeader *header = [RefreshGifHeader headerWithRefreshingBlock:^{
            [weakSelf.eventDelegate pullDown:self];
        }];
        
        self.mj_header = header;
        
        MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
        
        //footer.isDiyRefresh = _isDiyRefresh;

        
        NSMutableArray *imageArr = [NSMutableArray array];
        for (int i = 1; i<=24; i++) {
            UIImage *iamge = [UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
            [imageArr addObject:iamge];
        }
        
        [footer setImages:imageArr duration:1 forState:MJRefreshStateRefreshing];
        
        
        footer.refreshingTitleHidden = YES;
        
        self.mj_footer = footer;
        
        
    }else{
        
        self.mj_header.hidden = NO;
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDown)];
        [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
        [header setTitle:@"释放刷新" forState:MJRefreshStatePulling];
        [header setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
        header.stateLabel.font = [UIFont systemFontOfSize:14];
        header.stateLabel.textColor = TEXT_GRAY_COLOR;
        header.lastUpdatedTimeLabel.hidden = YES;
        self.mj_header = header;
        
        MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(pullUp)];
        // 设置字体
        //footer.isDiyRefresh = _isDiyRefresh;
        
        footer.stateLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置颜色
        //footer.stateLabel.textColor = [UIColor hexColor:@"F4F1F2"];
        footer.stateLabel.textColor = HexRGB(0xF4F1F2);
        footer.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
        
        
        footer.refreshingTitleHidden = NO;
        
        self.mj_footer = footer;
    }
    
    //默认关闭上拉加载以及开启上拉刷新
    self.isMoreInfo = NO;
    //self.refreshHeader = YES;
    
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}
#pragma mark 是否开启下拉刷新功能
- (void)setRefreshHeader:(BOOL)refreshHeader
{
    _isRefreshHeader = refreshHeader;
    if (_isRefreshHeader) {
        
        self.mj_header = _header;
    }else{
        self.mj_header = nil;
    }
}

#pragma mark 隐藏或显示没有数据的提示图片
- (void)setIsNOData:(BOOL)isNOData
{
    _isNOData = isNOData;
    _isMoreInfo = NO;
    if (_isNOData) {
        
        [self initNoDataImage];
        _noDataImageV.hidden = NO;
        _noDataLab.hidden = NO;
        //将tableView上的数据清除并刷新
        [self.dataArray removeAllObjects];
        [self reloadData];
        
    }else
    {
        _noDataImageV.hidden = YES;
        _noDataLab.hidden = YES;
        
    }
}

#pragma mark 是否开启上拉加载动画
- (void)setIsMoreInfo:(BOOL)isMoreInfo
{
    _isMoreInfo = isMoreInfo;
    if (_isMoreInfo) {
        //显示上拉加载动画
        self.mj_footer.hidden = NO;
    }else
{
        // 隐藏上拉加载动画
        self.mj_footer.hidden = YES;
        
    }
}





#pragma mark 关闭下拉加载
- (void)doneLoadingTableViewData{
    
    // 拿到当前的下拉刷新控件，结束刷新状态
    [self.mj_header endRefreshing];
    
    [self.mj_footer endRefreshing];
}




//#pragma mark ----------------------UITableViewDelegate---------------------
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    return self.data.count;
//}
//
//
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return nil;
//}



#pragma mark - 初始化没有数据的图片
- (void)initNoDataImage
{
    
    if (_noDataImageV == nil || _noDataLab == nil)
    {
        _noDataImageV = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        _noDataImageV.image = [UIImage imageNamed:@"空哒"];
        _noDataImageV.frame = CGRectMake((kScreenWidth-_noDataImageV.image.size.width)/2.0, (kScreenHeight-_noDataImageV.image.size.height)/2.0-48, _noDataImageV.image.size.width, _noDataImageV.image.size.height);
        _noDataImageV.hidden = YES;
        
        [self addSubview:_noDataImageV];
        
        _noDataLab = [[UILabel alloc]initWithFrame:CGRectMake((kScreenWidth-200)/2.0, _noDataImageV.tjp_bottom-30, 200, 100)];
        
        _noDataLab.text = @"空哒";
        _noDataLab.textAlignment = NSTextAlignmentCenter;
        //_noDataLab.textColor = [UIColor colorWithHexString:@"bab4b8"];
        _noDataLab.textColor = HexRGB(0xbab4b8);
        _noDataLab.font = [UIFont systemFontOfSize:13];
        _noDataLab.hidden = YES;
        
        [self addSubview:_noDataLab];
    }
    
}


#pragma mark 下拉刷新
- (void)pullDown
{
    // 2.模拟0.1秒后刷新表格UI（真实开发中，可以移除这段gcd代码），防止请求过快，看不到等待动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //停止加载，弹回下拉
        [self.eventDelegate pullDown:self];
        
    });
    
}


#pragma mark 上拉加载
- (void)pullUp
{
    // 2.模拟0.1秒后刷新表格UI（真实开发中，可以移除这段gcd代码），防止请求过快，看不到等待动画
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //停止加载，弹回下拉
        [self.eventDelegate pullUp:self];
        
    });
    
}


#pragma mark - 滚动栏滚动到最底部
- (void)scrollToBottomWithAnimated:(BOOL)animated
{
    if ([self numberOfSections] > 0) {
        NSInteger lastSectionIndex = [self numberOfSections] - 1;
        NSInteger lastRowIndex = [self numberOfRowsInSection:lastSectionIndex] - 1;
        if (lastRowIndex > 0) {
            NSIndexPath *lastIndexPath = [NSIndexPath indexPathForRow:lastRowIndex inSection:lastSectionIndex];
            [self scrollToRowAtIndexPath:lastIndexPath atScrollPosition: UITableViewScrollPositionTop animated:animated];
        }
    }
}

#pragma mark - 滚动到顶部
- (void)scrollToTopWithAnimated:(BOOL)animated
{
    if ([self numberOfSections] > 0 && [self numberOfRowsInSection:0] > 0) {
        [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:animated];
    }
}

@end
