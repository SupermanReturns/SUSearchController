//
//  ViewController.m
//  SUSearchController
//
//  Created by Superman on 2018/8/31.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "ViewController.h"
#import "SNavigationController.h"


#define SCREENHEIGHT [[UIScreen mainScreen] bounds].size.height
#define SCREENWIDTH [[UIScreen mainScreen] bounds].size.width

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *myTableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSArray *titleArray;
@end

@implementation ViewController
static NSString * const cellID = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UITableView *myTableView=[[UITableView alloc]init];
    myTableView.frame=CGRectMake(0, 0,SCREENWIDTH , SCREENHEIGHT);
    myTableView.delegate=self;
    myTableView.dataSource=self;
    [self.view addSubview:myTableView];
    _myTableView=myTableView;
    [self.myTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];

    
    self.titleArray = @[@"UISearchController 基本使用",@"高仿京东搜索框",@"高仿美团地址搜索"];
    self.dataArray = @[@"SNormalSearchViewController",@"JDHomeVC",@"GSMTAddressMainVC"];
}
#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.titleArray[indexPath.row];
    return cell;
}
#pragma mark - Table view delegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id classVC = NSClassFromString(self.dataArray[indexPath.row]);
    id vc = [[classVC alloc] init];
    if([self.titleArray[indexPath.row] isEqualToString:@"高仿美团地址搜索"]){
        SNavigationController *nav = [[SNavigationController alloc] initWithRootViewController:vc];
        [self presentViewController:nav animated:YES completion:nil];
    }else{
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
