//
//  AppDelegate.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "AppDelegate.h"

#import "MainViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //创建UIWindow
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //设置UIWindow的背景颜色
    self.window.backgroundColor = [UIColor whiteColor];
    //创建homeVC
    MainViewController *homeVC = [[MainViewController alloc] init];
    //创建UINavigationController，将homeVC作为他的根视图
    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:homeVC];
    //隐藏导航栏
    navVC.navigationBarHidden = YES;
    //
    navVC.interactivePopGestureRecognizer.delegate = nil;
    //设置rootViewController
    self.window.rootViewController = navVC;
    //让window成为keyWindow(主窗口),并且可见
    [self.window makeKeyAndVisible];
    
    return YES;
}

@end
