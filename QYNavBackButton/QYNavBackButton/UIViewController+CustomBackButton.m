//
//  UIViewController+CustomBackButton.m
//  QYNavBackButton
//
//  Created by qianye on 16/5/3.
//  Copyright © 2016年 qianye. All rights reserved.
//
//  https://github.com/peanutNote/QYNavBackButton

#import "UIViewController+CustomBackButton.h"
#import <objc/runtime.h>

@implementation QYMaskView

@end

@implementation UIViewController (CustomBackButton)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(mm_viewDidLoad);
        
        SEL originalSelector1 = @selector(viewDidAppear:);
        SEL swizzledSelector1 = @selector(mm_viewDidAppear);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        Method originalMethod1 = class_getInstanceMethod(class, originalSelector1);
        Method swizzledMethod1 = class_getInstanceMethod(class, swizzledSelector1);
        
        BOOL didAddMethod = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        BOOL didAddMethod1 = class_addMethod(class, originalSelector1, method_getImplementation(swizzledMethod1), method_getTypeEncoding(swizzledMethod1));

        if (didAddMethod) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        if (didAddMethod1) {
            class_replaceMethod(class, swizzledSelector1, method_getImplementation(originalMethod1), method_getTypeEncoding(originalMethod1));
        } else {
            method_exchangeImplementations(originalMethod1, swizzledMethod1);
        }
    });
}

#pragma mark - Method Swizzling

- (void)mm_viewDidLoad {
    [self mm_viewDidLoad];
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self.navigationItem setBackBarButtonItem:backButtonItem];
}

- (void)mm_viewDidAppear {
    [self mm_viewDidAppear];
    UIView *nav_backView = nil;
    QYMaskView *nav_qyView = nil;
    for (UIView *view in self.navigationController.navigationBar.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
            nav_backView = view;
        } else if ([view isKindOfClass:[QYMaskView class]]) {
            nav_qyView = (QYMaskView *)view;
        }
    }
    if (nav_backView && !nav_qyView) {
        QYMaskView *qyButtonView = [[QYMaskView alloc] initWithFrame:CGRectMake(8, 6, 100, 30)];
        qyButtonView.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        qyButtonView.backButton.frame = CGRectMake(0, 0, 20, 30);
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

@end