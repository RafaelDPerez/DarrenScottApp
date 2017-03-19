//
//  Register1ViewController.h
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Register1ViewController : UIViewController<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textViewFirstName;
@property (weak, nonatomic) IBOutlet UITextView *textViewLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtDateOfBirth;
@property (weak, nonatomic) IBOutlet UITextView *textViewEmail;
@property (weak, nonatomic) IBOutlet UITextView *textViewCountryCode;
@property (weak, nonatomic) IBOutlet UITextView *textViewPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextView *textViewUsername;
@end
