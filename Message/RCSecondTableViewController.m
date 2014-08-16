//
//  RCSecondTableViewController.m
//  Message
//
//  Created by xuzepei on 8/6/14.
//  Copyright (c) 2014 TapGuilt Inc. All rights reserved.
//

#import "RCSecondTableViewController.h"
#import "RCHttpRequest.h"
#import "RCPublicCell.h"
#import "Item.h"
#import "RCImageDisplayViewController.h"
#import "RCWebViewController.h"
#import "RCAppDelegate.h"

@interface RCSecondTableViewController ()

@end

@implementation RCSecondTableViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self showAdBanner:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdBanner:) name:SHOW_ADBANNER_NOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showAdFullScreen:) name:SHOW_FULLSCREENAD_NOTIFICATION object:nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(clickedRightBarButtonItem:)];
    
    
    if([RCTool systemVersion] >= 7.0)
        self.segmentedControl.tintColor = TINT_COLOR;
    
    self.tableView.backgroundColor = BG_COLOR;

    if(nil == _itemArray0)
        _itemArray0 = [[NSMutableArray alloc] init];
    
    if(nil == _itemArray1)
        _itemArray1 = [[NSMutableArray alloc] init];
    
    self.page0 = 0;
    self.page1 = 1;
    self.tryno = 0;
    self.type = 0;
    
    [self updateContent:nil page:0 type:0];
    
    [self initRefreshControl];
}

- (void)clickedRightBarButtonItem:(id)sender
{
    if(0 == _type)
        [self updateContent:nil page:0 type:0];
    else
        [self updateRandomContent:nil page:0 type:0];
}

#pragma mark - Refresh Control

- (void)initRefreshControl
{
    // 1.下拉刷新(进入刷新状态就会调用self的headerRereshing)
    [self.tableView addHeaderWithTarget:self action:@selector(headerRereshing)];
    
    // 2.上拉加载更多(进入刷新状态就会调用self的footerRereshing)
    [self.tableView addFooterWithTarget:self action:@selector(footerRereshing)];
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    self.tableView.headerPullToRefreshText = [RCTool getTextById:@"ti_6"];
    self.tableView.headerReleaseToRefreshText = [RCTool getTextById:@"ti_7"];
    self.tableView.headerRefreshingText = [RCTool getTextById:@"ti_8"];
    
    self.tableView.footerPullToRefreshText = [RCTool getTextById:@"ti_9"];
    self.tableView.footerReleaseToRefreshText = [RCTool getTextById:@"ti_10"];
    self.tableView.footerRefreshingText = [RCTool getTextById:@"ti_11"];
}

- (void)headerRereshing
{
    NSLog(@"headerRereshing");
    
    if(0 == _type)
        [self updateContent:nil page:0 type:0];
    else
        [self updateRandomContent:nil page:0 type:0];
}

- (void)footerRereshing
{
    NSLog(@"footerRereshing");
    
    if(0 == _type)
        [self updateContent:nil page:self.page0 type:1];
    else
        [self updateRandomContent:nil page:0 type:1];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Top

- (void)updateContent:(NSString*)timestamp page:(int)page type:(int)type
{
    if(0 == _type)
    {
        NSString* urlString = [NSString stringWithFormat:@"%@&page=%d",@"http://joke.zaijiawan.com/Joke/joke2.jsp?appname=readingxiaonimei&version=3.11&os=ios&hardware=ipad&sort=1",page];
        
        NSDictionary* token = @{@"type":[NSNumber numberWithInt:type],@"page":[NSNumber numberWithInt:page]};
        
        RCHttpRequest* temp = [[RCHttpRequest alloc] init] ;
        BOOL b = [temp request:urlString delegate:self resultSelector:@selector(finishedContent0Request:) token:token];
        if(b)
        {
            if(0 == [self.itemArray0 count])
            {
                [RCTool showIndicator:@"加载中..."];
            }
        }
    }
}

- (void)finishedContent0Request:(NSDictionary*)result
{
    [RCTool hideIndicator];
    
    NSString* jsonString = [result objectForKey:@"json"];
    NSDictionary* token = [result objectForKey:@"token"];
    int type = [[token objectForKey:@"type"] intValue];
    if(0 == type)
    {
        [self.tableView headerEndRefreshing];
    }
    else
    {
        [self.tableView footerEndRefreshing];
    }
    //int page = [[token objectForKey:@"page"] intValue];
    
    if(0 == [jsonString length])
    {
        return;
    }
    
    NSArray* array = [jsonString componentsSeparatedByString:@"<joke>"];
    
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];
    for(NSString* item in array)
    {
        __strong NSString* temp = item;
        
        NSString* id = @"";
        NSString* name = @"";
        NSString* time = @"";
        NSString* text = @"";
        NSString* imgurl = @"";
        NSString* forward = @"";
        NSString* commend = @"";
        NSString* videourl = @"";
        
        NSRange range = [temp rangeOfString:@"<id>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        NSRange range1 = [temp rangeOfString:@"</id>"];
        if(NSNotFound == range1.location)
            continue;
        id = [temp substringToIndex:range1.location];
        
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<name>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</name>"];
        if(NSNotFound == range1.location)
            continue;
        name = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<time>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</time>"];
        if(NSNotFound == range1.location)
            continue;
        time = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        
        ////////////////
        range = [temp rangeOfString:@"<text>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</text>"];
        if(NSNotFound == range1.location)
            continue;
        text = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        
        ////////////////
        range = [temp rangeOfString:@"<imgurl>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</imgurl>"];
        if(NSNotFound == range1.location)
            continue;
        imgurl = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<forward>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</forward>"];
        if(NSNotFound == range1.location)
            continue;
        forward = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<commend>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</commend>"];
        if(NSNotFound == range1.location)
            continue;
        commend = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<videourl>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</videourl>"];
        if(NSNotFound == range1.location)
            continue;
        videourl = [temp substringToIndex:range1.location];
        //temp = [temp substringFromIndex:range1.location  + range1.length];
        
        if(0 == [id length])
            continue;
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %@",id];
        NSManagedObjectID* objectID = [RCTool getExistingEntityObjectIDForName: @"Item"
                                                                     predicate: predicate
                                                               sortDescriptors: nil
                                                                       context: [RCTool getManagedObjectContext]];
        
        
        Item* item = nil;
        if(nil == objectID)
        {
            item = [RCTool insertEntityObjectForName:@"Item"
                                managedObjectContext:[RCTool getManagedObjectContext]];
            
            item.id = id;
        }
        else
        {
            item = (Item*)[RCTool insertEntityObjectForID:objectID
                                     managedObjectContext:[RCTool getManagedObjectContext]];
        }
        
        item.name = name;
        item.time = time;
        item.text = text;
        item.imgurl = imgurl;
        item.forward = forward;
        item.commend = commend;
        item.videourl = videourl;
        
        
        [itemArray addObject:item];
        
    }
    
    
    if([itemArray count])
    {
        self.page0++;
        
        if(0 == type)
        {
            [_itemArray0 removeAllObjects];
            self.page0 = 1;
        }
        
        [_itemArray0 addObjectsFromArray:itemArray];
        [self.tableView reloadData];
    }
}

#pragma mark - Random

- (void)updateRandomContent:(NSString*)timestamp page:(int)page type:(int)type
{
    if(1 == _type)
    {
        int tryno = self.tryno;
        //if(1 == type)
            //tryno = 0;
        if(0 == [timestamp length])
            timestamp = @"0";
        NSString* urlString = [NSString stringWithFormat:@"%@&page=%d&timestamp=%@&tryno=%d",@"http://joke.zaijiawan.com/Joke/joke2_random.jsp?appname=readingxiaonimei&version=3.11&os=ios&hardware=ipad&sort=1",page,timestamp,tryno];
        
        NSDictionary* token = @{@"type":[NSNumber numberWithInt:type],@"page":[NSNumber numberWithInt:page]};
        
        RCHttpRequest* temp = [[RCHttpRequest alloc] init] ;
        BOOL b = [temp request:urlString delegate:self resultSelector:@selector(finishedContent1Request:) token:token];
        if(b)
        {
            if(0 == [self.itemArray1 count])
            {
                [RCTool showIndicator:@"加载中..."];
            }
        }
    }

}


- (void)finishedContent1Request:(NSDictionary*)result
{
    [RCTool hideIndicator];
    
    NSString* jsonString = [result objectForKey:@"json"];
    NSDictionary* token = [result objectForKey:@"token"];
    int type = [[token objectForKey:@"type"] intValue];
    if(0 == type)
    {
        [self.tableView headerEndRefreshing];
    }
    else
    {
        [self.tableView footerEndRefreshing];
    }
    //int page = [[token objectForKey:@"page"] intValue];
    
    if(0 == [jsonString length])
    {
        return;
    }
    
    NSArray* array = [jsonString componentsSeparatedByString:@"<joke>"];
    
    NSMutableArray* itemArray = [[NSMutableArray alloc] init];
    for(NSString* item in array)
    {
        __strong NSString* temp = item;
        
        NSString* id = @"";
        NSString* name = @"";
        NSString* time = @"";
        NSString* text = @"";
        NSString* imgurl = @"";
        NSString* forward = @"";
        NSString* commend = @"";
        NSString* videourl = @"";
        
        NSRange range = [temp rangeOfString:@"<id>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        NSRange range1 = [temp rangeOfString:@"</id>"];
        if(NSNotFound == range1.location)
            continue;
        id = [temp substringToIndex:range1.location];
        
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<name>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</name>"];
        if(NSNotFound == range1.location)
            continue;
        name = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<time>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</time>"];
        if(NSNotFound == range1.location)
            continue;
        time = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        
        ////////////////
        range = [temp rangeOfString:@"<text>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</text>"];
        if(NSNotFound == range1.location)
            continue;
        text = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        
        ////////////////
        range = [temp rangeOfString:@"<imgurl>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</imgurl>"];
        if(NSNotFound == range1.location)
            continue;
        imgurl = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<forward>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</forward>"];
        if(NSNotFound == range1.location)
            continue;
        forward = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<commend>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</commend>"];
        if(NSNotFound == range1.location)
            continue;
        commend = [temp substringToIndex:range1.location];
        temp = [temp substringFromIndex:range1.location  + range1.length];
        
        ////////////////
        range = [temp rangeOfString:@"<videourl>"];
        if(NSNotFound == range.location)
            continue;
        
        temp = [temp substringFromIndex:range.location + range.length];
        range1 = [temp rangeOfString:@"</videourl>"];
        if(NSNotFound == range1.location)
            continue;
        videourl = [temp substringToIndex:range1.location];
        //temp = [temp substringFromIndex:range1.location  + range1.length];
        
        if(0 == [id length])
            continue;
        
        NSPredicate* predicate = [NSPredicate predicateWithFormat:@"id = %@",id];
        NSManagedObjectID* objectID = [RCTool getExistingEntityObjectIDForName: @"Item"
                                                                     predicate: predicate
                                                               sortDescriptors: nil
                                                                       context: [RCTool getManagedObjectContext]];
        
        
        Item* item = nil;
        if(nil == objectID)
        {
            item = [RCTool insertEntityObjectForName:@"Item"
                                managedObjectContext:[RCTool getManagedObjectContext]];
            
            item.id = id;
        }
        else
        {
            item = (Item*)[RCTool insertEntityObjectForID:objectID
                                     managedObjectContext:[RCTool getManagedObjectContext]];
        }
        
        item.name = name;
        item.time = time;
        item.text = text;
        item.imgurl = imgurl;
        item.forward = forward;
        item.commend = commend;
        item.videourl = videourl;
        
        
        [itemArray addObject:item];
        
    }
    
    
    if([itemArray count])
    {
        if(0 == type)
        {
            self.tryno++;
            NSIndexSet *indexes = [NSIndexSet indexSetWithIndexesInRange:
                                   NSMakeRange(0,[itemArray count])];
            
            [_itemArray1 insertObjects:itemArray atIndexes:indexes];
            
            
        }
        else
        {
            self.tryno++;
            [_itemArray1 addObjectsFromArray:itemArray];
        }
        
        
        [self.tableView reloadData];
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(0 == section)
    {
        if(0 == _type)
            return [self.itemArray0 count];
        else
            return [self.itemArray1 count];
    }
    
    return 1;
}

- (CGFloat)getCellHeight:(NSIndexPath*)indexPath
{
    CGFloat offset_width = 8.0f;
    CGFloat offset_height = 8.0f;
    CGFloat header_height = 30.0f;
    CGFloat name_height = 20.0f;
    CGFloat name_font_size = 14.0f;
    CGFloat text_font_size = 17.0f;
    CGFloat button_height = 45.0f;
    CGFloat image_height = 160.0f;
    
    CGFloat height = offset_height*7 + header_height + button_height;
    
    Item* item = (Item*)[self getCellDataAtIndexPath:indexPath];
    if(item)
    {
        NSString* text = item.text;
        if([text length])
        {
            CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:text_font_size] constrainedToSize:CGSizeMake([RCTool getScreenSize].width - offset_width*4,CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
            height += size.height;
        }
        
        NSString* imageUrl = item.imgurl;
        NSString* videourl = item.videourl;
        if([imageUrl length] || [videourl length])
        {
            height += image_height;
        }
    }
    
    return height;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self getCellHeight:indexPath];
}

- (id)getCellDataAtIndexPath: (NSIndexPath*)indexPath
{
    if(0 == _type)
    {
        if(indexPath.row >= [_itemArray0 count])
            return nil;
        
        return [_itemArray0 objectAtIndex: indexPath.row];
    }
    else
    {
        if(indexPath.row >= [_itemArray1 count])
            return nil;
        
        return [_itemArray1 objectAtIndex: indexPath.row];
    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellId1 = @"cellId1";
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:cellId1];
    if(cell == nil)
    {
        cell = [[RCPublicCell alloc] initWithStyle: UITableViewCellStyleDefault
                                   reuseIdentifier: cellId1 contentViewClass:NSClassFromString(@"RCPictureCellContentView")];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //cell.backgroundColor = [UIColor clearColor];
    }
    
    NSDictionary* item = (NSDictionary*)[self getCellDataAtIndexPath: indexPath];
    RCPublicCell* temp = (RCPublicCell*)cell;
    if(temp)
    {
        [temp updateContent:item cellHeight:[self getCellHeight:indexPath] delegate:self token:nil];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (IBAction)segmentedControlValueChanged:(id)sender
{
    NSLog(@"segmentedControlValueChanged");
    
    self.type = self.segmentedControl.selectedSegmentIndex;
    
    if(1 == self.type && 0 == [self.itemArray1 count])
        [self updateRandomContent:nil page:0 type:0];
    else if(0 == self.type && 0 == [self.itemArray0 count])
        [self updateContent:nil page:0 type:0];
    
    [self.tableView reloadData];
}

- (void)clickedImageRect:(id)token
{
    Item* item = (Item*)token;
    if(nil == item)
        return;
    
    static int times = 1;
    if(0 == times % [RCTool getScreenAdRate])
    {
        times = 1;
        [self showAdFullScreen:nil];
        return;
    }
    else
        times++;
    
    NSString* videoUrl = item.videourl;
    if(0 == [videoUrl length])
    {
        RCImageDisplayViewController* temp = [[RCImageDisplayViewController alloc] initWithNibName:nil bundle:nil];
        [temp updateContent:item];
        UINavigationController* naviCtrl = [[UINavigationController alloc] initWithRootViewController:temp];
        naviCtrl.navigationBar.translucent = NO;
        [self presentViewController:naviCtrl animated:YES completion:^{
            
        }];
    }
    else
    {
        RCWebViewController* temp = [[RCWebViewController alloc] initWithNibName:nil bundle:nil];
        temp.hideToolbar = NO;
        [temp updateContent:videoUrl title:nil];
        temp.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:temp animated:YES];
    }
}

- (void)clickedShareButton:(id)token
{
    Item* item = (Item*)token;
    if(nil == item)
        return;
    
    self.selectedItem = item;
    
    NSString* text = item.text;
    if(0 == [text length])
        text = @"";
    
    NSString* videourl = item.videourl;
    if([videourl length])
        videourl = [NSString stringWithFormat:@"(点链接看视频)%@",videourl];
    else
    {
        videourl = item.id;
        if([videourl length])
            videourl = [NSString stringWithFormat:@"(点链接看动画和原文) http://joke.zaijiawan.com/Joke/jokeforweixin.jsp?os=ios&jokeid=%@",videourl];
        else
            videourl = @"";
    }
    
    NSString* imageUrl = item.imgurl;
    
    NSString* imagePath = [RCTool getImageLocalPath:imageUrl];
    
    id image = nil;
    //if([imagePath hasSuffix:@".gif"] || [imagePath hasSuffix:@".GIF"])
    {
        image = [NSData dataWithContentsOfFile:imagePath];
    }
    
    NSString* message = [NSString stringWithFormat:@"%@%@",text,videourl];
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:UMENG_KEY
                                      shareText:message
                                     shareImage:image
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToEmail,UMShareToSms,nil]
                                       delegate:self];
}

-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
 NSLog(@"didFinishGetUMSocialDataInViewController");
    
    //根据`responseCode`得到发送结果,如果分享成功
    if(response.responseCode == UMSResponseCodeSuccess)
    {
        if(self.selectedItem)
        {
            self.selectedItem.forward = [NSString stringWithFormat:@"%d",[self.selectedItem.forward intValue] + 1];
            [self.tableView reloadData];
        }
        
        //得到分享到的微博平台名
        NSLog(@"share to sns name is %@",[[response.data allKeys] objectAtIndex:0]);
    }
}


#pragma mark -

- (void)showAdBanner:(NSNotification*)noti
{
    UIView* adView = [RCTool getAdView];
    if(adView)
    {
        CGRect rect = adView.frame;
        rect.origin.y = -adView.bounds.size.height;
        adView.frame = rect;
        
        [self.tabBarController.tabBar addSubview:adView];
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
