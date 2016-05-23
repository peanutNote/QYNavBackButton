//
//  UIViewController+QYCustomBackButton.h
//  QYNavBackButton
//
//  Created by qianye on 16/5/3.
//  Copyright © 2016年 qianye. All rights reserved.
//
//  https://github.com/peanutNote/QYNavBackButton

#import <UIKit/UIKit.h>

@interface QYMaskView : UIView

@property (nonatomic, strong) UIButton *backButton;

@end

@interface UIViewController (QYCustomBackButton)

- (void)customNavBackButtonMethod;

@end