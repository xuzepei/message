//
//  RCWebViewController.m
//  RCFang
//
//  Created by xuzepei on 4/4/13.
//  Copyright (c) 2013 xuzepei. All rights reserved.
//

#import "RCWebViewController.h"
#import "RCTool.h"

@interface RCWebViewController ()

@end

@implementation RCWebViewController

- (id)init:(BOOL)hideToolbar
{
    self.hideToolbar = hideToolbar;
    
    return [self initWithNibName:nil bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        UIBarButtonItem* rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickRightBarButtonItem:)];
        self.navigationItem.rightBarButtonItem = rightBarButtonItem;
        
        [self initWebView];
        
        [self initToolbar];
        
    }
    return self;
}

- (void)dealloc
{
    self.urlString = nil;
    
    if(self.webView)
        self.webView.delegate = nil;
    self.webView = nil;
    
    self.indicator = nil;
    self.toolbar = nil;
    self.backwardItem = nil;
    self.forwardItem = nil;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    if(self.webView)
        self.webView.delegate = nil;
    self.webView = nil;
    
    self.indicator = nil;
    self.toolbar = nil;
    self.backwardItem = nil;
    self.forwardItem = nil;
}

- (void)clickRightBarButtonItem:(id)sender
{
    [self clickRefreshItem:nil];
}

- (void)updateContent:(NSString *)urlString title:(NSString*)title
{
    if(0 == [urlString length])
        return;
    
    self.urlString = urlString;
    
    if([title length])
        self.title = title;
    else
        self.title = _urlString;
    
    [self updateToolbarItem];
    
    if(_webView)
    {
        NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]];
        [_webView loadRequest:request];
    }
    
}

#pragma mark - Toolbar

- (void)initToolbar
{
    if (nil == _toolbar) {
        _toolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0,[RCTool getScreenSize].height - NAVIGATION_BAR_HEIGHT*2 - STATUS_BAR_HEIGHT,[RCTool getScreenSize].width,NAVIGATION_BAR_HEIGHT)];
        
        _toolbar.barStyle = UIBarStyleBlack;
        
        UIBarButtonItem* fixedSpaceItem0 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                          target:nil
                                                                                          action:nil];
        fixedSpaceItem0.width = 180;
        
        UIBarButtonItem* fixedSpaceItem1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                                          target:nil
                                                                                          action:nil];
        fixedSpaceItem1.width = 50;
        
        
//        UIBarButtonItem* refreshItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
//                                                                                     target:self
//                                                                                     action:@selector(clickRefreshItem:)];
        
        self.backwardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browse_backward"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(clickBackwardItem:)];
        _backwardItem.enabled = NO;
        
        self.forwardItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"browse_forward"]
                                                              style:UIBarButtonItemStylePlain
                                                             target:self
                                                             action:@selector(clickForwardItem:)];
        
        _forwardItem.enabled = NO;
        
        [_toolbar setItems:[NSArray arrayWithObjects: /*refreshItem,*/fixedSpaceItem0,_backwardItem,fixedSpaceItem1,_forwardItem,nil]
                  animated: NO];

    }
	
	[self.view addSubview:_toolbar];

}

- (void)updateToolbarItem
{
	_backwardItem.enabled = _webView.canGoBack? YES:NO;
	_forwardItem.enabled = _webView.canGoForward? YES:NO;
}

- (void)clickRefreshItem:(id)sender
{
    if(_webView)
        [_webView reload];
}

- (void)clickBackwardItem:(id)sender
{
    if(_webView)
        [_webView goBack];
	
}

- (void)clickForwardItem:(id)sender
{
    if(_webView)
        [_webView goForward];
}

#pragma mark - WebView

- (void)initWebView
{
    if (nil == _webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,[RCTool getScreenSize].width,[RCTool getScreenSize].height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
        _webView.delegate = self;
    }

    [self.view addSubview: _webView];
    
    if (nil == _indicator) {
        _indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _indicator.center = CGPointMake([RCTool getScreenSize].width/2.0, [RCTool getScreenSize].height/2.0);
    }
    
    [_webView addSubview: _indicator];
}



#pragma mark -
#pragma mark UIWebViewDelegate

- (BOOL)webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
	if(request)
	{
//        if(self.hideToolbar)
//            return YES;
//        
//		NSURL* url = [request URL];
//		NSString* urlString = [url absoluteString];
//        if(NO == [urlString isEqualToString:_urlString])
//            self.title = urlString;
	}
    
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[_indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[_indicator stopAnimating];
	
	[self updateToolbarItem];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[_indicator stopAnimating];
}


@end
