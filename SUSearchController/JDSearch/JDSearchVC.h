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



@interface JDSearchVC : UIViewController

 
@end
















