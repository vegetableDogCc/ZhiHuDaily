//
//  SectionModel.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

//将网络请求的结果转为模型
#import <Foundation/Foundation.h>
#import "Stories.h"

NS_ASSUME_NONNULL_BEGIN

@interface SectionModel : NSObject

@property(nonatomic, copy) NSString *date;

//创建返回Stories对象的属性
@property(nonatomic, strong) NSArray <Stories *> *storyAry;

+ (void)requestLatest;

@end

NS_ASSUME_NONNULL_END
