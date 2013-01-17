//
//  StatusViewController.h
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-10.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
#import "StatusHead.h"
#import "StatusCell.h"
#import "StatusFoot.h"
#import "OAuthManager.h"
#import "AppDelegate.h"
#import "WeiBoMessageManager.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"
#import "SDWebImageManagerDelegate.h"
#import "EGOImageButton.h"
#import "PhotoViewer.h"
#import "ImagesViewer.h"
#import "EGORefreshTableHeaderView.h"
#import "PostViewController.h"

typedef enum {
    HomeIndex = 0 ,
    CustomHomeIndex ,
    MessageIndex
}_showType;

@interface StatusViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,StatusCellDelegate,WeiBoHttpDelegate,SDWebImageManagerDelegate,EGOImageButtonDelegate,ImagesViewerDelegate,StatusFootDelegate,PostViewControlelDelegate,StatusHeadClickDelegate>
{
    UITableView *_weiboTable;
    NSMutableArray *listData;
    NSMutableArray *cellArray;
    OAuthManager * sinaOAuthManager ;
    OAuthManager * tencentOAuthManager ;
    BOOL isSinaFirstShow;
    BOOL isTencentFirstShow;
    WeiBoMessageManager  *messageManager;
    EGORefreshTableHeaderView * headView ;
    User * _user;
     BOOL  isloading;
    int showWhichIndex;
    NSString * customUserID;
    int  alertCount;
    BOOL isAddToListData;
    int  sinaPageCount;
    int  tencentpageCount;
}

@property (retain, nonatomic) NSMutableArray *cellArray;
@property (retain,nonatomic)UITableView *weiboTable;
@property (retain,nonatomic)NSMutableArray *listData;
@property (retain,nonatomic)User * user;
@property (assign,nonatomic)int showWhichIndex;
@property (copy,nonatomic) NSString * customUserID;
-(void)loadVisuableImage:(UITableView *)scrollView;
-(NSString *)dateInFormat:(time_t)dateTime;
@end
