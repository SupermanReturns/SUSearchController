//
//  JDSearchVC.m
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "JDSearchVC.h"

@interface JDSearchVC (){
    JDSearchBar *_searchBar;
    UIViewController *_searchResultsController;
}

#define SCREENSIZE [[UIScreen mainScreen] bounds].size
#define IPhoneX (SCREENSIZE.width == 375.f && SCREENSIZE.height == 812.f ? YES : NO)
@end

@implementation JDSearchVC
-(JDSearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar=[[JDSearchBar alloc]init];
        [_searchBar addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    }
    return _searchBar;
}
-(void)textChange{
    if (self.searchBar.text.length ==1 &&self.delegate) {
        [self.delegate didPresentSearchController:self];
    }
    if (self.searchBar.text.length == 0 &&self.delegate) {
        [self.delegate didDismissSearchController:self];
    }
    if (self.searchResultsUpdater) {
        [self.searchResultsUpdater updateSearchResultsForSearchController:self];
    }
}
-(instancetype)initWithSearchResultsController:(UIViewController *)searchResultsController{
    self=[super init];
    if (searchResultsController) {
        _searchResultsController=searchResultsController;
        CGFloat yCoordinate =64.f;
        if (IPhoneX) {
            yCoordinate=88.f;
        }
        self.view.frame=CGRectMake(0, yCoordinate, SCREENSIZE.width, SCREENSIZE.height);
        [self addChildViewController:_searchResultsController];
        _searchResultsController.view.frame=searchResultsController.view.bounds;
        [self.view addSubview:_searchResultsController.view];
    }
    return self;
}
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
