//
//  MTAddressMainVC.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "MTAddressMainVC.h"
#import "SegmentedControl.h"
#import "AddressTableView.h"
#import "MTAddressModal.h"

#define SCREENSIZE [[UIScreen mainScreen] bounds].size

@interface MTAddressMainVC ()

@property (nonatomic, strong) AddressTableView *addressTableView;
@property (nonatomic, strong) MTAddressModal   *dataModal;

@end

@implementation MTAddressMainVC
-(AddressTableView *)addressTableView{
    if (!_addressTableView) {
        CGFloat yCoordinate = 0;
        _addressTableView =[ [AddressTableView alloc]initWithFrame:CGRectMake(0.f, yCoordinate, SCREENSIZE.width, SCREENSIZE.height) style:UITableViewStylePlain];
        _addressTableView.cityDataDict=self.dataModal.cityDataDict;
        _addressTableView.cityArr=self.dataModal.cityArr;
        __weak typeof(self) weakSelf = self;
        _addressTableView.selectCityAction = ^(NSString *city) {
            [weakSelf closeAction];
            NSLog(@"当前选中的城市:%@",city);
        };
    }
    return _addressTableView;
}
-(MTAddressModal *)dataModal{
    if (!_dataModal) {
        _dataModal = [[MTAddressModal alloc]init];
    }
    return _dataModal;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    [self setupNavigationBar];
    [self.view addSubview:self.addressTableView];
}
-(void)setupNavigationBar{
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeBtn.frame = CGRectMake(0.f, 0.f, 20.f, 20.f);
    [closeBtn setBackgroundImage:[UIImage imageNamed:@"btn_close"] forState:UIControlStateNormal];
    [closeBtn addTarget:self action:@selector(closeAction) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:closeBtn];
    
    SegmentedControl *segment=[[SegmentedControl alloc]initWithItems:@[@"国内",@"海外"]];
    self.navigationItem.titleView=segment;
    
}
- (void)closeAction{
    [self dismissViewControllerAnimated:YES completion:nil];
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
