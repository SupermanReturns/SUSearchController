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

@interface MTAddressMainVC ()

@property (nonatomic, strong) AddressTableView *addressTableView;
@property (nonatomic, strong) MTAddressModal   *dataModal;

@end

@implementation MTAddressMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
