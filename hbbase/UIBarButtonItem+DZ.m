//
//  UIBarButtonItem+DZ.m
//  hzbus
//
//  Created by Wise Sam on 12-7-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIBarButtonItem+DZ.h"
#import "HBAppDelegate.h"
@implementation UIBarButtonItem (DZ)
//+ (UIBarButtonItem *)itemWith:(id)target action:(SEL)action pngName:(NSString *)pngName{
//}
+ (UIBarButtonItem *)backItemWith:(UINavigationController *)nav{
   return [self itemWith:nav action:@selector(goBack:) pngName:@"nav_back"];
}

+ (UIBarButtonItem *)homeItemWith:(UINavigationController *)nav{
    return [self itemWith:nav action:@selector(goHome:) pngName:@"nav_home"];
}

+ (UIBarButtonItem *)itemWith:(id)target action:(SEL)action title:(NSString *)title{
   UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStyleBordered target:target action:action];
    return [item autorelease];
}

+ (UIBarButtonItem *)itemWith:(id)target action:(SEL)action pngName:(NSString *)pngName{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];    
    UIImage *img = [UIImage imageNamed:$str(@"%@.png",pngName)];
    UIImage *pressImg = [UIImage imageNamed:$str(@"%@_press.png",pngName)];
    [button setBackgroundImage: img forState:UIControlStateNormal];
    CGSize size = CGSizeZero;    
    if (pressImg) {
        [button setBackgroundImage:pressImg forState:UIControlStateHighlighted];
        size = pressImg.size;
    }else {
        size = img.size;
    }
    button.bounds = CGRectMake(0, 0, size.width, size.height);    
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
} 
@end



@implementation UINavigationController (DZ)

- (void)goBack:(id)sender{
    [self popViewControllerAnimated:YES];
}

- (void)goHome:(id)sender{
     [[NSNotificationCenter defaultCenter] postNotificationName:@"closeView" object:self.view];
}


@end
