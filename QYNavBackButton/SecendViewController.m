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
    [self.navigationController pushViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"ThirdVC"] animated:YES];
}

@end
