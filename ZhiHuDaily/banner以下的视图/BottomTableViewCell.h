//
//  BottomTableViewCell.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///复用标志
UIKIT_EXTERN NSString *BottomTableViewCellReuseIdentifier;

@interface BottomTableViewCell : UITableViewCell

@property(nonatomic, copy) NSData *imgData;

@property(nonatomic, copy) NSString *title;

@property(nonatomic, copy) NSString *author;

@end

NS_ASSUME_NONNULL_END
