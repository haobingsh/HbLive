//
//  HbBaseTableView.h
//  jvms
//
//  Created by 郝兵 on 2018/4/19.
//  Copyright © 2018年 Jovision. All rights reserved.
//

#import <UIKit/UIKit.h>


@class HbBaseTableView;

/**
 *  下拉，上拉，选择的代理
 */
@protocol UITableViewEventDelegate <NSObject>

@optional

/**
 *  下拉刷新
 *
 *  @param tableView 传入的tableView
 */
- (void)pullDown:(HbBaseTableView *)tableView;
/**
 *  上拉加载
 *
 *  @param tableView 传入的tableView
 */
- (void)pullUp:(HbBaseTableView *)tableView;


@end

@interface HbBaseTableView : UITableView

@property (nonatomic, assign)BOOL isDiyRefresh; // 是否自定义
@property (nonatomic,assign)BOOL isRefreshHeader;//是否需要下拉效果
@property (nonatomic,strong)NSMutableArray *dataArray;// 为tableView提供数据
@property (nonatomic,assign)id<UITableViewEventDelegate> eventDelegate;// 下拉，上拉事件代理
@property (nonatomic,assign)BOOL isMoreInfo;// 是否有更多数据,用来控制是否需要上拉加载功能
@property (nonatomic,strong)UILabel *footLabel;// 上拉加载时底部显示的标签提示
@property (nonatomic,assign)BOOL isNOData;// 没有数据

/**
 *  自定义的上拉
 *
 *
 */
- (id)initWithFrame:(CGRect)frame and:(BOOL)isDiyMoreRresh;
/**
 *  停止下拉刷新动画
 */
- (void)doneLoadingTableViewData;
/**
 *  滚动栏滚动到最底部
 *
 *  @param animated 是否开启动画
 */
- (void)scrollToBottomWithAnimated:(BOOL)animated;

@end
