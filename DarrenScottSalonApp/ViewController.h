//
//  ViewController.h
//  DarrenScottSalonApp
//
//  Created by maricarmen peignand  on 10/27/16.
//  Copyright (c) 2016 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
@import Firebase;
@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate,UITextViewDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto1;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto2;
@property (weak, nonatomic) IBOutlet UIButton *btnPhoto3;
@property (weak, nonatomic) IBOutlet UIButton *btnCheckIn;
@property(strong,nonatomic) IBOutlet ASStarRatingView *starsRating;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage2;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage3;
@property (strong, nonatomic) IBOutlet UITextField *txtWhere;
@property (strong, nonatomic) IBOutlet UITextField *txtWho;
@property (strong, nonatomic) IBOutlet UITextField *txtWhat;
@property (strong, nonatomic) IBOutlet UITextField *txtWith;
@property (strong, nonatomic) IBOutlet UITextField *txtWhy;
@property (strong, nonatomic) IBOutlet UITextView *textViewComments;
@property (strong, nonatomic) IBOutlet UITextView *textViewWhere;
@property (strong, nonatomic) IBOutlet UITextView *textViewWho;
@property (strong, nonatomic) IBOutlet UITextView *textViewWhat;
@property (strong, nonatomic) IBOutlet UITextView *textViewWith;
@property (strong, nonatomic) IBOutlet UITextView *textViewWhy;
@property (strong, nonatomic) IBOutlet UITextView *textViewCategory;
@property (nonatomic, strong) UIPickerView *pickerViewService;
@property (nonatomic, strong) UIPickerView *pickerViewStylist;
@property (nonatomic, strong) NSArray *pickerServices;
@property (nonatomic, strong) NSArray *pickerStylists;
@property (weak, nonatomic) IBOutlet UISwitch *swLocation;
@property (weak, nonatomic) IBOutlet UISwitch *swTwitter;
@property int senderID;
-(void)tapDetected;
-(void)tapDetected2;
-(void)tapDetected3;



@end

