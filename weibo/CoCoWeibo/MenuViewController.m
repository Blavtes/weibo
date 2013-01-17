//
//  MenuViewController.m
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MenuViewController.h"
#import "FriendsAndFansController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "MansInfoViewController.h"
#import "TabManagerController.h"
#import "AcountManager.h"
#import "FriendsAndFansController.h"
#import "menuHead.h"
#import "ZJTHelpler.h"
#import "StatusViewController.h"
@implementation MenuViewController
@synthesize headview = _headview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}



#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 */

-(void)menuButtonClicked:(id)sender
{
    NSLog(@"点击菜单");
    NSLog(@"点击菜单");
    UIButton *button = (UIButton *)sender;
    CGRect frame = button.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    frame.origin.x -=2;
    frame.origin.y -=2;
    [UIView animateWithDuration:0.25
                     animations:^{
                         [button setBackgroundColor:[UIColor  colorWithRed:0.3 green:0.3 blue:0.3 alpha:1.0]];
                         button.frame = frame;
                     } completion:^(BOOL finished) {
                         CGRect frame2 = button.frame;
                         frame2.size.width -= 4;
                         frame2.size.height -= 4;
                         frame2.origin.x +=2;
                         frame2.origin.y +=2;
                         [UIView animateWithDuration:0.25
                                          animations:^{
                                              [button setBackgroundColor:[UIColor colorWithRed:49/255.0f  green:56/255.0f blue:64/255.0f alpha:1.0]];
                                              button.frame = frame2;
                                          }];
                         
                     }];

    
    DDMenuController *menuController = (DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menuController;
    switch (button.tag) {
        case HOMEVIEW:
        {
            ViewController *vc = [[ViewController alloc]init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
            [menuController setRootController:navController animated:YES];
        }
            break;
        case MESSAGEVIEW:
        {
            
//            MessagesController *vc = [[MessagesController alloc]init];
//            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
//            [menuController setRootController:navController animated:YES];
            StatusViewController * status = [[StatusViewController alloc] init];
            status.showWhichIndex = MessageIndex;
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:status];
            //            [menuController setRootController:navController animated:YES];
             [menuController setRootController:navController animated:YES];
        }
            break;
        case FRIENDSVIEW:
        {
            
            ZJTHelpler * zjt = [ZJTHelpler getInstance];
            NSString *userID = nil;
            
            userID = [NSString stringWithFormat:@"%lld",zjt.user.userId];
            
            FriendsAndFansController *vc = [[FriendsAndFansController alloc]init];
            vc.userID = userID;
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:vc];
            [menuController setRootController:navController animated:YES];

        }
            break;
            
        case ACOUNTMANAGERVIEW:
        {
            AcountManager * acountManager = [[AcountManager alloc] init];
            UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:acountManager];
            [menuController setRootController:navController animated:YES];
        }
            break;
            
        case MYPAGE:
        {
             ZJTHelpler * zjt = [ZJTHelpler getInstance];
            MansInfoViewController * mansInfoPage = [[MansInfoViewController alloc] init];
            mansInfoPage.user = zjt.user;
            mansInfoPage.showCarebtn = NO;
            UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:mansInfoPage];
            [menuController setRootController:navController animated:YES];
        }
            break;
            
            case SETTINGVIEW:
        {
            TabManagerController * tabManager = [[TabManagerController alloc] init];
            UINavigationController * navController = [[UINavigationController alloc]initWithRootViewController:tabManager];
            [menuController setRootController:navController animated:YES];
        }
            break;
        default:
            break;
    }
}
-(void)menuButtonHover:(id)sender
{
    NSLog(@"点击菜单");
    UIButton *button = (UIButton *)sender;
    CGRect frame = button.frame;
    frame.size.width += 4;
    frame.size.height += 4;
    frame.origin.x -=2;
    frame.origin.y -=2;
    [UIView animateWithDuration:0.25
    animations:^{
        [button setBackgroundColor:[UIColor  colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0]];
        button.frame = frame;
    }];
}

-(void)createMenu
{
    NSArray *menuItems = [NSArray arrayWithObjects:@"首页",@"好友", @"@我的",@"主页",@"账号",@"设置",nil];
    int menutagArray[] = {HOMEVIEW, FRIENDSVIEW,MESSAGEVIEW,MYPAGE,ACOUNTMANAGERVIEW,SETTINGVIEW};
      NSArray *menuImages = [NSArray arrayWithObjects:@"menu_index",@"menu_friends",@"menu_atme",@"menu_mypage",@"menu_acount",@"menu_setting",nil];
    for (int  i=0; i < [menuItems count]; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(16+i%3*(68+10),200+i/3*(68+10), 68, 68);
        [button setBackgroundColor:[UIColor colorWithRed:49/255.0f  green:56/255.0f blue:64/255.0f alpha:1.0]];
        [button setTitle:[menuItems objectAtIndex:i]forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:[menuImages objectAtIndex:i]] forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(menuButtonHover:) forControlEvents:UIControlEventTouchDown];
        [button addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = menutagArray[i];
        NSLog(@"tagMenu:%d",button.tag);
        [self.view addSubview:button];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)caseTencentRemoveBtn:(NSArray *)arr
{
    for (id btn in arr) {
        if ([btn isKindOfClass:[UIButton class]]) {
            if (((UIButton *)btn).tag ==FRIENDSVIEW||((UIButton *)btn).tag ==MESSAGEVIEW||((UIButton *)btn).tag ==MYPAGE) { 
                [btn removeFromSuperview];
            }             
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"menu  viewWillAppearviewWillAppear");
    [self createMenu];
    NSString * filePath = NSHomeDirectory();
    filePath = [filePath stringByAppendingPathComponent:@"Documents/tab.plist"];
    
        
   if (SharedApp.currentWeiboindex == tencentIndex) {
        NSArray * arr = [self.view subviews];
       [self caseTencentRemoveBtn:arr];
    }else{
        //[self createMenu];
    }
    
    NSArray * arr = [NSArray  arrayWithContentsOfFile:filePath];
    for (NSString * weibo  in arr) {
        if ([arr count] == 1) {
            if ([weibo isEqualToString:@"新浪微博"]){
                [self createMenu];
            }else{
                [self caseTencentRemoveBtn:arr];
            }
        }if ([arr count] == 2) {
            [self createMenu];
        }
        if ([arr count] == 1) {
            if ([weibo isEqualToString:@"腾讯微博"]) {
                [self caseTencentRemoveBtn:arr];
            }
        }
        
    }

    self.headview = [[menuHead alloc]initWithFrame:CGRectMake(0, 0, 320, 160)];
    [self.view addSubview:_headview];
    [_headview release];
}

-(void)viewWillDisappear:(BOOL)animated
{
  NSArray * arr =   [self.view subviews];
    [self caseTencentRemoveBtn:arr];
}

-(void)dealloc
{

    self.headview = nil;
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.headview = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
