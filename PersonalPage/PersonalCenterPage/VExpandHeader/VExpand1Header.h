//
//  VOneHeaderView.h
//  VPersonalComponent
//
//  Created by Vols on 15/8/19.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VExpand1Header : UIView

@property (nonatomic, strong) UIScrollView* scrollView;
@property (nonatomic, strong) UIView* scrollContentView;
@property (nonatomic, strong) UIImageView* headerImageView;
@property (nonatomic, strong) UITableView* tableView;

- (instancetype)initWithTableViewWithHeaderImage:(UIImage*)headerImage withCoverHeight:(CGFloat)height withTableViewStyle:(UITableViewStyle)TableViewStyle;
- (instancetype)initWithScrollViewWithHeaderImage:(UIImage*)headerImage withCoverHeight:(CGFloat)height withScrollContentViewHeight:(CGFloat)height;

- (void)setHeaderImage:(UIImage *)headerImage;

@end
