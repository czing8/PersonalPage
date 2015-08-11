//
//  ViewController.m
//  NavController
//
//  Created by Vols on 15/8/11.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "ViewController.h"

#import "UIImage+Extension.h"


#define kHeadH 200
#define kHeadMinH 64
#define kTabBarH 44


@interface ViewController ()


@property (nonatomic, strong) UILabel *titleLabel;   //导航栏标题

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headHeightConstraint;
@property (nonatomic, assign) CGFloat lastOffsetY;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _lastOffsetY = -(kHeadH + kTabBarH);

    
    self.tableView.contentInset = UIEdgeInsetsMake(kHeadH + kTabBarH, 0, 0, 0);
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    // 给导航条的背景图片传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    // 隐藏底部阴影条，传递一个空图片的UIImage对象
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    self.navigationItem.titleView = self.titleLabel;
    self.titleLabel.text = @"吖了个峥";
    self.titleLabel.alpha = 0;
}



#pragma mark - properties
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0 , 100, 44)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.font = [UIFont boldSystemFontOfSize:20];
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID
                ];
    }
    
    cell.backgroundColor = [UIColor orangeColor];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGFloat delta = offsetY - _lastOffsetY;
    
    // 往上拖动，高度减少。
    CGFloat height = kHeadH - delta;
    
    if (height < kHeadMinH) {
        height = kHeadMinH;
    }
    
    _headHeightConstraint.constant = height;
    
    // 设置导航条的背景图片
    CGFloat alpha = delta / (kHeadH - kHeadMinH);
    
    // 当alpha大于1，导航条半透明，因此做处理，大于1，就直接=0.99
    if (alpha >= 1) {
        alpha = 0.99;
    }
    _titleLabel.alpha = alpha;
    // 设置导航条的背景图片
    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:48 green:0 blue:200 alpha:alpha] size:CGSizeMake(1, 1)];
    
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
