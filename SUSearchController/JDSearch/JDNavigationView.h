//
//  JDNavigationView.h
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JDButton.h"

@interface JDNavigationView : UIView

typedef void (^btnBlock)(void);

@property (nonatomic, strong) UIImageView *searchView;
@property (nonatomic, strong) JDButton *scanBtn;
@property (nonatomic, strong) JDButton *messageBtn;
@property (nonatomic, strong) UIButton *audioBtn;
@property (nonatomic, strong) btnBlock scanActionBlock;
@property (nonatomic, strong) btnBlock messageActionBlock;
@property (nonatomic, strong) btnBlock audioActionBlock;
@property (nonatomic, strong) btnBlock searchActionBlock;
@end
