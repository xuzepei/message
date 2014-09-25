//
//  FDSQResultView.m
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import "FDSQResultView.h"
#import "RCTool.h"
#import "FDSQDetailViewController.h"

@implementation FDSQResultView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
		
//		UIButton* button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//		[button setTitle:NSLocalizedString(@"参考答案",@"")  
//				forState:UIControlStateNormal];
//		[button addTarget:self action:@selector(clickAnswerButton:) 
//		 forControlEvents:UIControlEventTouchUpInside];
		
//		if(NO == [RCTool isIpad])
//		{
//			button.frame = CGRectMake(0,0,200,30);
//			button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//			button.center = CGPointMake(160, 460 - 20 - 42 - 50);
//		}
//		else
//		{
//			button.frame = CGRectMake(0,0,300,50);
//			button.titleLabel.font = [UIFont boldSystemFontOfSize:26];
//			button.center = CGPointMake(768/2.0, 1004 - 30 - 90 - 40);
//		}
		
//		[self addSubview: button];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	if(NO == [RCTool isIpad])
	{	
		UIImage* bgImage = [UIImage imageNamed:@"bg.png"];
		if(bgImage)
		{
			[bgImage drawInRect: self.bounds];
		}
		
		UIImage* image = [UIImage imageNamed:@"end_banner.png"];
        if(image)
        {
            [image drawInRect:CGRectMake((self.bounds.size.width - image.size.width)/2.0,20,image.size.width,image.size.height)];
        }
		
		[[UIColor colorWithRed:0.00 green:0.39 blue:0.00 alpha:1.00] set];
		NSString* temp = NSLocalizedString(@"分析:\r",@"");
		[temp drawInRect:CGRectMake(10, 180, 400, 40) 
				withFont:[UIFont boldSystemFontOfSize:26]];
		
		[[UIColor blackColor] set];
		if([_information length])
		{
			[[UIColor blackColor] set];
			[_information drawInRect:CGRectMake(20, 220, 300, 900) 
							withFont:[UIFont systemFontOfSize:18]];
		}
		
	}
	else
	{
		UIImage* bgImage = [UIImage imageNamed:@"bg_ipad.png"];
		if(bgImage)
		{
			[bgImage drawInRect: self.bounds];
		}
		
		UIImage* image = [UIImage imageNamed:@"end_banner@2x.png"];
        if(image)
        {
            [image drawInRect:CGRectMake((self.bounds.size.width - image.size.width)/2.0,20,image.size.width,image.size.height)];
        }
		
		[[UIColor colorWithRed:0.00 green:0.39 blue:0.00 alpha:1.00] set];
		NSString* temp = NSLocalizedString(@"分析:\r",@"");
		[temp drawInRect:CGRectMake(40, 330, 400, 40) 
				withFont:[UIFont boldSystemFontOfSize:34]];
		
		[[UIColor blackColor] set];
		if([_information length])
		{
			[[UIColor blackColor] set];
			[_information drawInRect:CGRectMake(60, 390, self.bounds.size.width - 120, self.bounds.size.height) 
							withFont:[UIFont boldSystemFontOfSize:24]];
		}
		
	}
	
}


- (void)updateContent:(int)score
{
	_score = score;
	
	if(0 == score)
	{
		self.information = NSLocalizedString(@"你是一个很有主见，比较自我的女孩子。年轻的时候会比同龄的女孩子来得更为叛逆，对于SEX的观念也比较开放，很可能早早就献出第一次，跟日剧中“想早一点儿从女孩成为女人”的女主角们有些类似。 \r\r给你的小建议：你的SEX对象是谁？不管你喜欢的人比你大几岁，假如是已婚男子或是不伦的三角关系，那么在发生SEX之前请多考虑清楚，成为夫妻之间的“第三者”的后果可要自行承担。",@"");
	}
	else if(1 == score)
	{
		self.information = NSLocalizedString(@"你是一个纯真、可爱的女孩子，对于上床这件事，起初会认为”最好还是结婚后才开始“。但是，当你真心地爱上他，而两人又是在两情相悦的情况下从一垒、二垒进步到三垒时，你也可能会自然而然地让他完成全垒打。 \r\r给你的小建议：你的SEX关系是建立在爱情上面的。因此，一旦你发现对方有了SEX就不注重爱的时候，将会大大降低你对爱情的信任感，不敢再与别人谈恋爱。所以，在你决定和他上床之前，一定要先做好自我的心理建设才行。 ",@"");

	}
	else if(2 == score)
	{
		self.information = NSLocalizedString(@"你是一个容易动感情的女孩子。虽然自己不见得会营造浪漫，但是却很喜欢浸淫在这样的气氛之中。因此，当你喜欢上一个人时，就很容易在浪漫的爱情因子下献身给他，尤其是在有纪念价值的日子时，更是你最易失身的时候。 \r\r给你的小建议：虽然要你别太快掉入爱情漩涡是件很难的事。不过，在你献出自己之前，可否先多观察对方的品行，而不要光是沉浸在甜言蜜语、鲜光烛光中，忘了所有该理智考虑的事情。",@"");

	}
	else if(3 == score)
	{
		self.information = NSLocalizedString(@"你是一个乐观向上的女孩子，对于爱情有着一份美丽的憧憬。你不会随意奉献自己，但却可能会因为极爱着对方而给了他第一次。因此，婚前SEX的行为在你身上仍然是有机会出现的。 \r\r给你的小建议：对于害羞、保守的你来说，在为爱付出前总是会考虑再三。其实，假如你不是那么地愿意，那么就不要勉强自己。再者，也可以多了解一些正确的SEX知识，当你对SEX比较了解时再来做决定。",@"");

	}
	
	[self setNeedsDisplay];
}

- (void)clickAnswerButton:(id)sender
{
	if(_detailViewController)
	{
		[_detailViewController clickAnswerButton];
	}
}

@end
