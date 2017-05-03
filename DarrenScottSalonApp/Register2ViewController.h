//
//  Register2ViewController.h
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "PDKClient.h"
@import FirebaseAuth;
@import Firebase;

@interface Register2ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UISwitch *sldFbk;
@property (weak, nonatomic) IBOutlet UISwitch *sldPinterest;
@property (weak, nonatomic) IBOutlet UISwitch *sldTwt;
@property (weak, nonatomic) NSString *userType;



@end
