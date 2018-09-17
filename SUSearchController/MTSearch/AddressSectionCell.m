//
//  AddressSectionCell.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "AddressSectionCell.h"

@implementation AddressSectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArr:(NSArray *)cityArr {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor =  [UIColor colorWithRed:0.97 green:0.97 blue:0.97 alpha:1];
        for (int i=0; i<cityArr.count; i++) {
            UIButton *cityBtn=[UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat margin = 15;
            NSInteger column =3;
            CGFloat btnHeight=35;
            CGFloat btnWidth =([UIScreen mainScreen].bounds.size.width - 5 * margin) / column;
            cityBtn.frame = CGRectMake((i%column)*(btnWidth + margin)+margin, 4.5+(44.f)*(i/column), btnWidth, btnHeight);
            cityBtn.layer.cornerRadius=5;
            cityBtn.layer.masksToBounds = YES;

            [cityBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [cityBtn setBackgroundColor:[UIColor whiteColor]];
            [cityBtn.titleLabel setFont:[UIFont systemFontOfSize:14.f]];
            [cityBtn setTitle:cityArr[i] forState:UIControlStateNormal];
            [cityBtn addTarget:self action:@selector(citySelct:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:cityBtn];
            
        }
    }
    return self;
}

-(void)citySelct:(UIButton *)sender{
    if (_btnBlock) {
        _btnBlock(sender.titleLabel.text);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
