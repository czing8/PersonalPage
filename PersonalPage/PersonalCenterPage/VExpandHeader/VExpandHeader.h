//
//  ExpandHeader.h
//  VPersonalComponent
//
//  Created by Vols on 15/8/21.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VExpandHeader : NSObject <UIScrollViewDelegate>

#pragma mark - 类方法
/**
 *  @param expandView 可以伸展的背景View
 *
 *  @return CExpandHeader 对象
 */
+ (id)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;


#pragma mark - 成员方法
/**
 *  @param expandView 可以伸展的背景View
 */
- (void)expandWithScrollView:(UIScrollView*)scrollView expandView:(UIView*)expandView;

/**
 *  监听scrollViewDidScroll方法
 */
- (void)scrollViewDidScroll:(UIScrollView*)scrollView;

@end
