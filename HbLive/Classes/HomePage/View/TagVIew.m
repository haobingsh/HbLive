//
//  TJPTagVIew.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/5.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "TagVIew.h"

@interface TagVIew () <UIScrollViewDelegate>

@property (nonatomic, weak) UIScrollView *bgScrollView;



@end

@implementation TagVIew
#pragma mark - lazy
- (UIScrollView *)bgScrollView {
    if (!_bgScrollView) {
        UIScrollView *bgScrollView = [[UIScrollView alloc] init];
        bgScrollView.delegate = self;
        bgScrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:bgScrollView];
        _bgScrollView = bgScrollView;
    }
    return _bgScrollView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self initialization];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        TJPLog(@"%f", frame.size.width);
        [self initialization];
    }
    return self;
}


- (void)initialization {
    [self bgScrollView];
    
    [self addGradientLayer];
    
}

- (void)addGradientLayer {
    
    //首端
    NSArray *firstColors = @[
                             (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.9] CGColor],
                             (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.7] CGColor],
                             (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.1] CGColor]
                             ];
    [self.layer addSublayer:[self createGradientLayerWithFrame:CGRectMake(0, 0, 10, 20) colors:firstColors]];
    
    //末尾端
    NSArray *lastColors = @[
                            (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.1] CGColor] ,
                            (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.7] CGColor],
                            (id)[[[UIColor whiteColor] colorWithAlphaComponent:0.9] CGColor]
                            ];
    [self.layer addSublayer:[self createGradientLayerWithFrame:CGRectMake(self.tjp_width - 10, 0, 10, 20) colors:lastColors]];

}


- (void)setTagInfos:(NSArray *)tagInfos {
    _tagInfos = tagInfos;
    //先移除之前添加过的子视图
    [self.bgScrollView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    //添加子视图
    [self initSubViews];
}


- (void)initSubViews {
//    NSAssert(_tagInfos.count, @"标签数据源不能为空");
    CGFloat currentW = 5;
    for (int i = 0; i < _tagInfos.count; i++) {
        UILabel *tagLabel = [[UILabel alloc] init];
        tagLabel.textAlignment = NSTextAlignmentCenter;
        tagLabel.font = [UIFont systemFontOfSize:12.f];
        tagLabel.text = _tagInfos[i];
        tagLabel.textColor = kGlobalLightBlueColor;
        tagLabel.layer.borderWidth = 0.5;
        tagLabel.layer.borderColor = tagLabel.textColor.CGColor;
        [self.bgScrollView addSubview:tagLabel];
        NSDictionary *attribute = @{NSFontAttributeName:tagLabel.font};
        CGSize strSize = [tagLabel.text sizeWithAttributes:attribute];
        strSize.width += 20;
        strSize.height += 5;
        
        tagLabel.tjp_x = currentW;
        
        tagLabel.tjp_y = 0;
        
        tagLabel.tjp_size = strSize;
        tagLabel.layer.cornerRadius = tagLabel.tjp_height * 0.5;
        tagLabel.layer.masksToBounds = YES;
        currentW = currentW + strSize.width + 10;
    }
    
    _bgScrollView.contentSize = CGSizeMake(currentW, 0);
}


- (void)layoutSubviews {
    [super layoutSubviews];
    _bgScrollView.frame = self.bounds;
    
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}



#pragma mark - privite
- (CAGradientLayer *)createGradientLayerWithFrame:(CGRect)frame colors:(NSArray *)colors {
    CAGradientLayer *shadowLayer = [[CAGradientLayer alloc] init];
    //水平渐变
    shadowLayer.startPoint = CGPointMake(0, .5);
    shadowLayer.endPoint = CGPointMake(1, .5);
    shadowLayer.frame = frame;
    shadowLayer.colors = colors;
    shadowLayer.locations = @[@(0.2f) ,@(0.5),@(1.f)];
    return shadowLayer;
}


@end
