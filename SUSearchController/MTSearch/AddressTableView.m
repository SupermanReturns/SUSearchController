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
