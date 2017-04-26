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
#import "ACFloatingTextField.h"

@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtForgotPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtRegister;
@end

@implementation LoginViewController
@synthesize loginButton = _loginButton;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_txtEmail setTextFieldPlaceholderText:@"Email"];
    _txtEmail.selectedLineColor = [UIColor blackColor];
    _txtEmail.placeHolderColor = [UIColor blackColor];
    [_txtEmail setTextColor:[UIColor blackColor]];
    _txtEmail.selectedPlaceHolderColor = [UIColor blackColor];
    _txtEmail.lineColor = [UIColor blackColor];
    
    [_txtPassword setTextFieldPlaceholderText:@"Password"];
    _txtPassword.selectedLineColor = [UIColor blackColor];
    _txtPassword.placeHolderColor = [UIColor blackColor];
    [_txtPassword setTextColor:[UIColor blackColor]];
    _txtPassword.selectedPlaceHolderColor = [UIColor blackColor];
    _txtPassword.lineColor = [UIColor blackColor];
    _txtPassword.secureTextEntry = YES;
    // Do any additional setup after loading the view.
    _loginButton = [[FBSDKLoginButton alloc] init];
    _loginButton.delegate = self;
    _loginButton.readPermissions =
   @[@"public_profile", @"email", @"user_friends", @"user_posts"];
//    // Optional: Place the button in the center of your view.
//    loginButton.center = self.view.center;
//    [self.view addSubview:loginButton];
}


-(IBAction)FacebookLogIn:(id)sender{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends", @"user_posts"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
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
             
             

         }
     }];

}

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}


//*** USED IN CASE OF NEEDING TO SCROLL UP
// Called when the UIKeyboardDidShowNotification is sent.
//- (void)keyboardWasShown:(NSNotification*)aNotification
//{
//    NSDictionary* info = [aNotification userInfo];
//    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
//    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
//    _scrollview.contentInset = contentInsets;
//    _scrollview.scrollIndicatorInsets = contentInsets;
//    
//    // If active text field is hidden by keyboard, scroll it so it's visible
//    // Your application might not need or want this behavior.
//    CGRect aRect = self.view.frame;
//    aRect.size.height -= kbSize.height;
//    //   if (!CGRectContainsPoint(aRect, _activeTxtView.frame.origin) ) {
//    CGPoint scrollPoint = CGPointMake(0.0, _activeTxtView.frame.origin.y-kbSize.height);
//    [_scrollview setContentOffset:scrollPoint animated:YES];
//    // }
//}
//
//// Called when the UIKeyboardWillHideNotification is sent
//- (void)keyboardWillBeHidden:(NSNotification*)aNotification
//{
//    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
//    _scrollview.contentInset = contentInsets;
//    _scrollview.scrollIndicatorInsets = contentInsets;
//}


//- (void)loginButton:(FBSDKLoginButton *)loginButton
//didCompleteWithResult:(FBSDKLoginManagerLoginResult *)result
//              error:(NSError *)error {
//    
//    
//    if (error == nil) {
//        FIRAuthCredential *credential = [FIRFacebookAuthProvider
//                                         credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
//                                         .tokenString];
//        [[FIRAuth auth] signInWithCredential:credential
//                                  completion:^(FIRUser *user, NSError *error) {
//                                   
//                                      [FDKeychain saveItem: @"YES"
//                                                    forKey: @"loggedin"
//                                                forService: @"ReviewApp"
//                                                     error: nil];
//                                  }];
//         
//        
// [self performSegueWithIdentifier:@"callReviewApp" sender:self];
//    } else {
//        NSLog(error.localizedDescription);
//    }
//    
//    //    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//    //                                  initWithGraphPath:@"/me/feed"
//    //                                  parameters:@{@"fields":  @"name, message, picture"}
//    //                                  HTTPMethod:@"GET"];
//    //    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//    //                                          id result,
//    //                                          NSError *error) {
//    //        NSLog([NSString stringWithFormat:@"%@", result]);
//    //    }];
//}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callReviewApp"]) {
   
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
