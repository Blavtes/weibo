//
//  UICheckButton.m
//  CoCoWeibo
//
//  Created by coobei on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UICheckButton.h"

@implementation UICheckButton
@synthesize  backgroundImage = _backgroundImage;
@synthesize checkedImage  = _checkedImage;
@synthesize isChecked = _isChecked;
@synthesize  checkedObject = _checkedObject;

-(void)isClicked:(id)sender
{
    UICheckButton*button  = (UICheckButton *)sender;
    button.isChecked = ! button.isChecked;
   
    if (button.isChecked) {
         NSLog(@"isChecked-----------YES");
        [button setBackgroundImage:_checkedImage forState:UIControlStateNormal];
    }else{
        NSLog(@"isChecked---------NO");
        [button setBackgroundImage:_backgroundImage forState:UIControlStateNormal];
    }
}

-(id)initWithBackgroundImage:(UIImage *) theBackgroundImage AndChecked:(UIImage *)theCheckedImage
{
    self = [super init];
    if (self) {
        self.backgroundImage = theBackgroundImage;
        self.checkedImage = theCheckedImage;
        [self addTarget:self action:@selector(isClicked:) forControlEvents:UIControlStateNormal];
    }
    return self;
}

+(UICheckButton *)getUICheckButtonByBackgroundImage:(UIImage *)theBackgroundImage 
                              AndChecked:(UIImage *)theCheckedImage
{
    UICheckButton *button = [UICheckButton buttonWithType:UIButtonTypeCustom];
    button.isChecked = NO;
    button.backgroundImage  = theBackgroundImage;
    button.checkedImage = theCheckedImage;
    [button setBackgroundImage:theBackgroundImage forState:UIControlStateNormal];
    [button addTarget:button action:@selector(isClicked:) forControlEvents:UIControlEventTouchUpInside];
    return (UICheckButton *)button;
}

@end
