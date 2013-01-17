//
//  AppDelegate.h
//  superWeiBo6-leslie
//
//  Created by  on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#define sinaIndex  101
#define tencentIndex 102
#define renrenIndex  103
#define sinaWeiboName  @"新浪微博"
#define tencentWeiboName  @"腾讯微博" 
#define renrenNetName  @"人人网"
#define sinaPaixuFilePathDocmentsdir  @"Documents/sinapaixuStyleArray.plist"
#define sinaFriendsSectionFilePathDocmentsdir   @"Documents/sinaFriendsSectionArray.plist"
#define tencentFilePathDocmentsdir @"Documents/tencentFriendsSectionArray.plist"
#define renrenFilePathDocmentsdir  @"Documents/renrenNewsShowStyleArray.plist"
#define tabIndexFilePathDocumentsdir @"Documents/tab.plist"
#define tabNoAddToTabWeiboFilePathDocumentsdir @"Documents/noWeibotab.plist"

#define SharedApp ((AppDelegate*)[[UIApplication sharedApplication] delegate])
#define followIndex  1
#define fansIndex  2
#define mutualFansIndex 3

@class ViewController;
@class DDMenuController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    int currentWeiboindex; 
    int currentFriendsIndex;
    NSManagedObjectContext         *_managedObjContext;
    NSManagedObjectModel           *_managedObjModel;
    NSPersistentStoreCoordinator   *_persistentStoreCoordinator;
    BOOL isLaunch;
}
@property (assign,nonatomic)BOOL isLaunch;
@property (strong, nonatomic) UIWindow *window;
@property (assign,nonatomic) int currentFriendsIndex;
@property (assign,nonatomic) int currentWeiboindex;
@property (retain, nonatomic)ViewController *viewController;
@property (retain, nonatomic)DDMenuController *menuController;

@property (nonatomic,retain,readonly) NSManagedObjectContext         *managedObjContext;
@property (nonatomic,retain,readonly) NSManagedObjectModel           *managedObjModel;
@property (nonatomic,retain,readonly) NSPersistentStoreCoordinator   *persistentStoreCoordinator;
@end
