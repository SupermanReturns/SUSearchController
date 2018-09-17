//
//  SelectButton.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SelectButton.h"
#import "UIView+Size.h"

@implementation SelectButton

const CGFloat ratio =5/8;

-(void)layoutSubviews{
    [super layoutSubviews];
    self.titleLabel.frame=CGRectMake(0, 0, self.gs_width-20,self.gs_height );
    
    CGFloat imageWidth =10;
    CGFloat imageHeight =10*ratio;
    self.imageView.frame=CGRectMake(self.gs_width-20, (self.gs_height-imageHeight)/2, imageWidth, imageWidth*ratio);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
