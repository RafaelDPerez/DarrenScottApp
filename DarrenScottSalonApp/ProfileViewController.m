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
#import "VKSideMenu.h"

@interface ProfileViewController ()<VKSideMenuDelegate, VKSideMenuDataSource>
@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation ProfileViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:320 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.view];
    self.menuLeft.backgroundColor = [UIColor whiteColor];
//    // Do any additional setup after loading the view.
//    _loginButton = [[FBSDKLoginButton alloc] init];
//    _loginButton.delegate = self;
//    _loginButton.readPermissions =
//    @[@"public_profile", @"email", @"user_friends", @"user_posts"];
//    FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                  initWithGraphPath:@"/me"
//                                  parameters:@{@"fields":  @"name, email, picture"}
//                                  HTTPMethod:@"GET"];
//    [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                          id result,
//                                          NSError *error) {
//        NSLog([NSString stringWithFormat:@"%@", result]);
//        
//        if (!error) {
//            NSString *img = result[@"picture"][@"data"][@"url"];
//            NSString *name = result[@"name"];
//            NSString *email = result [@"email"];
////            NSArray * arrData = result[@"picture"][@"data"][@"url"];
////            NSLog(@"Esta es una prueba %@",result[@"LaMediaCancha"][@"data"]);
//            //    recipeImageView.image = [[UIImage alloc] initWithData:data];
//            [_imgProfilePic sd_setImageWithURL:[NSURL URLWithString:img]
//                              placeholderImage:[UIImage imageNamed:@"lmc-292x292.png"]];
//            
//            _txtEmail.text = email;
//            _txtName.text = name;
//        }
//    }];
    
    

}

-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}


#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 3;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    if (sideMenu == self.menuLeft) // All LEFT and TOP menu items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Home";
                item.icon  = [UIImage imageNamed:@"Home-50"];
                break;
                
            case 1:
                item.title = @"My Reviews";
                item.icon  = [UIImage imageNamed:@"ic_option_1"];
                break;
                
            case 2:
                item.title = @"Log Out";
                item.icon  = [UIImage imageNamed:@"Like-50"];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 0) // RIGHT menu first section items
    {
        item.title = @"Login";
    }
    else // RIGHT menu second section items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Like";
                break;
                
            case 1:
                item.title = @"Share";
                break;
            default:
                break;
        }
    }
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        //        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        //        [loginManager logOut];
        NSError *signOutError;
        BOOL status = [[FIRAuth auth] signOut:&signOutError];
        if (!status) {
            NSLog(@"Error signing out: %@", signOutError);
            return;
        }
        else{
            // Sign-out succeeded
            [FDKeychain saveItem: @"NO"
                          forKey: @"loggedin"
                      forService: @"ReviewApp"
                           error: nil];
            [FDKeychain deleteItemForKey:@"token" forService:@"BIXI" error:nil];
            [self performSegueWithIdentifier:@"callLogIn" sender:self];
        }
    }
    if (indexPath.row == 0) {
      [self performSegueWithIdentifier:@"callHome" sender:self];
    }

}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callLogIn"]) {
        
    }
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did show", menu);
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did hide", menu);
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;
    
    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
