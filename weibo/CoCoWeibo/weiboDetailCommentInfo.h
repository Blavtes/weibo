//
//  weiboDetailCommentInfo.h
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
@interface weiboDetailCommentInfo : NSObject
{
       
        User * _user;
        NSString * _lastTimeLongStr;
        NSString * _commentContentStr;
}
@property (nonatomic,retain)User * user;
@property (nonatomic,retain)NSString * lastTimeLong;
@property (nonatomic,retain)NSString * commentContentStr;
@end
