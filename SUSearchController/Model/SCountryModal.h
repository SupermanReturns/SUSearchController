//
//  SCountryModal.h
//  SUSearchController
//
//  Created by Superman on 2018/8/31.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SCountryModal : NSObject
@property (nonatomic, strong) NSArray *dataArray;

+ (instancetype)sharedDataModal;

@end
