//
//  PostView.h
//  CoCoWeibo
//
//  Created by coobei on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//


//博客发送view 模仿信封样式
#import <UIKit/UIKit.h>

@interface PostView : UIView
{
    CALayer *envelop_bg;
    CALayer *envelop;
    CALayer *paper;
    CALayer *envelop_top_o; //信封开
    CALayer *envelop_top_x;//信封关
}
@end
