//
//  PullToRefreshTableViewController.h
//  hzbus
//
//  Created by Wise Sam on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "HNModels.h"

@interface PullToRefreshTableViewController : UITableViewController<EGORefreshTableHeaderDelegate>
@property(nonatomic,readonly) HBListBase *tableArray;
-(void)autoPullRefresh;
- (void)loadMore:(id)sender;
- (void)doneLoadingTableViewData:(NSObject *)holder;
@end
