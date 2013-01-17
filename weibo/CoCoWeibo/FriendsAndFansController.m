//
//  FriendsAndFansController.m
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-13.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FriendsAndFansController.h"
#import "FriendsChildViewController.h"

#import "AppDelegate.h"
#define duringtime  1.0f
@interface FriendsAndFansController ()

@end


@implementation FriendsAndFansController
@synthesize userID;
-(void)dealloc
{
        [super dealloc];
}

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
          }
    return self;
}

-(void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)addChildView
{
    FriendsChildViewController * follow = [[FriendsChildViewController alloc] init];
    follow.userID = userID;
    [self addChildViewController:follow];
    [follow  release];
    
    FriendsChildViewController * fans = [[FriendsChildViewController alloc]init];
    fans.userID = userID;
    [self  addChildViewController:fans];
    [fans  release];
    
    FriendsChildViewController * mutalFans = [[FriendsChildViewController alloc]init];
    mutalFans.userID = userID;
    [self  addChildViewController:mutalFans];
    [mutalFans  release];

    follow.view.frame = CGRectMake(0, 0, 320, 460-44);
    fans.view.frame = CGRectMake(0, 0, 320, 460-44);
    mutalFans.view.frame = CGRectMake(0, 0, 320, 460-44);
    
    [contentView addSubview:follow.view];
    currentViewController = follow;
}

-(void)segClicked:(int)index
{
    FriendsChildViewController * firstVc = [self.childViewControllers  objectAtIndex:0];
    FriendsChildViewController * secondVc = [self.childViewControllers objectAtIndex:1];
    FriendsChildViewController * thridVc = [self.childViewControllers objectAtIndex:2];
    if ((currentViewController == firstVc&&index == 0)||(currentViewController == secondVc&&index == 1)||(currentViewController == thridVc&&index == 2)) {
        return;
    }
    
    UIViewController * oldViewController = currentViewController;
    
    switch (index) {
        case 0:
            SharedApp.currentFriendsIndex = followIndex;
            [self transitionFromViewController:currentViewController toViewController:firstVc duration: duringtime options:UIViewAnimationOptionTransitionCurlDown animations:^{
            
            } completion:^(BOOL  finished){
                if (finished) {
                    currentViewController = firstVc;
                }else{
                    currentViewController = oldViewController;
                }
            }];
            break;
        case 1:
            SharedApp.currentFriendsIndex = fansIndex;
            [self transitionFromViewController:currentViewController toViewController:secondVc duration:duringtime options:UIViewAnimationOptionTransitionCurlDown animations:^{
            
            } completion:^(BOOL finished){
                if (finished) {
                    currentViewController = secondVc;
                }else{
                    currentViewController = oldViewController;
                }
            }];
            break;
            
        case 2:
            SharedApp.currentFriendsIndex = mutualFansIndex;
            [self transitionFromViewController:currentViewController toViewController:thridVc duration:duringtime options:UIViewAnimationOptionTransitionCurlDown animations:^{
            
            } completion:^(BOOL  finished){
                if (finished) {
                    currentViewController = thridVc;
                }else{
                    currentViewController = oldViewController;
                }
            }];
            break;
        default:
            break;
    }
}

-(void)addTitleBtn
{
    seg = [[SVSegmentedControl alloc] initWithSectionTitles:[NSArray  arrayWithObjects:@"关注",@"粉丝", @"相互关注",nil]];
//    seg.selectedIndex = 1;
//    SharedApp.currentFriendsIndex = followIndex;
  //  [self segClicked:seg.selectedIndex];
    seg.changeHandler = ^(NSUInteger  segIndex)
    {
       // NSLog(@"index%d",segIndex);
        [self segClicked:segIndex];
        
    };
    self.navigationItem.prompt =@"新浪好友";
    [self.navigationItem setTitleView:seg];
}



#pragma mark - View lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    contentView  = [[UIView  alloc] initWithFrame:CGRectMake(0, 0, 320, 460-44)];
    [self.view  addSubview:contentView];
    [self  addChildView];
     [self  addTitleBtn]; 
}


-(void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
