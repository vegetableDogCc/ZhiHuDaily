//
//  UserInformationView.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/23.
//

#import "UserInformationView.h"

#import "UIView+Frame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface UserInformationView ()

@property(nonatomic, strong) UIImageView *backgroundImg; //背景图片
@property(nonatomic, strong) UIImageView *userImg; //用户头像图片
@property(nonatomic, strong) UILabel *nameLab; //昵称文本框
@property(nonatomic, strong) UILabel *introductionLab; //个人简介文本框

@end

@implementation UserInformationView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.backgroundImg];
        [self addSubview:self.userImg];
        [self addSubview:self.nameLab];
        [self addSubview:self.introductionLab];
        [self addSubview:self.exitButton];
    }
    return self;
}

#pragma mark - Lazy

- (UIImageView *)backgroundImg {
    if (_backgroundImg == nil) {
        _backgroundImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backgroundImg.image = [UIImage imageNamed:@"背景"];
    }
    return _backgroundImg;
}

- (UIImageView *)userImg {
    if (_userImg == nil) {
        _userImg = [[UIImageView alloc] initWithFrame:CGRectMake(25, 75, 80, 80)];
        _userImg.image = [UIImage imageNamed:@"头像"];
        _userImg.layer.cornerRadius = _userImg.width / 2;
        _userImg.layer.masksToBounds = YES;
    }
    return _userImg;
}

- (UILabel *)nameLab {
    if (_nameLab == nil) {
        _nameLab = [[UILabel alloc] initWithFrame:CGRectMake(self.userImg.right + 15, self.userImg.top + 5, 250, 40)];
        _nameLab.text = @"昵称：这里是昵称";
        _nameLab.font = [UIFont systemFontOfSize:19];
        _nameLab.textColor = [UIColor darkGrayColor];
    }
    return _nameLab;
}

- (UILabel *)introductionLab {
    if (_introductionLab == nil) {
        _introductionLab = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLab.left, self.nameLab.bottom, self.nameLab.width, self.nameLab.height)];
        _introductionLab.text = @"个人简介：这里是个人简介";
        _introductionLab.font = [UIFont systemFontOfSize:19];
        _introductionLab.textColor = [UIColor darkGrayColor];
    }
    return _introductionLab;
}

- (UIButton *)exitButton {
    if (_exitButton == nil) {
        _exitButton = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 250) / 2, self.userImg.bottom + 80, 250, 50)];
        [_exitButton setTitle:@"退出登录" forState:UIControlStateNormal];
        [_exitButton setBackgroundColor:[UIColor darkGrayColor]];
    }
    return _exitButton;
}

@end
