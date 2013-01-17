//
//  MansSampleInfoViewController.m
//  CoCoWeibo
//
//  Created by a a a a a on 12-10-23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MansSampleInfoViewController.h"
#import "ZJTHelpler.h"
@implementation MansSampleInfoViewController
@synthesize name;
@synthesize city;
@synthesize infotext;
@synthesize user = _user;

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
//    ZJTHelpler * zjt = [ZJTHelpler getInstance];
    name.text = self.user.name;
    city.text = self.user.city;
    infotext.text = self.user.description;
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bgimg"]]];
    
}

- (void)viewDidUnload
{
    [self setName:nil];
    [self setCity:nil];
    [self setInfotext:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [name release];
    [city release];
    [infotext release];
    [super dealloc];
}
@end
