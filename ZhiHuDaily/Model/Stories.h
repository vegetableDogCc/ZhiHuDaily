//
//  Story.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/28.
//

//新闻字典转模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stories : NSObject

@property(nonatomic, copy) NSString *gaPrefix; //供GoogleAnalytics使用
@property(nonatomic, copy) NSString *hint; //作者及阅读时间
@property(nonatomic) long identifier; //唯一标识符
@property(nonatomic, strong)NSString *imageHue; //用于动画，颜色渲染
@property(nonatomic, copy) NSString *imageUrl; //图片URL
@property(nonatomic, copy) NSString *title; //标题
@property(nonatomic, copy) NSString *url; //文章URL

@property(nonatomic) long type;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
