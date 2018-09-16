//
//  JDHomeVC.m
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "JDHomeVC.h"
#import "JDNavigationView.h"
#import "JDSearchMainVC.h"
#import "SInfiniteView.h"
#import "UIView+Size.h"



#define SCREENSIZE [[UIScreen mainScreen] bounds].size
#define IPhoneX (SCREENSIZE.width == 375.f && SCREENSIZE.height == 812.f ? YES : NO)

@interface JDHomeVC ()
@property (nonatomic, strong) SInfiniteView *infiniteView;
@property (nonatomic, strong) JDNavigationView *navigationView;
@end

@implementation JDHomeVC
-(SInfiniteView *)infiniteView{
    if (!_infiniteView) {
        NSArray *imgArray=@[@"S0",@"S1",@"S2",@"S3",@"S4",@"S5"];
        
        CGFloat height=SCREENSIZE.width/2.f;
        if (IPhoneX) {
            height +=24.f;
            imgArray=@[@"S0X",@"S1X",@"S2X",@"S3X",@"S4X",@"S5X"];
        }
        _infiniteView=[[SInfiniteView alloc]initWithFrame:CGRectMake(0, 0, SCREENSIZE.width, height)];
        _infiniteView.imgArray=imgArray;
    }
    return _infiniteView;
}
-(JDNavigationView *)navigationView{
    if (!_navigationView) {
        CGFloat yCoordinate=20;
        if (IPhoneX) {
            yCoordinate=44;
        }
        __weak typeof(self) weakSelf =self;
        _navigationView = [[JDNavigationView alloc]initWithFrame:CGRectMake(0, yCoordinate, SCREENSIZE.width, 44)];
        _navigationView.searchActionBlock = ^{
            [weakSelf goSearchPage];
        };
        _navigationView.scanActionBlock = ^{
            NSLog(@"扫一扫");
        };
        _navigationView.messageActionBlock = ^{
            NSLog(@"消息");
        };
        _navigationView.audioActionBlock = ^{
            NSLog(@"语音");
        };
    }
    return _navigationView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(searchVCRemove) name:@"searchVCRemove" object:nil];
    
    self.view.backgroundColor=[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.view addSubview:self.infiniteView];
    [self.view addSubview:self.navigationView];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:YES];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}
- (void)searchVCRemove{
    __weak typeof(self) weakSelf =self;
    [UIView animateWithDuration:0.2 animations:^{
        weakSelf.navigationView.searchView.frame=({
            CGRect frame=weakSelf.navigationView.searchView.frame;
            frame.origin.x += 40;
            frame.size.width -= 40;
            frame;
        });
        weakSelf.navigationView.audioBtn.frame=({
            CGRect frame=weakSelf.navigationView.audioBtn.frame;
            frame.origin.x=weakSelf.navigationView.gs_width-20;
            frame;
        });
    }];
    CABasicAnimation *anim=[CABasicAnimation animationWithKeyPath:@"transform.scale"];
    anim.duration=0.2;
    anim.fromValue=@0;
    anim.toValue=@1;
    anim.fillMode=kCAFillModeForwards;
    anim.removedOnCompletion=NO;
    [_navigationView.messageBtn.layer addAnimation:anim forKey:nil];
}
- (void)goSearchPage{
    _navigationView.searchView.frame=({
        CGRect frame=_navigationView.searchView.frame;
        frame.origin.x -= 40;
        frame.size.width += 40;
        frame;
    });
    _navigationView.audioBtn.frame=({
        CGRect frame = _navigationView.audioBtn.frame;
        frame.origin.x = _navigationView.gs_width - 20;
        frame;
    });
    JDSearchMainVC *searchVC = [[JDSearchMainVC alloc]init];
    [self addChildViewController:searchVC];
    [self.view addSubview:searchVC.view];
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
