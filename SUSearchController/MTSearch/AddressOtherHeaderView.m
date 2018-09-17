//
//  AddressOtherHeaderView.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "AddressOtherHeaderView.h"
@interface AddressOtherHeaderView()
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation AddressOtherHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor=[UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
        _titleLabel.backgroundColor=[UIColor clearColor];
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = [UIColor grayColor];
        [self addSubview:_titleLabel];
    }
    return self;
}
-(void)setText:(NSString *)text{
    _text = text;
    _titleLabel.text =_text;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
