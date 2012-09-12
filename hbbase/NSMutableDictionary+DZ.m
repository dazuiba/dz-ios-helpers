//
//  NSMutableDictionary+DZ.m
//  hzbus
//
//  Created by Wise Sam on 12-9-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSMutableDictionary+DZ.h"

@implementation NSMutableDictionary (DZ)
- (void)dz_setObject:(id)anObject forKey:(id)aKey{
    if (anObject) {
        [self setObject:anObject forKey:aKey];
    }
}
@end
