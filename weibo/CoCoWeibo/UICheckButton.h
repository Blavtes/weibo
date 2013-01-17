//
//  UICheckButton.h
//  CoCoWeibo
//
//  Created by coobei on 12-10-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICheckButton : UIButton
{
    UIImage *_backgroundImage;
    UIImage *_checkedImage;
    BOOL _isChecked;
    id _checkedObject;
}
@property (nonatomic ,retain)id checkedObject;
@property (nonatomic, retain)UIImage *backgroundImage;
@property (nonatomic ,retain)UIImage *checkedImage;
@property (nonatomic, assign)BOOL isChecked;
-(void)isClicked:(id)sender;
+(UICheckButton *)getUICheckButtonByBackgroundImage:(UIImage *)theBackgroundImage 
                                         AndChecked:(UIImage *)theCheckedImage;
@end
