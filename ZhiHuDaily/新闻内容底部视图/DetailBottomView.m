//
//  DetailBottomView.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/19.
//

#import "DetailBottomView.h"

#import "UIView+Frame.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DetailBottomView ()

//底部的工具栏
@property(nonatomic, strong) UIToolbar *toolBar;
//返回主页按钮
@property(nonatomic, strong) UIButton *returnButton;
//竖直分割线
@property(nonatomic, strong) UIView *verticalLine;
//评论按钮
@property(nonatomic, strong) UIButton *commentButton;
//评论数文本框
@property(nonatomic, strong) UILabel *commentLab;
//点赞按钮
@property(nonatomic, strong) UIButton *likesButton;
//点赞数文本框
@property(nonatomic, strong) UILabel *likesLab;
//收藏按钮
@property(nonatomic, strong) UIButton *collectionButton;
//分享按钮
@property(nonatomic, strong) UIButton *shareButton;

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

//点击时改变点赞按钮选中状态
- (void)checkLikesButtonClick {
    _likesButton.selected = !_likesButton.selected;
}

//点击时改变收藏按钮选中状态
- (void)checkCollectionButtonClick {
    _collectionButton.selected = !_collectionButton.selected;
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
        [_likesButton setBackgroundImage:[UIImage imageNamed:@"已点赞"] forState:UIControlStateSelected];
        _likesButton.adjustsImageWhenHighlighted = NO;
        [_likesButton addTarget:self action:@selector(checkLikesButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
        [_collectionButton setBackgroundImage:[UIImage imageNamed:@"已收藏"] forState:UIControlStateSelected];
        _collectionButton.adjustsImageWhenHighlighted = NO;
        [_collectionButton addTarget:self action:@selector(checkCollectionButtonClick) forControlEvents:UIControlEventTouchUpInside];
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
