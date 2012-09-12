//
//  DB.h
//  BikeMap
//
//  Created by  on 12-3-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface DB : NSObject
+ (FMDatabase*)instance;
+ (void)checkAndInstall;
+ (void)close;
@end


#define $db [DB instance]