//点赞评论数字典转模型
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface InteractionNumber : NSObject

@property(nonatomic) long longComments; //长评论数
@property(nonatomic) long popularity; //点赞数
@property(nonatomic) long shortComments; //短评数
@property(nonatomic) long comments; //评论总数

- (instancetype)initWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
