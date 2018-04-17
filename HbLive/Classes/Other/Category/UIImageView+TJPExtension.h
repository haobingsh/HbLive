//
//  UIImageView+TJPExtension.h
//  TJPYingKe
//
//  Created by Walkman on 2017/2/27.
//  Copyright © 2017年 AaronTang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^TJPBlurredImageCompletionBlock)();

extern CGFloat const kTJPBlurredImageDefaultBlurRadius;

@interface UIImageView (TJPExtension)

/****************   请求图片   ****************/

/**
 请求图片显示进度条
 
 @param url 图片URL
 @param progress 进度
 @param complete 完成的block
 */
- (void)setURLImageWithURL: (NSURL *)url progress:(void(^)(CGFloat progress))progress complete: (void(^)())complete;

/**
 请求图片并剪裁
 
 @param url 图片URL
 @param placeHoldImage 占位图
 @param isCircle 是否需要剪裁
 */
- (void)setURLImageWithURL: (NSURL *)url placeHoldImage:(UIImage *)placeHoldImage isCircle:(BOOL)isCircle;

/****************   模糊效果   ****************/
/**
 根据模糊程度来处理图片
 
 @param image 要处理的图片
 @param blurRadius 模糊度
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image blurRadius:(CGFloat)blurRadius completionBlock:(TJPBlurredImageCompletionBlock)completion;


/**
 图片模糊效果处理
 
 @param image 要处理的图片
 @param completion 处理完成的block
 */
- (void)setImageToBlur:(UIImage *)image
       completionBlock:(TJPBlurredImageCompletionBlock)completion;


/****************   处理GIF   ****************/

/** 播放Image*/
- (void)playGifAnimationWithImages:(NSArray *)images;
/** 停止动画*/
- (void)stopGifAnimation;


@end
