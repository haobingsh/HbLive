//
//  TJPLivingRoomBottomView.h
//  TJPYingKe
//
//  Created by Walkman on 2016/12/14.
//  Copyright © 2016年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    
    LivingRoomBottomViewButtonClickTypeKnown,
    LivingRoomBottomViewButtonClickTypeChat,
    LivingRoomBottomViewButtonClickTypeMessage,
    LivingRoomBottomViewButtonClickTypeGift,
    LivingRoomBottomViewButtonClickTypeShare,
    LivingRoomBottomViewButtonClickTypeBack
    
}LivingRoomBottomViewButtonClickType;

@interface LivingRoomBottomView : UIView



//加载xib
+ (LivingRoomBottomView *)bottomView;

@property (nonatomic, copy) void(^buttonClickedBlock)(LivingRoomBottomViewButtonClickType clickType, UIButton *button);


@end
