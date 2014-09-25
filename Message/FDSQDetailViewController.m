//
//  FDSQDetailViewController.m
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import "FDSQDetailViewController.h"
#import "RCTool.h"
#import "FDSQDetailView.h"
#import "FDSQResultView.h"
#import "FDSQAnswerViewController.h"

@implementation FDSQDetailViewController

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
		_itemArray = [[NSMutableArray alloc] init];
        
        self.view.backgroundColor = [UIColor whiteColor];

    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
    
    UIView* adView = [RCTool getAdView];
    if(adView)
    {
        CGRect rect = adView.frame;
        rect.origin.y = [RCTool getScreenSize].height - rect.size.height - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT;
        adView.frame = rect;
        
        [self.view addSubview:adView];
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear: animated];
    
	if(_scrollView)
		[_scrollView removeFromSuperview];
}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	[super viewDidLoad];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)updateContent
{
	_index = 1;
	self.title = [NSString stringWithFormat:@"%@ (%d/18)",NSLocalizedString(@"女生测试",@""),_index];
	
	NSString* question1 = NSLocalizedString(@"1. 男同学或男同事当着你的面说黄色笑话，你会？", @"");
	NSNumber* question1_type = [NSNumber numberWithInt:0];
	NSString* question1_selection0 = NSLocalizedString(@"A. 没什么大不了", @"");
	NSString* question1_selection1 = NSLocalizedString(@"B. 很生气", @"");
    
    
	NSString* question2 = NSLocalizedString(@"2. 遇到喜欢的男生，你会想办法让他看见你吗？", @"");
	NSNumber* question2_type = [NSNumber numberWithInt:0];
	NSString* question2_selection0 = NSLocalizedString(@"A. 会", @"");
	NSString* question2_selection1 = NSLocalizedString(@"B. 顺其自然", @"");
    
 	NSString* question3 = NSLocalizedString(@"3. 当你提议去某处吃饭，朋友却持反对意见，你会？", @"");
	NSNumber* question3_type = [NSNumber numberWithInt:0];
	NSString* question3_selection0 = NSLocalizedString(@"A. 继续推销你提议的地方", @"");
	NSString* question3_selection1 = NSLocalizedString(@"B. 立即放弃你的建议，改听别人", @"");
    
    NSString* question4 = NSLocalizedString(@"4. 当心仪的对象和你说话时，你反而会变得不是很在乎他？", @"");
	NSNumber* question4_type = [NSNumber numberWithInt:0];
	NSString* question4_selection0 = NSLocalizedString(@"A. 是", @"");
	NSString* question4_selection1 = NSLocalizedString(@"B. 不是", @"");
    
    NSString* question5 = NSLocalizedString(@"5. 人家说你的眼睛很漂亮，即使你知道对方只是应酬话，仍然高兴不已？", @"");
	NSNumber* question5_type = [NSNumber numberWithInt:0];
	NSString* question5_selection0 = NSLocalizedString(@"A. 是", @"");
	NSString* question5_selection1 = NSLocalizedString(@"B. 不是", @"");
    
    NSString* question6 = NSLocalizedString(@"6. 你会主动向心仪的他表白吗？", @"");
	NSNumber* question6_type = [NSNumber numberWithInt:0];
	NSString* question6_selection0 = NSLocalizedString(@"A. 会", @"");
	NSString* question6_selection1 = NSLocalizedString(@"B. 打死也不会", @"");
    
    
    NSString* question7 = NSLocalizedString(@"7. 有男生找你一同吃饭，即使是讨厌的人也会去？", @"");
	NSNumber* question7_type = [NSNumber numberWithInt:0];
	NSString* question7_selection0 = NSLocalizedString(@"A. 会", @"");
	NSString* question7_selection1 = NSLocalizedString(@"B. 不会", @"");
    
    NSString* question8 = NSLocalizedString(@"8. 只要看见电影或连续剧有感人的情节，你就会流下眼泪？", @"");
	NSNumber* question8_type = [NSNumber numberWithInt:0];
	NSString* question8_selection0 = NSLocalizedString(@"A. 是，自认是很容易被剧情感动的女生", @"");
	NSString* question8_selection1 = NSLocalizedString(@"B. 不会", @"");
    
    NSString* question9 = NSLocalizedString(@"9. 只要有男生对你好一点，你就会认为他对你有意思而有所防范？", @"");
	NSNumber* question9_type = [NSNumber numberWithInt:0];
	NSString* question9_selection0 = NSLocalizedString(@"A. 会", @"");
	NSString* question9_selection1 = NSLocalizedString(@"B. 不会", @"");
    
    NSString* question10 = NSLocalizedString(@"10. 比你大八岁的男性约你一道用餐，可是你跟他并不是很熟，你会怎么做？", @"");
	NSNumber* question10_type = [NSNumber numberWithInt:0];
	NSString* question10_selection0 = NSLocalizedString(@"A. 答应他", @"");
	NSString* question10_selection1 = NSLocalizedString(@"B. 不会跟他去", @"");
    
    NSString* question11 = NSLocalizedString(@"11. 如果要你打扮得像个芭比娃娃，或是穿上正式礼服，你会？", @"");
	NSNumber* question11_type = [NSNumber numberWithInt:0];
	NSString* question11_selection0 = NSLocalizedString(@"A. 尽量打扮，因为平常你就很喜欢将自己穿得美美的", @"");
	NSString* question11_selection1 = NSLocalizedString(@"B. 觉得浑身不自在，说不定就不去赴约了", @"");
    
    
    NSString* question12 = NSLocalizedString(@"12. 你和异性一同到餐厅用餐，这时服务生端来咖啡，你会？", @"");
	NSNumber* question12_type = [NSNumber numberWithInt:0];
	NSString* question12_selection0 = NSLocalizedString(@"A. 他喝他的，我喝我的", @"");
	NSString* question12_selection1 = NSLocalizedString(@"B. 先替他加好糖，再将咖啡给他", @"");
    
    NSString* question13 = NSLocalizedString(@"13. 如果从一分到五分来为你的耐心评分，你会给自己打几分？", @"");
	NSNumber* question13_type = [NSNumber numberWithInt:0];
	NSString* question13_selection0 = NSLocalizedString(@"A. 一到三分", @"");
	NSString* question13_selection1 = NSLocalizedString(@"B. 四到五分", @"");
    
    NSString* question14 = NSLocalizedString(@"14. 除了运动之外，只要是好玩的活动，你都很跃跃欲试？", @"");
	NSNumber* question14_type = [NSNumber numberWithInt:0];
	NSString* question14_selection0 = NSLocalizedString(@"A. Yes", @"");
	NSString* question14_selection1 = NSLocalizedString(@"B. No", @"");
    
    NSString* question15 = NSLocalizedString(@"15. 当你已经有男朋友，却收到别的男生的情书邀约时，你会？", @"");
	NSNumber* question15_type = [NSNumber numberWithInt:0];
	NSString* question15_selection0 = NSLocalizedString(@"A. 前去赴约", @"");
	NSString* question15_selection1 = NSLocalizedString(@"B. 再也不会跟别的男生约会", @"");
    
    NSString* question16 = NSLocalizedString(@"16. 你已经跟朋友约好了后天一道吃饭，你会……", @"");
	NSNumber* question16_type = [NSNumber numberWithInt:0];
	NSString* question16_selection0 = NSLocalizedString(@"A. 无论如何都准时赴约", @"");
	NSString* question16_selection1 = NSLocalizedString(@"B. 如果有别的更吸引你的事情，你会跟朋友取消约会", @"");
    
    NSString* question17 = NSLocalizedString(@"17. 朋友说：“明天一起去打篮球吧！”你的回答是？", @"");
	NSNumber* question17_type = [NSNumber numberWithInt:0];
	NSString* question17_selection0 = NSLocalizedString(@"A. 有人约就去，不管自己喜不喜打篮球", @"");
	NSString* question17_selection1 = NSLocalizedString(@"B. 因为不喜欢篮球，所以就回绝了朋友", @"");
    
    NSString* question18 = NSLocalizedString(@"18. 你是一个……", @"");
	NSNumber* question18_type = [NSNumber numberWithInt:0];
	NSString* question18_selection0 = NSLocalizedString(@"A. 想到什么就去做的行动派", @"");
	NSString* question18_selection1 = NSLocalizedString(@"B. 什么事情都要考虑周全才会行动的计划派", @"");
	    
    
	_itemArray = [[NSMutableArray alloc] init];
	
	//1
	NSMutableDictionary* item = [[NSMutableDictionary alloc] init];
	[item setObject:question1 forKey:@"question"];
	[item setObject:question1_type forKey:@"type"];
	
	NSMutableArray* selectionArray = [[NSMutableArray alloc] init];
	NSMutableDictionary* selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question1_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question1_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];
    	
	[item setObject:selectionArray forKey:@"selections"];
	
	[_itemArray addObject:item];
    
    //2
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question2 forKey:@"question"];
	[item setObject:question2_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question2_selection0 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];
    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question2_selection1 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];
    
	[item setObject:selectionArray forKey:@"selections"];
	
	[_itemArray addObject:item];
    
    //3
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question3 forKey:@"question"];
	[item setObject:question3_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question3_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];
    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question3_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];
    
	[item setObject:selectionArray forKey:@"selections"];
	
	[_itemArray addObject:item];
    
    
    //4
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question4 forKey:@"question"];
	[item setObject:question4_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question4_selection0 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question4_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    //5
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question5 forKey:@"question"];
	[item setObject:question5_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question5_selection0 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question5_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    //6
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question6 forKey:@"question"];
	[item setObject:question6_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question6_selection0 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question6_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //7
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question7 forKey:@"question"];
	[item setObject:question7_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question7_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question7_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];
    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //8
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question8 forKey:@"question"];
	[item setObject:question8_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question8_selection0 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question8_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //9
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question9 forKey:@"question"];
	[item setObject:question9_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question9_selection0 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question9_selection1 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //10
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question10 forKey:@"question"];
	[item setObject:question10_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question10_selection0 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question10_selection1 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //11
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question11 forKey:@"question"];
	[item setObject:question11_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question11_selection0 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question11_selection1 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];
 
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //12
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question12 forKey:@"question"];
	[item setObject:question12_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question12_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question12_selection1 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //13
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question13 forKey:@"question"];
	[item setObject:question13_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question13_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question13_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //14
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question14 forKey:@"question"];
	[item setObject:question14_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question14_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question14_selection1 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

	
    
    
    //15
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question15 forKey:@"question"];
	[item setObject:question15_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question15_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question15_selection1 forKey:@"text"];
	[selection setObject:@"B" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //16
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question16 forKey:@"question"];
	[item setObject:question16_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question16_selection0 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question16_selection1 forKey:@"text"];
	[selection setObject:@"C" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    
    //17
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question17 forKey:@"question"];
	[item setObject:question17_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question17_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question17_selection1 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

    
    
    //18
	item = [[NSMutableDictionary alloc] init];
	[item setObject:question18 forKey:@"question"];
	[item setObject:question18_type forKey:@"type"];
	
	selectionArray = [[NSMutableArray alloc] init];
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question18_selection0 forKey:@"text"];
	[selection setObject:@"A" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	selection = [[NSMutableDictionary alloc] init];
	[selection setObject:question18_selection1 forKey:@"text"];
	[selection setObject:@"D" forKey:@"mark"];
	[selectionArray addObject: selection];

    
	[item setObject:selectionArray forKey:@"selections"];

	
	[_itemArray addObject:item];

	
	
	_detailView = [[FDSQDetailView alloc] initWithFrame:CGRectMake(0,0,
																   self.view.frame.size.width,
																   self.view.frame.size.height - 44)];
	[self.view addSubview: _detailView];
	_detailView.delegate = self;
    [_detailView updateContent:[_itemArray objectAtIndex:_index - 1] 
                         index:_index];
}

- (void)clickPreviousButton
{
	if(_index > 1)
	{
		_index--;
		
		if(_detailView)
		{
			[_detailView updateContent:[_itemArray objectAtIndex:_index - 1] 
								 index:_index];
		}
		
		self.title = [NSString stringWithFormat:@"%@ (%d/18)",NSLocalizedString(@"女生测试",@""),_index];
	}
}

- (void)clickNextButton
{
    UIView* adView = [RCTool getAdView];
    if(adView)
    {
        CGRect rect = adView.frame;
        rect.origin.y = [RCTool getScreenSize].height - rect.size.height - NAVIGATION_BAR_HEIGHT - STATUS_BAR_HEIGHT;
        adView.frame = rect;
        
        [self.view addSubview:adView];
    }
    
	if(_index < LAST_INDEX)
	{
		_index++;
		
		if(_detailView)
		{
			[_detailView updateContent:[_itemArray objectAtIndex:_index - 1] 
								 index:_index];
		}
		
		self.title = [NSString stringWithFormat:@"%@ (%d/18)",NSLocalizedString(@"女生测试",@""),_index];
	}
}

- (void)clickedRightBarButtonItem:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)clickResultButton
{
    if([RCTool isOpenAll])
    {
        UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithTitle:@"点击看妹纸的笑话 >" style:UIBarButtonItemStylePlain target:self action:@selector(clickedRightBarButtonItem:)];
        self.navigationItem.rightBarButtonItem = item;
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:@"finished_test"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
	self.title = NSLocalizedString(@"测试结果分析",@"");
	_timeLabel.hidden = YES;
	
	if(_detailView)
		[_detailView removeFromSuperview];

	if(NO == [RCTool isIpad])
	{
		if(nil == _scrollView)
		{
			_scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0,0,
																		 self.view.frame.size.width,
																		 self.view.frame.size.height)];
			_scrollView.showsVerticalScrollIndicator = NO;
			
			[_scrollView setContentSize:CGSizeMake([RCTool getScreenSize].width, [RCTool getScreenSize].height + 100)];
		}
		
		
		if(nil == _resultView)
		{
			_resultView = [[FDSQResultView alloc] initWithFrame:CGRectMake(0,0,
																		   self.view.frame.size.width,
																		   640)];
		}
		
		[_scrollView addSubview: _resultView];
		[self.view addSubview: _scrollView];
	}
	else
	{
	
		if(nil == _resultView)
		{
			_resultView = [[FDSQResultView alloc] initWithFrame:CGRectMake(0,0,
																		   self.view.frame.size.width,
																		   1000)];
		}
		
		[self.view addSubview: _resultView];
	}
	
	int a_sum = 0;
	int b_sum = 0;
	int c_sum = 0;
	int d_sum = 0;

	int score = -1;
	for(NSDictionary* item in _itemArray)
	{
		int selectedIndex = -1;
		NSNumber* selectedIndexNum = [item objectForKey:@"selectedIndex"];
		if(selectedIndexNum)
			selectedIndex = [selectedIndexNum intValue];
		
		if(-1 == selectedIndex)
			continue;
		
		NSArray* selections = [item objectForKey:@"selections"];
		if(selectedIndex < [selections count])
		{
			NSDictionary* selection = [selections objectAtIndex:selectedIndex];
			NSString* mark = [selection objectForKey:@"mark"];
			if([mark isEqualToString:@"A"])
				a_sum++;
			else if([mark isEqualToString:@"B"])
				b_sum++;
			else if([mark isEqualToString:@"C"])
				c_sum++;
			else if([mark isEqualToString:@"D"])
				d_sum++;
		}
	}
	
	for(int i = 0; i < 4; i++)
	{
		if(0 == i)
		{
			if(a_sum > b_sum && a_sum > c_sum && a_sum > d_sum)
			{
				score = 0;
				break;
			}
		}
		else if(1 == i)
		{
			if(b_sum > a_sum && b_sum > c_sum && b_sum > d_sum)
			{
				score = 1;
				break;
			}
		}
		else if(2 == i)
		{
			if(c_sum > a_sum && c_sum > b_sum && c_sum > d_sum)
			{
				score = 2;
				break;
			}
		}
		else if(3 == i)
		{
			if(d_sum > a_sum && d_sum > b_sum && d_sum > c_sum)
			{
				score = 3;
				break;
			}
		}
	}
	
	if(-1 == score)
		score = 1;
	
	[_resultView updateContent: score];
	
}

- (void)clickAnswerButton
{
	FDSQAnswerViewController* temp = [[FDSQAnswerViewController alloc] 
									  initWithNibName:@"FDSQAnswerViewController" bundle:nil];
    
	[self.navigationController pushViewController:temp animated:YES];

}

- (void)clickAnswerButtonItem:(id)sender
{
    
}


@end
