//
//  Register1ViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "Register1ViewController.h"
#import "ACFloatingTextField.h"
#import "FDKeychain.h"
@import Firebase;

static NSString * const sampleDescription1 = @"Welcome to clic pic review (CPR), the new exciting app that allows you a fun and simple way to record, review and share your experiences with your friends and the world.";
static NSString * const sampleDescription2 = @"Use it as your personal diary or to promote and share your views on anything and everything.";
static NSString * const sampleDescription3 = @"We need your details in order to comply with various laws, update you with updates to the app and be able to contact you for secutiry issues such as password re-sets";
static NSString * const sampleDescription4 = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";



@interface Register1ViewController ()<UITextFieldDelegate, UITextViewDelegate> {
    UIView *rootView;
    }

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSMutableArray *countries;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) UITextView *activeTxtView;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [FIRApp configure];
    self.ref = [[FIRDatabase database] reference];
   
    rootView = self.navigationController.view;
    [[_textViewFirstName layer] setBorderWidth:1.0f];
    [[_textViewFirstName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewLastName layer] setBorderWidth:1.0f];
    [[_textViewLastName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_txtDateOfBirth layer] setBorderWidth:1.0f];
    [[_txtDateOfBirth layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewEmail layer] setBorderWidth:1.0f];
    [[_textViewEmail layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewPhone layer] setBorderWidth:1.0f];
    [[_textViewPhone layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewUsername layer] setBorderWidth:1.0f];
    [[_textViewUsername layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewCountryCode layer] setBorderWidth:1.0f];
    [[_textViewCountryCode layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_txtPassword layer] setBorderWidth:1.0f];
    [[_txtPassword layer] setBorderColor:self.view.tintColor.CGColor];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    NSString *maxDateString = @"01-Jan-1996";
    // the date formatter used to convert string to date
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // the specific format to use
    dateFormatter.dateFormat = @"dd-MMM-yyyy";
    // converting string to date
    NSDate *theMaximumDate = [dateFormatter dateFromString: maxDateString];
    
    // repeat the same logic for theMinimumDate if needed
    
    // here you can assign the max and min dates to your datePicker
    //[datePicker setMaximumDate:theMaximumDate]; //the min age restriction
    [datePicker setDate:[NSDate date]];
    datePicker.datePickerMode = UIDatePickerModeDate;
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.txtDateOfBirth setInputView:datePicker];
    
    
    _textViewFirstName.text = @"First Name";
    _textViewFirstName.textColor = [UIColor lightGrayColor];
    _textViewFirstName.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewFirstName.delegate = self;
    
    _textViewLastName.text = @"Last Name";
    _textViewLastName.textColor = [UIColor lightGrayColor];
    _textViewLastName.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewLastName.delegate = self;
    

    _txtDateOfBirth.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _txtDateOfBirth.delegate = self;
    
    _textViewEmail.text = @"Email";
    _textViewEmail.textColor = [UIColor lightGrayColor];
    _textViewEmail.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewEmail.delegate = self;
    
    _textViewPhone.text = @"Mobile/Cell";
    _textViewPhone.textColor = [UIColor lightGrayColor];
    _textViewPhone.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewPhone.delegate = self;
    
    _textViewCountryCode.text = @"Country Code";
    _textViewCountryCode.textColor = [UIColor lightGrayColor];
    _textViewCountryCode.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewCountryCode.delegate = self;
    
    _textViewUsername.text = @"Username";
    _textViewUsername.textColor = [UIColor lightGrayColor];
    _textViewUsername.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewUsername.delegate = self;
    

    _txtPassword.clipsToBounds = YES;
    _txtPassword.secureTextEntry = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _txtPassword.delegate = self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardFrameWillChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    

    _countries = [[NSMutableArray alloc]init];
    _countries = [NSMutableArray arrayWithCapacity: [[NSLocale ISOCountryCodes] count]];
    
    for (NSString *countryCode in [NSLocale ISOCountryCodes])
    {
        NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
        NSString *country = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
        [_countries addObject: country];
    }
    //sortedCountries = [countries sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    // Do any additional setup after loading the view, typically from a nib.
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.textViewCountryCode.inputView = self.pickerView;
    
[self registerForKeyboardNotifications];

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
       if (!CGRectContainsPoint(aRect, _activeTxtView.frame.origin) ) {
    CGPoint scrollPoint = CGPointMake(0.0, _activeTxtView.frame.origin.y-kbSize.height);
    [_scrollview setContentOffset:scrollPoint animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    _scrollview.contentInset = contentInsets;
    _scrollview.scrollIndicatorInsets = contentInsets;
}



-(BOOL) NSStringIsValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if (textView == _textViewPhone) {
        int length = (int)[self getLength:textView.text];
        //NSLog(@"Length  =  %d ",length);
        
        if(length == 10)
        {
            if(range.length == 0)
                return NO;
        }
        
        if(length == 3)
        {
            NSString *num = [self formatNumber:textView.text];
            textView.text = [NSString stringWithFormat:@"(%@) ",num];
            
            if(range.length > 0)
                textView.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        }
        else if(length == 6)
        {
            NSString *num = [self formatNumber:textView.text];
            //NSLog(@"%@",[num  substringToIndex:3]);
            //NSLog(@"%@",[num substringFromIndex:3]);
            textView.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
            
            if(range.length > 0)
                textView.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        }
    }
    
    
    return YES;
}



- (NSString *)formatNumber:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = (int)[mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    return mobileNumber;
}

- (int)getLength:(NSString *)mobileNumber
{
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    int length = (int)[mobileNumber length];
    
    return length;
}

- (int)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (int)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_countries count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_countries objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.textViewCountryCode.text = [_countries objectAtIndex:row];
}

-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.txtDateOfBirth.inputView;
    //self.txtDateOfBirth.text = [NSString stringWithFormat:@"%@",picker.date];
    self.txtDateOfBirth.text = [self formatDate:picker.date];
}

- (NSString *)formatDate:(NSDate *)date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd-MMM-yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    _activeTxtView = textView;
    if([textView.text isEqualToString:@"First Name"]||[textView.text isEqualToString:@"Last Name"]||[textView.text isEqualToString:@"Date of Birth"]||[textView.text isEqualToString:@"Mobile/Cell"]||[textView.text isEqualToString:@"Email"]||[textView.text isEqualToString:@"Username"]||[textView.text isEqualToString:@"Password"]||[textView.text isEqualToString:@"Country Code"]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    else{
        textView.textColor = [UIColor blackColor];
        
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if([textView.text isEqualToString:@""])
    {
        if (textView.tag ==101) {
            textView.text = @"First Name";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==102) {
            textView.text = @"Last Name";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==103) {
            textView.text = @"Date of Birth";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==104) {
            textView.text = @"Email";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==105) {
            textView.text = @"Mobile/Cell";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==106) {
            textView.text = @"Username";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==107) {
            textView.text = @"Password";
            textView.textColor = [UIColor lightGrayColor];
            textView.secureTextEntry = YES;
            textView.clipsToBounds = YES;
            
        }
        if (textView.tag ==108) {
            textView.text = @"Country Code";
            textView.textColor = [UIColor lightGrayColor];
            textView.secureTextEntry = YES;
            textView.clipsToBounds = YES;
            
        }
    }
}

-(void)dismissKeyboard {
    [_textViewFirstName resignFirstResponder];
    [_textViewLastName resignFirstResponder];
    [_txtDateOfBirth resignFirstResponder];
    [_textViewEmail resignFirstResponder];
    [_textViewUsername resignFirstResponder];
    [_textViewPhone resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_textViewCountryCode resignFirstResponder];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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







#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

//-(BOOL)textFieldShouldReturn:(UITextField *)textField {
////    
////    [_txtTelephoneNumber resignFirstResponder];
////    [_txtPassword resignFirstResponder];
////    [_txtUsername resignFirstResponder];
////    [_txtFirstName resignFirstResponder];
////    [_txtLastName resignFirstResponder];
////    [_txtEmail resignFirstResponder];
//    return YES;
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)nextRegister:(id)sender{
    if (_textViewFirstName.text && _textViewFirstName.text.length > 0 && _textViewLastName.text && _textViewLastName.text.length > 0 && _txtDateOfBirth.text && _txtDateOfBirth.text.length > 0 && _textViewEmail.text && _textViewEmail.text.length > 0 && _textViewUsername.text && _textViewUsername.text.length > 0 && _textViewPhone.text && _textViewPhone.text.length > 0 && _txtPassword.text && _txtPassword.text.length > 0 && _textViewCountryCode.text && _textViewCountryCode.text.length > 0)
    {
        if ([self NSStringIsValidEmail:_textViewEmail.text]) {
        
            [[FIRAuth auth]
             createUserWithEmail:_textViewEmail.text
             password:_txtPassword.text
             completion:^(FIRUser *_Nullable user,
                          NSError *_Nullable error) {
                 if (user) {
                     FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
                     [[[_ref child:@"users"] child:user.uid]
                      setValue:@{@"id": user.uid,
                                 @"first_name": _textViewFirstName.text,
                                 @"last_name": _textViewLastName.text,
                                 @"username": _textViewUsername.text,
                                 @"email": _textViewEmail.text,
                                 @"password": _txtPassword.text,
                                 @"birth_date": _txtDateOfBirth.text,
                                 @"mobile_phone": _textViewPhone.text,
                                 @"reviews": @[
                                         ]}];
                     
                     [FDKeychain saveItem: @"YES"
                                   forKey: @"loggedin"
                               forService: @"ReviewApp"
                                    error: nil];
                     
                     [user getTokenWithCompletion:^(NSString *token, NSError *error) {
                         // token, if not nil, is an ID token, which you can safely send to a backend
                         [FDKeychain saveItem: token
                                       forKey: @"token"
                                   forService: @"ReviewApp"
                                        error: nil];
                         [self performSegueWithIdentifier:@"NextRegister" sender:self];
                     }];
                     
                     
                 }
                 else
                 {
                     UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[error localizedDescription]
                                                                     message:[error localizedRecoverySuggestion]
                                                                    delegate:nil
                                                           cancelButtonTitle:@"OK"
                                                           otherButtonTitles:nil];
                     [alert show];
                 }
                 

//                 [[FIRAuth auth]
//                  .currentUser sendEmailVerificationWithCompletion:^(NSError *_Nullable error) {
//                      
//                  }];
             }];
            
            
            
            
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Valid Email"
                                                            message:@"Please add a valid Email address."
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
        }
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required Fields"
                                                        message:@"Please fill all the fileds."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    
    if ([segue.identifier isEqualToString:@"NextRegister"]) {
        
//        //        NSIndexPath *indexPaths = [self.tableView indexPathForSelectedRow];
//        Register2ViewController *register2ViewController = [segue destinationViewController];
//        register2ViewController.user = [[User alloc]init];
//        register2ViewController.user.firstName = _txtNombre.text;
//        register2ViewController.user.age = _txtEdad.text;
//        register2ViewController.user.gender = _txtSexo.text;
//        
//        NSLog(_txtNombre.text);
//        //        _selectedStation = [stationsArray objectAtIndex:indexPaths.row];
//        //        stationViewController.Station = _selectedStation;
//        //        [self.tableView deselectRowAtIndexPath:indexPaths animated:NO];
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
