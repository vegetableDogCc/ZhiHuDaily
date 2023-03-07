//
//  BannerCollectionViewCell.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/1.
//

//主页banner视图
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///复用标志
UIKIT_EXTERN NSString *MainBannerCollectionViewCellReuseIdentifier;

@interface MainBannerCollectionViewCell : UICollectionViewCell

@property(nonatomic, copy) NSData *imgData; //图片data
@property(nonatomic, copy) NSString *title; //文章标题字符串
@property(nonatomic, copy) NSString *author; //作者字符串

@end

NS_ASSUME_NONNULL_END
