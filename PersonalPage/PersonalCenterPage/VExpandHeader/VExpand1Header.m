//
//  VExpand1Header.m
//  PersonalCenterPage
//
//  Created by Vols on 2016/11/8.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "VExpand1Header.h"
#import <QuartzCore/QuartzCore.h>
#import <Accelerate/Accelerate.h>
#import "UIImage+VAdd.h"

@interface VExpand1Header ()

@property (nonatomic, strong) NSMutableArray *blurImages;
@property (nonatomic, assign) CGFloat coverHeight;
@property (nonatomic, strong) UIView* scrollHeaderView;

@end


@implementation VExpand1Header

- (instancetype)initWithTableViewWithHeaderImage:(UIImage*)headerImage withCoverHeight:(CGFloat)height withTableViewStyle:(UITableViewStyle)TableViewStyle{
    
    CGRect bounds = [UIScreen mainScreen].bounds;
    self = [[VExpand1Header alloc] initWithFrame:bounds];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    [self.headerImageView setImage:headerImage];
    [self addSubview:self.headerImageView];
    
    self.coverHeight = height;
    
    self.tableView = [[UITableView alloc] initWithFrame:self.frame style:TableViewStyle];
    self.tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    self.tableView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.tableView];
    
    [self.tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.blurImages = [[NSMutableArray alloc] init];
    [self prepareForBlurImages];
    
    return self;
}


- (instancetype)initWithScrollViewWithHeaderImage:(UIImage*)headerImage withCoverHeight:(CGFloat)height withScrollContentViewHeight:(CGFloat)ContentViewheight{
    
    CGRect bounds = [[UIScreen mainScreen] bounds];
    self = [[VExpand1Header alloc] initWithFrame:bounds];
    
    self.headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, bounds.size.width, height)];
    [self.headerImageView setImage:headerImage];
    [self addSubview:self.headerImageView];
    
    self.coverHeight = height;
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.scrollView];
    
    self.scrollContentView = [[UIView alloc] initWithFrame:CGRectMake(0, height, bounds.size.width, ContentViewheight)];
    self.scrollContentView.backgroundColor = [UIColor whiteColor];
    self.scrollView.contentSize = self.scrollContentView.frame.size;
    [self.scrollView addSubview:self.scrollContentView];
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    
    self.blurImages = [[NSMutableArray alloc] init];
    [self prepareForBlurImages];
    
    return self;
}


- (void)setHeaderImage:(UIImage *)headerImage{
    [self.headerImageView setImage:headerImage];
    [self.blurImages removeAllObjects];
    [self prepareForBlurImages];
}

- (void)prepareForBlurImages {
    CGFloat factor = 0.1;
    [self.blurImages addObject:self.headerImageView.image];
    for (NSUInteger i = 0; i < self.coverHeight/10; i++) {
        [self.blurImages addObject:[UIImage boxblurImage:self.headerImageView.image ratio:factor]];
        factor+=0.04;
    }
}

- (void)animationForTableView{
    CGFloat offset = self.tableView.contentOffset.y;
    
    if (self.tableView.contentOffset.y > 0) {
        
        NSInteger index = offset / 10;
        if (index < 0) {
            index = 0;
        }
        else if(index >= self.blurImages.count) {
            index = self.blurImages.count - 1;
        }
        UIImage *image = self.blurImages[index];
        if (self.headerImageView.image != image) {
            [self.headerImageView setImage:image];
            
        }
        self.tableView.backgroundColor = [UIColor clearColor];
        
    }
    else {
        self.headerImageView.frame = CGRectMake(offset,0, self.frame.size.width+ (-offset) * 2, self.coverHeight + (-offset));
    }
}

- (void)animationForScrollView{
    CGFloat offset = self.scrollView.contentOffset.y;
    
    if (self.scrollView.contentOffset.y > 0) {
        
        NSInteger index = offset / 10;
        if (index < 0) {
            index = 0;
        }
        else if(index >= self.blurImages.count) {
            index = self.blurImages.count - 1;
        }
        UIImage *image = self.blurImages[index];
        if (self.headerImageView.image != image) {
            [self.headerImageView setImage:image];
            
        }
        self.scrollView.backgroundColor = [UIColor clearColor];
        
    }
    else {
        self.headerImageView.frame = CGRectMake(offset,0, self.frame.size.width + (-offset) * 2, self.coverHeight + (-offset));
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (self.tableView) {
        [self animationForTableView];
    }
    else{
        [self animationForScrollView];
    }
}

- (void)removeFromSuperview {
    if (self.tableView) {
        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
    else{
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
    [super removeFromSuperview];
}

- (void)dealloc {
    if (self.tableView) {
        //        [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
    }
    else{
        [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
    }
}


@end
