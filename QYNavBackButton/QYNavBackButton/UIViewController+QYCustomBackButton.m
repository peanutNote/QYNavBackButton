//
//  UIViewController+QYCustomBackButton.m
//  QYNavBackButton
//
//  Created by qianye on 16/5/3.
//  Copyright © 2016年 qianye. All rights reserved.
//
//  https://github.com/peanutNote/QYNavBackButton

#import "UIViewController+QYCustomBackButton.h"
#import <objc/runtime.h>

@implementation QYMaskView

@end

@implementation UIViewController (QYCustomBackButton)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalviewDidLoad = @selector(viewDidLoad);
        SEL swizzledviewDidLoad = @selector(qy_viewDidLoad);
        
        SEL originalviewDidAppear = @selector(viewDidAppear:);
        SEL swizzledviewDidAppear = @selector(qy_viewDidAppear);
        
        Method originalMethodLoad = class_getInstanceMethod(class, originalviewDidLoad);
        Method swizzledMethodLoad = class_getInstanceMethod(class, swizzledviewDidLoad);
        
        Method originalMethodAppear = class_getInstanceMethod(class, originalviewDidAppear);
        Method swizzledMethodAppear = class_getInstanceMethod(class, swizzledviewDidAppear);
        
        BOOL didAddMethodLoad = class_addMethod(class, originalviewDidLoad, method_getImplementation(swizzledMethodLoad), method_getTypeEncoding(swizzledMethodLoad));
        BOOL didAddMethodAppear = class_addMethod(class, originalviewDidAppear, method_getImplementation(swizzledMethodAppear), method_getTypeEncoding(swizzledMethodAppear));

        if (didAddMethodLoad) {
            class_replaceMethod(class, swizzledviewDidLoad, method_getImplementation(originalMethodLoad), method_getTypeEncoding(originalMethodLoad));
        } else {
            method_exchangeImplementations(originalMethodLoad, swizzledMethodLoad);
        }
        
        if (didAddMethodAppear) {
            class_replaceMethod(class, swizzledviewDidAppear, method_getImplementation(originalMethodAppear), method_getTypeEncoding(originalMethodAppear));
        } else {
            method_exchangeImplementations(originalMethodAppear, swizzledMethodAppear);
        }
    });
}

#pragma mark - Method Swizzling

- (void)qy_viewDidLoad {
    [self qy_viewDidLoad];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)qy_viewDidAppear {
    [self qy_viewDidAppear];
    [self setQYNavNeedLayout];
}

- (void)setQYNavNeedLayout {
    UIView *nav_backView = nil;
    QYMaskView *nav_qyView = nil;
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
            nav_backView = view;
        } else if ([view isKindOfClass:[QYMaskView class]]) {
            nav_qyView = (QYMaskView *)view;
        }
    }
    self.navigationController.interactivePopGestureRecognizer.enabled = [self isPopGestureAvailable];
    if (nav_backView && !nav_qyView) {
        QYMaskView *qyButtonView = [[QYMaskView alloc] initWithFrame:CGRectMake(0, 0, 100, 44)];
        qyButtonView.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qyButtonView.backButton.frame = CGRectMake(8, 6, 30, 30);
        [qyButtonView.backButton addTarget:self action:@selector(customNavBackButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [qyButtonView addSubview:qyButtonView.backButton];
        [self.navigationController.navigationBar addSubview:qyButtonView];
    } else if (nav_backView && nav_qyView) {
        [nav_qyView.backButton removeTarget:nil action:NULL forControlEvents:UIControlEventAllEvents];
        [nav_qyView.backButton addTarget:self action:@selector(customNavBackButtonMethod) forControlEvents:UIControlEventTouchUpInside];
    } else if (!nav_backView && nav_qyView) {
        [nav_qyView removeFromSuperview];
    }
}

- (void)customNavBackButtonMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)isPopGestureAvailable {
    return YES;
}

@end