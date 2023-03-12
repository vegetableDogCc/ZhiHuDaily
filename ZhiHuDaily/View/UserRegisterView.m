#import "UserRegisterView.h"

#import "UIView+Frame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UserRegisterView ()

@property(nonatomic, strong) UIImageView *loginImg; //选择登录方式图片
@property(nonatomic, strong) UILabel *agreementLab; //协议文本框

@end

@implementation UserRegisterView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.returnButton];
        [self addSubview:self.loginImg];
        [self addSubview:self.loginButton];
        [self addSubview:self.agreeButton];
        [self addSubview:self.agreementLab];
        
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

#pragma mark - method

//点击选中时改变按钮选中状态
- (void)checkClick {
    _agreeButton.selected = !_agreeButton.selected;
}

#pragma mark - Lazy

- (UIButton *)returnButton {
    if (_returnButton == nil) {
        _returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 50, 50, 50)];
        [_returnButton setBackgroundImage:[UIImage imageNamed:@"箭头"] forState:UIControlStateNormal];
        _returnButton.adjustsImageWhenHighlighted = NO;
    }
    return _returnButton;
}

- (UIImageView *)loginImg {
    if (_loginImg == nil) {
        _loginImg = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 80, SCREEN_HEIGHT / 3.0, 160, 100)];
        _loginImg.image = [UIImage imageNamed:@"登录"];
    }
    return _loginImg;
}

- (UIButton *)agreeButton {
    if (_agreeButton == nil) {
        _agreeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.loginButton.left - 25, self.loginButton.bottom + 35, 20, 20)];
        [_agreeButton setBackgroundImage:[UIImage imageNamed:@"圈圈"] forState:UIControlStateNormal];
        [_agreeButton setBackgroundImage:[UIImage imageNamed:@"勾勾"] forState:UIControlStateSelected];
        [_agreeButton addTarget:self action:@selector(checkClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _agreeButton;
}

- (UIButton *)loginButton {
    if (_loginButton == nil) {
        _loginButton = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH / 2.0 - 125, self.loginImg.bottom, 250, 55)];
        _loginButton.adjustsImageWhenHighlighted = NO;
        [_loginButton setBackgroundImage:[UIImage imageNamed:@"方式"] forState:UIControlStateNormal];
    }
    return _loginButton;
}

- (UILabel *)agreementLab {
    if (_agreementLab == nil) {
        _agreementLab = [[UILabel alloc] initWithFrame:CGRectMake(self.loginButton.left, self.agreeButton.top - 5, 290, 30)];
        NSString *str = @"我同意《知乎协议》和《个人信息保护指引》";
        
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:NSMakeRange(3, 6)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor systemBlueColor] range:NSMakeRange(10, 10)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(0, 3)];
        [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(9, 1)];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:NSMakeRange(0, str.length)];
        
        [_agreementLab setAttributedText:attrStr];
    }
    return _agreementLab;
}

@end

