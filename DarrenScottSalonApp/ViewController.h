//
//  ViewController.h
//  DarrenScottSalonApp
//
//  Created by maricarmen peignand  on 10/27/16.
//  Copyright (c) 2016 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"
#import "SlideNavigationController.h"
@import Firebase;

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate, SlideNavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;
@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property(strong,nonatomic) IBOutlet ASStarRatingView *starsRating;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (weak, nonatomic) IBOutlet UITextField *txtWhere;
@property (weak, nonatomic) IBOutlet UITextField *txtWho;
@property (weak, nonatomic) IBOutlet UITextField *txtWhat;
@property (weak, nonatomic) IBOutlet UITextField *txtWith;
@property (weak, nonatomic) IBOutlet UITextField *txtWhy;
@property (weak, nonatomic) IBOutlet UITextView *textViewComments;
@property (nonatomic, strong) UIPickerView *pickerViewService;
@property (nonatomic, strong) UIPickerView *pickerViewStylist;
@property (nonatomic, strong) NSArray *pickerServices;
@property (nonatomic, strong) NSArray *pickerStylists;

@end

