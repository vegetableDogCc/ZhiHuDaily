//
//  UserViewController.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/23.
//

#import "UserViewController.h"

#import "UserInformationView.h"
#import "UserRegisterView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UserViewController ()

@property(nonatomic, strong) UserInformationView *informationView; //用户信息
@property(nonatomic, strong) UserRegisterView *registerView; //登录

@end

@implementation UserViewController

//视图加载后
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clickExitButton];
    [self clickLoginButton];
}

#pragma mark - Method

//展示登录视图
- (void)clickExitButton {
    [self.view addSubview:self.registerView];
}
//展示用户信息视图
- (void)clickLoginButton {
    if ([self.registerView.agreeButton isSelected]) {
        [self.view addSubview:self.informationView];
    }
}
//返回主页
- (void)clickReturnButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy

- (UserInformationView *)informationView {
    if (_informationView == nil) {
        _informationView = [[UserInformationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //点击退出登录
        [_informationView.exitButton addTarget:self action:@selector(clickExitButton) forControlEvents:UIControlEventTouchUpInside];
        //点击返回
        [_informationView.returnButton addTarget:self action:@selector(clickReturnButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _informationView;
}

- (UserRegisterView *)registerView {
    if (_registerView == nil) {
        _registerView = [[UserRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        //点击登录
        [_registerView.loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
        //点击返回
        [_registerView.returnButton addTarget:self action:@selector(clickReturnButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerView;
}


@end
