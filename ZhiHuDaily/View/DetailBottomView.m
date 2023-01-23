//
//  DetailBottomView.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/19.
//

#import "DetailBottomView.h"

#import "UIView+Frame.h"

#import "MainViewController.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DetailBottomView ()

@property(nonatomic, strong) UIToolbar *toolBar; //底部的工具栏
@property(nonatomic, strong) UIButton *returnButton; //返回主页按钮
@property(nonatomic, strong) UIView *verticalLine; //竖直分割线
@property(nonatomic, strong) UIButton *commentButton; //评论按钮
@property(nonatomic, strong) UILabel *commentLab; //评论数文本框
@property(nonatomic, strong) UIButton *likesButton; //点赞按钮
@property(nonatomic, strong) UILabel *likesLab; //点赞数文本框
@property(nonatomic, strong) UIButton *collectionButton; //收藏按钮
@property(nonatomic, strong) UIButton *shareButton; //分享按钮

@end

@implementation DetailBottomView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.toolBar];
        [self.toolBar addSubview:self.returnButton];
        [self.toolBar addSubview:self.verticalLine];
        [self.toolBar addSubview:self.commentButton];
        [self.toolBar addSubview:self.commentLab];
        [self.toolBar addSubview:self.likesButton];
        [self.toolBar addSubview:self.likesLab];
        [self.toolBar addSubview:self.collectionButton];
        [self.toolBar addSubview:self.shareButton];
    }
    return self;
}

#pragma mark - Method

- (void)clickLikesButton {
    //点击时改变按钮选中状态
    self.likesButton.selected =! self.likesButton.selected;
    //设置弹出视图
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    //实现弹出方法
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.windowLevel = UIWindowLevelNormal;
    
    if ([self.likesButton isSelected]) {
        //显示已点赞
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"已点赞"]];
        view.frame = CGRectMake((SCREEN_WIDTH - 80) / 2, (SCREEN_HEIGHT - 70) / 2, 80, 70);
        //点赞数加一
        long number = [self.likesLab.text longLongValue];
        number += 1;
        self.likesLab.text = [NSString stringWithFormat:@"%ld", number];
    }
    else {
        //显示取消点赞
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"已取消点赞"]];
        view.frame = CGRectMake((SCREEN_WIDTH - 100) / 2, (SCREEN_HEIGHT - 70) / 2, 100, 70);
        //点赞数减一
        long number = [self.likesLab.text longLongValue];
        number -= 1;
        self.likesLab.text = [NSString stringWithFormat:@"%ld", number];
    }
    [self.window addSubview:view];
    //视图逐渐消失
    [UIView animateWithDuration:3.0f animations:^{
        view.alpha = 0.0f;
    }];
}

- (void)clickCollectionButton {
    //点击时改变按钮选中状态
    self.collectionButton.selected =! self.collectionButton.selected;
    //设置弹出视图
    UIView *view = [[UIView alloc] init];
    view.layer.cornerRadius = 8;
    view.layer.masksToBounds = YES;
    //实现弹出方法
    UIWindow *window = [[UIApplication sharedApplication].windows lastObject];
    window.windowLevel = UIWindowLevelNormal;
    //显示已收藏
    if ([self.collectionButton isSelected]) {
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"已收藏"]];
        view.frame = CGRectMake((SCREEN_WIDTH - 80) / 2, (SCREEN_HEIGHT - 70) / 2, 80, 70);
    }
    //显示取消收藏
    else {
        view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"已取消收藏"]];
        view.frame = CGRectMake((SCREEN_WIDTH - 100) / 2, (SCREEN_HEIGHT - 70) / 2, 100, 70);
    }
    [self.window addSubview:view];
    //视图逐渐消失
    [UIView animateWithDuration:3.0f animations:^{
        view.alpha = 0.0f;
    }];
}

#pragma mark - Lazy

- (UIToolbar *)toolBar {
    if (_toolBar == nil) {
        _toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _toolBar.backgroundColor = [UIColor colorWithRed:246.0/225 green:246.0/225 blue:246.0/225 alpha:1];
    }
    return _toolBar;
}

- (UIButton *)returnButton {
    if (_returnButton == nil) {
        _returnButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 5, 50, 35)];
        _returnButton.adjustsImageWhenHighlighted = NO;
        [_returnButton setBackgroundImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    }
    return _returnButton;
}

- (UIView *)verticalLine {
    if (_verticalLine == nil) {
        _verticalLine = [[UIView alloc] initWithFrame:CGRectMake(self.returnButton.right, 10, 0.5, self.returnButton.height - 10)];
        _verticalLine.backgroundColor = [UIColor lightGrayColor];
    }
    return _verticalLine;
}

- (UIButton *)commentButton {
    if (_commentButton == nil) {
        _commentButton = [[UIButton alloc] initWithFrame:CGRectMake(self.verticalLine.right + 15, 0, 25, self.returnButton.height)];
        _commentButton.adjustsImageWhenHighlighted = NO;
        [_commentButton setBackgroundImage:[UIImage imageNamed:@"评论"] forState:UIControlStateNormal];
    }
    return _commentButton;
}

- (UILabel *)commentLab {
    if (_commentLab == nil) {
        _commentLab = [[UILabel alloc] initWithFrame:CGRectMake(self.commentButton.right, 10, 70, 10)];
        _commentLab.font = [UIFont systemFontOfSize:10];
    }
    return _commentLab;
}

- (UIButton *)likesButton {
    if (_likesButton == nil) {
        _likesButton = [[UIButton alloc] initWithFrame:CGRectMake(self.commentLab.right, 0, self.commentButton.width, self.returnButton.height)];
        [_likesButton setBackgroundImage:[UIImage imageNamed:@"点赞"] forState:UIControlStateNormal];
        [_likesButton setBackgroundImage:[UIImage imageNamed:@"蓝色点赞"] forState:UIControlStateSelected];
        _likesButton.adjustsImageWhenHighlighted = NO;
        [_likesButton addTarget:self action:@selector(clickLikesButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _likesButton;
}

- (UILabel *)likesLab {
    if (_likesLab == nil) {
        _likesLab = [[UILabel alloc] initWithFrame:CGRectMake(self.likesButton.right, self.commentLab.top, self.commentLab.width, self.commentLab.height)];
        _likesLab.font = [UIFont systemFontOfSize:10];
    }
    return _likesLab;
}

- (UIButton *)collectionButton {
    if (_collectionButton == nil) {
        _collectionButton = [[UIButton alloc] initWithFrame:CGRectMake(self.likesLab.right, 0, self.commentButton.width, self.returnButton.height)];
        [_collectionButton setBackgroundImage:[UIImage imageNamed:@"收藏"] forState:UIControlStateNormal];
        [_collectionButton setBackgroundImage:[UIImage imageNamed:@"蓝色收藏"] forState:UIControlStateSelected];
        _collectionButton.adjustsImageWhenHighlighted = NO;
        [_collectionButton addTarget:self action:@selector(clickCollectionButton) forControlEvents:UIControlEventTouchUpInside];
    }
    return _collectionButton;
}

- (UIButton *)shareButton {
    if (_shareButton == nil) {
        _shareButton = [[UIButton alloc] initWithFrame:CGRectMake(self.collectionButton.right + self.commentLab.width, 0, self.commentButton.width, self.returnButton.height)];
        _shareButton.adjustsImageWhenHighlighted = NO;
        [_shareButton setBackgroundImage:[UIImage imageNamed:@"分享"] forState:UIControlStateNormal];
    }
    return _shareButton;
}

#pragma mark - Setter

- (void)setCommentCount:(long)CommentCount {
    self.commentLab.text = [NSString stringWithFormat:@"%ld", CommentCount];
}

- (void)setLikesCount:(long)likesCount {
    self.likesLab.text = [NSString stringWithFormat:@"%ld", likesCount];
}

@end
