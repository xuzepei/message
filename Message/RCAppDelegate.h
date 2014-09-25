//
//  RCAppDelegate.h
//  Message
//
//  Created by xuzepei on 8/5/14.
//  Copyright (c) 2014 TapGuilt Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GADBannerView.h"
#import "GADInterstitial.h"
#import <iAd/iAd.h>
#import "BaiduMobAdView.h"
#import "BaiduMobAdInterstitial.h"

@interface RCAppDelegate : UIResponder <UIApplicationDelegate,GADBannerViewDelegate,GADInterstitialDelegate,UIAlertViewDelegate,BaiduMobAdInterstitialDelegate,BaiduMobAdViewDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, strong) GADBannerView *adMobAd;
@property (assign)BOOL isAdMobVisible;
@property (nonatomic, strong) GADInterstitial *adInterstitial;

@property (nonatomic, strong) BaiduMobAdView *adView;
@property (assign)BOOL isAdViewVisible;
@property (nonatomic, strong) BaiduMobAdInterstitial* interstitial;

@property (nonatomic,strong) NSString* ad_id;
@property (nonatomic,assign)BOOL showFullScreenAd;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)showInterstitialAd:(UIViewController*)rootViewController;






@end
