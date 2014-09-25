//
//  FDSQStartView.m
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import "FDSQStartView.h"
#import "RCTool.h"
#import <QuartzCore/QuartzCore.h>

@implementation FDSQStartView

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)awakeFromNib
{
	[super awakeFromNib];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
 
    //NSString* text = NSLocalizedString(@"The old saying \"no news is good news\" doesn't apply to your sex life, so uncover your real lover rating by taking this test.",@"");
	
	NSString* text = NSLocalizedString(@"嘿，别害羞，女生，来做一个小测试吧。看看害羞的你内心里是怎样认识SEX那点事的。相信一定会对你有帮助！",@"");
	
	if(NO == [RCTool isIpad])
	{
		//[[UIColor brownColor] set];
		UIFont* font = [UIFont systemFontOfSize:18];
		
        UIImage* image = [UIImage imageNamed:@"start_banner.png"];
        if(image)
        {
            [image drawInRect:CGRectMake((self.bounds.size.width - image.size.width)/2.0,20,image.size.width,image.size.height)];
        }
        
		[text drawInRect:CGRectMake(20,230,self.bounds.size.width - 20,self.bounds.size.height - 80) 
				withFont:font
		   lineBreakMode:UILineBreakModeTailTruncation
               alignment:NSTextAlignmentLeft];
	}
	else
	{
		UIImage* image = [UIImage imageNamed:@"start_banner.png"];
        if(image)
        {
            [image drawInRect:CGRectMake((self.bounds.size.width - image.size.width)/2.0,20,image.size.width,image.size.height)];
        }
		
		[text drawInRect:CGRectMake(40,260,self.bounds.size.width - 40*2,self.bounds.size.height) 
				withFont:[UIFont boldSystemFontOfSize:30]
		   lineBreakMode:UILineBreakModeTailTruncation
			   alignment:UITextAlignmentLeft];
		
	}
	
}


@end
