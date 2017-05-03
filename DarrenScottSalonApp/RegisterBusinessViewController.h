//
//  RegisterBusinessViewController.h
//  clic pic review
//
//  Created by Rafael Perez on 4/30/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterBusinessViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textViewFirstName;
@property (weak, nonatomic) IBOutlet UITextView *textViewLastName;
@property (weak, nonatomic) IBOutlet UITextView *textViewCompanyName;
@property (weak, nonatomic) IBOutlet UITextView *textViewEmail;
@property (weak, nonatomic) IBOutlet UITextView *textViewPlace;
@property (weak, nonatomic) IBOutlet UITextView *textViewCategory;
@property (weak, nonatomic) IBOutlet UITextView *textViewCountryCode;
@property (weak, nonatomic) IBOutlet UITextView *textViewPhone;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextView *textPosition;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnBack;
@end
