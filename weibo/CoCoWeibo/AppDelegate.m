//
//  AppDelegate.m
//  superWeiBo6-leslie
//
//  Created by  on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "DDMenuController.h"

#import "MenuViewController.h"
#import "AcountManager.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize currentWeiboindex;
@synthesize currentFriendsIndex;
@synthesize viewController;
@synthesize menuController;
@synthesize isLaunch;
- (void)dealloc
{
    [menuController release];
    [_window release];
    [super dealloc];
}

#pragma mark - 设置自定义样式
-(void)setCustomAppearance{
    
    //导航栏
    UIImage *navbg = [[UIImage imageNamed:@"navbg2.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(20, 0, 22, 0)];
//    UIImage *navbg2  = [[UIImage imageNamed:@"navbg.png"]stretchableImageWithLeftCapWidth:0 topCapHeight:16];
    [[UINavigationBar appearance] setBackgroundImage:navbg
                                       forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearanceWhenContainedIn:[MessagesController class], nil]setBackgroundImage:navbg2 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //导航按钮
    UIImage *navBtn = [[UIImage imageNamed:@"button-black.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(16, 8, 16, 8)];
    [[UIBarButtonItem appearance] setBackgroundImage:navBtn forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    //返回按钮
    UIImage *backBtn = [[UIImage imageNamed:@"btnback_black.png"]resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 8)];
    [[UIBarButtonItem appearance]setBackButtonBackgroundImage:backBtn forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    
    UIImage *blackBtn = [[UIImage imageNamed:@"button-black.png"]stretchableImageWithLeftCapWidth:8 topCapHeight:8 ];
    [[UIButton  appearanceWhenContainedIn:[UITableViewCell class], nil] setBackgroundImage:blackBtn forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[AcountManager class], nil]setBackgroundImage:blackBtn forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[AcountManager class], nil]setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[UITableViewCell class], nil]setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [[UIButton appearance] setContentMode:UIViewContentModeCenter];
    //导航文本
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor, 
                                                          [UIColor blackColor], UITextAttributeTextShadowColor,[NSValue valueWithUIOffset:UIOffsetMake(0, -1)] ,UITextAttributeTextShadowOffset, 
                                                          [UIFont fontWithName:@"Arial" size:0.0],UITextAttributeFont,
                                                          nil] ];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
#if 0
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    UINavigationController *nav = [[[NSBundle mainBundle] loadNibNamed:@"CustomNavigationController" owner:self options:nil] objectAtIndex:0];
    [nav setViewControllers:[NSArray arrayWithObject:[[ViewController alloc] initWithNibName:@"ViewController" bundle:nil]]];
    self.window.rootViewController = nav;
#else 
    isLaunch = YES;
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    SharedApp.currentFriendsIndex = followIndex;
    self.viewController = [[ViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.viewController];
    MenuViewController *menu = [[MenuViewController alloc]init];
    menuController = [[DDMenuController alloc]initWithRootViewController:nav];
    //添加ViewController
//    MessagesController *messagesController = [[MessagesController alloc]init];
//    rootController.leftViewController = messagesController;
    
    [self setCustomAppearance];
    [menuController setLeftViewController:menu];
    self.window.rootViewController = menuController;
#endif
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
