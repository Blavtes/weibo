//
//  StatusViewDetailController.h
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusViewController.h"
#import "MyselfStatuHead.h"
@interface StatusViewDetailController : StatusViewController<UITableViewDelegate,UITableViewDataSource,HeadClickDelegate,UIActionSheetDelegate,StatusHeadClickDelegate>
{
    UITableView * detailTableView;
    Status * _weibo;
   // NSMutableArray * _commentListArray;
    NSMutableArray * listCommentsArray;
    NSNumber * commentsCount;
    BOOL  flagHeader;
    UIButton * footerButton;
    int pageCount;
    int count;
    UIActivityIndicatorView * _active;
}
@property (nonatomic,retain) Status * weibo;
@end
