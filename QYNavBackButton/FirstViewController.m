//
//  ViewController.m
//  QYNavBackButton
//
//  Created by qianye on 16/5/4.
//  Copyright © 2016年 qianye. All rights reserved.
//

#import "FirstViewController.h"
#import "SecendViewController.h"

@interface FirstViewController ()

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
//    self.navigationItem.backBarButtonItem = backBtn;
}

- (void)popAction:(UIButton *)sender {
    NSLog(@"come here");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pushAction:(id)sender {
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    SecendViewController *secendVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"SecendVC"];
    [self.navigationController pushViewController:secendVC animated:YES];
}


@end
