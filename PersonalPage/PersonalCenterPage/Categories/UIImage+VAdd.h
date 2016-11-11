//
//  UIImage+VAdd.h
//  NavController
//
//  Created by Vols on 15/8/11.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (VAdd)

/**
 * 根据颜色生成尺寸为size的图片
 **/
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;



/**
 * 图片模糊方法
 **/
+ (UIImage *)boxblurImage:(UIImage *)image ratio:(CGFloat)ratio;

+ (UIImage *)coreBlurImage:(UIImage *)image ratio:(CGFloat)ratio;


@end
