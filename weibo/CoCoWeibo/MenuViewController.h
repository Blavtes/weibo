//
//  MenuViewController.h
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-9.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "menuHead.h"
typedef  enum{
    HOMEVIEW,
    FRIENDSVIEW,
    MESSAGEVIEW,
    MYPAGE,
    ACOUNTMANAGERVIEW,
    SETTINGVIEW,
}_menuTag;
@interface MenuViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate,UINavigationControllerDelegate>
{
    menuHead *_headview;
}
@property (retain, nonatomic)menuHead *headview;
@end
