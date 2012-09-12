//
//  PullToRefreshTableViewController.m
//  hzbus
//
//  Created by Wise Sam on 12-7-28.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "PullToRefreshTableViewController.h"
#import "AFClient.h"
#import "SVProgressHUD.h"

@interface PullToRefreshTableViewController ()
@property(nonatomic,retain)    EGORefreshTableHeaderView *refreshHeaderView;
@property(nonatomic,assign)    BOOL reloading;
@property(nonatomic,retain)    UIView *footerActionView;
//- (IBAction)loadMore:(id)sender;
@end

@implementation PullToRefreshTableViewController

@synthesize refreshHeaderView = _refreshHeaderView;
@synthesize reloading = _reloading;
@synthesize footerActionView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadMore:(id)sender{
    assert(false);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor = UIColorFromRGB(0xEFEFEF);
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FooterActionView" owner:self options:nil];
    self.footerActionView = (UIView *)[nib objectAtIndex:0];    

    assert(self.footerActionView);
    UIButton *loadMoreBtn = (UIButton *)[self.footerActionView viewWithTag:1];
    [loadMoreBtn addTarget:self action:@selector(loadMore:) forControlEvents:UIControlEventTouchUpInside ];
    

    self.tableView.tableFooterView = self.footerActionView;
    self.tableView.tableFooterView.hidden = YES;
	if (_refreshHeaderView == nil) {
		EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height)];
		view.delegate = self;
		[self.tableView addSubview:view];
		_refreshHeaderView = view;
		[view release];		
	}
	
	[_refreshHeaderView refreshLastUpdatedDate];
}

- (void)autoPullRefresh{
    self.tableView.contentOffset = CGPointMake(0, -65);
    [_refreshHeaderView  egoRefreshScrollViewDidEndDragging:self.tableView];

}

- (void)viewDidUnload
{
    self.refreshHeaderView = nil;
    self.footerActionView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArray.count;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


#pragma mark -
#pragma mark UIScrollViewDelegate Methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{	
	
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
	
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
	
}

#pragma mark overwrite me!
- (HBListBase *)tableArray{
    assert(false);
    return nil;
}

- (void)reloadData:(void (^)(AFResult *afResult))block {
    assert(false);
}


#pragma mark -
#pragma mark EGORefreshTableHeaderDelegate Methods

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{    
    [self reloadData:^(AFResult *afResult) {
        _reloading = NO;
        [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
        [self performSelector:@selector(doneLoadingTableViewData:) withObject:afResult.error afterDelay:.15];
    }];
    _reloading = YES;
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
	
	return self.tableArray.refreshAt; // should return date data source was last changed
} 


- (void)doneLoadingTableViewData:(NSObject *)holder{	
    if ([holder isKindOfClass:[NSError class]]) {
        [SVProgressHUD showErrorWithStatus:@"加载失败..."];
    }else {
        [self.tableView reloadData];
        self.tableView.tableFooterView.hidden = !self.tableArray.hasMore;
    }
}


- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{	
	return _reloading; // should return if data source model is reloading
}


@end
