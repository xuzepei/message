//
//  RCPictureCellContentView.m
//  Message
//
//  Created by xuzepei on 8/5/14.
//  Copyright (c) 2014 TapGuilt Inc. All rights reserved.
//

#import "RCPictureCellContentView.h"
#import "RCImageLoader.h"
#import "Item.h"


#define LINE_COLOR [RCTool colorWithHex:0xdbe0e4]
#define TEXT_COLOR [RCTool colorWithHex:0x3c3c3c]
#define FONT_SIZE 15
#define BUTTON_RECT CGRectMake(220,self.bounds.size.height - 36,89,29)
#define BLUE_TEXT_COLOR [RCTool colorWithHex:0x02a3f1]

@implementation RCPictureCellContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.backgroundColor = BG_COLOR;
    }
    return self;
}

- (CGSize)getFitImageSize:(CGSize)size
{
    CGFloat offset_width = 8.0f;
    CGFloat image_height = 160.0f;
    
    CGFloat width = size.width;
    CGFloat height = size.height;
    
    if(size.width >= size.height)
    {
        while (width > ([RCTool getScreenSize].width - offset_width*4) || height > image_height){
            
            width--;
            
            height = size.height*width/size.width;
        }
    }
    else
    {
        while (width > ([RCTool getScreenSize].width - offset_width*4) || height > image_height){
            
            height--;
            
            width = size.width*height/size.height;
        }
    }
    
    return CGSizeMake(width, height);
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    if(nil == self.item)
        return;
    
    Item* item0 = (Item*)self.item;
    
    CGFloat offset_width = 8.0f;
    CGFloat offset_height = 8.0f;
    CGFloat header_height = 30.0f;
    CGFloat name_height = 20.0f;
    CGFloat name_font_size = 14.0f;
    CGFloat text_font_size = 17.0f;
    CGFloat button_height = 45.0f;
    CGFloat image_height = 160.0f;
    CGFloat number_font_size = 15.0f;
    
    CGFloat offset_y = offset_height;
    
    [[UIColor whiteColor] set];
    CGRect blockRect = CGRectMake(offset_width, offset_y, self.bounds.size.width - offset_width*2, self.bounds.size.height - offset_height*2);
    UIRectFill(blockRect);
    
    CGRect headerRect = CGRectMake(offset_width, offset_y, self.bounds.size.width - offset_width*2, header_height);
    
    [[RCTool colorWithHex:0xf5f5f5] set];
    UIRectFill(headerRect);
    
    offset_y += offset_height;
    [TEXT_COLOR set];
    NSString* name = item0.name;
    if([name length])
    {
        [name drawInRect:CGRectMake(offset_width*2, offset_y, [RCTool getScreenSize].width/2.0, name_height) withFont:[UIFont systemFontOfSize:name_font_size] lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentLeft];
    }
    
    NSString* time = item0.time;
    if([time length])
    {
        [time drawInRect:CGRectMake([RCTool getScreenSize].width/2.0, offset_y, [RCTool getScreenSize].width/2.0 - offset_width*2, name_height) withFont:[UIFont systemFontOfSize:name_font_size] lineBreakMode:NSLineBreakByTruncatingTail alignment:NSTextAlignmentRight];
    }
    
    offset_y += header_height;
    NSString* text = item0.text;
    if([text length])
    {
        CGSize size = [text drawInRect:CGRectMake(offset_width*2, offset_y, [RCTool getScreenSize].width - offset_width*4, CGFLOAT_MAX) withFont:[UIFont systemFontOfSize:text_font_size] lineBreakMode:NSLineBreakByWordWrapping];
        
        offset_y += size.height + offset_height*2;
    }
    
    if(_gifImageView)
        [_gifImageView removeFromSuperview];
    _gifImageView = nil;
    
    if(self.image)
    {
        NSString* imagePath = [RCTool getImageLocalPath:self.imageUrl];
        if(0 == [imagePath length])
        {
            if([RCTool isIpad])
            {
                imagePath = [[NSBundle mainBundle] pathForResource:@"loading_white_pad" ofType:@"gif"];
            }
            else
            {
                imagePath = [[NSBundle mainBundle] pathForResource:@"loading_white" ofType:@"gif"];
            }
        }
        
        if([imagePath hasSuffix:@".gif"] || [imagePath hasSuffix:@".GIF"])
        {
            CGSize size = [self getFitImageSize:self.image.size];
            _gifImageView = [[YLImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
            _gifImageView.center = CGPointMake([RCTool getScreenSize].width/2.0, offset_y + image_height/2.0);
            _gifImageView.image = [YLGIFImage imageWithContentsOfFile:imagePath];
            
            _imageRect = CGRectMake(offset_width*2, offset_y, [RCTool getScreenSize].width - offset_width*4, image_height);
            
            [self addSubview:_gifImageView];
        }
        else
        {
            
            CGSize size = [self getFitImageSize:self.image.size];
            CGRect tempRect = CGRectMake(([RCTool getScreenSize].width - size.width)/2.0, offset_y, size.width, size.height);
            if([self.videoUrl length])
            {
                tempRect = CGRectMake(([RCTool getScreenSize].width - image_height*4/3.0)/2.0, offset_y, image_height*4/3.0, image_height);
            }
            
            _imageRect = CGRectMake(offset_width*2, offset_y, [RCTool getScreenSize].width - offset_width*4, image_height);
            
            [self.image drawInRect:tempRect];
            
            if([self.videoUrl length])
            {
                UIImage* playImage = [UIImage imageNamed:@"play_button"];
                if(playImage)
                {
                    tempRect = CGRectMake(([RCTool getScreenSize].width - 44)/2.0, offset_y + (image_height - 44)/2.0, 44, 44);
                    [playImage drawInRect:tempRect];
                }
            }
        }
        
    }
    
    
    [LINE_COLOR set];
    CGRect lineRect = CGRectMake(offset_width, self.bounds.size.height - button_height - offset_height, [RCTool getScreenSize].width - offset_width*2, 1);
    UIRectFill(lineRect);
    
    lineRect = CGRectMake([RCTool getScreenSize].width/2.0 - 0.5, self.bounds.size.height - button_height - offset_height,1,button_height);
    UIRectFill(lineRect);
    
    _voteButtonRect = CGRectMake(offset_width, self.bounds.size.height - button_height - offset_height, ([RCTool getScreenSize].width - offset_width*2)/2.0, button_height);
    
    NSString* voteImageName = @"vote_button";
    if([item0.isLiked boolValue])
        voteImageName = @"vote_button_selected";
    UIImage* voteImage = [UIImage imageNamed:voteImageName];
    if(voteImage)
    {
        [TEXT_COLOR set];
        [voteImage drawInRect:CGRectMake(_voteButtonRect.origin.x + 40, _voteButtonRect.origin.y + (_voteButtonRect.size.height - 32)/2.0, 32, 32)];
        
        NSString* vote_number = item0.commend;
        if(0 == [vote_number length])
            vote_number = @"0";
        else if([vote_number intValue]>9999)
            vote_number = @"9999+";
        [vote_number drawInRect:CGRectMake(_voteButtonRect.origin.x + 74, _voteButtonRect.origin.y + (_voteButtonRect.size.height - number_font_size)/2.0, 100, 20) withFont:[UIFont systemFontOfSize:number_font_size] lineBreakMode:NSLineBreakByTruncatingTail];
    }
    
    _shareButtonRect = CGRectMake(offset_width + ([RCTool getScreenSize].width - offset_width*2)/2.0, self.bounds.size.height - button_height - offset_height, ([RCTool getScreenSize].width - offset_width*2)/2.0, button_height);
    
    UIImage* shareImage = [UIImage imageNamed:@"share_button"];
    if(shareImage)
    {
        [TEXT_COLOR set];
        [shareImage drawInRect:CGRectMake(_shareButtonRect.origin.x + 40, _shareButtonRect.origin.y + (_shareButtonRect.size.height - 32)/2.0, 32, 32)];
        
        NSString* share_number = item0.forward;
        if(0 == [share_number length])
            share_number = @"0";
        else if([share_number intValue]>9999)
            share_number = @"9999+";
        [share_number drawInRect:CGRectMake(_shareButtonRect.origin.x + 74, _shareButtonRect.origin.y + (_shareButtonRect.size.height - number_font_size)/2.0, 100, 20) withFont:[UIFont systemFontOfSize:number_font_size] lineBreakMode:NSLineBreakByTruncatingTail];
    }
}

- (void)updateContent:(id)item delegate:(id)delegate token:(NSDictionary*)token
{
    [super updateContent:item delegate:delegate token:token];
    
    if(_gifImageView)
        [_gifImageView removeFromSuperview];
    _gifImageView = nil;
    
    _imageRect = CGRectZero;
    
    Item* item0 = (Item*)item;
    
    self.image = nil;
    self.imageUrl = item0.imgurl;
    
    //设置默认图片
    if([self.imageUrl length])
    {
        NSString* imagePath = nil;
        if([RCTool isIpad])
        {
            imagePath = [[NSBundle mainBundle] pathForResource:@"loading_white_pad" ofType:@"gif"];
        }
        else
        {
            imagePath = [[NSBundle mainBundle] pathForResource:@"loading_white_pad" ofType:@"gif"];
        }
        
        self.image = [UIImage imageWithContentsOfFile:imagePath
                      ];
    }
    
    if([self.imageUrl length])
    {
        UIImage* image = [RCTool getImageFromLocal:self.imageUrl];
        if(image)
            self.image = image;
        else
        {
            [[RCImageLoader sharedInstance] saveImage:self.imageUrl
                                             delegate:self
                                                token:nil];
        }
    }
    
    self.videoUrl = item0.videourl;
    
    [self setNeedsDisplay];
}

- (void)succeedLoad:(id)result token:(id)token
{
	NSDictionary* dict = (NSDictionary*)result;
	NSString* urlString = [dict valueForKey: @"url"];
    
	if([urlString isEqualToString: self.imageUrl])
	{
		self.image = [RCTool getImageFromLocal:self.imageUrl];
		[self setNeedsDisplay];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch* touch = [touches anyObject];
    CGPoint endPoint = [touch locationInView:self];
    
    if(CGRectContainsPoint(_voteButtonRect, endPoint))
    {
        NSLog(@"clickedVoteButton");
        Item* item0 = (Item*)self.item;
        if(NO == [item0.isLiked boolValue])
        {
            item0.isLiked = [NSNumber numberWithBool:YES];
            item0.commend = [NSString stringWithFormat:@"%d",[item0.commend intValue]+1];
            [self setNeedsDisplay];
        }
        
    }
    else if(CGRectContainsPoint(_shareButtonRect, endPoint))
    {
        NSLog(@"clickedShareButton");
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(clickedShareButton:)])
        {
            [self.delegate clickedShareButton:self.item];
        }
    }
    else if(CGRectContainsPoint(_imageRect, endPoint))
    {
        if(nil == self.image)
            return;
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(clickedImageRect:)])
        {
            [self.delegate clickedImageRect:self.item];
        }
    }
}

@end
