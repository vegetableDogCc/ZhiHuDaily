//
//  ViewController.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "MainViewController.h"
#import <Masonry.h>
#import "UIView+Frame.h"
#import "TopView.h"
#import "BannerCollectionViewCell.h"
#import "SectionModel.h"
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainViewController () <
    UICollectionViewDataSource,
    UICollectionViewDelegate
    
>

@property(nonatomic, strong) UIView *topView;

@property(nonatomic, strong) UICollectionView *collectionView;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Lazy

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.height.mas_equalTo(52);
        }];
    }
    return _topView;
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) collectionViewLayout:layout];
        
        [self.view addSubview:self.collectionView];
        [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.top.equalTo(_topView.mas_bottom);
            make.width.mas_equalTo(SCREEN_WIDTH);
            make.height.mas_equalTo(SCREEN_WIDTH);
        }];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:BannerCollectionViewCell.class forCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier];
    }
    return _collectionView;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    [SectionModel requestLatestSuccess:^(SectionModel * _Nonnull model, SectionModelStoryPlace  _Nonnull storyPlace) {
        if (storyPlace == SectionModelStoryPlaceBanner) {
            cell.title = model.storyAry[indexPath.item].title;
            cell.author = model.storyAry[indexPath.item].hint;
            cell.data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.storyAry[indexPath.item].imageUrl]];
        }
    } failure:^(NSError * _Nonnull error) {
        //NSLog(@"%@",error);
        NSLog(@"error");
    }];
    //cell.imgName = @"钢铁侠";
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"单击了图片");
}

#pragma mark - <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.frame.size;
}

@end
