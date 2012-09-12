//
//  Models.h
//  hzbus
//
//  Created by  on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFClient.h"


@interface HBDictBase: NSObject
@property(nonatomic,retain) NSDictionary *dict;
@property(nonatomic,readonly) int entryID;
@property(nonatomic,readonly) NSNumber *entryIDNumber;

+ (id)createWithDict:(NSDictionary *)dict;
- (id)initWithDict:(NSDictionary *)dict;
- (void)mergeDict:(NSDictionary *)theDict;
@end

@interface HBBase : HBDictBase 

//+ (NSArray *)all;
@end

#define _NULL(object) [object isKindOfClass:[NSNull class]] ? nil : object

#define CUser [User current]


@interface User : HBDictBase

+ (User *)current;
+ (User *)loginWithURL:(NSURL *)url;
+ (void)setCurrentUser:(User *)user;
+ (void)logout;
- (NSMutableDictionary *)authParams:(NSDictionary *)params;

@property(nonatomic,readonly)NSString *name;
@property(nonatomic,readonly)NSURL *avatar;
@property(nonatomic,readonly)NSString *requestToken;
- (BOOL)isValidUser:(BOOL)checkLogin;

@end
@interface HBListBase : HBBase
@property(nonatomic,retain) NSMutableArray *records;
@property(nonatomic,retain) NSString *apiPath;
@property(nonatomic,retain) NSDate *refreshAt;
@property(nonatomic,assign) BOOL hasMore;
@property(nonatomic,assign) int currentPage;
@property(nonatomic,readonly) int count;

- (Class)_itemClass;
- (void)_setRecordsWhenInit;
- (void)loadMore:(void (^)(AFResult *afResult))block;
- (void)addPage:(HBListBase *)newPage;
@end
