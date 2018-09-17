//
//  AddressTableView.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "AddressTableView.h"
#import "AddressFirstHeaderView.h"
#import "AddressOtherHeaderView.h"
#import "AddressSectionCell.h"
#import "SSearchResultVC.h"

@interface AddressTableView ()<UITableViewDelegate,UITableViewDataSource,headerViewDelegate,UISearchResultsUpdating,UISearchControllerDelegate>{
    BOOL _countyDisplay;
    CGFloat _countyHeight;
    BOOL isRightIndexHidden;//是否隐藏左边的索引
}
@property(nonatomic, strong) UISearchController *searchCtrl;
@property (nonatomic, strong) NSMutableDictionary *sectionDict;//组数据
@property (nonatomic, strong) NSMutableArray *indexesArray;
@property (nonatomic, strong) NSArray *hotCityArray;
@property (nonatomic, strong)  NSMutableArray *countyArray;//存放区县数据
@property (nonatomic, strong) NSMutableArray *filterArray;
@end

@implementation AddressTableView
static NSString *const cellID = @"cellID";
static NSString *const headerCellID = @"headerCellID";

-(NSMutableArray *)filterArray{
    if (!_filterArray) {
        _filterArray =[NSMutableArray array];
    }
    return _filterArray;
}
-(UISearchController *)searchCtrl{
    if (!_searchCtrl) {
        SSearchResultVC *resultVC=[[SSearchResultVC alloc]init];
        _searchCtrl=[[UISearchController alloc]initWithSearchResultsController:resultVC];
        _searchCtrl.searchResultsUpdater=self;
        _searchCtrl.delegate = self;
        _searchCtrl.searchBar.placeholder = @"输入城市名称";
        _searchCtrl.hidesNavigationBarDuringPresentation = NO;
        _searchCtrl.dimsBackgroundDuringPresentation = YES;
        
        //修改取消和光标颜色
        _searchCtrl.searchBar.tintColor = [UIColor grayColor];
        //修改取消按钮的标题
        [[UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTitle:@"取消"];

        _searchCtrl.searchBar.barTintColor = [UIColor whiteColor];
        //取消上下两条线
        NSArray *subViewArr = _searchCtrl.searchBar.subviews.firstObject.subviews;
        for (UIView *view in subViewArr) {
            if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
            {
                [view removeFromSuperview];
            }
        }
        
        
        //设置textField背景颜色
        UITextField *textField = [_searchCtrl.searchBar valueForKey:@"_searchField"];
        textField.backgroundColor = [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
    }
    return _searchCtrl;
}
-(NSMutableArray *)indexesArray{
    if (!_indexesArray) {
        _indexesArray = [NSMutableArray arrayWithObjects:@"!", @"#", @"%", nil];
    }
    return _indexesArray;
}
-(NSArray *)hotCityArray{
    if (!_hotCityArray) {
        _hotCityArray = [NSArray arrayWithObjects:@"北京",@"上海",@"广州",@"深圳", nil];
    }
    return _hotCityArray;
}
#pragma  mark --UISearchResultsUpdating
-(void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}
#pragma  mark --UISearchControllerDelegate
-(void)willPresentSearchController:(UISearchController *)searchController{
    
    isRightIndexHidden = YES;
    [self reloadSectionIndexTitles];
}
- (void)didDismissSearchController:(UISearchController *)searchController {
    isRightIndexHidden = NO;
    [self reloadSectionIndexTitles];
}
#pragma mark - headerView delegate method
- (void)citySelectAction:(BOOL)isSelect {
    //标记当前选择的是展开还是收缩
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0 ];
    
    if (_countyDisplay) {//展开的情况
        NSString *currentCity=[[NSUserDefaults standardUserDefaults]objectForKey:@"currentCity"];
        _countyArray = [NSMutableArray arrayWithObject:@"全城"];
        [_countyArray addObjectsFromArray:_cityDataDict[currentCity]];

        //计算行高
        NSUInteger lines = (self.countyArray.count +3 -1)/3;
        _countyHeight =lines*44;
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
