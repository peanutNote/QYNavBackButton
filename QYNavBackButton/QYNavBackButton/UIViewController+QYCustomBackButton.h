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
 *
 *  @param option 是否需要检测手滑返回
 *
 *  @return 如果该值为yes需要直接返回yes(表示需要手滑返回)或者no(表示不需要手滑返回)
 */
- (BOOL)customBackMethodCheckPopWithGesture:(BOOL)option;
@end

@interface UIViewController (QYCustomBackButton) <QYNavBackButtonDelegate>
/**
 *  重新布局返回事件
 */
- (void)setQYNavNeedLayout;

@end