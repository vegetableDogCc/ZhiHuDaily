//
//  BottomTableViewHeaderView.h
//  ZhiHuDaily
//
//  Created by coin on 2023/1/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

///复用标志
UIKIT_EXTERN NSString *MainBottomTableViewHeaderViewReuseIdentifier;

@interface MainBottomTableViewHeaderView : UITableViewHeaderFooterView

@property(nonatomic, copy) NSString *date;

@end

NS_ASSUME_NONNULL_END
