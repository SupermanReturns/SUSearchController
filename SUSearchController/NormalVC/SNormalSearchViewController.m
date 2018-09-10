//
//  SNormalSearchViewController.m
//  SUSearchController
//
//  Created by Superman on 2018/8/31.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SNormalSearchViewController.h"
#import "SSearchResultVC.h"
#import "SCountryModal.h"

@interface SNormalSearchViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchControllerDelegate>{
    NSArray *_dataArray;//数据源
    NSArray *_filterArray;
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchController *searchController;

@end

@implementation SNormalSearchViewController
static NSString *const CellID = @"cellID";
-(UISearchController *)searchController{
    if (!_searchController) {
        SSearchResultVC *resultVC=[[SSearchResultVC alloc]init];
        _searchController = [[UISearchController alloc]initWithSearchResultsController:resultVC];
        _searchController.hidesNavigationBarDuringPresentation=YES;
        _searchController.dimsBackgroundDuringPresentation=YES;
        _searchController.searchBar.placeholder=@"查找您所在的区域";
        _searchController.delegate=self;
        _searchController.searchResultsUpdater=self;
    }
    return _searchController;
}
-(UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate=self;
        _tableView.dataSource=self;
        _tableView.tableFooterView=[[UIView alloc]init];

        if (@available(iOS 11,*)) {
            self.navigationItem.searchController =self.searchController;
            self.navigationItem.hidesSearchBarWhenScrolling = NO;
        }else{
            self.tableView.tableHeaderView = self.searchController.searchBar;
        }
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    }
    return _tableView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _dataArray=[SCountryModal sharedDataModal].dataArray;
    _filterArray =_dataArray;
    NSLog(@"数组数组===%@",_dataArray);
    self.view.backgroundColor=[UIColor whiteColor];
    self.definesPresentationContext =YES;
    [self.view addSubview:self.tableView];
}
#pragma mark --UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSPredicate *predicate=[NSPredicate predicateWithFormat:@"(SELF CONTAINS %@)",searchController.searchBar.text];
    _filterArray =[_dataArray filteredArrayUsingPredicate:predicate];
    _filterArray = searchController.searchBar.text.length >0 ? _filterArray:_dataArray;
    SSearchResultVC *resultVC=(SSearchResultVC *)searchController.searchResultsController;
    resultVC.filterDataArray = _filterArray;
    
//    [self.tableView reloadData];
}
#pragma mark --UISearchControllerDelegate
-(void)willPresentSearchController:(UISearchController *)searchController{
    NSLog(@"将要弹出searchController");
}
-(void)willDismissSearchController:(UISearchController *)searchController{
    NSLog(@"将要消失searchController");
}
#pragma mark --UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _filterArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.textLabel.text=_filterArray[indexPath.row];
    return cell;
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
