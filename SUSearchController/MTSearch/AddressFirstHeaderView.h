//
//  AddressFirstHeaderView.h
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol headerViewDelegate <NSObject>
@required
-(void)citySelectAction:(BOOL)isSelect;
@end

@interface AddressFirstHeaderView : UITableViewHeaderFooterView
@property (nonatomic, weak) id<headerViewDelegate> delegate;

@end
