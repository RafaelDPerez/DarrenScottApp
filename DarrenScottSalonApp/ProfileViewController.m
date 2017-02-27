//
//  ProfileViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 1/25/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "ProfileViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SDWebImage/UIImageView+WebCache.h"
#import "LoginViewController.h"
@import Firebase;
#import "FDKeychain.h"
@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize loginButton = _loginButton;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _loginButton = [[FBSDKLoginButton alloc] init];
    _loginButton.delegate = self;
    _loginButton.readPermissions =
    @[@"public_profile", @"email", @"user_friends", @"user_posts"];
    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
                                  initWithGraphPath:@"/me"
                                  parameters:@{@"fields":  @"name, email, picture"}
                                  HTTPMethod:@"GET"];
    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                          id result,
                                          NSError *error) {
        NSLog([NSString stringWithFormat:@"%@", result]);
        
        if (!error) {
            NSString *img = result[@"picture"][@"data"][@"url"];
            NSString *name = result[@"name"];
            NSString *email = result [@"email"];
//            NSArray * arrData = result[@"picture"][@"data"][@"url"];
//            NSLog(@"Esta es una prueba %@",result[@"LaMediaCancha"][@"data"]);
            //    recipeImageView.image = [[UIImage alloc] initWithData:data];
            [_imgProfilePic sd_setImageWithURL:[NSURL URLWithString:img]
                              placeholderImage:[UIImage imageNamed:@"lmc-292x292.png"]];
            
            _txtEmail.text = email;
            _txtName.text = name;
        }
    }];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(IBAction)logOut:(id)sender{
    [FDKeychain saveItem: @"NO"
                  forKey: @"loggedin"
              forService: @"ReviewApp"
                   error: nil];
    
    FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
    [loginManager logOut];
    
    [FBSDKAccessToken setCurrentAccessToken:nil];
    
    //[self performSegueWithIdentifier:@"callLogIn" sender:self];
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"LogIn"];
    self.window.rootViewController = vc;
    [self.window makeKeyAndVisible];
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
