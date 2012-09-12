//
//  NoticeCenter.m
//  hzbus
//
//  Created by Wise Sam on 12-8-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NoticeCenter.h"
#import "AFClient.h"
#import "HNModels.h"
#import "UIDevice+IdentifierAddition.h"
#import "UDefaultMng.h"

#define kAPISaveDeviceInfo @"save_device_info"
#define kAPIBindDevice @"bind_device"
#define kAPIUnbindDevice @"unbind_device"


@interface NoticeCenter()
@property(nonatomic,retain)NSDictionary *payload;
@end

@implementation NoticeCenter
@synthesize payload;

+ (NoticeCenter *)defaultCenter {
    static NoticeCenter *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[NoticeCenter alloc] init];
    });
    return _sharedClient;
}

- (void)didRegisterWithPushToken:(NSString *)tokenString{
    [UDefaultMng save:tokenString forKey:kPushTokenDefaultsKey];    
}

- (NSMutableDictionary *) getParamsContainsDeviceKey {
    NSString *deviceKey = [UDF stringForKey:kDeviceTokenDefaultsKey];
    if (!deviceKey) {
        deviceKey = [[UIDevice currentDevice] uniqueGlobalDeviceIdentifier];
        if (deviceKey) {
            [UDefaultMng save:deviceKey forKey:kDeviceTokenDefaultsKey];
        }
    }
    
    if (!deviceKey) {
        NSLog(@"Error postSavedTokens: deviceToken is null ");
        return nil;
    }
    
    NSMutableDictionary *params = $mdict(deviceKey,@"device_token");
    return params;
}

- (void)postSavedTokens{
    NSMutableDictionary *params = [self getParamsContainsDeviceKey];
    
    NSString *pushToken = [UDF stringForKey:kPushTokenDefaultsKey];
    if (pushToken) {
        [params setObject:pushToken forKey:@"push_token"];
    }
    [AFC postPath:kAPISaveDeviceInfo parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)registerForRemoteNotification{
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)|UIRemoteNotificationTypeAlert];    
}

- (void) bindDeviceToUser {
    NSMutableDictionary *params = [self getParamsContainsDeviceKey];
    [params addEntriesFromDictionary:[[User current] authParams:nil]];
    [AFC postPath:kAPIBindDevice parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void) unbindDeviceFromUser {
    NSMutableDictionary *params = [self getParamsContainsDeviceKey];
    [AFC postPath:kAPIUnbindDevice parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (void)dealloc {
    self.payload = nil;
    [super dealloc];
}

@end
