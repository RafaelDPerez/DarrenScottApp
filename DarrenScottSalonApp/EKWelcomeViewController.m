//
//  EKViewController.m
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKWelcomeViewController.h"
#import "EKWelcomeView.h"


static NSString * const kEKSegueIdentifier = @"callRegister";

@interface EKWelcomeViewController () <EKDismissWelcomeScreenDelegate>

@property (nonatomic, strong) EKWelcomeView *welcomeView;


@end


@implementation EKWelcomeViewController

- (void)loadView
{
	EKWelcomeView *view = [[EKWelcomeView alloc] init];
	self.view = view;
	self.welcomeView = view;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.welcomeView.delegate = self;
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
}

#pragma mark - EKDismissWelcomeScreenDelegate's & segue's stuff

- (void)dismissWelcomeScreen
{
	[self performSegueWithIdentifier:kEKSegueIdentifier sender:self];
}

- (void)goToLogIn
{
    [self performSegueWithIdentifier:@"callLogIn" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	if ([segue.identifier isEqualToString:kEKSegueIdentifier]) {

	}
}

@end
