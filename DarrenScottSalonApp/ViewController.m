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

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v) ([[[UIDevice currentDevice] systemVersion] compare:(v) options:NSNumericSearch] != NSOrderedAscending)

@interface ViewController ()<VKSideMenuDelegate, VKSideMenuDataSource,GMSAutocompleteViewControllerDelegate, UIAlertViewDelegate>{
    FIRStorageReference *storageRef;
    NSData *imageData;
    UIImage *hola;
}

@property (nonatomic, strong) VKSideMenu *menuLeft;
@property (nonatomic, strong) VKSideMenu *menuRight;
@property (nonatomic, strong) VKSideMenu *menuTop;
@property (nonatomic, strong) VKSideMenu *menuBottom;

@end

@implementation ViewController
@synthesize ivPickedImage;
@synthesize btnCamera,btnGallery,btnCheckIn;



- (void)viewDidLoad {
    [super viewDidLoad];
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

    
    [[btnCamera layer] setBorderWidth:1.0f];
    [[btnCamera layer] setBorderColor:self.view.tintColor.CGColor];
    btnCamera.layer.cornerRadius = 15.0f;
    
    [[btnGallery layer] setBorderWidth:1.0f];
    [[btnGallery layer] setBorderColor:self.view.tintColor.CGColor];
    btnGallery.layer.cornerRadius = 15.0f;
    
    [[btnCheckIn layer] setBorderWidth:1.0f];
    [[btnCheckIn layer] setBorderColor:self.view.tintColor.CGColor];
    //btnGallery.layer.cornerRadius = 15.0f;
    
    [[ivPickedImage layer] setBorderWidth:1.0f];
    [[ivPickedImage layer] setBorderColor:self.view.tintColor.CGColor];
    ivPickedImage.layer.cornerRadius = 15.0f;

    _textViewComments.text = @"Write (how was the whole experience)";
    _textViewComments.textColor = [UIColor lightGrayColor];
    _textViewComments.clipsToBounds = YES;
//    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewComments.delegate = self;
    
    _textViewWhere.text = @"Where (Check in or insert Website)";
    _textViewWhere.textColor = [UIColor lightGrayColor];
    _textViewWhere.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewWhere.delegate = self;
    
    _textViewWhy.text = @"Why (are you there, birthday, just because)";
    _textViewWhy.textColor = [UIColor lightGrayColor];
    _textViewWhy.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewWhy.delegate = self;
    
    _textViewWho.text = @"Who (Who helped/served you)";
    _textViewWho.textColor = [UIColor lightGrayColor];
    _textViewWho.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewWho.delegate = self;
    
    _textViewWhat.text = @"What (did you see/drink/get done)";
    _textViewWhat.textColor = [UIColor lightGrayColor];
    _textViewWhat.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewWhat.delegate = self;
    
    _textViewWith.text = @"With (are you with friends/family)";
    _textViewWith.textColor = [UIColor lightGrayColor];
    _textViewWhere.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewWhere.delegate = self;
   
    FIRStorage *storage = [FIRStorage storage];
    storageRef = [storage referenceForURL:@"gs://darrenscottsalon-46b98.appspot.com"];
    
    self.pickerViewService = [[UIPickerView alloc] init];
    self.pickerViewService.delegate = self;     //#2
    self.pickerViewService.dataSource = self;   //#2
    
    self.pickerViewStylist = [[UIPickerView alloc] init];
    self.pickerViewStylist.delegate = self;     //#2
    self.pickerViewStylist.dataSource = self;   //#2
    

    
   
    
    
//    self.textFieldService.inputView = self.pickerViewService;
//     self.textFieldStylist.inputView = self.pickerViewStylist;
//    
//    
//    self.pickerServices = @[ @"Hair", @"Nails", @"Extentions"];
//    self.pickerStylists = @[ @"Darren Scott", @"James Penningnton", @"Rafael Perez"];
//    
//    [self.view addSubview:self.textFieldService];
//    [self.view addSubview:self.textFieldStylist];
    
    // Do any additional setup after loading the view, typically from a nib.
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDetected)];
    singleTap.numberOfTapsRequired = 1;
    [ivPickedImage setUserInteractionEnabled:YES];
    [ivPickedImage addGestureRecognizer:singleTap];
    
//    CGRect frameRect = textFieldService.frame;
//    frameRect.size.height = 100; // <-- Specify the height you want here.
//    textFieldService.frame = frameRect;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];

}

-(IBAction)shareReview{
    if (_textViewWhere.text && _textViewWhere.text.length > 0 && _textViewWhy.text && _textViewWhy.text.length > 0 && _textViewWith.text && _textViewWith.text.length > 0 && _textViewWho.text && _textViewWho.text.length > 0 && _textViewWhat.text && _textViewWhat.text.length > 0)
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
        [alert show];
        
    }
   

}

- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if( 0 == buttonIndex ){ //cancel button
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    } else if ( 1 == buttonIndex ){
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
        UIAlertView * secondAlertView = [[UIAlertView alloc] initWithTitle:@"Success!!"
                                                                   message:@"Thanks for sharing your review!"
                                                                  delegate:nil
                                                         cancelButtonTitle:@"OK"
                                                         otherButtonTitles:nil];
        [secondAlertView show];
        _textViewComments.text = @"Write (how was the whole experience)";
        _textViewComments.textColor = [UIColor lightGrayColor];
        _textViewComments.clipsToBounds = YES;
        //    _textViewComments.layer.cornerRadius = 10.0f;
        _textViewComments.delegate = self;
        
        _textViewWhere.text = @"Where (Check in or insert Website)";
        _textViewWhere.textColor = [UIColor lightGrayColor];
        _textViewWhere.clipsToBounds = YES;
        //    _textViewComments.layer.cornerRadius = 10.0f;
        _textViewWhere.delegate = self;
        
        _textViewWhy.text = @"Why (are you there, birthday, just because)";
        _textViewWhy.textColor = [UIColor lightGrayColor];
        _textViewWhy.clipsToBounds = YES;
        //    _textViewComments.layer.cornerRadius = 10.0f;
        _textViewWhy.delegate = self;
        
        _textViewWho.text = @"Who (Who helped/served you)";
        _textViewWho.textColor = [UIColor lightGrayColor];
        _textViewWho.clipsToBounds = YES;
        //    _textViewComments.layer.cornerRadius = 10.0f;
        _textViewWho.delegate = self;
        
        _textViewWhat.text = @"What (did you see/drink/get done)";
        _textViewWhat.textColor = [UIColor lightGrayColor];
        _textViewWhat.clipsToBounds = YES;
        //    _textViewComments.layer.cornerRadius = 10.0f;
        _textViewWhat.delegate = self;
        
        _textViewWith.text = @"With (are you with friends/family)";
        _textViewWith.textColor = [UIColor lightGrayColor];
        _textViewWhere.clipsToBounds = YES;
        //    _textViewComments.layer.cornerRadius = 10.0f;
        _textViewWhere.delegate = self;
        
        ivPickedImage.image = [UIImage imageNamed:@"placeholder"];

        
    }
}

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
//    if (textView == _textViewWhere) {
//        GMSAutocompleteViewController *autocompleteViewController =
//        [[GMSAutocompleteViewController alloc] init];
//        autocompleteViewController.delegate = self;
//        [self presentViewController:autocompleteViewController animated:YES completion:nil];
//    }
    if([textView.text isEqualToString:@"Write (how was the whole experience)"]||[textView.text isEqualToString:@"Where (Check in or insert Website)"]||[textView.text isEqualToString:@"With (are you with friends/family)"]||[textView.text isEqualToString:@"Why (are you there, birthday, just because)"]||[textView.text isEqualToString:@"Who (Who helped/served you)"]||[textView.text isEqualToString:@"What (did you see/drink/get done)"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    else{
        textView.textColor = [UIColor blackColor];
        
    }
    return YES;
}

-(IBAction)checkIn{
    GMSAutocompleteViewController *autocompleteViewController =
    [[GMSAutocompleteViewController alloc] init];
    autocompleteViewController.delegate = self;
    [self presentViewController:autocompleteViewController animated:YES completion:nil];

}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([textView.text isEqualToString:@""])
    {
        _textViewComments.text = @"Write (how was the whole experience)";
        _textViewComments.textColor = [UIColor lightGrayColor];
        _textViewComments.clipsToBounds = YES;

        
        _textViewWhere.text = @"Where (Check in or insert Website)";
        _textViewWhere.textColor = [UIColor lightGrayColor];
        _textViewWhere.clipsToBounds = YES;

        
        _textViewWhy.text = @"Why (are you there, birthday, just because)";
        _textViewWhy.textColor = [UIColor lightGrayColor];
        _textViewWhy.clipsToBounds = YES;

        
        _textViewWho.text = @"Who (Who helped/served you)";
        _textViewWho.textColor = [UIColor lightGrayColor];
        _textViewWho.clipsToBounds = YES;

        
        _textViewWhat.text = @"What (did you see/drink/get done)";
        _textViewWhat.textColor = [UIColor lightGrayColor];
        _textViewWhat.clipsToBounds = YES;

        
        _textViewWith.text = @"With (are you with friends/family)";
        _textViewWith.textColor = [UIColor lightGrayColor];
        _textViewWhere.clipsToBounds = YES;
    }
}


-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show];
}


#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft || sideMenu == self.menuTop) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft || sideMenu == self.menuTop)
        return 3;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    if (sideMenu == self.menuLeft || sideMenu == self.menuTop) // All LEFT and TOP menu items
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
        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        [loginManager logOut];
        NSError *error;
        [[FIRAuth auth] signOut:&error];
        if (!error) {
            // Sign-out succeeded
            [FDKeychain saveItem: @"NO"
                          forKey: @"loggedin"
                      forService: @"ReviewApp"
                           error: nil];
            [self performSegueWithIdentifier:@"callLogIn" sender:self];
        }
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
    else if (sideMenu == self.menuTop)
        menu = @"TOP";
    else if (sideMenu == self.menuRight)
        menu = @"RIGHT";
    else if (sideMenu == self.menuBottom)
        menu = @"RIGHT";
    
    NSLog(@"%@ VKSideMenue did show", menu);
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    else if (sideMenu == self.menuTop)
        menu = @"TOP";
    else if (sideMenu == self.menuRight)
        menu = @"RIGHT";
    else if (sideMenu == self.menuBottom)
        menu = @"RIGHT";
    
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
    _textViewWhere.text = place.name;
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


- (void)keyboardFrameWillChange:(NSNotification *)notification
{
    CGRect keyboardEndFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGRect keyboardBeginFrame = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    UIViewAnimationCurve animationCurve = [[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
    NSTimeInterval animationDuration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] integerValue];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:animationDuration];
    [UIView setAnimationCurve:animationCurve];
    
    CGRect newFrame = self.view.frame;
    CGRect keyboardFrameEnd = [self.view convertRect:keyboardEndFrame toView:nil];
    CGRect keyboardFrameBegin = [self.view convertRect:keyboardBeginFrame toView:nil];
    
    newFrame.origin.y -= (keyboardFrameBegin.origin.y - keyboardFrameEnd.origin.y);
    self.view.frame = newFrame;
    
    [UIView commitAnimations];
}



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
//    _textViewTest.frame = newFrame;
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
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        ipc.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No Camera Available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

- (IBAction)btnGalleryClicked:(id)sender
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}


- (IBAction)btnPhotoGalleryClicked:(id)sender
{
    ipc= [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    ipc.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone)
        [self presentViewController:ipc animated:YES completion:nil];
    else
    {
        popover=[[UIPopoverController alloc]initWithContentViewController:ipc];
        [popover presentPopoverFromRect:btnGallery.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
    }
}



- (IBAction)btnCameraClicked:(id)sender
{
    ipc = [[UIImagePickerController alloc] init];
    ipc.delegate = self;
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        ipc.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:ipc animated:YES completion:NULL];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"" message:@"No Camera Available." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        alert = nil;
    }
}

#pragma mark - ImagePickerController Delegate

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    if(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPhone) {
        [picker dismissViewControllerAnimated:YES completion:nil];
    } else {
        [popover dismissPopoverAnimated:YES];
    }
    ivPickedImage.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    imageData = UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage], 1.0);
    //hola = [info objectForKey:UIImagePickerControllerOriginalImage];
    
}



-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
