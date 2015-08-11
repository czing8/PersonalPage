//
//  UIImage+Extension.h
//  NavController
//
//  Created by Vols on 15/8/11.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

// 根据颜色生成一张尺寸为size的图片
+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

@end
