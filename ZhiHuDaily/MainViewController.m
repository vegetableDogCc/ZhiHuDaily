//
//  ViewController.m
//  ZhiHuDaily
//
//  Created by coin on 2022/12/24.
//

#import "MainViewController.h"

#import <Masonry.h>

#import "TopView.h"

#import "SectionModel.h"

#import "BannerCollectionViewCell.h"

#import "BottomTableViewCell.h"
#import "BottomTableViewHeaderView.h"

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface MainViewController () <
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UITableViewDataSource,
    UITableViewDelegate
>

@property(nonatomic, strong) UIView *topView;
@property(nonatomic, strong) UICollectionView *collectionView;
@property(nonatomic, strong) UITableView *tableView;

//暂时存放请求到的model中的date
@property(nonatomic, copy) NSString *latestDate;
//存放每个latestDate
@property(nonatomic, strong) NSMutableArray <NSString *> *timeArray;
//存放顶部视图数据
@property(nonatomic, strong) NSArray <Stories *> *topDataArray;
//存放tableView视图数据
@property(nonatomic, strong) NSMutableArray <Stories *> *dataArray;

@end

@implementation MainViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.topView];
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [SectionModel requestLatestSuccess:^(SectionModel * _Nonnull model, SectionModelStoryPlace  _Nonnull storyPlace) {
        //判断请求到的是否是顶部视图数据
        if (storyPlace == SectionModelStoryPlaceBanner) {
            self.topDataArray = [[NSArray alloc] initWithArray:model.storyAry];
            [self.collectionView reloadData];
            //得到最新的日期
            self.latestDate = model.date;
        }
        //判断请求到的是否是tableView视图数据
        else if (storyPlace == SectionModelStoryPlaceBottom) {
            self.dataArray = [[NSMutableArray alloc] initWithArray:model.storyAry];
            [self.tableView reloadData];
        }
    } failure:^(NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 5;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BannerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier forIndexPath:indexPath];

    cell.title = self.topDataArray[indexPath.item].title;
    cell.author = self.topDataArray[indexPath.item].hint;
    cell.imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.topDataArray[indexPath.item].imageUrl]];
    
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

#pragma mark - <UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count / 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:BottomTableViewCellReuseIdentifier forIndexPath:indexPath];
    
    cell.title = self.dataArray[indexPath.row + indexPath.section * 6].title;
    cell.author = self.dataArray[indexPath.row + indexPath.section * 6].hint;
    cell.imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:self.dataArray[indexPath.row + indexPath.section * 6].imageUrl]];

    return cell;
}

#pragma mark - <UITableViewDelegate>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        return 0;
    }
    else {
        return 24;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    BottomTableViewHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:BottomTableViewCellReuseIdentifier];
    if (headerView == nil) {
        headerView = [[BottomTableViewHeaderView alloc] initWithReuseIdentifier:BottomTableViewCellReuseIdentifier];
    }
    headerView.date = self.timeArray[section - 1];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //判断是否为最后一个cell
    if((indexPath.row + 1) * (indexPath.section + 1) == self.dataArray.count) {
        [SectionModel requestWithDate:self.latestDate success:^(SectionModel * _Nonnull model) {
            //更新latestDate
            self.latestDate = model.date;
            
            [self.dataArray addObjectsFromArray:model.storyAry];
            [self.tableView reloadData];
            
            //转换日期格式为x月x日，以准备赋值给section间的dateLab
            //把NSString转化为NSDate
            NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
            formatter1.dateFormat = @"yyyyMMdd";
            NSDate *Mdate = [formatter1 dateFromString:self.latestDate];
            //把NSDate转化为要求格式的NSString
            NSDateFormatter *formatter2 = [[NSDateFormatter alloc] init];
            formatter2.dateFormat = @"M月d日";
            NSString *str = [formatter2 stringFromDate:Mdate];
            //将得到的NSString添加到数组中
            if (self.timeArray == nil) {
                self.timeArray = [NSMutableArray array];
            }
            [self.timeArray addObject:str];
            
        } failure:^(NSError * _Nonnull error) {
            NSLog(@"error");
        }];
    }
}

#pragma mark - Lazy

- (UIView *)topView {
    if (_topView == nil) {
        _topView = [[TopView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
        [self.view addSubview:_topView];
        [_topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.height.mas_equalTo(52);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
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
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) collectionViewLayout:layout];
        
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        _collectionView.pagingEnabled = YES;
        _collectionView.showsHorizontalScrollIndicator = NO;
        
        [_collectionView registerClass:BannerCollectionViewCell.class forCellWithReuseIdentifier:BannerCollectionViewCellReuseIdentifier];
    }
    return _collectionView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStyleGrouped];
        
        [self.view addSubview:_tableView];
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_topView.mas_bottom);
            make.height.mas_equalTo(SCREEN_HEIGHT-70);
            make.left.mas_equalTo(0);
            make.width.mas_equalTo(SCREEN_WIDTH);
        }];
        
        _tableView.dataSource = self;
        _tableView.delegate = self;
        
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.tableHeaderView = self.collectionView;
        [_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        
        _tableView.estimatedRowHeight = 0;
        _tableView.estimatedSectionHeaderHeight = 0;
        _tableView.estimatedSectionFooterHeight = 0;
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;

        [_tableView registerClass:BottomTableViewCell.class forCellReuseIdentifier:BottomTableViewCellReuseIdentifier];
        [_tableView registerClass:BottomTableViewHeaderView.class forHeaderFooterViewReuseIdentifier:BottomTableViewHeaderViewReuseIdentifier];
    }
    return _tableView;
}

@end
