//
//  BannerCollectionViewCell.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/1.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///复用标志
UIKIT_EXTERN NSString *BannerCollectionViewCellReuseIdentifier;

@interface BannerCollectionViewCell : UICollectionViewCell

@property(nonatomic, copy) NSData *data;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *author;

@end

NS_ASSUME_NONNULL_END
