//
//  AcountManager.h
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OAuthManager.h"
#import "WeiBoMessageManager.h"
@interface AcountManager : UIViewController
{
     OAuthManager *sinaOAuthManager;
    OAuthManager *tencentOAuthManager;
    WeiBoMessageManager * messageManager;
}
- (IBAction)sinaLogin:(id)sender;
- (IBAction)tencentLogin:(id)sender;

- (IBAction)sinaLogout:(id)sender;

- (IBAction)tencentLogout:(id)sender;
- (IBAction)sinaTestLog:(id)sender;
- (IBAction)tencentTestLog:(id)sender;

@end
