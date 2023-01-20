//
//  StoriesDetail.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/17.
//

//新闻内容字典转模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoriesContent : NSObject

//HTML格式的新闻
@property(nonatomic, strong) NSString *body;
//唯一标识符
@property(nonatomic) long identifier;
//供手机端的WebView(UIWebView)使用
@property(nonatomic, copy) NSString *js;
//供GoogleAnalytics使用
@property(nonatomic, copy) NSString *gaPrefix;
//文章URL
@property(nonatomic, copy) NSString *url;
//标题
@property(nonatomic, copy) NSString *title;
//用于动画，颜色渲染
@property(nonatomic, strong)NSString *imageHue;
//在文章浏览界面中使用的大图
@property(nonatomic, copy) NSString *imageUrl;
//供在线查看内容与分享至SNS用的URL
@property(nonatomic, copy) NSString *shareUrl;
//图片URL
@property(nonatomic, copy) NSString *imagesUrl;
//供手机端的WebView(WKWebView)使用
@property(nonatomic, copy) NSString *css;

@property(nonatomic) NSInteger type;

@property(nonatomic) NSInteger publishTime;

@property(nonatomic) NSInteger createTime;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
