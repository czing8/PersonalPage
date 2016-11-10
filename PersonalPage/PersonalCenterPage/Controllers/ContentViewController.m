//
//  ContentViewController.m
//  PersonalCenterPage
//
//  Created by Vols on 2016/11/10.
//  Copyright © 2016年 vols. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)loadView {
    [super loadView];

    if (self.navigationController.navigationBarHidden == YES) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor randomColor];
    
    [self setBackgroundViewColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self setBackgroundViewColor];
}




- (void)viewDidAppear:(BOOL)animated {
    if (animated) {
        [self setBackgroundViewColor];
    }
}

- (void)setBackgroundViewColor {
    UIView *uiBarBackground = self.navigationController.navigationBar.subviews.firstObject;
    
    UIView *backgroundView = uiBarBackground.subviews.firstObject;
    
    backgroundView.alpha = 1.0;
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
