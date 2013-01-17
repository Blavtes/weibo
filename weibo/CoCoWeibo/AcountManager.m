//
//  AcountManager.m
//  superWeiBo6-leslie
//
//  Created by a a a a a on 12-10-11.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AcountManager.h"
#import "TokenModel.h"
@implementation AcountManager

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
//     [self.view setBackgroundColor:[UIColor colorWithRed:229/255.0f green:235/255.0f blue:242/255.0f alpha:1.0f]];
    sinaOAuthManager = [[OAuthManager alloc]initWithOAuthManager:SINA_WEIBO];
    tencentOAuthManager = [[OAuthManager alloc]initWithOAuthManager:TENCENT_WEIBO];
    self.title = @"账号管理";
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


- (IBAction)sinaLogin:(id)sender {
    [sinaOAuthManager login];
}

- (IBAction)tencentLogin:(id)sender {
    [tencentOAuthManager login];
}

- (IBAction)sinaLogout:(id)sender {
    [sinaOAuthManager login];
}

- (IBAction)tencentLogout:(id)sender {
     [tencentOAuthManager login];
}

- (IBAction)sinaTestLog:(id)sender {
    NSLog(@"sn");
    if ([sinaOAuthManager isAlreadyLogin]) {
        NSLog(@"Sinalogin");
    }
}

- (IBAction)tencentTestLog:(id)sender {
    NSLog(@"sn");
    if ([sinaOAuthManager isAlreadyLogin]) {
        NSLog(@"Sinalogin");
    }
}
@end
