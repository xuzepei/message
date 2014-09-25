//
//  FDButton.h
//  Food
//
//  Created by xu zepei on 11/14/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FDButton : UIView
{
}

@property(nonatomic,retain)NSString* text;
@property(nonatomic,retain)UIFont* font;
@property(nonatomic,assign)BOOL isSelected;
@property(nonatomic,assign)id target;

@end
