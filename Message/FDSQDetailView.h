//
//  FDSQDetailView.h
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDSQDetailViewController;
@class FDButton;
@interface FDSQDetailView : UIView<UITextFieldDelegate> {
	

}

@property(nonatomic,retain)NSMutableDictionary* item;
@property(nonatomic,assign)CGFloat offset_y;
@property(nonatomic,assign)CGFloat question_width;
@property(nonatomic,assign)CGFloat question_y;
@property(nonatomic,retain)FDButton* button0;
@property(nonatomic,retain)FDButton* button1;
@property(nonatomic,retain)UIButton* button2;
@property(nonatomic,retain)UIButton* button3;
@property(nonatomic,retain)UIButton* button4;

@property(nonatomic,retain)UIButton* previous;
@property(nonatomic,retain)UIButton* next;
@property(nonatomic,retain)UIButton* resultButton;

@property(nonatomic,retain)UILabel* inputLabel;
@property(nonatomic,retain)UITextField* textField;

@property(nonatomic,assign)int index;
@property(nonatomic,assign)int selectedIndex;
@property(nonatomic,assign)int type;

@property(nonatomic,assign)FDSQDetailViewController* delegate;

- (void)updateContent:(NSMutableDictionary*)item index:(int)index;
- (void)clickButton:(NSNumber*)tag;

@end
