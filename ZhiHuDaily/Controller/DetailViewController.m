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
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface DetailViewController () <WKNavigationDelegate>

@property(nonatomic, strong) WKWebView *webView;
@property(nonatomic, strong) DetailBottomView *bottomView;

@end

@implementation DetailViewController

#pragma mark - Life Cycle

//视图加载后
- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.webView];
    [self.view addSubview:self.bottomView];
}

#pragma mark - WKNavigationDelegate

// 页面加载后
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    //屏蔽最顶部打开知乎日报和最底部进入知乎
    [webView evaluateJavaScript:@"document.getElementsByClassName('Daily')[0].remove();document.getElementsByClassName('view-more')[0].remove();" completionHandler:nil];
}

#pragma mark - Method

//返回主页
- (void)clickReturnButton {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Lazy

- (WKWebView *)webView {
    if (_webView == nil) {
        _webView = [[WKWebView alloc] initWithFrame:
                    CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - 55)];
        _webView.navigationDelegate = self;
        //展示新闻内容
        NSURL *mUrl = [NSURL URLWithString:self.url];
        [_webView loadRequest:[NSURLRequest requestWithURL:mUrl]];
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
        //点击返回
        [_bottomView.returnButton addTarget:self action:@selector(clickReturnButton) forControlEvents:UIControlEventTouchUpInside];
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
