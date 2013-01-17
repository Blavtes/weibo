//
//  MyPageStatusCell.m
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyPageStatusCell.h"
#import "StatusFoot.h"
@implementation MyPageStatusCell


-(void)customViewsSelf
{
    [super customViews];
    StatusFoot * foot = [[StatusFoot alloc] init];
    foot.frame = CGRectMake(0, 0, 320, 30);
    [self  addSubview:foot];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization cod
        [self customViewsSelf]; //自定义Cell
    }
    return self;
}




@end
