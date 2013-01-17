//
//  FriendsCellInfo.m
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsCellInfo.h"

@implementation FriendsCellInfo
@synthesize friendsHeadImage;
@synthesize friendsName;
//@synthesize friendsMessageImage;

-(id)initFriendsInfo:(UIImage *)fHeadImage fname:(NSString *)fname
{
//     NSLog(@"initFriendsInfo fHeadImage:%@  fname:%@ fMessageImage%@",fHeadImage,fname,fMessageImage);
    self = [super init];
    if (self) {
        self.friendsHeadImage = fHeadImage;
        self.friendsName = fname;
//        self.friendsMessageImage = fMessageImage;
       
    }
    return self;
}

@end
