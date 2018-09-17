//
//  AddressTableView.h
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressTableView : UITableView

@property (nonatomic, strong) NSMutableDictionary *cityDataDict;
@property (nonatomic, strong) NSArray      *cityArr;
@property (nonatomic, strong) void(^selectCityAction)(NSString *city);

@end
