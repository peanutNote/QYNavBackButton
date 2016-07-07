//
//  ThirdViewController.m
//  QYNavBackButton
//
//  Created by qianye on 16/5/4.
//  Copyright © 2016年 qianye. All rights reserved.
//
//  https://github.com/peanutNote/QYNavBackButton

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"ThirdVC";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 重新返回按钮的点击事件
- (BOOL)customBackMethodCheckPopWithGesture:(BOOL)option {
    if (option) {
        return NO;
    }
    [self.navigationController popToRootViewControllerAnimated:YES];
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)pushAction:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:[mainStoryboard instantiateViewControllerWithIdentifier:@"ThirdVC"] animated:YES];
}
@end
