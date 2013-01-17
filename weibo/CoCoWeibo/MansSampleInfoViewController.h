//
//  MansSampleInfoViewController.h
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@interface MansSampleInfoViewController : UIViewController
{
    User * _user;
}
@property (retain, nonatomic) IBOutlet UILabel *name;
@property (retain, nonatomic) IBOutlet UILabel *city;
@property (retain, nonatomic) IBOutlet UITextView *infotext;
@property (retain,nonatomic) User * user;

@end
