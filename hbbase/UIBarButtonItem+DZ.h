//
//  UIBarButtonItem+DZ.h
//  hzbus
//
//  Created by Wise Sam on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (DZ)
+ (UIBarButtonItem *)backItemWith:(UINavigationController *)nav;
+ (UIBarButtonItem *)itemWith:(id)target action:(SEL)action pngName:(NSString *)pngName;
+ (UIBarButtonItem *)homeItemWith:(UINavigationController *)nav;
+ (UIBarButtonItem *)itemWith:(id)target action:(SEL)action title:(NSString *)title;
@end



@interface UINavigationController(DZ)
- (void)goBack:(id)sender;
@end