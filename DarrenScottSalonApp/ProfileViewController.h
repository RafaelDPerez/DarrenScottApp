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
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>


@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblName;
@property (weak, nonatomic) IBOutlet UILabel *lbluserName;
@property (weak, nonatomic) IBOutlet UILabel *lbldateOfBirth;
@property (weak, nonatomic) IBOutlet UILabel *lblemail;
@property (weak, nonatomic) IBOutlet UILabel *lblcountry;
@property (weak, nonatomic) IBOutlet UILabel *lblphone;

@end
