//
//  RCSecondTableViewController.h
//  Message
//
//  Created by xuzepei on 8/6/14.
//  Copyright (c) 2014 TapGuilt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UMSocial.h"
#import "MJRefresh.h"

@class Item;
@interface RCSecondTableViewController : UITableViewController<UMSocialUIDelegate>

@property(nonatomic,weak)IBOutlet UISegmentedControl* segmentedControl;
@property(nonatomic,strong)NSMutableArray* itemArray0;
@property(nonatomic,strong)NSMutableArray* itemArray1;
@property(nonatomic,assign)int page0;
@property(nonatomic,assign)int page1;
@property(nonatomic,assign)int tryno;
@property(nonatomic,assign)int type;
@property(nonatomic,strong)Item* selectedItem;




- (IBAction)segmentedControlValueChanged:(id)sender;

@end
