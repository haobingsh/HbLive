//
//  TJPUserView.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/16.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "UserView.h"
#import "LiveRoomTopUserItem.h"

@interface UserView()

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIImageView *littleHeadImageView;

@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *leavelLabel;
@property (weak, nonatomic) IBOutlet UILabel *yingKeNumLab;

@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *certificateLabel;
@property (weak, nonatomic) IBOutlet UILabel *signLabel;

@end

@implementation UserView

+ (instancetype)userView {
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (IBAction)backBtnClick:(UIButton *)sender {
    if (self.closeViewBlock) {
        self.closeViewBlock();
    }
}

- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.layer.cornerRadius = 5;
    self.clipsToBounds = YES;

}

- (void)setUserItem:(LiveRoomTopUserItem *)userItem {
    _userItem = userItem;
    [_headImageView setURLImageWithURL:[NSURL URLWithString:_userItem.portrait] placeHoldImage:[UIImage imageNamed:@"default_head"] isCircle:YES];
    _nickLabel.text = _userItem.nick;
    _yingKeNumLab.text = [NSString stringWithFormat:@"映客号:%lu", (unsigned long)_userItem.ID];
    _leavelLabel.text = [NSString stringWithFormat:@"等级:%lu", (unsigned long)_userItem.level];
    if (_userItem.location.length) {
        _locationLabel.text = _userItem.location;
    }else {
        _locationLabel.text = @"   ";
    }
    
    _certificateLabel.text = _userItem.veri_info;
    _signLabel.text = _userItem.Description;
    
    
}




@end
