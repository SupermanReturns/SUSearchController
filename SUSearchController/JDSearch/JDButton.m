//
//  JDButton.m
//  SUSearchController
//
//  Created by Superman on 2018/9/13.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "JDButton.h"
#import "UIView+Size.h"

@implementation JDButton
-(void)layoutSubviews{
    [super layoutSubviews];
    if (!_noImage) {
        self.imageView.frame = CGRectMake(6.f, 0, self.gs_width - 12.f, self.gs_width - 12.f);
        self.titleLabel.frame = CGRectMake(0.f, self.gs_height - 12.f, self.gs_width, 12.f);
        self.titleLabel.font = [UIFont systemFontOfSize:9.f];
    }else{
        self.imageView.frame = CGRectZero;
        self.titleLabel.frame = CGRectMake(0.f, 0.f, self.gs_width, self.gs_height);
        self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
