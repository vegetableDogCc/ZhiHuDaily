//
//  UserrRgisterView.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/23.
//

#import "UserRegisterView.h"

#import "UIView+Frame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UserRegisterView ()

@property(nonatomic, strong) UIImageView *backgroundImg; //背景图片
@property(nonatomic, strong)UILabel *loginLab; //登录文本框
@property(nonatomic, strong)UIImageView *accountImg; //账号图片
@property(nonatomic, strong)UITextField *accountTextField; //账号输入框
@property(nonatomic, strong)UIImageView *passwordImg; //密码图片
@property(nonatomic, strong)UITextField *passwordTextField; //密码输入框

@end

@implementation UserRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImg];
        [self addSubview:self.loginLab];
        [self addSubview:self.accountImg];
        [self addSubview:self.accountTextField];
        [self addSubview:self.passwordImg];
        [self addSubview:self.passwordTextField];
        [self addSubview:self.loginButton];
    }
    return self;
}

#pragma mark - Method

//点击空白处收回键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self endEditing:YES];
}

#pragma mark - Lazy

- (UIImageView *)backgroundImg {
    if (_backgroundImg == nil) {
        _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backgroundImg.image = [UIImage imageNamed:@"背景"];
    }
    return _backgroundImg;
}

- (UILabel *)loginLab {
    if(_loginLab == nil){
        _loginLab = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 68, 48)];
        _loginLab.text = @"登录";
        _loginLab.font = [UIFont boldSystemFontOfSize:33];
        _loginLab.textColor = [UIColor darkGrayColor];
    }
    return _loginLab;
}

- (UIImageView *)accountImg {
    if(_accountImg == nil){
        _accountImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.loginLab.left, self.loginLab.bottom + 20, 20, 20)];
        _accountImg.image = [UIImage imageNamed:@"账号"];
    }
    return _accountImg;
}

- (UITextField *)accountTextField {
    if(_accountTextField == nil){
        _accountTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountImg.right + 10, self.accountImg.top - 10, 247, 40)];
        _accountTextField.placeholder = @"请输入日报号";
        _accountTextField.keyboardType = UIKeyboardTypeNumberPad;
    }
    return _accountTextField;
}

- (UIImageView *)passwordImg {
    if(_passwordImg == nil){
        _passwordImg = [[UIImageView alloc] initWithFrame:CGRectMake(self.accountImg.left, self.accountImg.bottom + 45, self.accountImg.width, self.accountImg.height)];
        _passwordImg.image = [UIImage imageNamed:@"密码"];
    }
    return _passwordImg;
}

- (UITextField *)passwordTextField
{
    if(_passwordTextField == nil){
        _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(self.accountTextField.left, self.passwordImg.top - 10, self.accountTextField.width, self.accountTextField.height)];
        _passwordTextField.placeholder = @"请输入密码";
        _passwordTextField.keyboardType = UIKeyboardTypeASCIICapable;
        _passwordTextField.secureTextEntry = YES;
    }
    return _passwordTextField;
}

- (UIButton *)loginButton
{
    if(_loginButton == nil){
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(30, self.passwordTextField.bottom + 30, 315, 52)];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        [_loginButton setBackgroundColor:[UIColor darkGrayColor]];
    }
    return _loginButton;
}

@end

