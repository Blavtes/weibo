//
//  MansInfoViewController.h
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
#import "WeiBoMessageManager.h"
@interface MansInfoViewController : UIViewController
{
    UIImageView * headImgae;
    UIImageView * isVipImage;
    UIImageView * ganderImage;
    UILabel * nameLable;
    
    UIButton * AddCareBtn;
    UIButton * careCountBtn;
    UIButton * fansCountBtn;
    UIButton * weiboCountBtn;
    UIButton * mansInfoBtn;
    User * user;
    BOOL showCarebtn;
    WeiBoMessageManager * weiboMessage;
}
@property (nonatomic,retain) User * user;
@property (nonatomic,assign)BOOL showCarebtn;
@end
