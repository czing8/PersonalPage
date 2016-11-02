//
//  Example1Controller.m
//  PersonalCenterPage
//
//  Created by Vols on 15/8/11.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "Example1Controller.h"
#import "UIImage+VAdd.h"
#import "Masonry.h"

#define kHeadH 200
#define kHeadMinH 64
#define kTabBarH 44

@interface Example1Controller ()

@property (weak, nonatomic) IBOutlet UITableView        * tableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint * headHeightConstraint;


@property (nonatomic, strong) UILabel *titleLabel;      //导航栏标题

@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, assign) CGFloat alpha;

@end

@implementation Example1Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = [UIColor whiteColor];
    
    _lastOffsetY = -(kHeadH + kTabBarH);
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadH + kTabBarH, 0, 0, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationItem.titleView = self.titleLabel;
    self.titleLabel.text    = @"个人中心";
    self.titleLabel.alpha   = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _titleLabel.alpha = _alpha;
}

#pragma mark - getter/setter

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.backgroundColor = [UIColor clearColor];
    }
    return _titleLabel;
}


#pragma mark - UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell_identifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                ];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    
    UIView *bgView = UIView.new;
    bgView.backgroundColor = [UIColor purpleColor];
    [cell.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(cell.contentView).insets(UIEdgeInsetsMake(2, 4, 2, 4));
    }];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController * vc   = [[UIViewController alloc]init];
    vc.view.backgroundColor = [UIColor orangeColor];
    [self.navigationController pushViewController:vc animated:YES];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat delta   = offsetY - _lastOffsetY;
    
    // 往上拖动，高度减少。
    CGFloat height  = kHeadH - delta;
    
    if (height < kHeadMinH) {
        height = kHeadMinH;
    }
    
    _headHeightConstraint.constant = height;
    
    _alpha = delta / (kHeadH - kHeadMinH);
    
    if (_alpha >= 1) {
        _alpha = 0.99;
    }
    _titleLabel.alpha = _alpha;

    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:248/255.f green:87/255.f blue:77/255.f alpha:_alpha] size:CGSizeMake(1, 1)];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
