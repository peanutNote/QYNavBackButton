## QYNavBackButton
* Change navigation bar system button event
* 自定义导航栏系统返回按钮事件

## 使用方法
* 将QYNavBackButton文件夹导入项目中即可
* 如果遇到需要自定义事件，可在对应的viewController中`#import "UIViewController+CustomBackButton.h"`，然后复写`- (void)customNavBackButtonMethod`方法即可

## 具体研究
最近遇到一个关于导航栏返回按钮的问题，因为之前项目里面都是用的系统默认的返回按钮样式所以没有想过要去更改，后来有需要将返回按钮箭头旁边的文字去掉，同时将该返回按钮的点击事件重新定义。一开始尝试自定义按钮然后设置为leftBarButtonItem，但是这样图片可能跟系统自带的不一样，还有就是返回按钮的位置跟系统自带的不一样。后来找了一些资料，发现将文字去掉比较简单，一般做法是控制器中添加如下代码，然后他的下一级控制就有一个只有箭头没有文字返回按钮：

```objc
UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
```
self.navigationItem.backBarButtonItem = backBtn;
也可以创建一个根控制器在其中使用上述代码然后让其他控制器继承这个根控制器实现批量操作。但是如果遇到需要自定义该返回的点击事件的时候，在上面方法中添加target与action是不可行的，同时这种做法也会产生一个问题，就是实际的返回按钮点击区域总是比按钮看到的范围大，一般是距离箭头右边30距离都可点击。接下来我就带大家一起了解这些问题产生的原因以及如何更好的解决这些问题。
首先我们看一下按照上面代码去掉返回按钮文字之后的导航栏视图的结构层次，因为导航栏的视图加载以及初始化跟viewController的view不一样，不能再veiwDidLoad中去观察（viewWillAppear中也不行）要在viewDidLoad中才可以看到完整的导航栏视图结构层次。我们可以在一个有去掉文字的返回按钮控制器的viewDidLoad中打上断点然后在控制台执行：
`po [[UIWindow keyWindow] recursiveDescription]`  
会得到如下输出：

```objc
<UIWindow: 0x8d6f970; frame = (0 0; 320 480); autoresize = W+H; gestureRecognizers = <NSArray: 0x8d5dbf0>; layer = <UIWindowLayer: 0x8d717d0>>
   | <UILayoutContainerView: 0x8d7bbf0; frame = (0 0; 320 480); autoresize = W+H; gestureRecognizers = <NSArray: 0x8d78a70>; layer = <CALayer: 0x8d7bcd0>>
   |    | <UINavigationTransitionView: 0x8d813f0; frame = (0 0; 320 480); clipsToBounds = YES; autoresize = W+H; layer = <CALayer: 0x8d814d0>>
   |    |    | <UIViewControllerWrapperView: 0x8d61050; frame = (0 0; 320 480); autoresize = W+H; userInteractionEnabled = NO; layer = <CALayer: 0x8d88f40>>
   |    |    |    | <UIView: 0x8ab0dc0; frame = (0 0; 320 480); autoresize = RM+BM; layer = <CALayer: 0x8ab0610>>
   |    |    |    |    | <_UILayoutGuide: 0x8ab0e20; frame = (0 0; 0 64); hidden = YES; layer = <CALayer: 0x8ab0e90>>
   |    |    |    |    | <_UILayoutGuide: 0x8ab1080; frame = (0 480; 0 0); hidden = YES; layer = <CALayer: 0x8ab10f0>>
   |    | <UINavigationBar: 0x8d75c40; frame = (0 20; 320 44); opaque = NO; autoresize = W; userInteractionEnabled = NO; gestureRecognizers = <NSArray: 0x8d5e750>; layer = <CALayer: 0x8d70f00>>
   |    |    | <_UINavigationBarBackground: 0x8d59af0; frame = (0 -20; 320 64); opaque = NO; autoresize = W; userInteractionEnabled = NO; layer = <CALayer: 0x8d549f0>> - (null)
   |    |    |    | <_UIBackdropView: 0x8d7c440; frame = (0 0; 320 64); opaque = NO; autoresize = W+H; userInteractionEnabled = NO; layer = <_UIBackdropViewLayer: 0x8d7e7b0>>
   |    |    |    |    | <_UIBackdropEffectView: 0x8d7f1c0; frame = (0 0; 320 64); clipsToBounds = YES; opaque = NO; autoresize = W+H; userInteractionEnabled = NO; animations = { filters.colorMatrix.inputColorMatrix=<CABasicAnimation: 0x8ba4490>; }; layer = <CABackdropLayer: 0x8d7f480>>
   |    |    |    |    | <UIView: 0x8d7fc80; frame = (0 0; 320 64); hidden = YES; opaque = NO; autoresize = W+H; userInteractionEnabled = NO; layer = <CALayer: 0x8d7fce0>>
   |    |    |    | <UIImageView: 0x8d67cc0; frame = (0 64; 320 0.5); userInteractionEnabled = NO; layer = <CALayer: 0x8d67d50>> - (null)
   |    |    | <UINavigationItemView: 0x8ab6400; frame = (124 8; 163 27); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8ab6480>>
   |    |    |    | <UILabel: 0x8ab64b0; frame = (0 3; 163 22); text = 'A Story About a Fish'; clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8ab6550>>
   |    |    | <UINavigationItemButtonView: 0x8ab6c80; frame = (8 6; 41 30); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8ab6d60>>
   |    |    |    | <UILabel: 0x8ab6f10; frame = (-981 -995; 91 22); text = ''; clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8ab6fb0>>
   |    |    | <_UINavigationBarBackIndicatorView: 0x8d87560; frame = (8 12; 12.5 20.5); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8d87650>> - Back
```
直接看或许不容易懂，还需要结合Xcode的“Debug view Hierarchy”或者是Reveal工具看实际视图结构：  

![image](https://github.com/peanutNote/QYNavBackButton/blob/master/QYNavBackButton/demo1.png)  

我们可以看到在UINavigationBar中包含有4个类，它们大致的作用是：

* _UINavigationBarBackground ：(UIImageView)导航栏背景图(不可以直接设置图片)
* UINavigationItemView ：(UIView)包含显示导航栏标题
* UINavigationItemButtonView ：(UIView)包含显示导航栏左视图（不可移除、更改大小、颜色，可以隐藏，决定了点击区域的大小）
* _UINavigationBarBackIndicatorView ：(UIImageView)导航栏返回按钮箭头图片（不可以修改图片）

_UINavigationBarBackIndicatorView就是返回按钮的箭头也就是我们需要保留的，UINavigationItemButtonView就是我们需要研究的也是我们前面提到问题的主要原因所在。再次看看这个对象在控制台的输出：

```objc
 |    |    | <UINavigationItemButtonView: 0x8ab6c80; frame = (8 6; 41 30); opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8ab6d60>>
 |    |    |    | <UILabel: 0x8ab6f10; frame = (-981 -995; 91 22); text = ''; clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x8ab6fb0>>
```
这个UINavigationItemButtonView应该是系统在这个view的draw方法里就决定frame，修改frame就触发needdisplay重新改变它的frame，因此这个view只会根据其上的label（也就是返回按钮显示的文字）的内容变化而改变宽度其余基本不可变，我们虽然将label的内容设置为空但是这个UINavigationItemButtonView的大小却并没有改变同时点击区域也没有改变。从控制台里的还可看到这个veiw的userInteractionEnabled属性为NO，如果说点击的是这个view，但现在这个view是不可交互的，只能说明是真正响应点击事件的是这个view背后的某个控件（视图结构和代码里都没有发现这个控件）。因此要想解决我之前提到的问题就得利用这个UINavigationItemButtonView，我们可以在viewDidAppear中取得到UINavigationItemButtonView（如果用遍历的方式获取会有一个延迟，因为这个view的位置固定为第三个所以我们就直接获取就可以了），将其userInteractionEnabled设置为yes并且在这个View上添加手势tap事件即可：

```objc
UIView *nav_back = [self.navigationController.navigationBar.subviews objectAtIndex:2];
if ([nav_back isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
     nav_back.userInteractionEnabled = YES;
     //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
     //    [nav_back addGestureRecognizer:tap];
     UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
     backButton.frame = CGRectMake(0, 0, 20, 30);
     [backButton addTarget:self action:@selector(customMethod) forControlEvents:UIControlEventTouchUpInside];
     [nav_back addSubview:backButton];
 }
```
这样可以改变返回按钮的点击事件，此时想要解决点击范围只能在这个view上添加一个指定大小的按钮了，可能有人会疑惑UINavigationBar每个导航栏公用一个，这样会不会导致多次添加，这里我用实践告诉大家不会的，每个viewController在创建时它的UINavigationItemButtonView会重新加载。最后总结出来的解决办法就是创建一个viewController的分类:  
> UIViewController+CustomBackButton.h文件

```objc
#import <UIKit/UIKit.h>

@interface UIViewController (CustomBackButton)

- (void)customNavBackButtonMethod;

@end
```
>UIViewController+CustomBackButton.m文件

```objc
#import "UIViewController+CustomBackButton.h"
#import <objc/runtime.h>

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
    UIView *nav_back = [self.navigationController.navigationBar.subviews objectAtIndex:2];
    if ([nav_back isKindOfClass:NSClassFromString(@"UINavigationItemButtonView")]) {
        nav_back.userInteractionEnabled = YES;
        //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backAction:)];
        //    [nav_back addGestureRecognizer:tap];
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame = CGRectMake(0, 0, 20, 30);
        [backButton addTarget:self action:@selector(customNavBackButtonMethod) forControlEvents:UIControlEventTouchUpInside];
        [nav_back addSubview:backButton];
    }
}


- (void)customNavBackButtonMethod {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
```
在项目里面创建完以后就会生效。这里所做的就是在所有的viewController执行viewDidLoad的时候将返回按钮的文字置空，在执行viewDidAppear的时候添加一个自定义的按钮去响应pop事件。如果遇到需要自定义返回事件我在.h将返回事件开放出来，只要在对应的viewDidLoad中导入  
`#import "UIViewController+CustomBackButton.h"`  
然后复写customNavBackButtonMethod方法就可以在点击返回按钮时执行到你复写的方法中了，好了，是不是感觉很简单呢。当然在研究这一个问题过程中还是有很多我没弄明白的地方，可能在各位同学使用的时候产生各种问题，给大家带来的不便敬请谅解，同时欢迎大家提出宝贵的建议予以改进，在此感激不尽！