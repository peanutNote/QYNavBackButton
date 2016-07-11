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

@protocol QYNavBackButtonDelegate <NSObject>
@optional
/**
 *  自定义返回事件，在需要自定义返回事件的viewController中实现该方法
 */
- (void)customNavBackButtonMethod;

/**
 *  右滑手势返回是否可用
 *
 *  @return YES表示手势可用，NO表示不可用
 */
- (BOOL)isPopGestureAvailable;

@end

@interface UIViewController (QYCustomBackButton) <QYNavBackButtonDelegate>
/**
 *  重新布局返回事件
 */
- (void)setQYNavNeedLayout;

@end