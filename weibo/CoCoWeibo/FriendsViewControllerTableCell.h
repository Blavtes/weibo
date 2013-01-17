//
//  FriendsViewControllerTableCell.h
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsCellInfo.h"
#import "LPBaseCell.h"
@class FriendsViewControllerTableCell;

@protocol FriendCellDelegate <NSObject>

-(void)cellDidClicked:(FriendsViewControllerTableCell*)cell;

@end

@interface FriendsViewControllerTableCell : UITableViewCell
{
    
    IBOutlet UIImageView *_friendsHeadImage;
    IBOutlet UILabel *_friendsNameLable;
    IBOutlet UIButton *invitationBtn;
    IBOutlet UIImageView *avatar_vipImg;
//    IBOutlet UIImageView *_friendsMessageImage;
    FriendsCellInfo * _info;
     NSIndexPath *_cellIndexPath;
     id<FriendCellDelegate>    _delegate;
}
@property (nonatomic,retain)UIImageView *friendsHeadImage;
@property (nonatomic ,retain)UILabel * friendsNameLable;
@property (nonatomic, retain) UIButton *invitationBtn;
@property (nonatomic,retain)UIImageView *avatar_vipImg;
//@property(nonatomic,retain)UIImageView *friendsMessageImage;
@property (nonatomic,retain)FriendsCellInfo * info;
@property (nonatomic,retain) NSIndexPath * cellIndexPath;
@property (nonatomic, assign) id<FriendCellDelegate> delegate;
- (IBAction)careClicked:(id)sender;
@end
