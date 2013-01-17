//
//  MansInfoViewController.m
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-22.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MansInfoViewController.h"
#import "ZJTHelpler.h"
#import "UIImageView+WebCache.h"
#import "FriendsAndFansController.h"
#import "MansInfoViewController.h"
#import "MansSampleInfoViewController.h"
#import "StatusViewController.h"
#import "WeiBoMessageManager.h"
#define  careBtnTag  101
#define  fansBtnTag 102
#define  weiboBtnTag  103
#define  manInfoBtnTag 104
#define  addCareBtnTag 105

@implementation MansInfoViewController
@synthesize user;
@synthesize showCarebtn;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

-(void)btnClicked:(id)sender
{
    UIButton * btn = (UIButton *)sender;
    int index = btn.tag;
    FriendsAndFansController * friends = [[FriendsAndFansController alloc] init];
    friends.userID = [NSString stringWithFormat:@"%lld",self.user.userId];
    switch (index) {
        case careBtnTag:{
            [self.navigationController pushViewController:friends animated:YES];
            [friends release];
        }
            break;
            case fansBtnTag:
        {
            [self.navigationController pushViewController:friends animated:YES];
            [friends release];
        }
            break;
            
        case weiboBtnTag:
        {
            StatusViewController * status = [[StatusViewController alloc] init];
            status.showWhichIndex = CustomHomeIndex;
            status.customUserID = [NSString stringWithFormat:@"%d",self.user.userId];
            [self.navigationController pushViewController:status animated:YES];
            [friends release];
        }
            case manInfoBtnTag:
        {
            MansSampleInfoViewController * mansInfo = [[MansSampleInfoViewController alloc] init];
            mansInfo.user = self.user;
            [self.navigationController pushViewController:mansInfo animated:YES];
            [mansInfo release];
        }
            break;
            case addCareBtnTag:
        {
            if (self.user.following) {
                [weiboMessage unfollowByUserID:self.user.userId];
            }else{
                [weiboMessage followByUserID:self.user.userId];
            }
        }
        default:
            break;
    }
}

-(void)createView
{
    headImgae  = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"touxiang_40x40"]];
    headImgae.frame = CGRectMake(20, 13, 50, 50);
    
    isVipImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar_vip"]];
    isVipImage.frame = CGRectMake(65, 45, 15, 15);

    ganderImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"male"]];
    ganderImage.frame = CGRectMake(84, 0, 20, 28);
    
    nameLable = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 160, 30)];
    nameLable.backgroundColor = [UIColor  clearColor];
    nameLable.textColor = [UIColor colorWithRed:42/255.0f green:47/255.0f blue:54/255.0f alpha:1.0f];
    nameLable.font = [UIFont systemFontOfSize:22];
    UIView *infoBg = [[UIView alloc]initWithFrame:CGRectMake(20, 20, 280, 74)];
    infoBg.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"manInfo_head"]];
    UIImageView *headimageBg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"manInfo_head_image_bg"]];
    headimageBg.frame = CGRectMake(0, 0, 108, 74);
    [infoBg addSubview:headImgae];
   
    //   [infoBg addSubview:ganderImage];
    
    [infoBg addSubview:headimageBg];
    [infoBg addSubview:nameLable];
     [infoBg addSubview:isVipImage];
    [headimageBg addSubview:ganderImage];
    [self.view addSubview:infoBg];
    [infoBg release];
    infoBg = nil;
    
    AddCareBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [AddCareBtn setBackgroundImage:[UIImage imageNamed:@"clover_c"] forState:UIControlStateNormal];
    AddCareBtn.frame = CGRectMake(120, 210, 80, 80);
    AddCareBtn.contentEdgeInsets = UIEdgeInsetsMake(30, 5, 5, 5);
    [AddCareBtn setTitle:@"" forState:UIControlStateNormal];
    if (showCarebtn) {
        AddCareBtn.hidden = NO;
    }else{
        AddCareBtn.hidden = YES;
    }
    AddCareBtn.tag = addCareBtnTag;
    [AddCareBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    if (self.user.following) {
        [AddCareBtn setBackgroundImage:[UIImage  imageNamed:@"clover_c_love"] forState:UIControlStateNormal];
    }else{
        [AddCareBtn setBackgroundImage:[UIImage imageNamed:@"clover_c"] forState:UIControlStateNormal];
    }

    careCountBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
    [careCountBtn setBackgroundImage:[UIImage imageNamed:@"clover_lt"] forState:UIControlStateNormal];
    [careCountBtn setTitle:@"关注" forState:UIControlStateNormal];
    careCountBtn.frame = CGRectMake(14, 110, 140, 140);
    careCountBtn.tag = careBtnTag;
    careCountBtn.titleLabel.font  =[UIFont systemFontOfSize:14];
    [careCountBtn addTarget:self action:@selector(btnClicked:) forControlEvents:
     UIControlEventTouchUpInside];
    careCountBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 50, 5);
    careCountBtn.imageView.backgroundColor = [UIColor redColor];
    fansCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [fansCountBtn setTitle:@"粉丝" forState:UIControlStateNormal];
    [fansCountBtn setBackgroundImage:[UIImage imageNamed:@"clover_rt"] forState:UIControlStateNormal];
    fansCountBtn.frame = CGRectMake(160, 110, 140, 140);
    fansCountBtn.tag = fansBtnTag;
    fansCountBtn.titleLabel.font  =[UIFont systemFontOfSize:14];
    [fansCountBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    fansCountBtn.contentEdgeInsets = UIEdgeInsetsMake(5, 5, 50, 5);
    
    
    weiboCountBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [weiboCountBtn setTitle:@"微博" forState:UIControlStateNormal];
    [weiboCountBtn setBackgroundImage:[UIImage imageNamed:@"clover_lb"] forState:UIControlStateNormal];
    weiboCountBtn.titleLabel.font  =[UIFont systemFontOfSize:14];
    weiboCountBtn.frame = CGRectMake(14, 250, 140, 140);
    weiboCountBtn.tag = weiboBtnTag;
    [weiboCountBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    weiboCountBtn.contentEdgeInsets = UIEdgeInsetsMake(50, 5, 5, 5);
    
    mansInfoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [mansInfoBtn setTitle:@"个人简介" forState:UIControlStateNormal];
    [mansInfoBtn setBackgroundImage:[UIImage imageNamed:@"clover_rb"] forState:UIControlStateNormal];
    mansInfoBtn.frame = CGRectMake(160, 250, 140, 140);
    mansInfoBtn.tag = manInfoBtnTag;
    mansInfoBtn.titleLabel.font  =[UIFont systemFontOfSize:14];
    [mansInfoBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    mansInfoBtn.contentEdgeInsets = UIEdgeInsetsMake(50, 5, 5, 5);
    //    [self.view addSubview:headImgae];
    //    [self.view addSubview:isVipImage];
    //    [self.view addSubview:ganderImage];
    //    [self.view addSubview:nameLable];
    [self.view addSubview:careCountBtn];
    [self.view addSubview:fansCountBtn];
    [self.view addSubview:weiboCountBtn];
    [self.view addSubview:mansInfoBtn];
    [self.view addSubview:AddCareBtn];
}


-(void)setInfo
{
    [headImgae  setImageWithURL:[NSURL URLWithString:self.user.profileImageUrl]];
    
    if (self.user.gender == GenderMale) {
        ganderImage.image = [UIImage imageNamed:@"male"];
    }else if(self.user.gender == GenderFemale)
    {
        ganderImage.image = [UIImage imageNamed:@"female"];
    }else{
//        ganderImage.image = [UIImage imageNamed:@"unknow"];
    }
    if (self.user.verified) {
        isVipImage.hidden = NO;
    }else{
        isVipImage.hidden = YES;
    }
    
    nameLable.text = user.name;
    [careCountBtn setTitle:[NSString  stringWithFormat:@"关注%d",self.user.friendsCount] forState:UIControlStateNormal];
    [fansCountBtn setTitle:[NSString stringWithFormat:@"粉丝%d",self.user.followersCount] forState:UIControlStateNormal];
    [weiboCountBtn setTitle:[NSString stringWithFormat:@"微博%d",self.user.followersCount] forState:UIControlStateNormal];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    weiboMessage = [WeiBoMessageManager getInstance];
    
//    [self.view setBackgroundColor:[UIColor colorWithRed:50/255.0f green:56/255.0f blue:65/255.0f alpha:1.0f]];
//    [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f]];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
    [self createView];
    [self setInfo];
}

-(void)viewWillAppear:(BOOL)animated
{
    NSNotificationCenter *notifCenter = [NSNotificationCenter defaultCenter];
    [notifCenter addObserver:self selector:@selector(gotFollowResult:) name:MMSinaFollowedByUserIDWithResult object:nil];
    [notifCenter addObserver:self selector:@selector(gotUnfollowResult:) name:MMSinaUnfollowedByUserIDWithResult object:nil];
}


-(void)gotFollowResult:(NSNotification *)noti
{
    [AddCareBtn setBackgroundImage:[UIImage imageNamed:@"clover_c_love"] forState:UIControlStateNormal];
    NSLog(@"关注－－－－－－－－－");
    
}

-(void)gotUnfollowResult:(NSNotification *)noti
{
    [AddCareBtn setBackgroundImage:[UIImage imageNamed:@"clover_c"] forState:UIControlStateNormal];
    NSLog(@"取消关注－－－－－－－－－");
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)dealloc
{
    [headImgae release];
    [isVipImage release];
    [ganderImage release];
    [nameLable release];
    [careCountBtn release];
    [AddCareBtn release];
    [weiboCountBtn release];
    [mansInfoBtn release];
}

@end
