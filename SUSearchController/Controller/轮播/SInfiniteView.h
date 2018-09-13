//
//  SInfiniteView.h
//  SUSearchController
//
//  Created by Superman on 2018/9/10.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SInfiniteView : UIView

@property (nonatomic , strong) NSArray *imgArray;
@property (nonatomic , strong) NSArray *desArray;
@property (nonatomic , strong) void(^imgClick)(NSInteger index);
@property (nonatomic , assign, getter=isShowImgDescription) BOOL showDescription;
@end
