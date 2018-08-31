//
//  SCountryModal.m
//  SUSearchController
//
//  Created by Superman on 2018/8/31.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "SCountryModal.h"

@implementation SCountryModal
static SCountryModal *__countryModal;

+(instancetype)sharedDataModal{
    return __countryModal;
}
+(void)initialize{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!__countryModal) {
            __countryModal=[[SCountryModal alloc]init];
        }
    });
}
-(instancetype)init{
    if (!__countryModal) {
        if (self=[super init]) {
            NSString *path= [[NSBundle mainBundle]pathForResource:@"country" ofType:@"txt"];
            NSString *countryStr=[NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
            _dataArray = [countryStr componentsSeparatedByString:@"\n"];
        }
    }
    return self;
}

@end























