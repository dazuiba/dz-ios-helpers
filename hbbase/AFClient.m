// AFTwitterAPIClient.h
//
// Copyright (c) 2012 Mattt Thompson (http://mattt.me/)
// 
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
// 
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
// 
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "AppConstant.h"

#import "AFClient.h"

#import "AFJSONRequestOperation.h"


@implementation AFClient

+ (AFClient *)sharedClient {
    static AFClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        assert(![kApiBaseURLString gh_endsWith:@"/" options:NSLiteralSearch]);
        _sharedClient = [[AFClient alloc] initWithBaseURL:[NSURL URLWithString:[kApiBaseURLString stringByAppendingString:@"/api/"]]];
    });
    return _sharedClient;
}


- (NSURL *)urlFor:(NSString *)sub{
    if (![sub gh_startsWith:@"/"]) {
        sub = $str(@"/%@",sub);
    }
    return [NSURL URLWithString:[kApiBaseURLString stringByAppendingString:sub]];
}



- (id)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    
    // Accept HTTP Header; see http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html#sec14.1
	[self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

@end



@implementation AFResult

@synthesize data,error;
@synthesize status;

+ (AFResult *)resultWithError:(NSError *)theError{
    AFResult *r = [[AFResult alloc] initWithError:theError];
    return [r autorelease];
}

+ (AFResult *)resultWithData:(id)theData{
    AFResult *r = [[AFResult alloc] initWithData:theData];
    r.status = AFStatusNone;
    return [r autorelease];
}

- (AFResult *)initWithError:(NSError *)theError{
    if (self = [super init]) {
        self.status = AFStatusError;
        self.error = theError;
    }
    return self;    
}


-(AFResult *)initWithData:(id)theData{
    if (self = [super init]) {
        self.status = AFStatusLoaded;
        self.data = theData;
    }
    return self;    
}


- (void)dealloc {
    self.error = nil;
    self.data = nil;
    [super dealloc];
}



@end