//
//  Story.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/28.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Story : NSObject

@property(nonatomic, copy) NSString *gaPrefix;

//作者及阅读时间
@property(nonatomic, copy) NSString *hint;

//唯一标识符
@property(nonatomic) NSInteger identifier;

@property(nonatomic, strong)NSString *imageHue;

//图片URL
@property(nonatomic, copy) NSString *imageUrl;

//标题
@property(nonatomic, copy) NSString *title;

@property(nonatomic) NSInteger type;

//文章URL
@property(nonatomic, copy) NSString *url;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
