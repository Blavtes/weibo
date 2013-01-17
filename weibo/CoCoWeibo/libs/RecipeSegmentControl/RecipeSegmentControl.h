//
//  RecipeSegmentControl.h
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//


#import "SegmentButtonView.h"
#import "AppDelegate.h"
#import "TabDelegate.h"
@interface RecipeSegmentControl : UIView <SegmentButtonViewDelegate>
{
    id<TabDelegate> delegate;
    NSInteger numofSegments;
}
@property (strong,nonatomic)id  delegate;
@property (assign,nonatomic)NSInteger numofSegments;
- (void)setUpSegmentButtons;
@end
