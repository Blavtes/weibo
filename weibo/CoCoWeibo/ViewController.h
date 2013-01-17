//
//  ViewController.h
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabDelegate.h"
#import "SBTableAlert.h"
#import "AppDelegate.h"
#import "WeiBoMessageManager.h"
#import "PostViewController.h"
@class TimeLineViewController;
@class SinaViewController ;
@class TencentViewController;
@class RenrenViewController;
@class RecipeSegmentControl;
@interface ViewController : UIViewController<TabDelegate,SBTableAlertDelegate,SBTableAlertDataSource, PostViewControlelDelegate>

{
    UIViewController * currentViewController;
    UIViewController * toViewController;
    
    IBOutlet UIView *contentView;
    RecipeSegmentControl * recipe;
     UIImageView *luanchPage;
    NSMutableArray * sinaPaixuArray;
    NSMutableArray * sinaFriendsSectionArray;
    NSMutableArray * tencentShowStyleArray;
    NSMutableArray * renrenShowStyleArray;
    NSNotificationCenter *defaultNotifCenter;
    NSString *userID;
    WeiBoMessageManager * _manager;
}
@property (retain, nonatomic)UIImageView *luanchPage;
@property (retain, nonatomic) IBOutlet UIView *segView;
@property (nonatomic,retain)NSMutableArray * sinaPaixuArray;
@property (nonatomic,retain)NSMutableArray * sinaFriendsSectionArray;
@property (nonatomic,retain)NSMutableArray * tencentShowStyleArray;
@property (nonatomic,retain)NSMutableArray * renrenShowStyleArray;
@property (nonatomic, copy)     NSString *userID;

@end