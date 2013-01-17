//
//  ViewController.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import "ViewController.h"
#import "RecipeSegmentControl.h"
#import "TabManagerController.h"



#import <QuartzCore/QuartzCore.h>

#import "FriendsSectionManager.h"

#import "StatusViewController.h"
#import "AcountManager.h"
#import "PostViewController.h"
#import "TabManagerController.h"
#define duringtime  1.0f
@interface ViewController ()

@end

@implementation ViewController
@synthesize segView;
@synthesize sinaPaixuArray;
@synthesize sinaFriendsSectionArray;
@synthesize tencentShowStyleArray;
@synthesize renrenShowStyleArray;
@synthesize userID;
@synthesize luanchPage;

-(void)tabClicked:(int)index
{
    
    NSLog(@"index:%d",index);
    
//    SinaViewController *firstViewController=[self.childViewControllers objectAtIndex:0];
    StatusViewController *firstViewController=[self.childViewControllers objectAtIndex:0];
    StatusViewController *secondViewController=[self.childViewControllers objectAtIndex:1];
//    RenrenViewController *thirdViewController=[self.childViewControllers objectAtIndex:2];
    if ((currentViewController==firstViewController&&index==sinaIndex)||(currentViewController==secondViewController&&index==tencentIndex)) {
        return;
    }
    
    UIButton * titleBtn = (UIButton *)[self.navigationItem.titleView viewWithTag:10000];
    
    UIViewController *oldViewController=currentViewController;
    switch (index) {
        case sinaIndex:
        {
             SharedApp.currentWeiboindex = sinaIndex;
            [self transitionFromViewController:currentViewController toViewController:firstViewController duration:duringtime  options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
            }  completion:^(BOOL finished) {
                if (finished) {
                    currentViewController=firstViewController;
                }else{
                    currentViewController=oldViewController;
                }
            }];
            
            [titleBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
        }
            break;
        case tencentIndex:
        {
              SharedApp.currentWeiboindex = tencentIndex;
            [self transitionFromViewController:currentViewController toViewController:secondViewController duration:duringtime options:UIViewAnimationOptionTransitionFlipFromRight animations:^{
                
            }  completion:^(BOOL finished) {
                if (finished) {
                    currentViewController=secondViewController;
                }else{
                    currentViewController=oldViewController;
                }
            }];
          
            [titleBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
        }
            break;
//        case renrenIndex:
//        {
//             SharedApp.currentWeiboindex = renrenIndex;
//            [self transitionFromViewController:currentViewController toViewController:thirdViewController duration:duringtime options:UIViewAnimationOptionTransitionCurlUp animations:^{
//            }  completion:^(BOOL finished) {
//                if (finished) {
//                    currentViewController=thirdViewController;
//                }else{
//                    currentViewController=oldViewController;
//                }
//            }];
//           
//            [titleBtn setTitle:@"人人leslie" forState:UIControlStateNormal];
//        }
//            break;
        default:
            break;
    }
}

-(void)jumpToTabManager
{
    TabManagerController * tab = [[TabManagerController alloc] init];
    [self.navigationController pushViewController:tab animated:YES];
   //[tab release];
}

-(void)addTextCaseEmptyTab
{
//    UILabel * lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
//    lable.backgroundColor = [UIColor  clearColor];
//    lable.center = self.view.center; 
//    lable.numberOfLines = 0;
//    lable.lineBreakMode = UILineBreakModeCharacterWrap;
//    lable.text = @"您现在还没有添加微博哦！，您可以在右上角【管理】中添加微博到此界面";
//    lable.textColor = [UIColor colorWithRed:51.0 / 255.0 green:26.0 / 255.0 blue:3.0 / 255.0 alpha:1.0];
//    lable.shadowColor = [UIColor colorWithRed:192.0 / 255.0 green:177.0 / 255.0 blue:161.0 / 255.0 alpha:1.0];
//    lable.shadowOffset = CGSizeMake(1, 1);
//    lable.textAlignment = UITextAlignmentCenter;
//    lable.font = [UIFont boldSystemFontOfSize:20];
    UIButton * addWeiboBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [addWeiboBtn setImage:[UIImage imageNamed:@"addweibo"] forState:UIControlStateNormal];
    
    addWeiboBtn.frame = CGRectMake(0, 0, 320, 480);
    addWeiboBtn.tag = 20000;
   
    [addWeiboBtn addTarget:self action:@selector(jumpToTabManager) forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:addWeiboBtn];
      [self.view sendSubviewToBack:addWeiboBtn];
    //[self.view sendSubviewToBack:addWeiboBtn];
    //[[UIApplication sharedApplication].keyWindow addSubview:addWeiboBtn];
    //[ bringSubviewToFront:addWeiboBtn];
}

-(void)addWeiBoTable
{
    StatusViewController * sina = [[StatusViewController alloc] init];
    [self addChildViewController:sina];
    sina.showWhichIndex = HomeIndex;
    
    StatusViewController * tencent = [[StatusViewController alloc]init];
    [self addChildViewController:tencent];
    tencent.showWhichIndex = HomeIndex;
    
//    RenrenViewController * renren = [[RenrenViewController alloc]initWithNibName:@"RenrenViewController" bundle:nil];
//    [self addChildViewController:renren];
    
    [contentView addSubview:sina.view];
    currentViewController=sina;
}

-(void)createTitleBar
{
//    UIImage *image = [UIImage imageNamed:@"navbg.png"];
//    [[self.navigationController navigationBar] setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    UIBarButtonItem *rightManagerBtn = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(rightClicked)];
//    UIBarButtonItem * leftManagerBtn = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(leftClicked)];
    self.navigationItem.rightBarButtonItem = rightManagerBtn;
//    self.navigationItem.leftBarButtonItem = leftManagerBtn;
    UIButton * titleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    titleBtn.tag = 10000;
    titleBtn.frame = CGRectMake(0, 0, 120, 50);
    switch (SharedApp.currentWeiboindex) {
        case sinaIndex:
            [titleBtn setTitle:@"新浪微博" forState:UIControlStateNormal];
            break;
        case tencentIndex:
            [titleBtn setTitle:@"腾讯微博" forState:UIControlStateNormal];
            break;
//        case renrenIndex:
//            [titleBtn setTitle:@"人人微博" forState:UIControlStateNormal];
//            break;
        default:
            break;
    }
//    [titleBtn addTarget:self action:@selector(titleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:titleBtn];
}

#pragma mark -  //新浪微博的排序和好友分组信息 
-(void)getAlertInfo
{
    //新浪微博的排序和好友分组信息
    NSString * sinafilePath = NSHomeDirectory();
    sinafilePath = [sinafilePath stringByAppendingPathComponent:sinaPaixuFilePathDocmentsdir];
    self.sinaPaixuArray = [NSArray arrayWithObjects:@"时间排序",@"智能排序",@"我的微博",@"周边", nil];
    [self.sinaPaixuArray writeToFile:sinafilePath atomically:YES];
    
    NSString * sinafilePath2 = NSHomeDirectory();
    sinafilePath2 = [sinafilePath2 stringByAppendingPathComponent:sinaFriendsSectionFilePathDocmentsdir];
    self.sinaFriendsSectionArray = [NSArray arrayWithObjects:@"好朋友",@"好基友",@"情人", nil];
    [self.sinaFriendsSectionArray writeToFile:sinafilePath2 atomically:YES];
    
    
    //腾讯微博的查看方式信息
    NSString * tencentfilePath = NSHomeDirectory();
    
    tencentfilePath = [tencentfilePath stringByAppendingPathComponent:tencentFilePathDocmentsdir];
    self.tencentShowStyleArray = [NSArray arrayWithObjects:@"全部",@"认证用户",@"相互收听",@"QQ好友", nil];
    [self.tencentShowStyleArray writeToFile:tencentfilePath atomically:YES];
    
    
    //人人新鲜事的查看方式
    NSString * renrenfilePath = NSHomeDirectory();
    renrenfilePath = [renrenfilePath stringByAppendingPathComponent:renrenFilePathDocmentsdir];
    self.renrenShowStyleArray = [NSArray arrayWithObjects:@"全部新鲜事",@"特别关注",@"状态",@"照片",@"位置",@"分享",@"日志", nil];
    [self.renrenShowStyleArray writeToFile:renrenfilePath atomically:YES];
}

-(void)createtitleWoodTab
{
    recipe = [[RecipeSegmentControl alloc] init];
    recipe.delegate = self;
    if(recipe.numofSegments == 1||recipe.numofSegments == 0)
    {
        NSLog(@"不显示TAB");
        contentView.frame = CGRectMake(0, -20, 320, 460);
     //   contentView.backgroundColor = [UIColor orangeColor];
    }else if(recipe.numofSegments == 2){
        [segView addSubview:recipe];
        contentView.frame = CGRectMake(0, 15, 320, 460);
       // contentView.backgroundColor = [UIColor orangeColor];
    }
}
 
-(void)notificationTodo
{
     defaultNotifCenter = [NSNotificationCenter defaultCenter];
    [defaultNotifCenter addObserver:self selector:@selector(didGetUserID:)      name:MMSinaGotUserID            object:nil];
}

-(void)luanchApp
{
    
    [UIView animateWithDuration:1.5
                     animations:^{
                         [luanchPage setAlpha:0.0f];
                     } completion:^(BOOL finished) {
                         [luanchPage removeFromSuperview];
                     }];
    SharedApp.isLaunch = NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"dotted-pattern.png"]]];
//    [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f]];
    if (SharedApp.isLaunch) {
        self.luanchPage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Default"]];
        self.luanchPage.frame = CGRectMake(0, 0, 320, 480);
        [SharedApp.window addSubview:luanchPage];
        [SharedApp.window bringSubviewToFront:luanchPage];
        [self luanchApp];
    }
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
      //新浪微博的排序和好友分组信息
    _manager = [ WeiBoMessageManager getInstance];
     [_manager getUserID];
    [self notificationTodo];
    [self getAlertInfo];
    [self createtitleWoodTab];
    [self createTitleBar];
   
    [self addWeiBoTable];
    [self addTextCaseEmptyTab];
    
}

//广播执行
-(void)didGetUserID:(NSNotification *)sender
{
    NSLog(@"do notification :%@",sender);
    
    self.userID = sender.object;
    [[NSUserDefaults standardUserDefaults] setObject:userID forKey:USER_STORE_USER_ID];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)titleClick
{
    SBTableAlert * sbtableAlert;    
    switch (SharedApp.currentWeiboindex) {
        case sinaIndex:
        {
            sbtableAlert = [SBTableAlert alertWithTitle:@"新浪微博排序/好友分组" cancelButtonTitle:@"取消" messageFormat:@"选择你的排序方式或好友分组"];
            sbtableAlert.tableView.tag  = sinaIndex;
             [sbtableAlert.view addButtonWithTitle:@"管理分组"];
        }
            break;
        case tencentIndex:
        {
            sbtableAlert = [SBTableAlert alertWithTitle:@"腾讯微博排序" cancelButtonTitle:@"取消" messageFormat:@"选择你想查看的微博"];
            sbtableAlert.tableView.tag  = tencentIndex;
        }
            break;
        case renrenIndex:
        {
            sbtableAlert = [SBTableAlert alertWithTitle:@"人人新鲜事" cancelButtonTitle:@"取消" messageFormat:@"选择你的新鲜事类型"];
            sbtableAlert.tableView.tag  = renrenIndex;
        }
            break;
        default:
            break;
    }

    [sbtableAlert setStyle:SBTableAlertStylePlain];

    sbtableAlert.delegate = self;
    sbtableAlert.dataSource = self;
    [sbtableAlert show];
}

-(void)rightClicked
{
    PostViewController *postView = [[PostViewController alloc]init];
    postView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    postView.delegate = self;
    postView.witchOperating = postText;
    [self presentModalViewController: postView animated:YES];
}

-(void)closePostView:(id)sender
{
    [sender dismissModalViewControllerAnimated:YES];
}

-(void)leftClicked
{

}

-(void)viewWillAppear:(BOOL)animated
{
    NSString * filePath = NSHomeDirectory();
    filePath = [filePath stringByAppendingPathComponent:@"Documents/tab.plist"];
    
    UIButton * btn = (UIButton *)[self.view viewWithTag:20000];
    
    NSArray * tabarr = [NSArray arrayWithContentsOfFile:filePath];
    if ([tabarr count] != 0) {
        btn.hidden = YES;
      
        [btn removeFromSuperview];
        
    }else{
        [self addTextCaseEmptyTab];
    }
    
    NSLog(@"123");
    [recipe setUpSegmentButtons];
    if (recipe.numofSegments == 0) {
        contentView.hidden = YES;
    }else{
        contentView.hidden = NO;
    }
}

- (void)viewDidUnload
{
    [contentView release];
    contentView = nil;

    [self setSegView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

-(UITableViewCell *)tableAlert:(SBTableAlert *)tableAlert cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell * cell;

    cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil]autorelease]; 
    
    
    switch (tableAlert.tableView.tag) {
        case sinaIndex:
        {
            if (indexPath.section == 0) {
                cell.textLabel.text = [self.sinaPaixuArray objectAtIndex:indexPath.row];
            }else
                cell.textLabel.text = [self.sinaFriendsSectionArray objectAtIndex:indexPath.row];
            return cell;

        }
            break;
        case tencentIndex:
        {
            cell.textLabel.text = [self.tencentShowStyleArray objectAtIndex:indexPath.row];
            return cell;

        }
            break;
        case renrenIndex:
        {
            cell.textLabel.text = [self.renrenShowStyleArray objectAtIndex:indexPath.row];
            return cell;
        }
            break;
        default:
            break;
    }
    return nil;
}


-(NSInteger)numberOfSectionsInTableAlert:(SBTableAlert *)tableAlert
{
    switch (tableAlert.tableView.tag) {
        case sinaIndex:
        {
            return 2;
        }
            break;
        case tencentIndex:
        {
            return 1;
        }
            break;
        case renrenIndex:
        {
            return 1;
        }
            break;
        default:
            break;
    }
    return 0;
    
}
-(NSInteger)tableAlert:(SBTableAlert *)tableAlert numberOfRowsInSection:(NSInteger)section
{
    switch (tableAlert.tableView.tag) {
        case sinaIndex:
        {
            if (section == 0) {
                return [self.sinaPaixuArray count];
            }else
                return [self.sinaFriendsSectionArray count];
        }
            break;
            case tencentIndex:
        {
            return [self.tencentShowStyleArray count];
        }
            case renrenIndex:
        {
            return [self.renrenShowStyleArray count];
        }
            break;
        default:
            break;
    }
    return 0;
}

-(NSString *)tableAlert:(SBTableAlert *)tableAlert titleForHeaderInSection:(NSInteger)section
{
   // return [NSString  stringWithFormat:@"section %2d",section];
    
    switch (tableAlert.tableView.tag) {
        case sinaIndex:
        {
            switch (section) {
                case 0:
                    return @"微博排序";
                    break;
                case 1:
                    return @"好友分组";
                    break;
                default:
                    break;
            }

        }
            break;
        case tencentIndex:
        {
            return @"腾讯微博查看方式";
        }
            break;
        case renrenIndex:
        {
            return  @"人人网新鲜事查看方式";
        }
            break;
        default:
            break;
    }

       return nil;
}

-(void)tableAlert:(SBTableAlert *)tableAlert didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    switch (tableAlert.tableView.tag) {
        case sinaIndex:
        {
            switch (buttonIndex) {
                case 0:
                {
                    NSLog(@"cancel");
                }
                    break;
                case 1:
                {
                    FriendsSectionManager * friendSectionManager = [[FriendsSectionManager alloc] init];
                    [self.navigationController pushViewController:friendSectionManager animated:YES];
                }
                    break;
                default:
                    break;
            }

        }
            break;
        case tencentIndex:
        {
             NSLog(@"cancel");
        }
            break;
        case renrenIndex:
        {
             NSLog(@"cancel");
        }
            break;
        default:
            break;
    }
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    
    [contentView release];
    [segView release];
    [super dealloc];
}


@end