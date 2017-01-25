//
//  ProfileViewController.h
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 1/25/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseAuth;
@import Firebase;
#import "SlideNavigationController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface ProfileViewController : UIViewController
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (weak, nonatomic) IBOutlet UIImageView *imgProfilePic;
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;
@property (weak, nonatomic) IBOutlet UILabel *txtName;
@property (weak, nonatomic) IBOutlet UILabel *txtEmail;
@property (weak, nonatomic) IBOutlet UIButton *btnLogOut;

@end
