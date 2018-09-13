//
//  JDSearchBar.m
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "JDSearchBar.h"
#define SColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

@implementation JDSearchBar
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:14.f];
        self.backgroundColor = SColor(240, 243, 245);
        self.layer.cornerRadius = 5.f;
        self.placeholder = @"京东超级品牌日";
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, 28.f, 28.f)];
        UIImageView *searchIcon = [[UIImageView alloc] initWithFrame:CGRectMake(8.f, 7.5f, 13.f, 13.f)];
        searchIcon.image = [UIImage imageNamed:@"search_gray"];
        [leftView addSubview:searchIcon];
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
