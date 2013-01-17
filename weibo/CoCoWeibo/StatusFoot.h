//
//  StatusFoot.h
//  CoCoWeibo
//
//  Created by coobei on 12-10-18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"
@protocol StatusFootDelegate;
@interface StatusFoot : UIView
{
    id<StatusFootDelegate> delegate;
    Status *weibo;
}

@property (retain, nonatomic)Status *weibo;
@property (retain,nonatomic)id<StatusFootDelegate> delegate;
@property (retain, nonatomic) IBOutlet UILabel *commentCount;
@property (retain, nonatomic) IBOutlet UILabel *repostCount;
@end
@protocol StatusFootDelegate<NSObject>

- (void)repostWeibo:(Status *)weibo;
- (void)commentWeibo:(Status *)weibo ;
@end
