//
//  Content2ViewController.m
//  PersonalCenterPage
//
//  Created by Vols on 2016/11/10.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "Content2ViewController.h"

@interface Content2ViewController ()

@end

@implementation Content2ViewController

- (void)loadView {
    [super loadView];
    
    NSLog(@"%d", self.navigationController.navigationBarHidden);
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    NSLog(@"%d", self.navigationController.navigationBarHidden);

}



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Second";
    self.view.backgroundColor = [UIColor randomColor];
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
