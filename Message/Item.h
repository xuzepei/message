//
//  Item.h
//  Message
//
//  Created by xuzepei on 8/6/14.
//  Copyright (c) 2014 TapGuilt Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * time;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * imgurl;
@property (nonatomic, retain) NSString * forward;
@property (nonatomic, retain) NSString * commend;
@property (nonatomic, retain) NSString * videourl;
@property (nonatomic, retain) NSNumber * isHidden;
@property (nonatomic, retain) NSNumber * isLiked;

@end
