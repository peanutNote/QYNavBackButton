//
//  SecendViewController.m
//  QYNavBackButton
//
//  Created by qianye on 16/5/4.
//  Copyright © 2016年 qianye. All rights reserved.
//

#import "SecendViewController.h"
#import "ThirdViewController.h"

@interface SecendViewController ()

@end

@implementation SecendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    backBtn.frame = CGRectMake(0, 0, 20, 20);
//    [backBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *backBarBtn = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    self.navigationItem.leftBarButtonItem = backBarBtn;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
//    for (UIView *nav_back in self.navigationController.navigationBar.subviews) {
//        if ([nav_back isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
//            nav_back.userInteractionEnabled = YES;
//            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
//            [nav_back addGestureRecognizer:tap];
//        }
//    }
}


- (void)customNavBackButtonMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backAction:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)presentAction:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    UINavigationController *secendNav = [[UINavigationController alloc] initWithRootViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"ThirdVC"]];
    [self presentViewController:secendNav animated:YES completion:nil];
}

@end
