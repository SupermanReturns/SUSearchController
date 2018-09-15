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
}
- (void)goSearchPage{

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
