//
//  BannerCollectionViewCell.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/1.
//

#import "MainBannerCollectionViewCell.h"

#import <Masonry.h>

NSString *MainBannerCollectionViewCellReuseIdentifier = @"MainBannerCollectionViewCell";

@interface MainBannerCollectionViewCell ()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *authorLab;

@end

@implementation MainBannerCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.authorLab];
    }
    return self;
}

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes {
    self.imgView.frame = CGRectMake(0, 0, layoutAttributes.size.width, layoutAttributes.size.height);
    self.authorLab.frame = CGRectMake(20, layoutAttributes.size.height - 50, 300, 35);
    
    self.titleLab.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.authorLab.mas_top);
        make.left.equalTo(self.authorLab.mas_left);
        make.width.mas_equalTo(320);
    }];
}

#pragma mark - Lazy

- (UIImageView *)imgView {
    if (_imgView == nil) {
        _imgView = [[UIImageView alloc] init];
    }
    return _imgView;
}

- (UILabel *)titleLab {
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:20];
        _titleLab.textColor = [UIColor whiteColor];
        _titleLab.numberOfLines = 0;
    }
    return _titleLab;
}

- (UILabel *)authorLab {
    if (_authorLab == nil) {
        _authorLab = [[UILabel alloc] init];
        _authorLab.font = [UIFont systemFontOfSize:13];
        _authorLab.textColor = [UIColor whiteColor];
    }
    return _authorLab;
}

#pragma mark - Setter

- (void)setImgData:(NSData *)imgData {
    _imgData = imgData.copy;
    self.imgView.image = [UIImage imageWithData:imgData];
}

- (void)setTitle:(NSString *)title {
    self.titleLab.text = title.copy;
}

- (void)setAuthor:(NSString *)author {
    self.authorLab.text = author.copy;
}

#pragma mark - Getter

- (NSString *)title {
    return self.titleLab.text.copy;
}

- (NSString *)author {
    return self.authorLab.text.copy;
}

@end
