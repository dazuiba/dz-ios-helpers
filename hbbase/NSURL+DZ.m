//
//  NSURL+DZ.m
//  hzbus
//
//  Created by Wise Sam on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "NSURL+DZ.h"

#define kImgStyleSmall @"thumb"
#define kImgStyleNormal @"medium"
#define kImgStyleOrigin @"original"

@implementation NSURL (DZ)

- (DZImgStyle)currentImgStyle{
   NSString *last =  self.lastPathComponent;
    if ([last gh_startsWith:kImgStyleSmall]) {
        return DZImgStyleSmall;
    }else if ([last gh_startsWith:kImgStyleNormal]) {
        return DZImgStyleNormal;
    }else if ([last gh_startsWith:kImgStyleOrigin]) {
        return DZImgStyleOrigin;
    }else {
        return DZImgStyleUnknown;
    }
}

- (NSString *)styleToStr:(DZImgStyle)style{
    switch (style) {
        case DZImgStyleOrigin:
            return kImgStyleOrigin;
        case DZImgStyleSmall:
            return kImgStyleSmall;
        default:
            return kImgStyleNormal;
    }
}

- (NSURL *)imgStyleURL:(DZImgStyle)style{
    DZImgStyle crtSty = self.currentImgStyle;
    if ( crtSty == style||crtSty == DZImgStyleUnknown) {
        return self;
    }
     
    NSMutableArray *array = [NSMutableArray arrayWithArray:[self.lastPathComponent componentsSeparatedByString:@"."]];
    [array replaceObjectAtIndex:0 withObject:[self styleToStr:style]];
    
    return [[self URLByDeletingLastPathComponent] URLByAppendingPathComponent:[array componentsJoinedByString:@"."]];
    
}
@end
