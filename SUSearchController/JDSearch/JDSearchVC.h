//
//  JDSearchVC.h
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDSearchBar.h"
@class JDSearchVC;

@protocol SearchControllerDelegate <NSObject>
@optional
-(void)didPresentSearchController:(JDSearchVC *)searchController;
-(void)didDismissSearchController:(JDSearchVC *)searchController;

@end;

@protocol SearchResultsUpdating <NSObject>
@required

- (void)updateSearchResultsForSearchController:(JDSearchVC *)searchController;
@end

@interface JDSearchVC : UIViewController

@property (nullable, nonatomic, weak) id <SearchResultsUpdating> searchResultsUpdater;
@property (nullable, nonatomic, weak) id <SearchControllerDelegate> delegate;
@property (nonatomic, strong, readonly) JDSearchBar *searchBar;
@property (nullable, nonatomic, strong, readonly) UIViewController *searchResultsController;

- (instancetype)initWithSearchResultsController:(nullable UIViewController *)searchResultsController;


@end
















