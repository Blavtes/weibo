//
//  TabManagerController.h
//  superWeiBo6-leslie
//
//  Created by  on 12-9-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface TabManagerController :UIViewController <UITableViewDelegate,UITableViewDataSource>
{
      UITableView *myTableView;
    NSMutableArray *  contactsArray;
      NSMutableArray *  nocontactsArray;
    NSMutableArray * dataSource;
    NSArray * sectionStrArray ;
    BOOL isEditing;
//    NSString * filepath;
//    NSString * noWeibofilepath;
}


@end
