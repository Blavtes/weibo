//
//  FollowsViewController.m
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsChildViewController.h"
#import "FriendsViewControllerTableCell.h"
#import "FriendsCellInfo.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
#import <QuartzCore/QuartzCore.h>
#import "MansInfoViewController.h"
#define pageCount  10
@implementation FriendsChildViewController
@synthesize friendsUserArr = _friendsUserArr;
@synthesize userID;
//@synthesize fansUserArr = _fansUserArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _manager = [WeiBoMessageManager getInstance];
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

-(void)loadDataWithCursor:(int)cursor
{
//    NSString *userID = nil;
//    if (_user) {
//        userID = [NSString stringWithFormat:@"%lld",_user.userId];
//    }
//    else {
      // userID = [[NSUserDefaults standardUserDefaults] objectForKey:USER_STORE_USER_ID];
  //  }
    if (SharedApp.currentFriendsIndex == followIndex) {
         NSLog(@"followIndex");
        [_manager getFollowingUserList:[userID longLongValue] count:pageCount cursor:cursor];
    }else if(SharedApp.currentFriendsIndex == fansIndex){
         NSLog(@"fansIndex");
        [_manager getFollowedUserList:[userID longLongValue] count:pageCount cursor:cursor];
    }
    else if(SharedApp.currentFriendsIndex == mutualFansIndex){
        NSLog(@"mutualFansIndex");
        [_manager getBilateralUserListAll:[userID longLongValue] sort:0];
    }
}

-(void)getmoreFriends:(UIButton *)sender
{
        _friendsCursor += 10;
        [_moreFriendsbtn setTitle:[NSString  stringWithFormat:@"正在为您加载%d条...",pageCount] forState:UIControlStateNormal];
        [self loadDataWithCursor:_friendsCursor];
}

-(void)createFriendsTable
{
    _moreFriendsbtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *footImage = [[UIImage imageNamed:@"tabbar_greenbtn"]resizableImageWithCapInsets:UIEdgeInsetsMake(8, 16, 8, 16)];
    [_moreFriendsbtn setBackgroundImage:footImage forState:UIControlStateNormal];
    _moreFriendsbtn.frame = CGRectMake(0, 0, 320, 44);
    [_moreFriendsbtn addTarget:self action:@selector(getmoreFriends:) forControlEvents:UIControlEventTouchUpInside];
    [_moreFriendsbtn setTitle:@"加载更多" forState:UIControlStateNormal];
    
    _friendsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, 460-73) style:UITableViewStylePlain];
    [self.view addSubview:_friendsTableView];
    
    _friendsTableView.delegate = self;
    _friendsTableView.dataSource = self;
    [_friendsTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _friendsTableView.tableFooterView = _moreFriendsbtn;
}

-(void)setCellStatus:(NSString*)uid  title:(NSString*)title
{
    
        for (int i = 0;i<[_friendsUserArr count];i++) {
            User *user = [_friendsUserArr objectAtIndex:i];
            
            if (user.userId == [uid longLongValue]) 
            {
                user.following = YES;
                FriendsViewControllerTableCell *cell = (FriendsViewControllerTableCell *)[_friendsTableView cellForRowAtIndexPath:user.cellIndexPath];
                [cell.invitationBtn setTitle:title forState:UIControlStateNormal];
                NSLog(@"followTable invitationBtn%@",title);
            }
    }
}

-(void)cellDidClicked:(FriendsViewControllerTableCell *)cell
{
    NSInteger index = cell.cellIndexPath.row;
    if ([_friendsTableView indexPathForCell:cell]) {
        if (index > [_friendsUserArr count]) {
            return;
        }
        User *user = [_friendsUserArr objectAtIndex:index];
        
        if (user.following) {
            [_manager unfollowByUserID:user.userId ];
        }
        else {
            NSLog(@"关注操作");
            [_manager followByUserID:user.userId ];
        }
    }
}

-(void)gotFriendsUserList:(NSNotification*)sender
{
    NSArray *arr;
    if (SharedApp.currentFriendsIndex != mutualFansIndex) {
        NSLog(@"NSNotification gotFollowUserList");
        NSDictionary *dic = sender.object;
        arr = [dic objectForKey:@"userArr"];
    }else{
        arr = sender.object;
    }
    NSLog(@"arr count%d",[arr count]);
    if ([arr count] == 0) {
        [_moreFriendsbtn setTitle:@"全部加载完成" forState:UIControlStateNormal];
        _moreFriendsbtn.userInteractionEnabled = NO;
    }else{
//        for (User * user in arr) {
//          //  NSLog(@"arr username:%@",user.name);
//        }
        [_friendsUserArr addObjectsFromArray:arr];
        [_friendsTableView reloadData];
        
        //显示可见的cell
//        NSArray * cellarr = [_friendsTableView  visibleCells];
        [self loadImageFromNet:_friendsTableView];
        
        
        NSLog(@"nil arrtest:%@",arr);
        if (SharedApp.currentFriendsIndex != mutualFansIndex) {
            [_moreFriendsbtn setTitle:[NSString  stringWithFormat:@"加载更多"] forState:UIControlStateNormal];
        }else{
            [_moreFriendsbtn setUserInteractionEnabled:NO];
            [_moreFriendsbtn setTitle:[NSString  stringWithFormat:@"全部加载完成"] forState:UIControlStateNormal];
        }
    }
}

-(void)gotFollowResult:(NSNotification*)sender
{
    NSLog(@"sender.objet = %@",sender.object);
    NSDictionary *dic = sender.object;
    NSString *uid = [dic objectForKey:@"uid"];
    
    if (uid == nil) {
        return;
    }
    
    for (int i = 0;i<[_friendsUserArr count];i++) {
        User *user = [_friendsUserArr objectAtIndex:i];
        
        if (user.userId == [uid longLongValue]) 
        {
            user.following = YES;
            
            //reload table
            NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:i inSection:0];
            NSArray     *arr        = [NSArray arrayWithObject:indexPath];
            NSLog(@"关注");
            [_friendsTableView reloadRowsAtIndexPaths:arr withRowAnimation:YES];
            [self loadImageFromNet:_friendsTableView];
        }
    }
}

-(void)gotUnfollowResult:(NSNotification*)sender
{
    
    NSLog(@"sender.objet = %@",sender.object);
    NSDictionary *dic = sender.object;
    NSString *uid = [dic objectForKey:@"uid"];
    
    if (uid == nil) {
        return;
    }
    
    for (int i = 0;i<[_friendsUserArr count];i++) {
        User *user = [_friendsUserArr objectAtIndex:i];
        
        if (user.userId == [uid longLongValue]) 
        {
            user.following = NO;
            
            //reload table
            NSIndexPath *indexPath  = [NSIndexPath indexPathForRow:i inSection:0];
            NSArray     *arr        = [NSArray arrayWithObject:indexPath];
            NSLog(@"取消关注");
            [_friendsTableView reloadRowsAtIndexPaths:arr withRowAnimation:YES];
             [self loadImageFromNet:_friendsTableView];
        }
    }
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
    _friendsUserArr = [[NSMutableArray alloc] initWithCapacity:0];
    [self  createFriendsTable];
    isFirstLoad = YES;
    isFirstLoadCellWithImage = YES;
}

-(void)alertToCution:(NSNotification *)noti
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"网络连接异常" message:@"您的请求不成功！" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    [alert show];
    alert.delegate = self;
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // [self loadDataWithCursor:0];
    }
}



-(void)viewWillAppear:(BOOL)animated
{
    //currentViewIndex = SharedApp.currentFriendsIndex;
     NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(gotFriendsUserList:) name:MMSinaGotFollowingUserList object:nil];
    [notifCenter addObserver:self selector:@selector(gotFriendsUserList:) name:MMSinaGotFollowedUserList object:nil]; 
     [notifCenter addObserver:self selector:@selector(gotFriendsUserList:) name:MMSinaGotBilateralUserList object:nil]; 
    [notifCenter addObserver:self selector:@selector(gotFollowResult:) name:MMSinaFollowedByUserIDWithResult object:nil];
    [notifCenter addObserver:self selector:@selector(gotUnfollowResult:) name:MMSinaUnfollowedByUserIDWithResult object:nil];
    [notifCenter addObserver:self selector:@selector(alertToCution:) name:MMSinaRequestFailed object:nil];
    if (isFirstLoad) {
         [self  loadDataWithCursor:0];
    }else{
        NSLog(@"second Load");
    }
}



-(void)viewWillDisappear:(BOOL)animated
{
    isFirstLoad = NO;
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter removeObserver:self name:MMSinaGotFollowingUserList object:nil];
    [notifCenter removeObserver:self name:MMSinaGotFollowedUserList object:nil];
    [notifCenter removeObserver:self name:MMSinaGotBilateralUserList object:nil];
    [notifCenter removeObserver:self name:MMSinaFollowedByUserIDWithResult object:nil];
    [notifCenter removeObserver:self name:MMSinaUnfollowedByUserIDWithResult object:nil];
    [notifCenter removeObserver:self name:MMSinaRequestFailed object:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   return  [_friendsUserArr count];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
//    [self loadImageFromNet:tableView];
    NSLog(@" [self loadImageFromNet:tableView];");
    return 66.0f;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellid = @"cellid";
    FriendsViewControllerTableCell * cell = [tableView  dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"FriendsViewControllerTableCell" owner:self options:nil]lastObject];
        cell.delegate = self;
//        [self  loadImageFromNet:tableView];
      //  [self  updateCell:indexPath cell:cell];
    }
    if (indexPath.row%2 == 0) {
        
        cell.contentView.backgroundColor  = [UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f];
    }else{
        cell.backgroundColor = [UIColor whiteColor];
    }
        return cell;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    NSLog(@"viewDidUnload");
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)updateCell:(NSIndexPath *)indexPath cell:(FriendsViewControllerTableCell *)cell
{
    User * user = [_friendsUserArr objectAtIndex:indexPath.row];
    cell.cellIndexPath = indexPath;
    user.cellIndexPath = indexPath;
    cell.friendsNameLable.text = user.screenName;
    //        [cell.friendsHeadImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    //缓存图片
    SDWebImageManager * manager = [SDWebImageManager sharedManager];
    UIImage * chacheImage = [manager imageWithURL:[NSURL  URLWithString:user.profileImageUrl]];
    if (chacheImage) {
        //  NSLog(@"有缓存");
        [cell.friendsHeadImage setImage:chacheImage];
    }else{
        //  NSLog(@"无缓存");
        [cell.friendsHeadImage setImageWithURL:[NSURL URLWithString:user.profileImageUrl]];
    }
  //  [head.userImg.layer setCornerRadius:5];
    [cell.friendsHeadImage.layer  setMasksToBounds:YES];
    [cell.friendsHeadImage.layer setCornerRadius:10];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (user.verified) {
        cell.avatar_vipImg.hidden = NO;
    }
    if (user.following == NO) {
        [cell.invitationBtn setTitle:@"关注" forState:UIControlStateNormal];
    }else{
        [cell.invitationBtn setTitle:@"取消关注" forState:UIControlStateNormal];
    }
//    if (indexPath.row/2 == 0) {
//        cell.backgroundColor = [UIColor grayColor];
//    }
    
    cell.delegate = self;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MansInfoViewController * manInfo =  [[MansInfoViewController alloc] init];
    manInfo.user = [_friendsUserArr objectAtIndex:indexPath.row];
    manInfo.showCarebtn = YES;
    [self.navigationController pushViewController:manInfo animated:YES];
    [manInfo release];
}

//滚动时加载图片
-(void)loadImageFromNet:(UITableView *)tableView
{
    NSArray * visuableCell = [tableView visibleCells];
    for (FriendsViewControllerTableCell * cell in visuableCell) {
        NSIndexPath * indexPath = [tableView indexPathForCell:cell];
        [self updateCell:indexPath cell:cell];
    }
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    UITableView * tableView = (UITableView *)scrollView;
    if (decelerate == YES) {
         NSLog(@"scrollViewDidEndDraggingYES");
    }else {
         NSLog(@"scrollViewDidEndDraggingNO");
        [self  loadImageFromNet:tableView];
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"scrollViewDidEndDecelerating");
    [self loadImageFromNet:(UITableView *)scrollView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
