//
//  SectionModel.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import <Foundation/Foundation.h>
#import "Stories.h"

NS_ASSUME_NONNULL_BEGIN

@interface SectionModel : NSObject

@property(nonatomic, copy) NSString *date;

@property(nonatomic, strong) NSArray <Stories *> *storyAry;

+ (void)requestLatest;

@end

NS_ASSUME_NONNULL_END
