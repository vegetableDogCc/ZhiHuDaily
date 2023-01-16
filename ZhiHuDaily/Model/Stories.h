//
//  Story.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/28.
//

//字典转模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stories : NSObject

//供GoogleAnalytics使用
@property(nonatomic, copy) NSString *gaPrefix;
//作者及阅读时间
@property(nonatomic, copy) NSString *hint;
//唯一标识符
@property(nonatomic) NSInteger identifier;
//用于动画，颜色渲染
@property(nonatomic, strong)NSString *imageHue;
//图片URL
@property(nonatomic, copy) NSString *imageUrl;
//标题
@property(nonatomic, copy) NSString *title;
//文章URL
@property(nonatomic, copy) NSString *url;

@property(nonatomic) NSInteger type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
