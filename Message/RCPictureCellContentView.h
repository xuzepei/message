//
//  RCPictureCellContentView.h
//  Message
//
//  Created by xuzepei on 8/5/14.
//  Copyright (c) 2014 TapGuilt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCPublicCellContentView.h"
#import "SCGIFImageView.h"
#import "YLGIFImage.h"
#import "YLImageView.h"

@protocol RCPictureCellContentViewDelegate <NSObject>

@optional
- (void)clickedShareButton:(id)token;
- (void)clickedImageRect:(id)token;

@end

@interface RCPictureCellContentView : RCPublicCellContentView

@property(nonatomic,strong)UIWebView* webView;
@property(nonatomic,strong)YLImageView* gifImageView;
@property(nonatomic,strong)NSString* videoUrl;
@property(nonatomic,assign)CGRect voteButtonRect;
@property(nonatomic,assign)CGRect shareButtonRect;
@property(nonatomic,assign)CGRect imageRect;

@end
