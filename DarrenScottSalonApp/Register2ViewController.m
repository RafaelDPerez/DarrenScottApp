//
//  Register2ViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "Register2ViewController.h"
#import "FDKeychain.h"
#import "PDKClient.h"
#import "PDKUser.h"
#import <TwitterKit/TwitterKit.h>
#import "PDKBoard.h"
#import "PDKClient.h"
#import "PDKPin.h"
#import "PDKResponseObject.h"
#import "PDKUser.h"
#import "TermsAndConditionsViewController.h"

@interface Register2ViewController ()
@property (nonatomic, strong) PDKUser *user;

@end

@implementation Register2ViewController
@synthesize sldFbk, sldPinterest, sldTwt;
- (void)viewDidLoad {
    [super viewDidLoad];
    TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
        if (session) {
            // Callback for login success or failure. The TWTRSession
            // is also available on the [Twitter sharedInstance]
            // singleton.
            //
            // Here we pop an alert just to give an example of how
            // to read Twitter user info out of a TWTRSession.
                //
            // TODO: Remove alert and use the TWTRSession's userID
            // with your app's user model
            NSString *message = [NSString stringWithFormat:@"@%@ logged in! (%@)",
                                 [session userName], [session userID]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Logged in!"
                                                            message:message
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        } else {
            NSLog(@"Login error: %@", [error localizedDescription]);
        }
}];
    
//    // TODO: Change where the log in button is positioned in your view
    logInButton.center = self.view.center;
    [self.view addSubview:logInButton];

  [sldFbk addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
  [sldPinterest addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
  [sldTwt addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    
    // Do any additional setup after loading the view.
}

- (void)setState:(id)sender
{
    BOOL state = [sender isOn];
    if (sender ==sldFbk && state) {
        [self FacebookLogIn:self];
    }
    if (sender==sldPinterest && state) {
        [self authenticateButtonTapped:sender];
    }
    if (sender==sldTwt && state) {
        TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
        NSString *userID = store.session.userID;
        if (userID) {
            NSLog(@"User is Logged.");
        }
        else{
            [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
                if (session) {
                    NSLog(@"signed in as %@", [session userID]);
                } else {
                    NSLog(@"error: %@", [error localizedDescription]);
                }
            }];
        }
       
    }
  
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
//             FIRAuthCredential *credential = [FIRFacebookAuthProvider
//                                              credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
//                                              .tokenString];
//             [[FIRAuth auth] signInWithCredential:credential
//                                       completion:^(FIRUser *user, NSError *error) {
//                                           
//                                           [FDKeychain saveItem: @"YES"
//                                                         forKey: @"loggedin"
//                                                     forService: @"ReviewApp"
//                                                          error: nil];
//                                       }];
           //  [self performSegueWithIdentifier:@"callReviewApp" sender:self];
             
             
             
         }
     }];
    
}

- (IBAction)authenticateButtonTapped:(id)sender
{
    __weak Register2ViewController *weakSelf = self;
    [[PDKClient sharedInstance] authenticateWithPermissions:@[PDKClientReadPublicPermissions,
                                                              PDKClientWritePublicPermissions,
                                                              PDKClientReadRelationshipsPermissions,
                                                              PDKClientWriteRelationshipsPermissions]
                                                withSuccess:^(PDKResponseObject *responseObject)
     {
         weakSelf.user = [responseObject user];
     //    weakSelf.resultLabel.text = [NSString stringWithFormat:@"%@ authenticated!", weakSelf.user.firstName];
       //  [weakSelf updateButtonEnabledState];
     } andFailure:^(NSError *error) {
        // weakSelf.resultLabel.text = @"authentication failed";
     }];
    
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)RegisterUser:(id)sender{
[self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
    
    //
//    if (_txtEmail.text && _txtEmail.text.length > 0 && _txtMobile.text && _txtMobile.text.length > 0 &&_txtPassword.text && _txtPassword.text.length > 0 && _txtConfirmPassword.text && _txtConfirmPassword.text.length > 0 )
//    {
//        
////        self.user.password = _txtPassword.text;
////        self.user.passwordConfirm = _txtConfirmPassword.text;
////        self.user.phone1 = _txtMobile.text;
////        self.user.email = _txtEmail.text;
////        NSLog(@"%@ - %@ -%@ -%@ -%@ -%@ -%@",self.user.password, self.user.passwordConfirm, self.user.gender, self.user.email, self.user.firstName, self.user.age, self.user.phone1);
//        [self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required Fields"
//                                                        message:@"Please fill all the fileds."
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        [alert show];
//        
//    }
    
    
    
}


#pragma mark - Navigation

 //In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"RegisterCompleted"]) {
    TermsAndConditionsViewController *viewCont = [segue destinationViewController];
        viewCont.userType = self.userType;
    
    }
}


@end
