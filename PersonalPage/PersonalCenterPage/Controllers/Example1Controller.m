//
//  Example1Controller.m
//  PersonalCenterPage
//
//  Created by Vols on 14/8/11.
//  Copyright (c) 2014年 Vols. All rights reserved.
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

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, assign) CGFloat alpha;

@end

@implementation Example1Controller

- (void)viewDidLoad {
    [super viewDidLoad];

    [self displayUIs];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    _titleLabel.alpha = _alpha;
}

- (void)displayUIs {
    self.view.backgroundColor   = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    _lastOffsetY = -(kHeadH + kTabBarH);
    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadH + kTabBarH, 0, 0, 0);    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell_identifier"];

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationItem.titleView = self.titleLabel;
    self.titleLabel.text    = @"个人中心";
    self.titleLabel.alpha   = 0;
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 0, 40, 30);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem = leftButton;
}


#pragma mark - actions

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell_identifier"];
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
    [self pushNextViewController:[UIViewController class]];
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
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

#pragma mark - helper

- (void)pushNextViewController:(Class)class{
    UIViewController * vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor purpleColor];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
