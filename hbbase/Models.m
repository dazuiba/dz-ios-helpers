//
//  Models.m
//  hzbus
//
//  Created by  on 12-5-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Models.h"
#import "AFJSONUtilities.h"
#import "GTMBase64.h"


#define kDftKeyLoginUserDict @"login_user_dict"

@implementation User
@synthesize name,avatar,requestToken;
static User *_currentUser = nil;

+ (User *)current{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSDictionary *uinfo = [defaults objectForKey:kDftKeyLoginUserDict];
        if ([uinfo isKindOfClass:[NSDictionary class]]) {
            _currentUser = [[User alloc] initWithDict:uinfo];
        }
    });
    
    return _currentUser;
}

+ (User *)loginWithURL:(NSURL *)url{
    NSError *error = nil;
    NSDictionary *userInfo = AFJSONDecode([GTMBase64 webSafeDecodeString:url.query],&error);
    if(!userInfo) {
        return nil;
    }
    
    //checking values    
    User *loginUser = [[[User alloc] initWithDict:userInfo] autorelease];
    if (![loginUser isValidUser:YES]) {
        return nil;
    }
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:userInfo forKey:kDftKeyLoginUserDict];
    [self setCurrentUser:loginUser];
    return loginUser;
}

+ (void)logout{
    [self setCurrentUser:nil];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults removeObjectForKey:kDftKeyLoginUserDict];
    [defaults synchronize];
}

+ (void)setCurrentUser:(User *)user{
    GH_SAFE_RELEASE(_currentUser);
    _currentUser = [user retain];
}

- (BOOL)isValidUser:(BOOL)checkLogin{
    BOOL r = self.entryID>0 && ![self.name gh_isBlank];
    
    if (checkLogin) {
        r = r&&![self.requestToken gh_isBlank];
    }
    return r;
    
}

- (NSMutableDictionary *)authParams:(NSDictionary *)params{
    if ([self isValidUser:YES]) {
        return $mdict($str(@"%@----%d",self.requestToken,self.entryID),@"j");
    }
    return nil;
}


- (NSString *)name{
    return [self.dict objectForKey:@"name"];
}

- (NSString *) avatar {
    return [self.dict objectForKey:@"avatar"];
}

- (NSString *)requestToken{
    return [self.dict objectForKey:@"app_token"];
}

- (void)dealloc {
    [super dealloc];
}
@end


@implementation HBDictBase
@synthesize dict;

@synthesize entryID;

+ (id)createWithDict:(NSDictionary *)dict{
    HBBase *r = [[[self alloc] initWithDict:dict] autorelease];
    return r;
}

- (int)entryID{
    return self.entryIDNumber.intValue;
}

- (NSNumber *)entryIDNumber{
    return ((NSNumber *)[self.dict objectForKey:@"id"]);
}

- (id)initWithDict:(NSDictionary *)theDict{
    self = [super init];
    if (self) {
        self.dict = theDict;
    }
    return self;
}

- (void)mergeDict:(NSDictionary *)theDict{
    NSMutableDictionary *mdict = [NSMutableDictionary dictionaryWithDictionary:self.dict];
    [mdict addEntriesFromDictionary:theDict];
    self.dict = mdict;
}


- (NSString *)description{
    return GHDescription(@"dict");
}


- (void)dealloc
{
    self.dict = nil;
    [super dealloc];
}

@end

@implementation HBBase

- (BOOL)isEqual:(id)other{
    return ([other isKindOfClass: self.class] && self.entryID == ((HBBase *)other).entryID);
}

- (NSUInteger)hash{
    return $int(self.entryID).hash;
}

@end



@implementation HBListBase

@synthesize refreshAt,records;
@synthesize hasMore,currentPage;
@synthesize apiPath;

- (Class)_itemClass{
    assert(false);
    return nil;
}

- (void)_setRecordsWhenInit{
    NSArray *dictArray = [self.dict objectForKey:@"data"];
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:dictArray.count];
    for (NSDictionary *newsDict in dictArray) {
        NSObject *news = [((HBDictBase *)[[self _itemClass] alloc]) initWithDict:newsDict];
        [array addObject:news];
        [news release];
    }
    self.records = array;
}

- (id)initWithDict:(NSDictionary *)theDict
{
    self = [super initWithDict:theDict];
    if (self) {
        [self _setRecordsWhenInit];
        self.refreshAt = [NSDate date];
        NSNumber *num = (NSNumber *)[self.dict objectForKey:@"has_more"];
        if ([num isKindOfClass:[NSNumber class]]) {
            self.hasMore = num.boolValue;
        }
        self.currentPage = 1;
    }
    return self;
}

- (void)addPage:(HBListBase *)newPage{
    
    if (newPage.records.count>0) {
        [self.records addObjectsFromArray:newPage.records];
    }
    
    if (!newPage.hasMore) {
        self.hasMore = NO;
    }
    self.currentPage+=1;
}

- (void)loadMore:(void (^)(AFResult *afResult))block{
    assert(false);
}

- (int)count{
    return self.records.count;
}

- (void)dealloc
{
    self.records = nil;
    self.apiPath = nil;
    self.refreshAt = nil;
    [super dealloc];
}

@end