//
//  AddressFirstHeaderView.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "AddressFirstHeaderView.h"
#import "SelectButton.h"

@implementation AddressFirstHeaderView
-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self=[super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor= [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 200, 30)];
        titleLabel.textColor=[UIColor grayColor];
        titleLabel.font=[UIFont systemFontOfSize:14];
        titleLabel.text = [NSString stringWithFormat:@"当前:长沙全城"];
        [self addSubview:titleLabel];
        
        SelectButton *citySelectBtn = [SelectButton buttonWithType:UIButtonTypeCustom];
        [citySelectBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [citySelectBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [citySelectBtn setTitle:@"切换区县" forState:UIControlStateNormal];
        [citySelectBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        
//        [citySelectBtn setBackgroundImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];

        [citySelectBtn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateSelected];
        
        [citySelectBtn addTarget:self action:@selector(citySelect:) forControlEvents:UIControlEventTouchUpInside];
        citySelectBtn.frame =CGRectMake([UIScreen mainScreen].bounds.size.width-100, 0, 80, 30);
        [self addSubview:citySelectBtn];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        
    }
    return self;
}
-(void)citySelect:(UIButton *)btn{
    btn.selected = !btn.selected;
    if (self.delegate) {
        [self.delegate citySelectAction:btn.selected];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
