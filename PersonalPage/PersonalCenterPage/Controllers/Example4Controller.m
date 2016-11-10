//
//  Example4Controller.m
//  PersonalCenterPage
//
//  Created by Vols on 2016/11/8.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "Example4Controller.h"
#import "VExpand1Header.h"
#define kRGB(r, g, b)      [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

@interface Example4Controller ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) NSArray * dataSource;
@property (nonatomic, strong) NSArray * cellImages;

@end

@implementation Example4Controller{
    UIScrollView *scrollView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];

    [self displayUIs];
}

- (void)initData {
    _dataSource = @[@[@"我的订单",@"我的贩售机", @"我的消息", @"开具发票"], @[@"在线客服", @" 软件分享", @"意见反馈", @"鼓励一下吧"]];
    _cellImages = @[@[@"acc_myorder",@"acc_myfavorites", @"acc_message",@"acc_bill"],@[@"acc_contract",@"acc_share2",@"acc_qa", @"feed_praise"]];
}

- (void)displayUIs{
    self.view.backgroundColor = kRGB(239, 239, 244);
    UIBarButtonItem * leftButton = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = leftButton;

    
    VExpand1Header *test = [[VExpand1Header alloc] initWithTableViewWithHeaderImage:[UIImage imageNamed:@"bg"] withCoverHeight:200 withTableViewStyle:UITableViewStyleGrouped];
    test.tableView.delegate = self;
    test.tableView.dataSource = self;
    
    [self.view addSubview:test];
}


#pragma mark - Actions

- (void)backAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UITableViewDelegate Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_dataSource[section] count];
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *identifier = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType  = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.textColor = [UIColor colorWithWhite:0.293 alpha:1.000];
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.text = _dataSource[indexPath.section][indexPath.row];
    cell.imageView.image = [UIImage imageNamed:_cellImages[indexPath.section][indexPath.row]];
    
    if (indexPath.section == 1 && indexPath.row == 0) {
        UILabel * phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 160, 7, 150, 30)];
        phoneLabel.text = @"000-000-0000";
        phoneLabel.textAlignment = NSTextAlignmentRight;
        phoneLabel.font = [UIFont systemFontOfSize:14];
        cell.accessoryView = phoneLabel;
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
