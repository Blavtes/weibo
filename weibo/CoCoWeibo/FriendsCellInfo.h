//
//  FriendsCellInfo.h
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsCellInfo : NSObject
{
    UIImage * friendsHeadImage;
    NSString * friendsName;
    UIImage * friendsMessageImage;
}
@property (nonatomic,retain)UIImage * friendsHeadImage;;
@property (nonatomic,copy)    NSString * friendsName;;
//@property (nonatomic,retain)UIImage * friendsMessageImage;
-(id)initFriendsInfo:(UIImage *)friendsHeadImage fname:(NSString *)friendsName;

@end
