//
//  JDSearchHistory.h
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JDSearchHistory : UITableView<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *historyData;
@property (nonatomic, strong) void(^scrollAction)(void);
@property (nonatomic, strong) void(^hotBtnAction)(NSString *);

@end
