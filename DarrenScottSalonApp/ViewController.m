//
//  ViewController.m
//  DarrenScottSalonApp
//
//  Created by maricarmen peignand  on 10/27/16.
//  Copyright (c) 2016 maranta. All rights reserved.
//

#import "ViewController.h"
#import <Social/Social.h>
#import <QuartzCore/QuartzCore.h>
#import <GooglePlaces/GooglePlaces.h>
#import "LeftMenuViewController.h"
#import "ProfileViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "VKSideMenu.h"
#import "FDKeychain.h"
#import <TwitterKit/TwitterKit.h>
#import "Review.h"
#import "UIViewController+SLPhotoSelection.h"


@import Firebase;
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@interface ViewController ()<VKSideMenuDelegate, VKSideMenuDataSource,GMSAutocompleteViewControllerDelegate, UIAlertViewDelegate>{
    FIRStorageReference *storageRef;
    NSData *imageData;
    NSData *imageData2;
    NSData *imageData3;
    UIImage *hola;
    UITextView *selectedTextView;
    
}

@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, strong) Review *review;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) UITextView *activeTxtView;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSString *PlaceAddress;
@property (strong, nonatomic) NSString *downloadURL;
@end

@implementation ViewController
@synthesize ivPickedImage,ivPickedImage2,ivPickedImage3;
@synthesize btnPhoto1,btnPhoto2,btnPhoto3, swLocation, swTwitter, btnCheckIn;



- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:320 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.view];
    self.menuLeft.backgroundColor = [UIColor whiteColor];

    [[_textViewComments layer] setBorderWidth:1.0f];
    [[_textViewComments layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewWho layer] setBorderWidth:1.0f];
    [[_textViewWho layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewWhat layer] setBorderWidth:1.0f];
    [[_textViewWhat layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewWhy layer] setBorderWidth:1.0f];
    [[_textViewWhy layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewWith layer] setBorderWidth:1.0f];
    [[_textViewWith layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewWhere layer] setBorderWidth:1.0f];
    [[_textViewWhere layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewCategory layer] setBorderWidth:1.0f];
    [[_textViewCategory layer] setBorderColor:self.view.tintColor.CGColor];

    
    [[btnPhoto1 layer] setBorderWidth:1.0f];
    [[btnPhoto1 layer] setBorderColor:self.view.tintColor.CGColor];
    btnPhoto1.layer.cornerRadius = 15.0f;
    
    [[btnPhoto2 layer] setBorderWidth:1.0f];
    [[btnPhoto2 layer] setBorderColor:self.view.tintColor.CGColor];
    btnPhoto2.layer.cornerRadius = 15.0f;
    
    [[btnPhoto3 layer] setBorderWidth:1.0f];
    [[btnPhoto3 layer] setBorderColor:self.view.tintColor.CGColor];
    btnPhoto3.layer.cornerRadius = 15.0f;
    
    
    
    [[btnCheckIn layer] setBorderWidth:1.0f];
    [[btnCheckIn layer] setBorderColor:self.view.tintColor.CGColor];
    //btnGallery.layer.cornerRadius = 15.0f;
    
    [[ivPickedImage layer] setBorderWidth:1.0f];
    [[ivPickedImage layer] setBorderColor:self.view.tintColor.CGColor];
    ivPickedImage.layer.cornerRadius = 15.0f;
    
    [[ivPickedImage2 layer] setBorderWidth:1.0f];
    [[ivPickedImage2 layer] setBorderColor:self.view.tintColor.CGColor];
    ivPickedImage2.layer.cornerRadius = 15.0f;
    
    [[ivPickedImage3 layer] setBorderWidth:1.0f];
    [[ivPickedImage3 layer] setBorderColor:self.view.tintColor.CGColor];
    ivPickedImage3.layer.cornerRadius = 15.0f;

    _textViewComments.text = @"Write (how was the whole experience)";
    _textViewComments.textColor = [UIColor lightGrayColor];
    _textViewComments.clipsToBounds = YES;
    _textViewComments.delegate = self;
    
    _textViewCategory.text = @"Category";
    _textViewCategory.textColor = [UIColor lightGrayColor];
    _textViewCategory.clipsToBounds = YES;
    _textViewCategory.delegate = self;
    
    _textViewWhere.text = @"Where (Check in or insert Website)";
    _textViewWhere.textColor = [UIColor lightGrayColor];
    _textViewWhere.clipsToBounds = YES;
    _textViewWhere.delegate = self;
    
    _textViewWhy.text = @"Why (are you there, birthday, just because)";
    _textViewWhy.textColor = [UIColor lightGrayColor];
    _textViewWhy.clipsToBounds = YES;
    _textViewWhy.delegate = self;
    
    _textViewWho.text = @"Who (Who helped/served you)";
    _textViewWho.textColor = [UIColor lightGrayColor];
    _textViewWho.clipsToBounds = YES;
    _textViewWho.delegate = self;
    
    _textViewWhat.text = @"What (did you see/drink/get done)";
    _textViewWhat.textColor = [UIColor lightGrayColor];
    _textViewWhat.clipsToBounds = YES;
    _textViewWhat.delegate = self;
    
    _textViewWith.text = @"With (are you with friends/family)";
    _textViewWith.textColor = [UIColor lightGrayColor];
    _textViewWhere.clipsToBounds = YES;
    _textViewWhere.delegate = self;
   
    FIRStorage *storage = [FIRStorage storage];
    storageRef = [storage referenceForURL:@"gs://darrenscottsalon-46b98.appspot.com"];
    
    self.pickerViewService = [[UIPickerView alloc] init];
    self.pickerViewService.delegate = self;     //#2
    self.pickerViewService.dataSource = self;   //#2
    
    self.pickerViewStylist = [[UIPickerView alloc] init];
    self.pickerViewStylist.delegate = self;     //#2
    self.pickerViewStylist.dataSource = self;   //#2
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [ivPickedImage setUserInteractionEnabled:YES];
    [ivPickedImage addGestureRecognizer:singleTap];
    
    UITapGestureRecognizer *singleTap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected2)];
    singleTap2.numberOfTapsRequired = 1;
    [ivPickedImage2 setUserInteractionEnabled:YES];
    [ivPickedImage2 addGestureRecognizer:singleTap2];
    
    UITapGestureRecognizer *singleTap3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected3)];
    singleTap3.numberOfTapsRequired = 1;
    [ivPickedImage3 setUserInteractionEnabled:YES];
    [ivPickedImage3 addGestureRecognizer:singleTap3];
    
    [swLocation addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
    [swTwitter addTarget:self action:@selector(setState:) forControlEvents:UIControlEventValueChanged];
//    CGRect frameRect = textFieldService.frame;
//    frameRect.size.height = 100; // <-- Specify the height you want here.
//    textFieldService.frame = frameRect;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [self registerForKeyboardNotifications];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

- (void)setState:(id)sender
{
    BOOL state = [sender isOn];
    if (sender==swLocation) {
        if (state) {
            // [_textViewWhere becomeFirstResponder];
            [_textViewWhere performSelector:@selector(becomeFirstResponder) withObject:nil afterDelay:0];
            
            _textViewWhere.editable = YES;
            _textViewWhere.text = @"";
        }
        else{
            [_textViewWhere resignFirstResponder];
            _textViewWhere.text = @"Where (Check in or insert Website)";
            _textViewWhere.textColor = [UIColor lightGrayColor];
            _textViewWhere.clipsToBounds = YES;
            
            _textViewWhere.delegate = self;
            _textViewWhere.editable = NO;
        }
    }
    if (sender==swTwitter) {
        if (state) {
            [self sendTweet:sender];
        }
    }
    
}

-(IBAction)shareReview{
    if (_textViewWhere.text && _textViewWhere.text.length > 0 && _textViewWhy.text && _textViewWhy.text.length > 0 && _textViewWith.text && _textViewWith.text.length > 0 && _textViewWho.text && _textViewWho.text.length > 0 && _textViewWhat.text && _textViewWhat.text.length > 0 && _textViewCategory.text && _textViewCategory.text.length > 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"clic pic review"
                                                        message:@"Are you sure you want to share this review?"
                                                       delegate:self
                                              cancelButtonTitle:@"No"
                                              otherButtonTitles:@"Yes",nil];
        [alert show];
    }
    else{
        
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required Fields"
                                                        message:@"Please fill all the fields."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        alert.tag=0;
        [alert show];
        
    }
   

}

#pragma mark - SLPhotoSelection methods

- (IBAction)addImageView:(id)sender
{
    UIButton *buttonTap = sender;
    __weak UIImageView *imageView = self.ivPickedImage;
    if (buttonTap.tag ==11) {
        imageView = self.ivPickedImage;
    }
    if (buttonTap.tag ==22) {
        imageView = self.ivPickedImage2;
    }
    if (buttonTap.tag ==33) {
        imageView = self.ivPickedImage3;
    }
   
    
    [self addPhotoWithCompletionHandler:^(BOOL success, UIImage *image) {
        if (success) {
            imageView.image = image;
            if (buttonTap.tag ==11) {
                imageData = UIImageJPEGRepresentation(image, 0.5);
            }
            if (buttonTap.tag ==22) {
                imageData2 = UIImageJPEGRepresentation(image, 0.5);
            }
            if (buttonTap.tag ==33) {
                imageData3 = UIImageJPEGRepresentation(image, 0.5);
            }

        }
    }];
}



- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 0) {
        if( 0 == buttonIndex ){ //cancel button
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        } else if ( 1 == buttonIndex ){
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"dd-MM-yyyy";
            NSString *string = [formatter stringFromDate:[NSDate date]];

            
            
            
            
            
            
            
            FIRDatabaseReference *autoId = [_ref childByAutoId];
            //NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
            _review = [[Review alloc]init];
            _review.reviewID=autoId.key;
            _review.comments = _textViewComments.text;
            _review.date = string;
            
            _review.what = _textViewWhat.text;
            _review.where = _textViewWhere.text;
            _review.who = _textViewWho.text;
            _review.with = _textViewWith.text;
            _review.why = _textViewWhy.text;
            _review.categories = _textViewCategory.text;
            _review.address = _PlaceAddress;
            _review.rating = [[NSNumber numberWithFloat:_starsRating.rating] stringValue];
            
            
            NSString * selfieStorageName = [NSString stringWithFormat:@"reviewsPics/review%@.jpg",autoId];
            // Create a reference to the file you want to upload
            FIRStorageReference *riversRef = [storageRef child:selfieStorageName];
//
//            // Upload the file to the path "images/rivers.jpg"
//            // Upload the file to the path "images/rivers.jpg"
//            
//           // ***FIREBASE UPLOAD
                FIRStorageUploadTask *uploadTask = [riversRef putData:imageData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
                    if (error != nil) {
                        // Uh-oh, an error occurred!
                    } else {
                        // Metadata contains file metadata such as size, content-type, and download URL.
                        NSURL *downloadURL = metadata.downloadURL;
                        _downloadURL = downloadURL.absoluteString;
                        [_review.photos addObject: _downloadURL];
                        NSLog(@"%@",autoId.key);
                        [[[_ref child:@"reviews"] child:autoId.key]
                         setValue:@{@"id": autoId.key,
                                    @"comments": _review.comments,
                                    @"date": string,
                                    @"photos":@[_downloadURL],
                                    @"what": _review.what,
                                    @"where": _review.where,
                                    @"who": _review.who,
                                    @"with": _review.with,
                                    @"why":_review.why,
                                    @"categories":_review.categories,
                                    @"address":_PlaceAddress,
                                    @"rating": [[NSNumber numberWithFloat:_starsRating.rating] stringValue],
                                    @"user":[FIRAuth auth].currentUser.uid}];
                        NSString *userID = [FIRAuth auth].currentUser.uid;
                        [[[[[_ref child:@"users"] child:userID] child:@"reviews"] child:autoId.key]setValue:@{@"id":autoId.key}];
                    }
                }];

            // For more complex open graph stories, use `FBSDKShareAPI`
            // with `FBSDKShareOpenGraphContent`
            //*****FACEBOOK SHARING
//            FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
//            
//            [login
//             logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends", @"user_posts"]
//             fromViewController:self
//             handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
//                 if (error) {
//                     NSLog(@"Process error");
//                 } else if (result.isCancelled) {
//                     NSLog(@"Cancelled");
//                 } else {
//                     //             FIRAuthCredential *credential = [FIRFacebookAuthProvider
//                     //                                              credentialWithAccessToken:[FBSDKAccessToken currentAccessToken]
//                     //                                              .tokenString];
//                     //             [[FIRAuth auth] signInWithCredential:credential
//                     //                                       completion:^(FIRUser *user, NSError *error) {
//                     //
//                     //                                           [FDKeychain saveItem: @"YES"
//                     //                                                         forKey: @"loggedin"
//                     //                                                     forService: @"ReviewApp"
//                     //                                                          error: nil];
//                     //                                       }];
//                     //  [self performSegueWithIdentifier:@"callReviewApp" sender:self];
//                                                                           NSDictionary *params = @{
//                                                                                                    @"message": @"This is a test message",
//                                                                                                    };
//                                                                           /* make the API call */
//                                                                           FBSDKGraphRequest *request = [[FBSDKGraphRequest alloc]
//                                                                                                         initWithGraphPath:@"/me/feed"
//                                                                                                         parameters:params
//                                                                                                         HTTPMethod:@"POST"];
//                                                                           [request startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
//                                                                                                                 id result,
//                                                                                                                 NSError *error) {
//                                                                               // Handle the result
//                                                                           }];
//                                                                     
//                 
//                     
//                     
//                 }
//             }];
//            
//            if ([[FBSDKAccessToken currentAccessToken] hasGranted:@"publish_actions"]) {
//                // TODO: publish content.
//            } else {
//                
//                
////                FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
////                [loginManager logInWithPublishPermissions:@[@"publish_actions"]
////                                       fromViewController:self
////                                                  handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
////                                                      //TODO: process error or result.
////                                                      NSLog(@"token: %@",[FBSDKAccessToken currentAccessToken].tokenString);
//
//            }
//            
            
            
            
            UIAlertView * secondAlertView = [[UIAlertView alloc] initWithTitle:@"Success!!"
                                                                       message:@"Thanks for sharing your review!"
                                                                      delegate:nil
                                                             cancelButtonTitle:@"OK"
                                                             otherButtonTitles:nil];
            [secondAlertView show];

           
            _textViewComments.text = @"Write (how was the whole experience)";
            _textViewComments.textColor = [UIColor lightGrayColor];
            _textViewComments.clipsToBounds = YES;
            _textViewComments.delegate = self;
            
            _textViewCategory.text = @"Category";
            _textViewCategory.textColor = [UIColor lightGrayColor];
            _textViewCategory.clipsToBounds = YES;
            _textViewCategory.delegate = self;
            
            _textViewWhere.text = @"Where (Check in or insert Website)";
            _textViewWhere.textColor = [UIColor lightGrayColor];
            _textViewWhere.clipsToBounds = YES;
            
            _textViewWhere.delegate = self;
            
            _textViewWhy.text = @"Why (are you there, birthday, just because)";
            _textViewWhy.textColor = [UIColor lightGrayColor];
            _textViewWhy.clipsToBounds = YES;
            
            _textViewWhy.delegate = self;
            
            _textViewWho.text = @"Who (Who helped/served you)";
            _textViewWho.textColor = [UIColor lightGrayColor];
            _textViewWho.clipsToBounds = YES;
            
            _textViewWho.delegate = self;
            
            _textViewWhat.text = @"What (did you see/drink/get done)";
            _textViewWhat.textColor = [UIColor lightGrayColor];
            _textViewWhat.clipsToBounds = YES;
            
            _textViewWhat.delegate = self;
            
            _textViewWith.text = @"With (are you with friends/family)";
            _textViewWith.textColor = [UIColor lightGrayColor];
            _textViewWhere.clipsToBounds = YES;
            
            _textViewWhere.delegate = self;
            
            ivPickedImage.image = [UIImage imageNamed:@"logo_cpr_new"];
            ivPickedImage2.image = [UIImage imageNamed:@"logo_cpr_new"];
            ivPickedImage3.image = [UIImage imageNamed:@"logo_cpr_new"];
            
            
        }

    }
    if (alertView.tag==1) {
        if (buttonIndex == 1) {
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
                [FDKeychain deleteItemForKey:@"token" forService:@"ReviewApp" error:nil];
                [self performSegueWithIdentifier:@"callLogIn" sender:self];
                TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
                NSString *userID = store.session.userID;
//                [[[Twitter sharedInstance] APIClient] loadUserWithID:[session userID]
//                                                          completion:^(TWTRUser *user,
//                                                                       NSError *error)
              //  [[[Twitter sharedInstance] sessionStore] logOutUserID:USERID];
                [store logOutUserID:userID];
                NSLog(@"%@",store.session.userID);
            }
            
        }
        else {
            
        }
    }
   }

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _activeTxtView = textView;
    if([textView.text isEqualToString:@"Write (how was the whole experience)"]||[textView.text isEqualToString:@"Where (Check in or insert Website)"]||[textView.text isEqualToString:@"With (are you with friends/family)"]||[textView.text isEqualToString:@"Why (are you there, birthday, just because)"]||[textView.text isEqualToString:@"Who (Who helped/served you)"]||[textView.text isEqualToString:@"What (did you see/drink/get done)"]||[textView.text isEqualToString:@"Category"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    else{
        textView.textColor = [UIColor blackColor];
        
    }
    return YES;
}




-(IBAction)sendTweet:(id)sender{
    // Objective-C
    
    TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
    NSString *userID = store.session.userID;
    
    
    //[store logOutUserID:userID];
    if (userID) {
        [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
            if (session) {
                NSLog(@"signed in as %@", [session userID]);
                TWTRComposer *composer = [[TWTRComposer alloc] init];
                
                [composer setText:@"this is a test"];
                [composer setImage:[UIImage imageNamed:@"selfie"]];
                
                // Called from a UIViewController
                [composer showFromViewController:self completion:^(TWTRComposerResult result) {
                    if (result == TWTRComposerResultCancelled) {
                        NSLog(@"Tweet composition cancelled");
                    }
                    else {
                        NSLog(@"Sending Tweet!");
                    }
                }];
            } else {
                NSLog(@"error: %@", [error localizedDescription]);
            }
        }];

    }
    else{
        TWTRSessionStore *store = [[Twitter sharedInstance] sessionStore];
        NSString *userID = store.session.userID;
        if (userID) {
            NSLog(@"User is Logged.");
        }
        else{
            [[Twitter sharedInstance] logInWithCompletion:^(TWTRSession *session, NSError *error) {
                if (session) {
                    NSLog(@"signed in as %@", [session userID]);
                    TWTRComposer *composer = [[TWTRComposer alloc] init];
                    
                    [composer setText:@"this is a test"];
                    [composer setImage:[UIImage imageNamed:@"selfie"]];
                    
                    // Called from a UIViewController
                    [composer showFromViewController:self completion:^(TWTRComposerResult result) {
                        if (result == TWTRComposerResultCancelled) {
                            NSLog(@"Tweet composition cancelled");
                        }
                        else {
                            NSLog(@"Sending Tweet!");
                        }
                    }];
                } else {
                    NSLog(@"error: %@", [error localizedDescription]);
                }
            }];
        }
    }
    

}



-(IBAction)checkIn{
    GMSAutocompleteViewController *autocompleteViewController =
    [[GMSAutocompleteViewController alloc] init];
    autocompleteViewController.delegate = self;
    [self presentViewController:autocompleteViewController animated:YES completion:nil];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
   // [textView scrollRangeToVisible:NSMakeRange(1, 1)];
    [textView setContentOffset:CGPointZero animated:YES];
    if([textView.text isEqualToString:@""])
    {
        if (textView.tag ==101) {
            textView.text = @"Where (Check in or insert Website)";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==102) {
            textView.text = @"Who (Who helped/served you)";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==103) {
            textView.text = @"What (did you see/drink/get done)";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==104) {
            textView.text = @"Why (are you there, birthday, just because)";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==105) {
            textView.text = @"With (are you with friends/family)";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==106) {
            textView.text = @"Write (how was the whole experience)";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==107) {
            textView.text = @"Category";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
    }
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
                item.title = @"Profile";
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
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Log Out"
                              message: @"Are you sure?"
                              delegate: self
                              cancelButtonTitle:@"NO"
                              otherButtonTitles:@"YES",nil];
        alert.tag = 1;
        [alert show];
        }
    if (indexPath.row==0) {
        [self performSegueWithIdentifier:@"callProfile" sender:self];
    }
    
    if (indexPath.row==1) {
        [self performSegueWithIdentifier:@"callReviews" sender:self];
    }
    NSLog(@"SideMenu didSelectRow: %@", indexPath);
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField == _txtWhere) {
        GMSAutocompleteViewController *autocompleteViewController =
        [[GMSAutocompleteViewController alloc] init];
        autocompleteViewController.delegate = self;
        [self presentViewController:autocompleteViewController animated:YES completion:nil];
    }
    return YES;
}



#pragma mark - Actions
//
//- (IBAction)showAutocompleteWidgetButtonTapped {
//    // When the button is pressed modally present the autocomplete view controller.
//    GMSAutocompleteViewController *autocompleteViewController =
//    [[GMSAutocompleteViewController alloc] init];
//    autocompleteViewController.delegate = self;
//    [self presentViewController:autocompleteViewController animated:YES completion:nil];
//}


#pragma mark - GMSAutocompleteViewControllerDelegate

- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    // Dismiss the view controller and tell our superclass to populate the result view.
    [viewController dismissViewControllerAnimated:YES completion:nil];
    NSMutableAttributedString *text =
    [[NSMutableAttributedString alloc] initWithString:[place description]];
    if (place.attributions) {
        [text appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n\n"]];
        [text appendAttributedString:place.attributions];
    }
    [_textViewWhere resignFirstResponder];
    _textViewWhere.textColor = [UIColor blackColor];
    _textViewWhere.text = place.name;
    _PlaceAddress = place.formattedAddress;

    [_textViewCategory resignFirstResponder];
    _textViewCategory.textColor = [UIColor blackColor];
    NSArray *types = place.types;
    NSMutableString *typesName = [NSMutableString stringWithCapacity:150];
    for (int i=0; i<[types count]; i++) {
        if (i==[types count]-1) {
            NSString *placeCat = types[i];
            [typesName appendString:[NSString stringWithFormat:@"%@",[placeCat stringByReplacingOccurrencesOfString:@"_"withString:@" "]]];
        }
        else{
            NSString *placeCat = types[i];
            [typesName appendString:[NSString stringWithFormat:@"%@, ",[placeCat stringByReplacingOccurrencesOfString:@"_"withString:@" "]]];
        }
        
    }
    _textViewCategory.text = typesName;

}

- (void)viewController:(GMSAutocompleteViewController *)viewController
didFailAutocompleteWithError:(NSError *)error {
    // Dismiss the view controller and notify our superclass of the failure.
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    // Dismiss the controller and show a message that it was canceled.
    [viewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
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

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    _scrollview.contentInset = contentInsets;
    _scrollview.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
 //   if (!CGRectContainsPoint(aRect, _activeTxtView.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, _activeTxtView.frame.origin.y-kbSize.height);
        [_scrollview setContentOffset:scrollPoint animated:YES];
   // }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollview.contentInset = contentInsets;
    _scrollview.scrollIndicatorInsets = contentInsets;
}


//- (void)keyboardFrameWillChange:(NSNotification *)notification
//{
//    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
//    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
//    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
//    
//    [UIView beginAnimations:nil context:nil];
//    [UIView setAnimationDuration:animationDuration];
//    [UIView setAnimationCurve:animationCurve];
//    
//    CGRect newFrame = self.view.frame;
//    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
//    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
//    
//    newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
//    self.view.frame = newFrame;
//    
//    [UIView commitAnimations];
//}



-(void) textViewDidChange:(UITextView *)textView
{
    
    //if(_textViewComments.text.length == 0){
        //_textViewComments.textColor = [UIColor lightGrayColor];
        //_textViewComments.text = @"Write";
      //  [_textViewComments resignFirstResponder];
    //}

//    CGFloat fixedWidth = textView.frame.size.width;
//    CGSize newSize = [textView sizeThatFits:CGSizeMake(fixedWidth, MAXFLOAT)];
//    CGRect newFrame = textView.frame;
//    newFrame.size = CGSizeMake(fmaxf(newSize.width, fixedWidth), newSize.height);
//    textView.frame = newFrame;
}

- (IBAction)btnAddReviewClicked:(id)sender
{
    
//        if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
//        {
//            SLComposeViewController *tweetSheet = [SLComposeViewController
//                                                   composeViewControllerForServiceType:SLServiceTypeTwitter];
//            [tweetSheet setInitialText:@"Great fun to learn iOS programming at appcoda.com!"];
//            [self presentViewController:tweetSheet animated:YES completion:nil];
//        }
    
    NSString * timestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSString * selfieStorageName = [NSString stringWithFormat:@"selfieImages/selfie_%@.jpg", timestamp];
    // Create a reference to the file you want to upload
    FIRStorageReference *riversRef = [storageRef child:selfieStorageName];
    
    // Upload the file to the path "images/rivers.jpg"
    // Upload the file to the path "images/rivers.jpg"

    //***FIREBASE UPLOAD
    //    FIRStorageUploadTask *uploadTask = [riversRef putData:imageData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
//        if (error != nil) {
//            // Uh-oh, an error occurred!
//        } else {
//            // Metadata contains file metadata such as size, content-type, and download URL.
//            NSURL *downloadURL = metadata.downloadURL;
//        }
//    }];
//    FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
//    [[[rootRef child:@"users" ]childByAutoId]
//     setValue:@{@"id":  timestamp,
//                @"review_photo_url": selfieStorageName,
//                @"review_rating": @"rafaeldperez",
//                @"review_comments": _textViewComments.text,
//                @"review_stylist": _textFieldStylist.text,
//                @"review_service": textFieldService.text}];
}

-(void)dismissKeyboard {
    [_textViewComments resignFirstResponder];
    [_textViewWhat resignFirstResponder];
    [_textViewWho resignFirstResponder];
    [_textViewWith resignFirstResponder];
    [_textViewWhy resignFirstResponder];
    [_textViewWhere resignFirstResponder];
    [_textViewCategory resignFirstResponder];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - UIPickerViewDataSource

// #3
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (pickerView == self.pickerViewService) {
        return 1;
    }
    if (pickerView == self.pickerViewStylist) {
        return 1;
    }
    
    return 0;
}

// #4
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.pickerViewService) {
        return [self.pickerServices count];
    }
    if (pickerView == self.pickerViewStylist) {
        return [self.pickerStylists count];
    }

    
    return 0;
}

#pragma mark - UIPickerViewDelegate

// #5
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.pickerViewService) {
        return self.pickerServices[row];
    }
    if (pickerView == self.pickerViewStylist) {
        return self.pickerStylists[row];
    }
    
    return nil;
}

// #6
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    if (pickerView == self.pickerViewService) {
//        self.textFieldService.text = self.pickerServices[row];
//    }
//    if (pickerView == self.pickerViewStylist) {
//        self.textFieldStylist.text = self.pickerStylists[row];
//    }
//    [[self view] endEditing:YES];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}


-(void)tapDetected{
    
    [self addImageView:ivPickedImage];
}

-(void)tapDetected2{
    
    [self addImageView:ivPickedImage2];
}

-(void)tapDetected3{
    
    [self addImageView:ivPickedImage3];
}
//
//- (IBAction)btnGalleryClicked:(id)sender
//{
//    ipc= [[UIImagePickerController alloc] init];
//    ipc.delegate = self;
//    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//
//    UIButton *hola = sender;
//    _senderID = hola.tag;
//    
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//        [self presentViewController:ipc animated:YES completion:nil];
//    else
//    {
//        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
//        [popover presentPopoverFromRect:btn.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
//}


//- (IBAction)btnPhotoGalleryClicked:(id)sender
//{
//    ipc= [[UIImagePickerController alloc] init];
//    ipc.delegate = self;
//    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
//    
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
//        [self presentViewController:ipc animated:YES completion:nil];
//    else
//    {
//        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
//        [popover presentPopoverFromRect:btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
//    }
//}



//- (IBAction)btnCameraClicked:(id)sender
//{
//    ipc = [[UIImagePickerController alloc] init];
//    ipc.delegate = self;
//    
//    UIButton *hola = sender;
//    _senderID = hola.tag;
//    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
//    {
//        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
//        [self presentViewController:ipc animated:YES completion:NULL];
//    }
//    else
//    {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No Camera Available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
//        [alert show];
//        alert = nil;
//    }
//}

//#pragma mark - ImagePickerController Delegate
//
//-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
//{
//    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
//        [picker dismissViewControllerAnimated:YES completion:nil];
//    } else {
//        [popover dismissPopoverAnimated:YES];
//    }
//    if (_senderID == 11 || _senderID == 21) {
//        ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
//    }
//    if (_senderID == 12 || _senderID == 22) {
//        ivPickedImage2.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
//    }
//    if (_senderID == 13 || _senderID == 23) {
//        ivPickedImage3.image = [info objectForKey:UIImagePickerControllerOriginalImage];
//        imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
//    }
////    ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
////    imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
//    //hola = [info objectForKey:UIImagePickerControllerOriginalImage];
//    
//}
//
//
//
//-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
//{
//    [picker dismissViewControllerAnimated:YES completion:nil];
//}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
