//
//  NSURL+DZ.h
//  hzbus
//
//  Created by Wise Sam on 12-8-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    DZImgStyleSmall,
    DZImgStyleNormal,
	DZImgStyleOrigin,
    DZImgStyleUnknown
} DZImgStyle;

@interface NSURL (DZ)

- (DZImgStyle)currentImgStyle;
- (NSURL *)imgStyleURL:(DZImgStyle)style;

@end
