//
//  RecipeSegmentControl.m
//  RecipeSegmentControlDemo
//
//  Created by Derek Yang on 05/30/12.
//  Copyright (c) 2012 Derek Yang. All rights reserved.
//

#import "RecipeSegmentControl.h"
#import "SegmentButtonView.h"
#import <QuartzCore/QuartzCore.h>

@interface RecipeSegmentControl ()

@property (nonatomic, strong) NSMutableArray *segmentButtons;

- (void)setUpSegmentButtons;

@end

@implementation RecipeSegmentControl

@synthesize segmentButtons = _segmentButtons;
@synthesize delegate;
@synthesize numofSegments;
- (id)init {
    self = [super init];
    if (self) {
        // Set up layer in order to clip any drawing that is done outside of self.bounds
        self.layer.masksToBounds = YES;

        // Set up segment buttons
        [self setUpSegmentButtons];

        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, 0,
                [[UIScreen mainScreen] applicationFrame].size.width,
                [UIImage imageNamed:@"recipe_tab.png"].size.height);
    }
    return self;
}

- (void)setUpSegmentButtons {
    
    NSArray * subarray = [self subviews];
    for (SegmentButtonView * seg in subarray) {
        [seg  removeFromSuperview];
    }
    NSString * filePath = NSHomeDirectory();
    filePath = [filePath stringByAppendingPathComponent:@"Documents/tab.plist"];
    
    NSString *  noWeibofilepath = NSHomeDirectory();
    noWeibofilepath = [noWeibofilepath stringByAppendingPathComponent:@"Documents/noWeibotab.plist"];
    NSArray * yesArray = [NSArray arrayWithContentsOfFile:filePath];
    NSArray * noArray = [NSArray arrayWithContentsOfFile:noWeibofilepath];
    
    
    if ([yesArray count] == 0&&[noArray count] == 0) {
        noArray = [NSArray arrayWithObjects:@"新浪微博",@"腾讯微博", nil];
        [noArray writeToFile:noWeibofilepath atomically:YES];
    }
    
    self.segmentButtons = [NSMutableArray arrayWithCapacity:0];
   // double frameoffset = ;
    //int tag = 101;
    for (int i = 0; i<[yesArray count]; i++) {
        
        SegmentButtonView * segment = [[SegmentButtonView alloc]initWithTitle:[yesArray objectAtIndex:i] normalImage:[UIImage imageNamed:@"recipe_tab.png"] highlightImage:[UIImage imageNamed:@"recipe_tab_active.png"] delegate:self];
      
       // NSLog(@"segment.frame:%@",segment.frame);
        segment.frame = CGRectMake(0, 0, 160, 44);
        
        segment.frame = CGRectOffset(segment.frame, i*segment.frame.size.width, 0);
        if ([[yesArray objectAtIndex:i] isEqualToString:@"新浪微博"]) {
            segment.tag = sinaIndex;
        }else if([[yesArray objectAtIndex:i] isEqualToString:@"腾讯微博"])
        {
            segment.tag = tencentIndex;
        }
//        else if([[array objectAtIndex:i] isEqualToString:@"人人网"])
//        {
//            segment.tag = renrenIndex;
//        }
        [self addSubview:segment];
        [self.segmentButtons addObject:segment];
    }
    if ([self.segmentButtons count]!=0) {
        SegmentButtonView * segmentHighloght = [self.segmentButtons objectAtIndex:0];
        [segmentHighloght setHighlighted:YES animated:YES];
        
        switch (segmentHighloght.tag) {
            case 101:
                SharedApp.currentWeiboindex= sinaIndex;
                [delegate tabClicked:sinaIndex];
                break;
                
            case 102:
                SharedApp.currentWeiboindex = tencentIndex;
                [delegate tabClicked:tencentIndex];
                                break;
//            case 103:
//                SharedApp.currentWeiboindex = renrenIndex;
//                [delegate tabClicked:renrenIndex];
//                
//                break;
            default:
                break;
        }
}
   
    
    self.numofSegments = [self.segmentButtons count];
    
}

#pragma mark - SegmentButtonViewDelegate

- (void)segmentButtonHighlighted:(SegmentButtonView *)highlightedSegmentButton {
    for (SegmentButtonView *segmentButton in self.segmentButtons) {
        if ([segmentButton isEqual:highlightedSegmentButton]) {
            [segmentButton setHighlighted:YES animated:YES];
        } else {
            [segmentButton setHighlighted:NO animated:YES];
        }
    }
    switch (highlightedSegmentButton.tag) {
        case 101:
            [delegate tabClicked:sinaIndex];
            break;
        case 102:
            [delegate tabClicked:tencentIndex];
            break;
        case 103:
            [delegate tabClicked:renrenIndex];
            break;
        default:
            break;
    }
    
}


-(void)dealloc
{
    [delegate release];
    [super release];
}
@end
