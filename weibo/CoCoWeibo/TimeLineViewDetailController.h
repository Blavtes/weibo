//
//  TimeLineViewDetailController.h
//  superWeiBo6-leslie
//
//  Created by  on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "StatusViewController.h"
@interface TimeLineViewDetailController : StatusViewController
{
    Status * _weibo;
    NSMutableArray * _commentListArray;
}

@property (nonatomic,retain)Status * weibo;
@property (nonatomic,retain)NSMutableArray * commentListArray;
@end
