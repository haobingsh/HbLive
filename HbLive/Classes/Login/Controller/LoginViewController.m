//
//  TJPLoginViewController.m
//  TJPYingKe
//
//  Created by Walkman on 2017/3/20.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *treeImageView;
@property (weak, nonatomic) IBOutlet UILabel *protocolLabel;
@property (nonatomic, weak) UIImageView *bigCloud;
@property (nonatomic, weak) UIImageView *smallCloud;
@property (nonatomic, weak) UIImageView *smallerCloud;



@end

@implementation LoginViewController



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //UI
    [self setupUI];
}
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}



- (void)setupUI {
    //clouds
    UIImageView *bigCloud = [self createImageViewWithImage:@"login_bg_cloud_1"];
    bigCloud.tjp_x = kScreenWidth;
    bigCloud.tjp_y = 100;
    [self.view addSubview:bigCloud];
    _bigCloud = bigCloud;
    [_bigCloud.layer addAnimation:[self startAnimationWithDuration:23.f toValue:CGPointMake(0 - _bigCloud.tjp_width, _bigCloud.tjp_y)] forKey:@"bigCloudMove"];
    
    UIImageView *smallCloud = [self createImageViewWithImage:@"login_bg_cloud_2"];
    smallCloud.tjp_x = bigCloud.tjp_x;
    smallCloud.tjp_y = CGRectGetMaxY(bigCloud.frame) + 80;
    [self.view insertSubview:smallCloud belowSubview:_treeImageView];
    _smallCloud = smallCloud;
    [_smallCloud.layer addAnimation:[self startAnimationWithDuration:18.5f toValue:CGPointMake(0 - _smallCloud.tjp_width, _smallCloud.tjp_y)] forKey:@"smallCloudMove"];
    
    UIImageView *smallerCloud = [self createImageViewWithImage:@"login_bg_cloud_2"];
    smallerCloud.tjp_x = bigCloud.tjp_x;
    smallerCloud.tjp_y = CGRectGetMaxY(_treeImageView.frame) + 5;
    [self.view insertSubview:smallerCloud belowSubview:_treeImageView];
    _smallerCloud = smallerCloud;
    [_smallerCloud.layer addAnimation:[self startAnimationWithDuration:26.f toValue:CGPointMake(0 - _smallerCloud.tjp_width, _smallerCloud.tjp_y)] forKey:@"smallerCloudMove"];
    //富文本
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc] initWithString:_protocolLabel.text];
    [abs beginEditing];
    [abs addAttribute:NSForegroundColorAttributeName value:kGlobalLightBlueColor range:NSMakeRange(8, _protocolLabel.text.length - 8)];
    [abs addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:NSMakeRange(8, _protocolLabel.text.length - 8)];
    self.protocolLabel.attributedText = abs;
}


- (IBAction)weiboBtnClick:(id)sender {
    [self goHomePage];
}
- (IBAction)wechatBtnClick:(id)sender {
    [self goHomePage];
}
- (IBAction)mobileBtnClick:(id)sender {
    [self goHomePage];
}
- (IBAction)qqBtnClick:(id)sender {
    [self goHomePage];
}

- (void)goHomePage {
    [UserHelper saveLoginMark:1];
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate homePageViewControllerShow];
}



#pragma mark - privite
- (UIImageView *)createImageViewWithImage:(NSString *)image {
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:image]];
    [imageView sizeToFit];
    return imageView;
}

- (CABasicAnimation *)startAnimationWithDuration:(CFTimeInterval)duration toValue:(CGPoint)point{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    animation.toValue = [NSValue valueWithCGPoint:point];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.removedOnCompletion = NO;
    return animation;
}


- (void)removeAnimation {
    [_bigCloud.layer removeAnimationForKey:@"bigCloudMove"];
    [_smallCloud.layer removeAnimationForKey:@"smallCloudMove"];
    [_smallerCloud.layer removeAnimationForKey:@"smallerCloudMove"];
}


- (void)dealloc {
    [self removeAnimation];
}

@end
