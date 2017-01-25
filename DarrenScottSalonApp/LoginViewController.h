//
//  LoginViewController.h
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 1/23/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
@import FirebaseAuth;
@import Firebase;
@import GoogleSignIn;
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@interface LoginViewController : UIViewController<GIDSignInDelegate,
GIDSignInUIDelegate>
@property (weak, nonatomic) IBOutlet FBSDKLoginButton *loginButton;

@end
