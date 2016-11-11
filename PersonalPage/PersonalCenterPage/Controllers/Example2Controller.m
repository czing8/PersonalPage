//
//  Example3Controller.m
//  PersonalCenterPage
//
//  Created by Vols on 2015/11/8.
//  Copyright © 2015年 vols. All rights reserved.
//

#import "Example2Controller.h"
#import "ContentViewController.h"

#import "VExpandHeader.h"
#import "UIImage+VAdd.h"
#import "Masonry.h"

#define kHeadH      200
#define kHeadMinH   64
#define kTabBarH    44


@interface Example2Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UIView * navigationBgView;



@property (nonatomic, strong) UITableView   * tableView;

@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSArray * cellImages;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) CGFloat lastOffsetY;
@property (nonatomic, assign) CGFloat alpha;

@property (nonatomic, strong) UIImageView * headerExpandIView;
@property (nonatomic, strong) UIImageView * avaterImgView;
@property (nonatomic, strong) UILabel * nameLabel;
@property (nonatomic, strong) UILabel * moneyLabel;
@property (nonatomic, strong) UILabel * coupnLabel;

@end

@implementation Example2Controller{
    VExpandHeader *_header;
}

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self initData];
    [self displayUIs];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self scrollViewDidScroll:self.tableView];
}


- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

    [self refreshData];
}

- (void)initData {
    _dataSource = @[@[@"我的订单",@"我的贩售机", @"我的消息", @"开具发票"], @[@"在线客服", @" 软件分享", @"意见反馈", @"鼓励一下吧"]];
    _cellImages = @[@[@"acc_myorder",@"acc_myfavorites", @"acc_message",@"acc_bill"],@[@"acc_contract",@"acc_share2",@"acc_qa", @"feed_praise"]];
}

- (void)refreshData {
    _nameLabel.text = @"Tom";
}

- (void)displayUIs{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self navigationConfig];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];

    _header = [VExpandHeader expandWithScrollView:_tableView expandView:self.headerExpandIView];
    
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, -120, [UIScreen mainScreen].bounds.size.width, 120)];
    contentView.backgroundColor = [UIColor clearColor];
    
    UIView *bgView = [[UIView alloc] initWithFrame:contentView.bounds];
    bgView.backgroundColor = [UIColor grayColor];
    bgView.alpha = 0.4;

    UIButton *moneyNoteBtn = [self buildButtonTitle:@"积分"];
    moneyNoteBtn.frame = CGRectMake(self.moneyLabel.frame.origin.x + 24, self.moneyLabel.frame.origin.y+22, 60, 20);

    UIButton *coupnNoteBtn  = [self buildButtonTitle:@"优惠券"];
    coupnNoteBtn.frame = CGRectMake(self.coupnLabel.frame.origin.x - 15, self.coupnLabel.frame.origin.y + 22, 60, 20);
    
    [contentView addSubview:bgView];
    [contentView addSubview:self.avaterImgView];
    [contentView addSubview:self.nameLabel];
    [contentView addSubview:self.moneyLabel];
    [contentView addSubview:self.coupnLabel];
    [contentView addSubview:moneyNoteBtn];
    [contentView addSubview:coupnNoteBtn];
    [_tableView addSubview:contentView];
}

#pragma mark - UIs

- (void)navigationConfig {

    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.barStyle  = UIBarStyleBlack;  
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
    
    self.navigationItem.titleView = self.titleLabel;
    self.titleLabel.text    = @"个人中心";
    self.titleLabel.alpha   = 0;
    
    _navigationBgView= [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64)];
    _navigationBgView.backgroundColor = [UIColor colorWithRed:33/255.0 green:184/255.0 blue:229/255.0 alpha:1.0];
    _navigationBgView.alpha = 0.0;
    UIView *uiBarBackground = self.navigationController.navigationBar.subviews.firstObject;
    [uiBarBackground addSubview:_navigationBgView];
}


#pragma mark - actions

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma mark - properties
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


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.showsVerticalScrollIndicator = NO;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cellIdentifier"];
    }
    return _tableView;
}

- (UIImageView *) headerExpandIView {
    if (!_headerExpandIView) {
        _headerExpandIView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 200)];
        [_headerExpandIView setImage:[UIImage imageNamed:@"bg"]];
//        _headerExpandIView.autoresizingMask = UIViewAutoresizingFlexibleHeight| UIViewAutoresizingFlexibleWidth;
        _headerExpandIView.clipsToBounds = YES;
        _headerExpandIView.contentMode = UIViewContentModeScaleAspectFill;
        _headerExpandIView.userInteractionEnabled = YES;
    }
    return _headerExpandIView;
}


- (UIImageView *) avaterImgView {
    if (!_avaterImgView) {
        _avaterImgView = [[UIImageView alloc] initWithFrame:CGRectMake(16, 10, 64, 64)];
        [_avaterImgView.layer setCornerRadius:(_avaterImgView.frame.size.height/2)];
        [_avaterImgView.layer setMasksToBounds:YES];
        _avaterImgView.image = [UIImage imageNamed:@"headIcon"];
        [_avaterImgView setContentMode:UIViewContentModeScaleAspectFill];
        [_avaterImgView setClipsToBounds:YES];
        _avaterImgView.layer.shadowColor = [UIColor blackColor].CGColor;
        _avaterImgView.layer.shadowOffset = CGSizeMake(4, 4);
        _avaterImgView.layer.shadowOpacity = 0.5;
        _avaterImgView.layer.shadowRadius = 2.0;
        _avaterImgView.userInteractionEnabled = YES;
    }
    return _avaterImgView;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(90, 20, 180, 20)];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:20];
    }
    return _nameLabel;
}

- (UILabel *)moneyLabel {
    if (!_moneyLabel) {
        _moneyLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 185, 50, 100, 20)];
        _moneyLabel.textColor = [UIColor whiteColor];
        _moneyLabel.textAlignment = NSTextAlignmentCenter;
        _moneyLabel.userInteractionEnabled = YES;
        _moneyLabel.font = [UIFont systemFontOfSize:14];
        _moneyLabel.text = @"￥0.00";
    }
    return _moneyLabel;
}

- (UILabel *)coupnLabel{
    if (!_coupnLabel) {
        _coupnLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 62, 50, 60, 20)];
        _coupnLabel.textColor = [UIColor whiteColor];
        _coupnLabel.text = @"0 张";
        _coupnLabel.font = [UIFont systemFontOfSize:14];
        _coupnLabel.userInteractionEnabled = YES;
    }
    return _coupnLabel;
}


#pragma mark - UITableViewDelegate Methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdentifier"];
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

    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat delta = offsetY + kHeadH;
    _alpha = delta / (kHeadH - 64);
    
    NSLog(@"%f", _alpha);

    if (_alpha >= 1)  _alpha = 0.99;
    
    self.titleLabel.alpha = _alpha;
    
    _navigationBgView.alpha = _alpha;
    
//    UIImage *image = [UIImage imageWithColor:[UIColor colorWithRed:248/255.f green:87/255.f blue:77/255.f alpha:_alpha] size:CGSizeMake(1, 1)];
//    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
}

#pragma mark - helper

- (UIButton *)buildButtonTitle:(NSString *)title {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:14];
    btn.titleLabel.textColor = [UIColor whiteColor];
    btn.layer.borderWidth = 1;
    btn.layer.cornerRadius = 10;
    btn.layer.borderColor = [UIColor whiteColor].CGColor;

    return btn;
}

- (void)pushNextViewController:(Class)class{
    UIViewController * vc = [[class alloc] init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.view.backgroundColor = [UIColor randomColor];
    [self.navigationController pushViewController:vc animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
