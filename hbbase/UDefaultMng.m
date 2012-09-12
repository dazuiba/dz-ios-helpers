//
//  UDefaultMng.m
//  hzbus
//
//  Created by Wise Sam on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UDefaultMng.h"

@implementation UDefaultMng

+ (void)save:(NSString *)value forKey:(NSString *)key{    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setValue:value forKey:key];
    //    [userDefaults synchronize];
}

@end
