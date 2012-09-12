//
//  UIHelper.m
//  hzbus
//
//  Created by Wise Sam on 12-7-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIHelper.h"
#import <QuartzCore/QuartzCore.h>
@implementation UIHelper

+ (UINavigationController *)navFor:(UIViewController *)root{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:root] ;    
    if (SV_GE_5) {        
        UIImage *image = [[UIImage imageNamed: @"navigationbar.png"] stretchableImageWithLeftCapWidth:0 topCapHeight:0];
        [nav.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    }
    return [nav autorelease];
}
@end