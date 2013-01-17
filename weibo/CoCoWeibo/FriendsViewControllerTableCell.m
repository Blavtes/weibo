//
//  FriendsViewControllerTableCell.m
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewControllerTableCell.h"

@implementation FriendsViewControllerTableCell
@synthesize friendsHeadImage = _friendsHeadImage;
@synthesize friendsNameLable = _friendsNameLable;
//@synthesize friendsMessageImage = _friendsMessageImage;
@synthesize info = _info;
@synthesize invitationBtn;
@synthesize avatar_vipImg;
@synthesize cellIndexPath = _cellIndexPath;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setInfo:(FriendsCellInfo *)info
{
    
//    NSLog(@"info:%@%@%@",info.friendsHeadImage,info.friendsName,info.friendsMessageImage);
    if (_info!= info) {
        [_info release];
        _info = [info retain];
//        _friendsHeadImage = [[UIImageView alloc] initWithImage:info.friendsHeadImage];
        _friendsHeadImage.image = info.friendsHeadImage;
        _friendsNameLable.text = info.friendsName;
//        _friendsMessageImage.image = info.friendsMessageImage;
    }
}
    
- (void)dealloc {
    [_friendsNameLable release];
    [_friendsHeadImage release];
//    [_friendsMessageImage release];
    [invitationBtn release];
    [avatar_vipImg release];
    [super dealloc];
}
- (IBAction)careClicked:(id)sender {
    
    [_delegate cellDidClicked:self];
}
@end
