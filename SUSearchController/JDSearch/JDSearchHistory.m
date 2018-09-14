//
//  JDSearchHistory.m
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "JDSearchHistory.h"
#import "UIView+Size.h"

#define SCREENSIZE [[UIScreen mainScreen] bounds].size
#define IPhoneX (SCREENSIZE.width == 375.f && SCREENSIZE.height == 812.f ? YES : NO)
@implementation JDSearchHistory
static NSString *const cellID=@"cellID";

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if (self=[super initWithFrame:frame style:style]) {
        self.delegate=self;
        self.dataSource=self;
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return self;
}
#pragma mark -- UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!_historyData.count) {
        return 1;
    }
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==0) {
        return 1;
    }
    return self.historyData.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    //热搜
    if (indexPath.section ==0 && indexPath.row ==0) {
        if (!self.historyData.count) {
            [self createHotSearchHistory:cell hasHistory:NO];
        }else{
            [self createHotSearchHistory:cell hasHistory:YES];
        }
    }
    else{//历史搜索
        if (indexPath.row ==0 ) {
            cell.textLabel.textColor=[UIColor blackColor];
            cell.textLabel.font=[UIFont systemFontOfSize:16];
        }else{
            cell.textLabel.textColor=[UIColor grayColor];
            cell.textLabel.font=[UIFont systemFontOfSize:14];
        }
        cell.textLabel.text=self.historyData[indexPath.row];
    }
    return cell;
}
#pragma mark -- UITableViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (self.scrollAction) {
        self.scrollAction();
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (!self.historyData.count) {
            return 250  ;
        }
        return 80;
    }else if (indexPath.section==1 && indexPath.row>1){
        return 44;
    }
    return 35;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section !=0 &&self.hotBtnAction) {
        self.hotBtnAction(self.historyData[indexPath.row]);
    }
}
- (void)createHotSearchHistory:(UITableViewCell *)cell hasHistory:(BOOL)hasHistory{
    UIView *hotSearchView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, 80)];
    hotSearchView.backgroundColor=[UIColor clearColor];
    [cell addSubview:hotSearchView];
    
    UILabel *hotTitleLabel=[[UILabel alloc]initWithFrame:CGRectMake(15, 0, 100, 30)];
    hotTitleLabel.text=@"热搜";
    hotTitleLabel.backgroundColor=[UIColor clearColor];
    hotTitleLabel.font=[UIFont systemFontOfSize:15];
    [hotSearchView addSubview:hotTitleLabel];
    
    //热搜词汇数组
    NSArray *hotSearchWords = @[@"美特斯邦威", @"黄尾袋鼠", @"孕妇袜", @"广角镜头手机", @"唇彩唇蜜", @"汽车坐垫", @"应急启动电源", @"钢笔", @"鼠标垫护腕", @"不粘锅煎锅", @"橄榄调和油", @"铝框拉杆箱"];
    if (hasHistory) {
        UIScrollView *hotSearchScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 30, SCREENSIZE.width, 50)];
        hotSearchScrollView.showsHorizontalScrollIndicator = NO;
        hotSearchScrollView.showsVerticalScrollIndicator=NO;
        [hotSearchView addSubview:hotSearchScrollView];
        CGFloat xCoordinate =15;
        for (int i=0; i<hotSearchWords.count; i++) {
            NSString *hotWords=hotSearchWords[i];
            CGSize hotWordSize =[hotWords sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
            UIButton *hotBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            hotBtn.frame = CGRectMake(xCoordinate, 10.f, hotWordSize.width + 20.f, 30.f);
            hotBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            hotBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [hotBtn setTitle:hotWords forState:UIControlStateNormal];
            [hotBtn addTarget:self action:@selector(hotBtnAction:) forControlEvents:UIControlEventTouchUpInside];
            
            [hotSearchScrollView addSubview:hotBtn];
            xCoordinate = CGRectGetMaxX(hotBtn.frame) + 15.f;
            hotBtn.layer.cornerRadius = 6.0f;
            hotBtn.layer.masksToBounds = YES;
            hotBtn.backgroundColor = [UIColor grayColor];
        }
        hotSearchScrollView.contentSize = CGSizeMake(xCoordinate, 0.f);

    }else{
        CGFloat yCoordinate = 40.f;
        CGFloat xCoordinate = 15.f;
        for (int i=0; i<hotSearchWords.count; i++) {
            NSString *hotWords = hotSearchWords[i];
            CGSize hotWordSize = [hotWords sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12.f]}];
            if (xCoordinate + hotWordSize.width + 15 > SCREENSIZE.width) {
                xCoordinate = 15.f;
                yCoordinate += 45.f;
            }
            UIButton *hotBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            hotBtn.frame = CGRectMake(xCoordinate, yCoordinate, hotWordSize.width + 20.f, 30.f);
            hotBtn.titleLabel.font = [UIFont systemFontOfSize:12.f];
            hotBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
            [hotBtn setTitle:hotWords forState:UIControlStateNormal];
            [hotSearchView addSubview:hotBtn];
            
            xCoordinate = CGRectGetMaxX(hotBtn.frame) + 15.f;
            hotBtn.layer.cornerRadius = 6.0f;
            hotBtn.layer.masksToBounds = YES;
            hotBtn.backgroundColor = [UIColor grayColor];
        }
        hotSearchView.gs_height = yCoordinate + 45.f;
    }
}

#pragma mark action
- (void)hotBtnAction:(UIButton *)hotBtn{
    if (self.hotBtnAction) {
        
        self.hotBtnAction(hotBtn.titleLabel.text);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
