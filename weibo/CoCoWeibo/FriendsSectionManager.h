//
//  FriendsSectionManager.h
//  superWeiBo6-leslie
//
//  Created by  on 12-10-4.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#define alertUpateTag 100
#define alertInsertTag 200
@interface FriendsSectionManager : UIViewController<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate,UITextFieldDelegate>
{
    UITableView * friendsTable;
    NSMutableArray * friendsSectionArray;
    BOOL isEditing;
    NSString  * filePath;
    //对话框中的OK按钮
    UIButton * okBtn ;
    
    int cellIndex;
}
@property (nonatomic,retain)NSMutableArray * friendsSectionArray;
@property (nonatomic,copy)NSString * filePath;

@end
