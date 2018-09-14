//
//  JDSearchMainVC.m
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "JDSearchMainVC.h"
#import "JDSearchVC.h"
#import "JDButton.h"
#import "SCountryModal.h"
#import "JDSearchHistory.h"
#import "SSearchResultVC.h"

#define SCREENSIZE [[UIScreen mainScreen] bounds].size
#define IPhoneX (SCREENSIZE.width == 375.f && SCREENSIZE.height == 812.f ? YES : NO)
@interface JDSearchMainVC ()<SearchResultsUpdating,SearchControllerDelegate,CAAnimationDelegate>{
    JDButton *_scanBtn;
    JDButton *_messageBtn;
}
@property (nonatomic, strong) JDSearchVC *searchVC;
@property (nonatomic, strong) JDSearchHistory *historyView;
@end

@implementation JDSearchMainVC

-(JDSearchVC *)searchVC{
    if (!_searchVC) {
        SSearchResultVC *resultVC=[[SSearchResultVC alloc]init];
        _searchVC=[[JDSearchVC alloc]initWithSearchResultsController:resultVC];
        _searchVC.delegate=self;
        _searchVC.searchResultsUpdater=self;
    }
    return _searchVC;
}
-(JDSearchHistory *)historyView{
    if (!_historyView) {
        CGFloat yCoordinate=64;
        if (IPhoneX) {
            yCoordinate=88;
        }
        _historyView=[[JDSearchHistory alloc]initWithFrame:CGRectMake(0, yCoordinate, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStyleGrouped];
        if (@available (ios 11,*)) {
            _historyView.contentInsetAdjustmentBehavior=UIScrollViewContentInsetAdjustmentNever;
        }
        __weak typeof(self) weakSelf =self;
        _historyView.scrollAction = ^{
            [weakSelf.searchVC.searchBar resignFirstResponder];
        };
        _historyView.hotBtnAction = ^(NSString *searchData) {
            [weakSelf messageAction];
        };
        _historyView.historyData=@[@"历史记录", @"笔记本", @"iPhone7", @"化妆品", @"台式机"];
    }
    return _historyView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setNavigationView];
    [self.view addSubview:self.historyView];
    [self.searchVC.searchBar becomeFirstResponder];
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [UIView animateWithDuration:0.2 animations:^{
        self.searchVC.searchBar.frame=({
            CGRect frame = self.searchVC.searchBar.frame;
            frame.origin.x-=40;
            frame.size.width+=40;
            frame;
        });
        self->_scanBtn.alpha=0;
    }];
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration=0.2;
    anim.fromValue=@1;
    anim.toValue=@0;
    anim.fillMode=kCAFillModeForwards;
    anim.removedOnCompletion=NO;
    anim.delegate=self;
    [_messageBtn.layer addAnimation:anim forKey:nil];
}
- (void)setNavigationView{
    CGFloat yCoordinate=20;
    if (IPhoneX) {
        yCoordinate=44;
    }
    UIView *navView=[[UIView alloc] initWithFrame:CGRectMake(0.f, yCoordinate, SCREENSIZE.width, 44.f)];
    [self.view addSubview:navView ];
    
    //扫一扫按钮
    _scanBtn = [JDButton buttonWithType:UIButtonTypeCustom];
    [_scanBtn setTitle:@"扫一扫" forState:UIControlStateNormal];
    [_scanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_scanBtn setImage:[UIImage imageNamed:@"scan_gray"] forState:UIControlStateNormal];
    _scanBtn.frame = CGRectMake(10.f, 7.f, 30.f, 33.f);
    [navView addSubview:_scanBtn];
    
    //消息按钮
    _messageBtn = [JDButton buttonWithType:UIButtonTypeCustom];
    [_messageBtn setTitle:@"消息" forState:UIControlStateNormal];
    [_messageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [_messageBtn setImage:[UIImage imageNamed:@"message_gray"] forState:UIControlStateNormal];
    _messageBtn.frame = CGRectMake(SCREENSIZE.width - 40.f, 7.f, 30.f, 33.f);
    [_messageBtn addTarget:self action:@selector(messageAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:_messageBtn];
    
    //添加搜索框
    self.searchVC.searchBar.frame = CGRectMake(50.f, 8.f, SCREENSIZE.width - 100.f, 28.f);
    [navView addSubview:self.searchVC.searchBar];
}
#pragma mark --CAAnimationDelegate
-(void)animationDidStop:(CABasicAnimation *)anim finished:(BOOL)flag{
    if ([anim.keyPath isEqualToString:@"transform.scale"] ) {
        _messageBtn.noImage=YES;
        [_messageBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        CABasicAnimation *anim1=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
        anim1.duration=0.2;
        anim1.fromValue=@0;
        anim1.toValue=@1;
        anim1.fillMode=kCAFillModeForwards;
        anim1.removedOnCompletion=NO;
        [_messageBtn.layer addAnimation:anim1 forKey:nil];
    }
}
#pragma mark --GSSearchControllerDelegate
-(void)didPresentSearchController:(JDSearchVC *)searchController{
    [self addChildViewController:searchController];
    
}
- (void)messageAction{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"searchVCRemove" object:nil];
    [self removeFromParentViewController];
    [self.view removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
