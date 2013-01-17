//
//  FriendsAndFansController.h
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LPFriendCell.h"
#import "SVSegmentedControl.h"
@class WeiBoMessageManager;
@class User;

@interface FriendsAndFansController : UIViewController<UITableViewDataSource,UITableViewDelegate,LPFriendCellDelegate>
{
    UIView * contentView;
    UIViewController * currentViewController;
    SVSegmentedControl * seg;
    NSString * userID;
}
@property (nonatomic,copy)NSString * userID;


@end
