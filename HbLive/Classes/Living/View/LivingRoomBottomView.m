//
//  TJPLivingRoomBottomView.m
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import "LivingRoomBottomView.h"

@interface LivingRoomBottomView()



@end

@implementation LivingRoomBottomView

+ (LivingRoomBottomView *)bottomView {
    return [[[NSBundle mainBundle] loadNibNamed:@"LivingRoomBottomView" owner:nil options:nil] lastObject];
}


- (IBAction)chatBtnClick:(UIButton *)sender {
    self.buttonClickedBlock(LivingRoomBottomViewButtonClickTypeChat, sender);
}

- (IBAction)messageBtnClick:(UIButton *)sender {
    self.buttonClickedBlock(LivingRoomBottomViewButtonClickTypeMessage, sender);

}

- (IBAction)giftBtnClick:(UIButton *)sender {
    self.buttonClickedBlock(LivingRoomBottomViewButtonClickTypeGift, sender);

}
- (IBAction)shareBtnClick:(UIButton *)sender {
    self.buttonClickedBlock(LivingRoomBottomViewButtonClickTypeShare, sender);

}
- (IBAction)backBtnClick:(UIButton *)sender {
    self.buttonClickedBlock(LivingRoomBottomViewButtonClickTypeBack, sender);

}


@end
