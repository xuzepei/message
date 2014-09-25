//
//  FDSQDetailView.m
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import "FDSQDetailView.h"
#import <QuartzCore/QuartzCore.h>
#import "FDSQDetailViewController.h"
#import "RCTool.h"
#import "FDButton.h"

@implementation FDSQDetailView


- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	
	if(nil == _item)
		return;
	
	if(NO == [RCTool isIpad])
	{
		UIImage* bgImage = [UIImage imageNamed:@"bg.png"];
		if(bgImage)
		{
			[bgImage drawInRect: self.bounds];
		}
		
		CGFloat question_y = 20;
		
		if(0 == _type)
		{
			NSString* question = [_item objectForKey:@"question"];
			if([question length])
			{
				[question drawInRect:CGRectMake(10,question_y,300,CGFLOAT_MAX) 
							withFont:[UIFont boldSystemFontOfSize:18]];
			}
		}
	}
	else
	{
		
		UIImage* bgImage = [UIImage imageNamed:@"bg_ipad.png"];
		if(bgImage)
		{
			[bgImage drawInRect: self.bounds];
		}
		
		CGFloat question_y = 40;
		
		if(0 == _type)
		{
			NSString* question = [_item objectForKey:@"question"];
			if([question length])
			{
				[question drawInRect:CGRectMake(20,question_y,728,CGFLOAT_MAX) 
							withFont:[UIFont boldSystemFontOfSize:26]];
			}
		}		
        
	}
	
    
    
}


- (void)updateContent:(NSMutableDictionary*)item index:(int)index
{
	if(nil == item)
		return;
	
	self.item = item;
	_index = index;
	_selectedIndex = -1;
	_type = -1;
	[self setNeedsDisplay];
	
	_type = [[_item objectForKey:@"type"] intValue];
	
	if(NO == [RCTool isIpad])
	{
		CGSize size;
		CGFloat question_y = 20;
		CGFloat question_width = 0;
		
		size = [[_item objectForKey:@"question"] sizeWithFont:[UIFont boldSystemFontOfSize:18]
											constrainedToSize:CGSizeMake(300,CGFLOAT_MAX)];
		
		question_width = 10 + size.width + 10;
		
		if(nil == _previous)
		{
			self.previous = [UIButton buttonWithType:UIButtonTypeCustom];
			_previous.frame = CGRectMake(10,self.frame.size.height - 102,90,30);
			_previous.titleLabel.font = [UIFont systemFontOfSize: 16];
			_previous.layer.borderWidth = 1.0;
			_previous.layer.borderColor = [[UIColor blackColor] CGColor];
			[_previous setTitleColor:[UIColor blackColor] 
							forState:UIControlStateNormal];
			[_previous setTitleColor:NAVIGATION_BAR_COLOR
							forState:UIControlStateHighlighted];
			[_previous setTitle:NSLocalizedString(@"上一题",@"")
					   forState:UIControlStateNormal];
			[_previous addTarget:self
						  action:@selector(clickPreviousButton:) 
				forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _previous];
		}
		
		_previous.hidden = (1 == _index) ? YES: NO;
		
		if(nil == _next)
		{
			self.next = [UIButton buttonWithType:UIButtonTypeCustom];
			_next.frame = CGRectMake(self.frame.size.width - 100,self.frame.size.height - 102,90,30);
			_next.titleLabel.font = [UIFont systemFontOfSize: 16];
			_next.layer.borderWidth = 1.0;
			_next.layer.borderColor = [[UIColor blackColor] CGColor];
			[_next setTitleColor:[UIColor blackColor] 
						forState:UIControlStateNormal];
			[_next setTitleColor:NAVIGATION_BAR_COLOR
						forState:UIControlStateHighlighted];
			[_next setTitle:NSLocalizedString(@"下一题",@"")
				   forState:UIControlStateNormal];
			[_next addTarget:self
					  action:@selector(clickNextButton:) 
			forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _next];
		}
		
		_next.hidden = (LAST_INDEX == _index) ? YES: NO;
		
		if(nil == _resultButton)
		{
			self.resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
			_resultButton.frame = CGRectMake(self.frame.size.width - 100,self.frame.size.height - 102,90,30);
			_resultButton.titleLabel.font = [UIFont systemFontOfSize: 16];
			_resultButton.layer.borderWidth = 1.0;
			_resultButton.layer.borderColor = [[UIColor blackColor] CGColor];
			[_resultButton setTitleColor:[UIColor blackColor] 
								forState:UIControlStateNormal];
			[_resultButton setTitleColor:NAVIGATION_BAR_COLOR
								forState:UIControlStateHighlighted];
			[_resultButton setTitle:NSLocalizedString(@"完成",@"")
						   forState:UIControlStateNormal];
			[_resultButton addTarget:self
							  action:@selector(clickResultButton:) 
					forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _resultButton];
		}
		
		if(LAST_INDEX == _index)
			_resultButton.hidden = NO;
		else
			_resultButton.hidden = YES;
		
		if(nil == _button0)
		{
			_button0 = [[FDButton alloc] initWithFrame:CGRectZero];
            _button0.font = [UIFont systemFontOfSize: 18];
            _button0.tag = 0;
            _button0.target = self;
            _button0.layer.borderColor = [BUTTON_FRAME_COLOR CGColor];
			[self addSubview: _button0];
		}
		
		if(nil == _button1)
		{
            _button1 = [[FDButton alloc] initWithFrame:CGRectZero];
            _button1.font = [UIFont systemFontOfSize: 18];
            _button1.tag = 1;
            _button1.target = self;
            _button1.layer.borderColor = [BUTTON_FRAME_COLOR CGColor];
			[self addSubview: _button1];
		}
				
		_button0.hidden = YES;
        _button0.text = @"";
        _button0.isSelected = NO;
        _button0.layer.borderWidth = 0.0;
        
        _button1.hidden = YES;
        _button1.text = @"";
        _button1.isSelected = NO;
        _button1.layer.borderWidth = 0.0;
				
		if(0 == _type)
		{
			NSNumber* selectedIndexNum = [_item objectForKey:@"selectedIndex"];
			if(selectedIndexNum)
				_selectedIndex = [selectedIndexNum intValue];
			
			CGFloat offset_x = 20.0;
			CGFloat offset_height = 30.0;
            CGFloat offset_frame_height = 10.0;
			
			question_y += size.height + 30.0;
			
			NSArray* selections = [_item objectForKey:@"selections"];
			for(int i = 0; i < [selections count]; i++)
			{
				NSDictionary* selection = [selections objectAtIndex:i];
				
				if(0 == i)
				{
                    NSString* text = [selection objectForKey:@"text"];
                    CGSize size = [text sizeWithFont:_button0.font
                                                        constrainedToSize:CGSizeMake(280 - 12,CGFLOAT_MAX)];
                    
					_button0.hidden = NO;
					_button0.frame = CGRectMake(offset_x,question_y,280,size.height + offset_frame_height);
					_button0.text = text;
					if(_selectedIndex == i)
                    {
						_button0.isSelected = YES;
                        _button0.layer.borderWidth = 2.0;
                    }
                    
                    question_y += size.height + offset_frame_height + offset_height;
                    
                    [_button0 setNeedsDisplay];
				}
				else if(1 == i)
				{
                    NSString* text = [selection objectForKey:@"text"];
                    CGSize size = [text sizeWithFont:_button1.font
                                   constrainedToSize:CGSizeMake(280 -12,CGFLOAT_MAX)];
                    
					_button1.hidden = NO;
					_button1.frame = CGRectMake(offset_x,question_y,280,size.height + offset_frame_height);
					_button1.text = text;
                    if(_selectedIndex == i)
                    {
						_button1.isSelected = YES;
                        _button1.layer.borderWidth = 2.0;
                    }
                    
                    question_y += size.height + offset_frame_height + offset_height;
                    
                    [_button1 setNeedsDisplay];
				}
			}
		}

    }
	else 
	{
		CGSize size;
		CGFloat question_y = 40;
		CGFloat question_width = 0;
		
		size = [[_item objectForKey:@"question"] sizeWithFont:[UIFont boldSystemFontOfSize:26]
											constrainedToSize:CGSizeMake(728,CGFLOAT_MAX)];
		
		question_width = 20 + size.width + 40;
		
		if(nil == _previous)
		{
			self.previous = [UIButton buttonWithType:UIButtonTypeCustom];
			_previous.frame = CGRectMake(30,self.frame.size.height - 163,150,50);
			_previous.titleLabel.font = [UIFont systemFontOfSize: 26];
			_previous.layer.borderWidth = 1.0;
			_previous.layer.borderColor = [[UIColor blackColor] CGColor];
			[_previous setTitleColor:[UIColor blackColor] 
							forState:UIControlStateNormal];
			[_previous setTitleColor:NAVIGATION_BAR_COLOR
							forState:UIControlStateHighlighted];
			[_previous setTitle:NSLocalizedString(@"上一题",@"")
					   forState:UIControlStateNormal];
			[_previous addTarget:self
						  action:@selector(clickPreviousButton:) 
				forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _previous];
		}
		
		_previous.hidden = (1 == _index) ? YES: NO;
		
		if(nil == _next)
		{
			self.next = [UIButton buttonWithType:UIButtonTypeCustom];
			_next.frame = CGRectMake(self.frame.size.width - 180,self.frame.size.height - 163,150,50);
			_next.titleLabel.font = [UIFont systemFontOfSize: 26];
			_next.layer.borderWidth = 1.0;
			_next.layer.borderColor = [[UIColor blackColor] CGColor];
			[_next setTitleColor:[UIColor blackColor] 
						forState:UIControlStateNormal];
			[_next setTitleColor:NAVIGATION_BAR_COLOR 
						forState:UIControlStateHighlighted];
			[_next setTitle:NSLocalizedString(@"下一题",@"")
				   forState:UIControlStateNormal];
			[_next addTarget:self
					  action:@selector(clickNextButton:) 
			forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _next];
		}
		
		_next.hidden = (LAST_INDEX == _index) ? YES: NO;
		
		if(nil == _resultButton)
		{
			self.resultButton = [UIButton buttonWithType:UIButtonTypeCustom];
			_resultButton.frame = CGRectMake(self.frame.size.width - 180,self.frame.size.height - 163,150,50);
			_resultButton.titleLabel.font = [UIFont systemFontOfSize: 26];
			_resultButton.layer.borderWidth = 1.0;
			_resultButton.layer.borderColor = [[UIColor blackColor] CGColor];
			[_resultButton setTitleColor:[UIColor blackColor] 
								forState:UIControlStateNormal];
			[_resultButton setTitleColor:NAVIGATION_BAR_COLOR 
								forState:UIControlStateHighlighted];
			[_resultButton setTitle:NSLocalizedString(@"完成",@"")
						   forState:UIControlStateNormal];
			[_resultButton addTarget:self
							  action:@selector(clickResultButton:) 
					forControlEvents:UIControlEventTouchUpInside];
			[self addSubview: _resultButton];
		}
		
		if(LAST_INDEX == _index)
			_resultButton.hidden = NO;
		else
			_resultButton.hidden = YES;
		
		if(nil == _button0)
		{
			_button0 = [[FDButton alloc] initWithFrame:CGRectZero];
            _button0.font = [UIFont systemFontOfSize: 26];
            _button0.tag = 0;
            _button0.target = self;
            _button0.layer.borderColor = [BUTTON_FRAME_COLOR CGColor];
			[self addSubview: _button0];
		}
		
		if(nil == _button1)
		{
            _button1 = [[FDButton alloc] initWithFrame:CGRectZero];
            _button1.font = [UIFont systemFontOfSize: 26];
            _button1.tag = 1;
            _button1.target = self;
            _button1.layer.borderColor = [BUTTON_FRAME_COLOR CGColor];
			[self addSubview: _button1];
		}
		
		_button0.hidden = YES;
        _button0.text = @"";
        _button0.isSelected = NO;
        _button0.layer.borderWidth = 0.0;
        
        _button1.hidden = YES;
        _button1.text = @"";
        _button1.isSelected = NO;
        _button1.layer.borderWidth = 0.0;
		
		if(0 == _type)
		{
			NSNumber* selectedIndexNum = [_item objectForKey:@"selectedIndex"];
			if(selectedIndexNum)
				_selectedIndex = [selectedIndexNum intValue];
			
			CGFloat offset_x = 40.0;
			CGFloat offset_height = 60.0;
            CGFloat offset_frame_height = 20.0;
			
			question_y += size.height + 60.0;
			
			NSArray* selections = [_item objectForKey:@"selections"];
			for(int i = 0; i < [selections count]; i++)
			{
				NSDictionary* selection = [selections objectAtIndex:i];
				
				if(0 == i)
				{
                    NSString* text = [selection objectForKey:@"text"];
                    CGSize size = [text sizeWithFont:_button0.font
								   constrainedToSize:CGSizeMake(768 - 80 - 24,CGFLOAT_MAX)];
                    
					_button0.hidden = NO;
					_button0.frame = CGRectMake(offset_x,question_y,768 - 80,size.height + offset_frame_height);
					_button0.text = text;
					if(_selectedIndex == i)
                    {
						_button0.isSelected = YES;
                        _button0.layer.borderWidth = 2.0;
                    }
                    
                    question_y += size.height + offset_frame_height + offset_height;
                    
                    [_button0 setNeedsDisplay];
				}
				else if(1 == i)
				{
                    NSString* text = [selection objectForKey:@"text"];
                    CGSize size = [text sizeWithFont:_button1.font
                                   constrainedToSize:CGSizeMake(768 - 80 -24,CGFLOAT_MAX)];
                    
					_button1.hidden = NO;
					_button1.frame = CGRectMake(offset_x,question_y,768 - 80,size.height + offset_frame_height);
					_button1.text = text;
                    if(_selectedIndex == i)
                    {
						_button1.isSelected = YES;
                        _button1.layer.borderWidth = 2.0;
                    }
                    
                    question_y += size.height + offset_frame_height + offset_height;
                    
                    [_button1 setNeedsDisplay];
				}
			}
			
		}
	}

}

- (void)clickButton0:(id)sender
{
	if(0 == _type)
	{
		_button0.isSelected = YES;
        _button0.layer.borderWidth = 2.0;
        _button1.isSelected = NO;
        _button1.layer.borderWidth = 0.0;
		_selectedIndex = 0;
        
        [_button0 setNeedsDisplay];
        [_button1 setNeedsDisplay];
	}
}

- (void)clickButton1:(id)sender
{
	if(0 == _type)
	{
        _button0.isSelected = NO;
        _button0.layer.borderWidth = 0.0;
        _button1.isSelected = YES;
        _button1.layer.borderWidth = 2.0;
		_selectedIndex = 1;
        
        [_button0 setNeedsDisplay];
        [_button1 setNeedsDisplay];
	}
}

- (void)clickButton:(NSNumber*)tag
{
    
    if(0 == [tag intValue])
    {
        [self clickButton0:nil];
    }
    else if(1 == [tag intValue])
    {
        [self clickButton1:nil];
    }
}

- (void)clickPreviousButton:(id)sender
{
	NSLog(@"clickPreviousButton");
	
	[_delegate clickPreviousButton];
}

- (void)clickNextButton:(id)sender
{
	NSLog(@"clickNextButton");
	
	if(0 == _type)
	{
		if(-1 == _selectedIndex)
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示",@"")
															message:NSLocalizedString(@"您需要先完成当前的题目,才能进入下一题！",@"")
														   delegate:nil 
												  cancelButtonTitle:NSLocalizedString(@"确定",@"")
												  otherButtonTitles:nil];
			
			[alert show];
			
			return;
		}
		else
		{
			[_item setObject:[NSNumber numberWithInt:_selectedIndex] 
					  forKey:@"selectedIndex"];
		}
		
	}
    
	
	[_delegate clickNextButton];
}

- (void)clickResultButton:(id)sender
{
	[_delegate clickResultButton];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	if(_textField)
		[_textField resignFirstResponder];
	
	return YES;
}

@end
