//
//  LoginViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 1/23/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "FDKeychain.h"
#import "ProfileViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize loginButton = _loginButton;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loginButton = [[FBSDKLoginButton alloc] init];
    _loginButton.delegate = self;
    _loginButton.readPermissions =
   @[@"public_profile", @"email", @"user_friends", @"user_posts"];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
}

- (void)loginButton:(FBSDKLoginButton *)loginButton
didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
              error:(NSError *)error {
    
    
    if (error == nil) {
        FIRAuthCredential *credential = [FIRFacebookAuthProvider
                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
                                         .tokenString];
        [[FIRAuth auth] signInWithCredential:credential
                                  completion:^(FIRUser *user, NSError *error) {
                                   
                                      [FDKeychain saveItem: @"YES"
                                                    forKey: @"loggedin"
                                                forService: @"ReviewApp"
                                                     error: nil];
                                  }];
         
        
 [self performSegueWithIdentifier:@"callReviewApp" sender:self];
    } else {
        NSLog(error.localizedDescription);
    }
    
    //    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
    //                                  initWithGraphPath:@"/me/feed"
    //                                  parameters:@{@"fields":  @"name, message, picture"}
    //                                  HTTPMethod:@"GET"];
    //    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
    //                                          id result,
    //                                          NSError *error) {
    //        NSLog([NSString stringWithFormat:@"%@", result]);
    //    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callReviewApp"]) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProfileViewController *leftMenu = (ProfileViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
        [SlideNavigationController sharedInstance].leftMenu = leftMenu;
        [SlideNavigationController sharedInstance].menuRevealAnimationDuration = .18;
    }
}


- (void)loginButtonDidLogOut:(FBSDKLoginButton *)loginButton{
    NSError *error;
    [[FIRAuth auth] signOut:&error];
    if (!error) {
        // Sign-out succeeded
        [FDKeychain saveItem: @"NO"
                      forKey: @"loggedin"
                  forService: @"ReviewApp"
                       error: nil];
    }
}

//-(IBAction)fetchUserInfo {
//
//    if ([FBSDKAccessToken currentAccessToken]) {
//        
//        NSLog(@"Token is available");
//        
//        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:nil]
//         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
//             if (!error) {
//                 NSLog(@"Fetched User Information:%@", result);
//                 
//             }
//             else {
//                 NSLog(@"Error %@",error);
//             }
//         }];
//        
//    } else {
//        
//        NSLog(@"User is not Logged in");
//    }
//}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
