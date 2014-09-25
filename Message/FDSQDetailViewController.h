//
//  FDSQDetailViewController.h
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDSQDetailView;
@class FDSQResultView;
@interface FDSQDetailViewController : UIViewController {
}

@property(nonatomic,strong)NSMutableArray* itemArray;
@property(nonatomic,strong)FDSQDetailView* detailView;
@property(nonatomic,strong)FDSQResultView* resultView;
@property(nonatomic,strong)UIScrollView* scrollView;
@property(nonatomic,strong)UILabel* timeLabel;
@property(nonatomic,assign)int index;
@property(nonatomic,assign)int timeCount;

- (void)updateContent;
- (void)clickPreviousButton;
- (void)clickNextButton;
- (void)clickResultButton;
- (void)clickAnswerButton;


@end
