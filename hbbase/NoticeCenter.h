//
//  NoticeCenter.h
//  hzbus
//
//  Created by Wise Sam on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NoticeCenter : NSObject
+ (NoticeCenter *)defaultCenter;


// user allowed the permistion
- (void)didRegisterWithPushToken:(NSString *)tokenString;

//register permistion in device
- (void)registerForRemoteNotification;

- (void)postSavedTokens;

- (void)bindDeviceToUser;

- (void)unbindDeviceFromUser;

@end
