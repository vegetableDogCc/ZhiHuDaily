//
//  BottomTableViewCell.m
//  ZhiHuDaily
//
//  Created by coin on 2023/1/9.
//

#import "MainBottomTableViewCell.h"

#import <Masonry.h>

NSString *MainBottomTableViewCellReuseIdentifier = @"MainBottomTableViewCell";

@interface MainBottomTableViewCell ()

@property(nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) UILabel *titleLab;
@property(nonatomic, strong) UILabel *authorLab;

@end

@implementation MainBottomTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.imgView];
        [self.contentView addSubview:self.titleLab];
        [self.contentView addSubview:self.authorLab];
    }
    return self;
}

- (void)layoutIfNeeded {
    self.imgView.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.imgView];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.height.mas_equalTo(70);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(70);
    }];
    
    self.titleLab.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.titleLab];
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(24);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(275);
    }];
    
    self.authorLab.frame = CGRectMake(0, 0, 0, 0);
    [self.contentView addSubview:self.authorLab];
    [self.authorLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLab.mas_bottom).offset(4);
        make.left.equalTo(self.titleLab.mas_left);
        make.width.equalTo(self.titleLab.mas_width);
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
        _titleLab.font = [UIFont boldSystemFontOfSize:15.5];
        _titleLab.numberOfLines = 2;
    }
    return _titleLab;
}

- (UILabel *)authorLab {
    if (_authorLab == nil) {
        _authorLab = [[UILabel alloc] init];
        _authorLab.font = [UIFont systemFontOfSize:13];
        _authorLab.textColor = [UIColor grayColor];
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
