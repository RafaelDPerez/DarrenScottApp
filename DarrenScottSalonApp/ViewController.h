//
//  ViewController.h
//  DarrenScottSalonApp
//
//  Created by maricarmen peignand  on 10/27/16.
//  Copyright (c) 2016 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface ViewController : UIViewController<UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    UIImagePickerController *ipc;
    UIPopoverController *popover;
}

@property (weak, nonatomic) IBOutlet UIButton *btnGallery;
@property (weak, nonatomic) IBOutlet UIButton *btnCamera;
@property (weak, nonatomic) IBOutlet UIButton *btnPhotoGallery;
@property(strong,nonatomic) IBOutlet ASStarRatingView *starsRating;
@property (weak, nonatomic) IBOutlet UIImageView *ivPickedImage;
@property (weak, nonatomic) IBOutlet UITextField *textFieldService;
@property (weak, nonatomic) IBOutlet UITextField *textFieldStylist;
@property (weak, nonatomic) IBOutlet UITextField *textFieldComments;
@property (nonatomic, strong) UIPickerView *pickerViewService;
@property (nonatomic, strong) UIPickerView *pickerViewStylist;
@property (nonatomic, strong) NSArray *pickerServices;
@property (nonatomic, strong) NSArray *pickerStylists;

@end

