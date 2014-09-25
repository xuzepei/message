//
//  FDSQViewController.m
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import "FDSQViewController.h"
#import "FDSQDetailViewController.h"
#import "RCTool.h"
#import <QuartzCore/QuartzCore.h>
#import "FDSQStartView.h"
#import "RCAppDelegate.h"

@implementation FDSQViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

		self.title = NSLocalizedString(@"关于SEX那点事",@"");
        
        FDSQStartView* startView = [[FDSQStartView alloc] initWithFrame:CGRectMake(0,0,[RCTool getScreenSize].width,[RCTool getScreenSize].height)];
        [self.view addSubview:startView];
		
		UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
		[button setTitle:NSLocalizedString(@"开始测试",@"")  
				forState:UIControlStateNormal];
		[button addTarget:self action:@selector(clickStartButton:) 
		 forControlEvents:UIControlEventTouchUpInside];
		
		if(NO == [RCTool isIpad])
		{
			button.frame = CGRectMake(0,0,200,30);
			button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
			button.center = CGPointMake(160, 460 - 20 - 42 - 50);
		}
		else
		{
			button.frame = CGRectMake(0,0,300,50);
			button.titleLabel.font = [UIFont boldSystemFontOfSize:26];
			button.center = CGPointMake(768/2.0, 1004 - 30 - 90 - 40);
		}
		
        [startView setNeedsDisplay];
		[self.view addSubview: button];
        
        
        if([RCTool isOpenAll])
        {
            UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"点击看妹纸的笑话 >" style:UIBarButtonItemStylePlain target:self action:@selector(clickedRightBarButtonItem:)];
            self.navigationItem.rightBarButtonItem = item;
        }
		
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    [self showAdBanner:nil];
}


/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad {
 [super viewDidLoad];
 }
 */


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdBanner:) name:SHOW_ADBANNER_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdFullScreen:) name:SHOW_FULLSCREENAD_NOTIFICATION object:nil];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)clickedRightBarButtonItem:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickStartButton:(id)sender
{
	FDSQDetailViewController* temp = [[FDSQDetailViewController alloc] 
									  initWithNibName:nil bundle:nil];
	
	[temp updateContent];

	[self.navigationController pushViewController:temp animated:YES];

}

- (void)showAdBanner:(NSNotification*)noti
{
    UIView* adView = [RCTool getAdView];
    BOOL b = YES;
    if(noti)
    {
        if(adView.superview)
            b = NO;
    }
    
    if(adView && b)
    {
        CGRect rect = adView.frame;
        rect.origin.y = [RCTool getScreenSize].height - rect.size.height - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT;
        adView.frame = rect;
        
        [self.view addSubview:adView];
    }
}

- (void)showAdFullScreen:(NSNotification*)noti
{
    RCAppDelegate* appDelegate = (RCAppDelegate*)[UIApplication sharedApplication].delegate;
    if(appDelegate)
    {
        [appDelegate showInterstitialAd:self.tabBarController];
    }
}

@end
