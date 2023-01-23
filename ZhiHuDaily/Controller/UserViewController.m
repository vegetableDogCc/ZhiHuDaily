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

@property(nonatomic, strong) UserInformationView *informationView;
@property(nonatomic, strong) UserRegisterView *registerView;

@end

@implementation UserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self clickExitButton];
    [self clickLoginButton];
}

#pragma mark - Method

- (void)clickExitButton {
    [self.view addSubview:self.registerView];
}

- (void)clickLoginButton {
    [self.view addSubview:self.informationView];
}

#pragma mark - Lazy

- (UserInformationView *)informationView {
    if (_informationView == nil) {
        _informationView = [[UserInformationView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_informationView.exitButton addTarget:self action:@selector(clickExitButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _informationView;
}

- (UserRegisterView *)registerView {
    if (_registerView == nil) {
        _registerView = [[UserRegisterView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        [_registerView.loginButton addTarget:self action:@selector(clickLoginButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerView;
}


@end
