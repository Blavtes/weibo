//
//  MyselfStatuHead.h
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HeadClickDelegate <NSObject>

-(void)delegateHeadClicked:(id)sender;

@end

@interface MyselfStatuHead : UIView
{
    id<HeadClickDelegate> deleagte;
}
@property (retain, nonatomic) IBOutlet UIButton *headBtn;
@property (retain, nonatomic) IBOutlet UIButton *weiboButton;
@property (assign,nonatomic) id delegate;
- (IBAction)headClicked:(id)sender;
@end
