//
//  ViewController.m
//  头部缩放效果
//
//  Created by qianfeng on 16/9/29.
//  Copyright © 2016年 com.xuwenjie. All rights reserved.
//

#import "Example3Controller.h"
#import "ContentViewController.h"


#define kTableHeaderViewHeight      400  //tableHeaderView的高度
#define kTableViewUpHeight          240  //tableView整体上移高度

@interface Example3Controller ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic, strong) UIView * navigationBgView;
@property (nonatomic, strong) UIImageView * headerImgView;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation Example3Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navigationConfig];
    [self displayUIs];
}

- (void)displayUIs {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    [self.view addSubview:self.tableView];
    _tableView.tableHeaderView = self.headerImgView;

}


- (void)navigationConfig {
    
    self.navigationItem.title = @"首页";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addClick)];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
    
    UIView *uiBarBackground = self.navigationController.navigationBar.subviews.firstObject;
    [uiBarBackground addSubview:self.navigationBgView];
    
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}



#pragma mark - Actions

- (void)addClick {
    ContentViewController *secondVC = [[ContentViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
}

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Properities

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        
        //将整个tableView上移并加长上移的高度
        CGRect temp = _tableView.frame;
        temp.origin.y -= kTableViewUpHeight;
        temp.size.height += kTableViewUpHeight;
        _tableView.frame = temp;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}


- (UIView *)navigationBgView{
    if (!_navigationBgView) {
        _navigationBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
        _navigationBgView.backgroundColor = [UIColor colorWithRed:33/255.0 green:184/255.0 blue:229/255.0 alpha:1.0];
        _navigationBgView.alpha = 0.0;
    }
    return _navigationBgView;
}

- (UIImageView *)headerImgView{
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, _tableView.frame.size.width, kTableHeaderViewHeight)];
        _headerImgView.image = [UIImage imageNamed:@"bg"];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
    }
    return _headerImgView;
}

#pragma mark - TableViewDelegate （代理）
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];

    UIView *bgView = UIView.new;
    bgView.backgroundColor = [UIColor randomColor];
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
    [self pushNextViewController:[ContentViewController class]];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.headerImgView.frame = [self calculateFrameWithOffY:_tableView.contentOffset.y];
    
    CGPoint center = self.headerImgView.center;
    center.x = self.view.frame.size.width / 2;
    self.headerImgView.center = center;
}

#pragma mark -
- (CGRect)calculateFrameWithOffY:(CGFloat)offy {
    
    CGFloat upDistance = offy + 64;
    
    //1.navigationBar透明度计算
    CGFloat alphaScale = 0.0;
    
    CGFloat criticalHeight = kTableHeaderViewHeight - kTableViewUpHeight;
    
    if (upDistance <= criticalHeight) {
        alphaScale = (upDistance-20) / criticalHeight;
    } else {
        alphaScale = 1.0;
    }
    
    _navigationBgView.alpha = alphaScale;
    
    //2.缩放比例计算
    CGFloat zoomScale = -offy / self.tableView.frame.size.height + 1;
    
    CGRect rect = self.headerImgView.frame;
    if (offy < 0) {
        rect.size.width = self.view.frame.size.width * zoomScale;
        rect.size.height = kTableHeaderViewHeight * zoomScale;
    }
    
    return rect;
}


#pragma mark - helper

- (void)pushNextViewController:(Class)class{
    UIViewController * vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor randomColor];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - properties


@end
