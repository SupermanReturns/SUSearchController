//
//  AddressSectionCell.h
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^btnActionBlock) (NSString *cityString);


@interface AddressSectionCell : UITableViewCell

@property (nonatomic, strong) btnActionBlock btnBlock;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityArr:(NSArray *)cityArr;

@end
