//
//  Example2Controller.m
//  PersonalCenterPage
//
//  Created by Vols on 15/8/11.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "Example2Controller.h"
#import "Masonry.h"

@interface Example2Controller () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView           * tableView;
@property (nonatomic, strong) NSArray <NSArray *>   * dataSource;

@property (nonatomic, strong) UIView        * headerBgView;
@property (nonatomic, strong) UIImageView   * headerImgView;
@property (nonatomic, strong) UIButton      * likeBtn;
@property (nonatomic, strong) UIButton      * fansBtn;
@property (nonatomic, strong) UIButton      * levelBtn;

@end

@implementation Example2Controller

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self displayUIs];
    
}

- (void)initData {
    _dataSource = @[@[@"我的账户", @"我的收藏", @"我的关注"],@[@"认证", @"设置"]];
    
}

- (void)displayUIs {
    self.view.backgroundColor = [UIColor orangeColor];
    
    [self.view addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.headerBgView.backgroundColor = [UIColor purpleColor];
    self.tableView.tableHeaderView = self.headerBgView;
    [self.headerBgView addSubview:self.headerImgView];
    [self.headerBgView addSubview:self.likeBtn];
    [self.headerBgView addSubview:self.fansBtn];
    [self.headerBgView addSubview:self.levelBtn];
    
    [_headerImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.centerX.equalTo(_headerBgView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
    
    [_fansBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_headerBgView);
        make.bottom.equalTo(_headerBgView.mas_bottom).offset(-10);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    [_likeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(_fansBtn.mas_left).offset(-5);
        make.bottom.equalTo(_fansBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
    
    [_levelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_fansBtn.mas_right).offset(5);
        make.bottom.equalTo(_fansBtn.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];

    
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;
}

#pragma mark - actions

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickLikeAction:(UIButton *)sender {
    
}

- (void)clickFansAction:(UIButton *)sender {
    
}

- (void)clickLevelAction:(UIButton *)sender {
    
}


#pragma mark - setter/getter

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"identifier"];
    }
    return _tableView;
}


- (UIView *)headerBgView {
    if (!_headerBgView) {
        _headerBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 200)];
        UIImageView * iView = [[UIImageView alloc] init];
        iView.image = [UIImage imageNamed:@"bg"];
        [_headerBgView addSubview:iView];
        [iView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_headerBgView);
        }];
    }
    return _headerBgView;
}


- (UIImageView *)headerImgView {
    if (!_headerImgView) {
        _headerImgView = [[UIImageView alloc] init];
        _headerImgView.image = [UIImage imageNamed:@"headIcon"];
        _headerImgView.backgroundColor = [UIColor orangeColor];
        _headerImgView.contentMode = UIViewContentModeScaleAspectFill;
        _headerImgView.layer.cornerRadius = 40;
        [_headerImgView.layer setMasksToBounds:YES];
    }
    return _headerImgView;
}


- (UIButton *)likeBtn{
    if (!_likeBtn) {
        _likeBtn = [self buildButtonTitle:@"关注 111" action:@selector(clickLikeAction:)];
    }
    return _likeBtn;
}

- (UIButton *)fansBtn{
    if (!_fansBtn) {
        _fansBtn = [self buildButtonTitle:@"粉丝 100" action:@selector(clickFansAction:)];
    }
    return _fansBtn;
}

- (UIButton *)levelBtn{
    if (!_levelBtn) {
        _levelBtn = [self buildButtonTitle:@"等级 1" action:@selector(clickLevelAction:)];
    }
    return _levelBtn;
}



#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource[section].count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"identifier"];
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;    
    cell.textLabel.textColor = [UIColor colorWithWhite:0.293 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self pushNextViewController:[UIViewController class]];
    
    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


#pragma mark - helper

- (UIButton*)buildButtonTitle:(NSString *)title action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:title forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    btn.titleLabel.textColor = [UIColor whiteColor];
    [btn addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

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
