//
//  SInfiniteView.m
//  SUSearchController
//
//  Created by Superman on 2018/9/10.
//  Copyright © 2018年 Superman. All rights reserved.
//
#define MaxSectionNum (100)


#import "SInfiniteView.h"
#import "Masonry.h"

#import "GSProxy.h"
@interface SInfiniteView()<UICollectionViewDelegate , UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, weak) NSTimer *timer;

@end

@implementation SInfiniteView
static NSString *const cellID = @"News";
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        UIPageControl *pageControl=[[UIPageControl alloc]init];
        pageControl.currentPageIndicatorTintColor=[UIColor yellowColor];
        pageControl.pageIndicatorTintColor=[UIColor lightGrayColor];
        _pageControl=pageControl;
    }
    return _pageControl;
}
-(UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc]init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumLineSpacing=0.f;
        flowLayout.minimumInteritemSpacing=0.f;
        flowLayout.itemSize=CGSizeMake(self.frame.size.width, self.frame.size.height);
        
        UICollectionView *collectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:flowLayout];
        collectionView.pagingEnabled=YES;
        collectionView.delegate=self;
        collectionView.dataSource=self;
        [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:cellID];
        _collectionView=collectionView;
    }
    return _collectionView;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.showDescription=YES;
        [self addSubview:self.collectionView];
        [self addSubview:self.pageControl];
        [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.collectionView).with.offset(-15);
            make.width.mas_equalTo(150);
            make.bottom.equalTo(self.collectionView.mas_bottom);
            make.height.mas_equalTo(20);
        }];
        [self startTimer];
    }
    return self;
}
-(void)setShowDescription:(BOOL)showDescription{
    _showDescription=showDescription;
}
-(void)setImgArray:(NSArray *)imgArray{
    _imgArray=imgArray;
    self.pageControl.numberOfPages = imgArray.count;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:MaxSectionNum/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    [self.collectionView reloadData];
}
- (void)startTimer{
    NSTimer *timer=[NSTimer timerWithTimeInterval:2.f target:[GSProxy proxyWithTarget:self] selector:@selector(nextPage) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop]addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer=timer;
}
-(void)stopTimer{
    [self.timer invalidate];
    self.timer=nil;
}
-(void)nextPage{
    NSIndexPath *currentIndexPath=[[self.collectionView indexPathsForVisibleItems]lastObject];
    
    NSIndexPath *currentIndexPathReset=[NSIndexPath indexPathForRow:currentIndexPath.item inSection:MaxSectionNum/2];
    
    [self.collectionView scrollToItemAtIndexPath:currentIndexPathReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    
    NSInteger nextItem=currentIndexPathReset.item+1;
    NSInteger nextSection =currentIndexPathReset.section;
    if (nextItem ==self.imgArray.count) {
        nextItem =0;
        nextItem ++;
    }
    
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForRow:nextItem inSection:nextSection];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
#pragma mark --UICollectionViewDataSource
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return MaxSectionNum;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imgArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    UIImageView *imgView=[[UIImageView alloc]init];
    [cell.contentView addSubview:imgView];
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(cell);
    }];
    imgView.image=[UIImage imageNamed:self.imgArray[indexPath.row]];
    if (self.isShowImgDescription && self.desArray.count>0) {
        UILabel *titleLabel =[[UILabel alloc]init];
        [cell.contentView addSubview:titleLabel];
        titleLabel.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        titleLabel.textColor = [UIColor whiteColor];
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.and.right.top.equalTo(cell);
            make.height.mas_equalTo(40);
        }];
        titleLabel.text=[NSString stringWithFormat:@"  %@",self.desArray[indexPath.row]];
    }
    return cell;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self stopTimer];
}
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    [self startTimer];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.pageControl.currentPage = (NSInteger)(scrollView.contentOffset.x/self.collectionView.frame.size.width +0.5) % self.imgArray.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.imgClick) {
        self.imgClick([self.imgArray[indexPath.row]integerValue]);
    }
}
-(void)dealloc{
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end




























