//
//  InteractionNumber.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/21.
//

//点赞评论数字典转模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InteractionNumber : NSObject

//长评论数
@property(nonatomic) long longComments;
//点赞数
@property(nonatomic) long popularity;
//短评数
@property(nonatomic) long shortComments;
//评论总数
@property(nonatomic) long comments;

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
