//
//  Test.m
//  TimeLineVIew
//
//  Created by coobei on 12-9-26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Test.h"
#import "Status.h"
#import "User.h"
#import "weiboDetailCommentInfo.h"
@implementation Test

+(User *)createUser
{
    User *user = [[User alloc]init];
    NSString *name = [NSString stringWithFormat:@"user%d",rand()%10+1];
    user.name = name;
    user.profileImageUrl = @"touxiang_40x40";
    return [user autorelease];
}

+(NSArray *)createWeiboModel:(int)num
{
    NSMutableArray *weiboArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int i=0; i < num; i++) {
        Status *weibo = [[Status alloc]init];
        Status *retWeibo  = [[Status alloc]init];
        weibo.user = [self createUser];
        retWeibo.user = [self createUser];
        int  strnum = rand()%5+1;
        NSString *str = @"";
        NSString *restr = @"";
        for (int j= 0; j < strnum; j++) {
            str  = [str stringByAppendingFormat:@"#微博测试文字#，测试链接:http://www.test.com, 测试@测试员;"];
            restr = [restr stringByAppendingFormat:@"#测试转发#，测试转发!"];
        }
        NSLog(@"str:%@", str);
        weibo.text = str;
        weibo.thumbnailImageUrl = @"http://xxx.jpg";
        retWeibo.text = restr;
        retWeibo.thumbnailImageUrl = @"http://rexxx.jpg";
        weibo.retweetedStatus = retWeibo;
        [weiboArray addObject:weibo];
        [weibo release];
        [retWeibo release];
    }
    return [weiboArray autorelease];
}

+(NSArray *)createWeiboCommentModel:(int)num
{
    NSMutableArray * commentArray = [[NSMutableArray alloc]initWithCapacity:0];
    for (int  i = 0; i< num; i++) {
        weiboDetailCommentInfo  * commentInfo = [[weiboDetailCommentInfo alloc] init];
        int randnum = rand()%10+10;
        NSLog(@"randnum:%d",randnum);
        NSString * commentStr = @"";
        for (int j = 0; j<randnum; j++) {
            commentStr = [commentStr stringByAppendingFormat:@"微博评论%d",i];
        }
        NSLog(@"commentStr:%@",commentStr);
        
        commentInfo.commentContentStr = commentStr;
        commentInfo.lastTimeLong = @"10分钟";
        commentInfo.user = [self  createUser];
        
        [commentArray  addObject:commentInfo];
        [commentInfo release];
    }
    return [commentArray autorelease];
}

@end
