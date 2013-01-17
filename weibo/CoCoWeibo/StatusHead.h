//
//  StatusHead.h
//  superWeiBo6-leslie
//
//  Created by coobei on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"
@protocol StatusHeadClickDelegate <NSObject>

-(void)statusHeadImageClicked:(id)sender;

@end

@interface StatusHead : UIView
{
    UIColor *_lightColor;
    UIColor *_darkColor;
    id<StatusHeadClickDelegate>  _delegate;
    User * _user;
}

@property (retain, nonatomic) IBOutlet UIImageView *userImg;
@property (retain, nonatomic) IBOutlet UILabel *userName;
@property (retain, nonatomic) IBOutlet UILabel *postTime;
@property (retain, nonatomic) IBOutlet UIImageView *statusHeadImage;
@property (retain) UIColor *lightColor;
@property (retain) UIColor *darkColor;
@property (assign,nonatomic)id<StatusHeadClickDelegate> delegate;
@property (retain,nonatomic)User * user;
- (IBAction)statuheadImageClicked:(id)sender;
@end
