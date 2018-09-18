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
    NSLog(@"代理");
    //标记当前选择的是展开还是收缩
    _countyDisplay = isSelect;
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0 ];
    
    if (_countyDisplay) {//展开的情况
        NSString *currentCity=[[NSUserDefaults standardUserDefaults]objectForKey:@"currentCity"];
        _countyArray = [NSMutableArray arrayWithObject:@"全城"];
        [_countyArray addObjectsFromArray:_cityDataDict[currentCity]];

        //计算行高
        NSUInteger lines = (self.countyArray.count +3 -1)/3;
        _countyHeight =lines*44;
        [self beginUpdates];
        [self insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self endUpdates];
    }else{
        [_countyArray removeAllObjects];
        //更新tableView
        [self beginUpdates];
        [self deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        [self endUpdates];
    }
}
#pragma mark -- system method
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    if(self = [super initWithFrame:frame style:style]){
        self.dataSource=self;
        self.delegate = self;
        self.tableHeaderView=self.searchCtrl.searchBar;
        
        [self registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
        [self registerClass:[AddressOtherHeaderView class] forHeaderFooterViewReuseIdentifier:headerCellID];
    }
    return self;
}
-(void)setCityArr:(NSArray *)cityArr{
    _cityArr = cityArr;
    
    _sectionDict =[NSMutableDictionary dictionary];
    for (NSDictionary *dict in self.cityArr) {
        NSString *cityName = dict[@"name"];
        NSString *cityPinyin = dict[@"pinyin"];
        NSString *firstWord = [[cityPinyin substringToIndex:1] uppercaseString];

        //indexArray存储首字母的数组
        if (![self.indexesArray containsObject:firstWord]) {
            [self.indexesArray addObject:firstWord];
            NSMutableArray *citiesArr = [NSMutableArray arrayWithObject:cityName];
            _sectionDict[firstWord] = citiesArr;
        }else{
            NSMutableArray *citiesArr = _sectionDict[firstWord];
            [citiesArr addObject:cityName];
        }
        
    }
    [_indexesArray sortUsingSelector:@selector(compare:)];
    [self reloadData];
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return self.sectionDict.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    if (section ==0) {
        return _countyDisplay?1:0;
    }else if (section<4){
        return 1;
    }
    NSMutableArray *citiesArr =self.sectionDict[self.indexesArray[section]];
    return citiesArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section<4) {
        NSArray *cityArr;
        switch (indexPath.section) {
            case 0:
                cityArr = _countyArray;
                break;
            case 1: //当前城市
                cityArr = @[@"长沙"];
                break;
            case 2: //历史访问的城市
                cityArr = self.hotCityArray;
                break;
            case 3:
                cityArr = self.hotCityArray;
                break;
            default:
                break;
        }
        AddressSectionCell *cell=[[AddressSectionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"sectionCell" cityArr:cityArr];
        if (indexPath.section==0) {
            cell.btnBlock = ^(NSString *cityName) {
                if (self.selectCityAction) {
                    self.selectCityAction(cityName);
                }
            };
        }else{
            cell.btnBlock = ^(NSString *cityName) {
                [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@市",cityName] forKey:@"currentCity"];
                
                if (self.selectCityAction) {
                    self.selectCityAction(cityName);
                }
            };
        }
        return cell;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    NSArray *arr = _sectionDict[_indexesArray[indexPath.section]];
    cell.textLabel.text=arr[indexPath.row];
    
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    NSString *title;
    switch (section) {
        case 0:
        {
            AddressFirstHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"firstSection"];
            if (!headerView) {
                headerView = [[AddressFirstHeaderView alloc] initWithReuseIdentifier:@"firstSection"];
            }
            headerView.delegate = self;
            return headerView;
        }
            break;
        case 1:
            title = @"定位城市";
            break;
        case 2:
            title = @"最近访问城市";
            break;
        case 3:
            title = @"热门城市";
            break;
        default:
            title = _indexesArray[section];
            break;
    }
    
    AddressOtherHeaderView *headerView =[tableView dequeueReusableHeaderFooterViewWithIdentifier:headerCellID];
    if (!headerView) {
        headerView=[[AddressOtherHeaderView alloc]initWithReuseIdentifier:headerCellID];
    }
    headerView.text=title;
    return headerView;
}
-(NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView{
    return isRightIndexHidden?0:self.indexesArray;
}
#pragma mark -- UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.selectCityAction) {
        NSArray *arr = _sectionDict[_indexesArray[indexPath.section]];
        NSString *city=arr[indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:[NSString stringWithFormat:@"%@市",city] forKey:@"currentCity"];
        self.selectCityAction(city);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return _countyHeight;
    }
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
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
