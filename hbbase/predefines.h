//
//  predefines.h
//  BikeMap
//
//  Created by  on 12-3-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
#import "GHKit.h"
#import <MapKit/MapKit.h>
#import "ConciseKit.h"
#import "DZLocationMethods.h"

#import "NimbusCore.h"
//#import "NSString+Extenstion.h"
//#import "UIHelper.h"
#ifndef BikeMap_predefines_h
#define BikeMap_predefines_h


#define GH_SAFE_RELEASE(v) [v release],v = nil
#define GH_LOCATION_TO_STR(lat) [NSString stringWithFormat:@"%.4f",lat]

#define _NOT_NULL(object) [object isKindOfClass:[NSNull class]] ? nil : object

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define UIColorFromRGBAlpha(rgbValue,r) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(float)r]
#define GH_INT_TO_STRING(theInteger) [NSString stringWithFormat:(@"%d"), theInteger]




#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define SV_GE_5 SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"5.0")


#ifndef DEBUG
#define DEBUG 0
#endif

#ifndef JLog
#define JLine(firstarg, ...) ([NSString stringWithFormat:@"\t(%08x.%04d)%s %@",self,__LINE__,__FUNCTION__,[NSString stringWithFormat:firstarg, ##__VA_ARGS__ ]])
#define JLineC(firstarg, ...) ([NSString stringWithFormat:@"\t(%08x.%04d) %s %s(): %@",NULL,__LINE__,__FILE__,__FUNCTION__,[NSString stringWithFormat:firstarg , ##__VA_ARGS__ ]])

#define JLog(firstarg, ...) NSLog(@"%@",JLine(firstarg , ##__VA_ARGS__ ))
#define JLogC(firstarg, ...) NSLog(@"%@",JLineC(firstarg , ##__VA_ARGS__ ))

#define DJLog if(DEBUG)JLog
#define DJLogC if(DEBUG)JLogC

#define D2JLog if(DEBUG>1)JLog
#define D2JLogC if(DEBUG>1)JLogC

#define D3JLog if(DEBUG>2)JLog
#define D3JLogC if(DEBUG>2)JLogC

#define DJLOG if(DEBUG)DJLog(@"");
#define D2JLOG if(DEBUG>1)DJLog(@"");
#define D3JLOG if(DEBUG>1)DJLog(@"");
#endif

#endif
