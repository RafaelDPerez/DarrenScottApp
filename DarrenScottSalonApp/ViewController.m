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

@interface ViewController (){
    FIRStorageReference *storageRef;
    NSData *imageData;
    UIImage *hola;
}

@end

@implementation ViewController
@synthesize ivPickedImage, textFieldService;
@synthesize btnCamera,btnGallery,btnPhotoGallery;

- (void)viewDidLoad {
    [super viewDidLoad];
       [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"Terms"];
    _textViewComments.text = @"Comment";
    _textViewComments.textColor = [UIColor lightGrayColor];
    _textViewComments.clipsToBounds = YES;
    _textViewComments.layer.cornerRadius = 10.0f;
    [_textViewComments.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [_textViewComments.layer setBorderWidth:0.5];
    _textViewComments.delegate = self;
   
    FIRStorage *storage = [FIRStorage storage];
    storageRef = [storage referenceForURL:@"gs://darrenscottsalon-46b98.appspot.com"];

    self.pickerViewService = [[UIPickerView alloc] init];
    self.pickerViewService.delegate = self;     //#2
    self.pickerViewService.dataSource = self;   //#2
    
    self.pickerViewStylist = [[UIPickerView alloc] init];
    self.pickerViewStylist.delegate = self;     //#2
    self.pickerViewStylist.dataSource = self;   //#2
    
   
    
    
    self.textFieldService.inputView = self.pickerViewService;
     self.textFieldStylist.inputView = self.pickerViewStylist;
    
    
    self.pickerServices = @[ @"Hair", @"Nails", @"Extentions"];
    self.pickerStylists = @[ @"Darren Scott", @"James Penningnton", @"Rafael Perez"];
    
    [self.view addSubview:self.textFieldService];
    [self.view addSubview:self.textFieldStylist];
    
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

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([_textViewComments.text isEqualToString:@"Comment"]){
        _textViewComments.text = @"";
    _textViewComments.textColor = [UIColor blackColor];
    }
    else
        _textViewComments.textColor = [UIColor blackColor];
    
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(_textViewComments.text.length == 0){
        _textViewComments.textColor = [UIColor lightGrayColor];
        _textViewComments.text = @"Comment";
        [_textViewComments resignFirstResponder];
    }
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
    FIRStorageUploadTask *uploadTask = [riversRef putData:imageData metadata:nil completion:^(FIRStorageMetadata *metadata, NSError *error) {
        if (error != nil) {
            // Uh-oh, an error occurred!
        } else {
            // Metadata contains file metadata such as size, content-type, and download URL.
            NSURL *downloadURL = metadata.downloadURL;
        }
    }];
    FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
    [[[rootRef child:@"users" ]childByAutoId]
     setValue:@{@"id":  timestamp,
                @"review_photo_url": selfieStorageName,
                @"review_rating": @"rafaeldperez",
                @"review_comments": _textViewComments.text,
                @"review_stylist": _textFieldStylist.text,
                @"review_service": textFieldService.text}];
}

-(void)dismissKeyboard {
    [_textViewComments resignFirstResponder];
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
    if (pickerView == self.pickerViewService) {
        self.textFieldService.text = self.pickerServices[row];
    }
    if (pickerView == self.pickerViewStylist) {
        self.textFieldStylist.text = self.pickerStylists[row];
    }
    [[self view] endEditing:YES];
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
