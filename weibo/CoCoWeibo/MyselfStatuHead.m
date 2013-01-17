//
//  MyselfStatuHead.m
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-15.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyselfStatuHead.h"


@implementation MyselfStatuHead
@synthesize headBtn;
@synthesize weiboButton;
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
 
    [weiboButton release];
    [headBtn release];
    [super dealloc];
}
- (IBAction)headClicked:(id)sender {
    [delegate delegateHeadClicked:sender];
}
@end
