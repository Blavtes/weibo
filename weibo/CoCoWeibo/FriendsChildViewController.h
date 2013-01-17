//
//  FollowsViewController.h
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeiBoMessageManager.h"
#import "User.h"
#import "FriendsViewControllerTableCell.h"
@interface FriendsChildViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,FriendCellDelegate>
{
    WeiBoMessageManager *_manager;
    User *_user;
    NSMutableArray * _friendsUserArr;
   // NSMutableArray * _fansUserArr;
    UIButton * _moreFriendsbtn;
    UITableView * _friendsTableView;
    int _friendsCursor;
    int currentViewIndex;
    BOOL  isFirstLoad;
    BOOL  isFirstLoadCellWithImage;
    NSString * userID;
    
}

@property (nonatomic,retain) NSMutableArray * friendsUserArr;
@property (nonatomic,copy)NSString * userID;
//@property (nonatomic,retain) NSMutableArray * fansUserArr;

-(void)loadImageFromNet:(UITableView *)tableView;
- (void)updateCell:(NSIndexPath *)indexPath cell:(FriendsViewControllerTableCell *)cell;
@end
