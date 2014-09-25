//
//  FDSQResultView.h
//  Food
//
//  Created by xu zepei on 11/9/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FDSQDetailViewController;
@interface FDSQResultView : UIView {

}

@property(nonatomic,assign)int score;
@property(nonatomic,strong)NSString* information;
@property(nonatomic,weak)FDSQDetailViewController* detailViewController;

- (void)updateContent:(int)score;

@end
