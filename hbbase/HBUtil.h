//
//  BMUtil.h
//  BikeMap
//
//  Created by  on 12-3-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HBUtil : NSObject
+ (NSString *)encodeToJson:(id)object;
+ (BOOL)openPhoneNumber:(NSString *)phoneNumber;
+ (BOOL)openLocationRoutes:(CLLocationCoordinate2D) location;
@end
