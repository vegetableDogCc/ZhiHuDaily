//
//  DetailViewController.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/17.
//

#import "DetailViewController.h"

#import <WebKit/WebKit.h>

#import "SectionModel.h"

#import "DetailBottomView.h"

#import <Masonry.h>

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width

@interface DetailViewController ()

@property(nonatomic, strong) WKWebView *webView;

@property(nonatomic, strong) DetailBottomView *bottomView;

@end

@implementation DetailViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    [self.view addSubview:self.bottomView];
}

#pragma mark - Lazy

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        //展示新闻内容
        [SectionModel requeatWithId:self.identifier success:^(SectionModel * _Nonnull model) {
            NSURL *mUrl = [NSURL URLWithString:model.storyContentAry[0].url];
            NSURLRequest *request = [NSURLRequest requestWithURL:mUrl];
            [self->_webView loadRequest:request];
            
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"%@",error);
        }];
    }
    return _webView;
}

- (DetailBottomView *)bottomView {
    if (_bottomView == nil) {
        _bottomView = [[DetailBottomView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:_bottomView];
        [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideBottom).offset(-55);
            CGFloat mainScreenBottom = [UIScreen mainScreen].bounds.origin.y + [UIScreen mainScreen].bounds.size.height;
            make.bottom.mas_equalTo(mainScreenBottom);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        //展示互动数
        [SectionModel requestInteractionWithId:self.identifier success:^(SectionModel * _Nonnull model) {
            self->_bottomView.CommentCount = model.interactionAry[0].comments;
            self->_bottomView.likesCount = model.interactionAry[0].popularity;
            
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    }
    return _bottomView;
}

@end
