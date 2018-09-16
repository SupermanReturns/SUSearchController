//
//  MTAddressModal.m
//  SUSearchController
//
//  Created by Superman on 2018/9/16.
//  Copyright © 2018年 Superman. All rights reserved.
//

#import "MTAddressModal.h"

@implementation MTAddressModal

-(instancetype)init{
    if (self = [super init]) {
        NSString *cityPath=[[NSBundle mainBundle]pathForResource:@"city" ofType:@"plist"];
        NSString *cityDataPath= [[NSBundle mainBundle]pathForResource:@"citydata" ofType:@"plist" ];
        
        _cityArr=[NSMutableArray arrayWithContentsOfFile:cityPath];
        NSMutableArray *cityDataArr=[NSMutableArray arrayWithContentsOfFile:cityDataPath];
        _cityDataDict=[self filterCityData:cityDataArr];
    }
    return self;
}
- (NSMutableDictionary *)filterCityData:(NSArray *)cityDataArr {
    NSMutableDictionary *citiesDict=[NSMutableDictionary dictionary];
    for (NSDictionary *provinceDict in cityDataArr) {
        NSArray *cityList=provinceDict[@"citylist"];
        for (NSDictionary *dict in cityList) {
            NSMutableString *cityName=[NSMutableString stringWithString:dict[@"cityName"]];
            if (![cityName hasSuffix:@"市"]) {
                [cityName appendString:@"市"];
            }
            NSArray *areas=dict[@"arealist"];
            NSMutableArray *areaArray=[NSMutableArray array];
            for (NSDictionary *areaDict in areas) {
                [areaArray addObject:areaDict[@"areaName"]];
            }
            citiesDict[cityName] = areaArray;
        }
    }
    return citiesDict;
}
@end









