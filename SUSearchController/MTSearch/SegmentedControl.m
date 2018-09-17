//
//  SegmentedControl.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SegmentedControl.h"
#import "UIColor+Utils.h"

@implementation SegmentedControl
-(instancetype)initWithItems:(NSArray *)items{
    if (self = [super initWithItems:items]) {
        self.frame = CGRectMake(0, 0, 160, 30);
        self.selectedSegmentIndex = 0;
        [self setTintColor:[UIColor colorWithHexString:@"#00bfaf"]];
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
