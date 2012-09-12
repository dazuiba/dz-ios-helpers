//
//  UDefaultMng.h
//  hzbus
//
//  Created by Wise Sam on 12-8-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kLineHistoryArrayDefaultsKey @"Dft_line_his"
#define kStationHistoryArrayDefaultsKey @"Dft_station_his"


#define kDeviceTokenDefaultsKey @"Dft_device_token"
#define kPushTokenDefaultsKey @"Dft_push_token"

#define UDF [NSUserDefaults standardUserDefaults]
@interface UDefaultMng : NSObject
+ (void)save:(NSString *)value forKey:(NSString *)key;
@end
