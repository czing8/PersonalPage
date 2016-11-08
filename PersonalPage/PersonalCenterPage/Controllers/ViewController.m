//
//  ViewController.m
//  PersonalCenterPage
//
//  Created by Vols on 15/8/11.
//  Copyright (c) 2015年 Vols. All rights reserved.
//

#import "ViewController.h"
#import "Example1Controller.h"
#import "Example2Controller.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray * dataSource;

@end


@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"个人中心模板";
    
    [self initData];
    [self displayUIs];
}

- (void)initData{
    _dataSource = @[@"1.最简单样式", @"2.拉伸效果：Storyboard实现", @"3.拉伸效果：代码实现，原理同2", @"4.拉伸效果：连tableView一起封装"];
    
    
}

- (void)displayUIs {
    
    
}


#pragma mark - UITableViewDelegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataSource.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString * identifier = @"cell_identifier";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
    cell.textLabel.textColor = [UIColor colorWithWhite:0.293 alpha:1.000];
    cell.textLabel.text = _dataSource[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"ToExample2Segue" sender:self];
    }
    else if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"ToExample1Segue" sender:self];
    }
    else if (indexPath.row == 2) {
        [self performSegueWithIdentifier:@"ToExample3Segue" sender:self];
    }
    else if (indexPath.row == 3) {
        [self performSegueWithIdentifier:@"ToExample4Segue" sender:self];
    }

    [self performSelector:@selector(deselect:) withObject:tableView afterDelay:0.2f];
}

- (void)deselect:(UITableView *)tableView {
    [tableView deselectRowAtIndexPath:[tableView indexPathForSelectedRow] animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
