//
//  UIView+Frame.h
//  ZhiHuDaily
//
//  Created by coin on 2022/12/25.
//

//更简洁方便地修改frame属性
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Frame)

@property(nonatomic, assign) CGFloat top;
@property(nonatomic, assign) CGFloat bottom;
@property(nonatomic, assign) CGFloat left;
@property(nonatomic, assign) CGFloat right;
@property(nonatomic, assign) CGFloat width;
@property(nonatomic, assign) CGFloat height;

@end

NS_ASSUME_NONNULL_END
