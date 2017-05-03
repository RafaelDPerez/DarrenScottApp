//
//  RegisterBusinessViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 4/30/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "RegisterBusinessViewController.h"
#import "ACFloatingTextField.h"
#import "FDKeychain.h"
#import "Country.h"
@import Firebase;
#import "RMPhoneFormat.h"
#import <GooglePlaces/GooglePlaces.h>

@interface RegisterBusinessViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;
@property (weak, nonatomic) UITextView *activeTxtView;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (strong, nonatomic) NSMutableArray *countries;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSString *PlaceAddress;
@end

@implementation RegisterBusinessViewController{
    UIView *rootView;
}
@synthesize btnBack;


- (void)viewDidLoad {
    [super viewDidLoad];
    self.ref = [[FIRDatabase database] reference];
    btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(goBack:)];
    [btnBack setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                     [UIFont fontWithName:@"Syncopate" size:14.0], NSFontAttributeName,
                                     [UIColor blackColor], NSForegroundColorAttributeName,
                                     nil]
                           forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = btnBack;
    // Do any additional setup after loading the view.
    [[_textViewFirstName layer] setBorderWidth:1.0f];
    [[_textViewFirstName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewLastName layer] setBorderWidth:1.0f];
    [[_textViewLastName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewCompanyName layer] setBorderWidth:1.0f];
    [[_textViewCompanyName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewEmail layer] setBorderWidth:1.0f];
    [[_textViewEmail layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewPlace layer] setBorderWidth:1.0f];
    [[_textViewPlace layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewCategory layer] setBorderWidth:1.0f];
    [[_textViewCategory layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewPhone layer] setBorderWidth:1.0f];
    [[_textViewPhone layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textPosition layer] setBorderWidth:1.0f];
    [[_textPosition layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewCountryCode layer] setBorderWidth:1.0f];
    [[_textViewCountryCode layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_txtPassword layer] setBorderWidth:1.0f];
    [[_txtPassword layer] setBorderColor:self.view.tintColor.CGColor];
    
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
    
    _textViewEmail.text = @"Email";
    _textViewEmail.textColor = [UIColor lightGrayColor];
    _textViewEmail.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewEmail.delegate = self;
    
    _textViewPhone.text = @"Contact Phone";
    _textViewPhone.textColor = [UIColor lightGrayColor];
    _textViewPhone.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewPhone.delegate = self;
    
    _textViewCountryCode.text = @"Country Code";
    _textViewCountryCode.textColor = [UIColor lightGrayColor];
    _textViewCountryCode.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewCountryCode.delegate = self;
    
    _textViewCategory.text = @"Category";
    _textViewCategory.textColor = [UIColor lightGrayColor];
    _textViewCategory.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewCategory.delegate = self;
    
    _textViewPlace.text = @"Search Company";
    _textViewPlace.textColor = [UIColor lightGrayColor];
    _textViewPlace.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewPlace.delegate = self;
    
    _textViewCompanyName.text = @"Company Name";
    _textViewCompanyName.textColor = [UIColor lightGrayColor];
    _textViewCompanyName.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewCompanyName.delegate = self;
    
    _textPosition.text = @"Company Position";
    _textPosition.textColor = [UIColor lightGrayColor];
    _textPosition.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textPosition.delegate = self;
    
    
    
    
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
        Country *countryAdded = [[Country alloc]init];
        NSString *identifier = [NSLocale localeIdentifierFromComponents: [NSDictionary dictionaryWithObject: countryCode forKey: NSLocaleCountryCode]];
        NSString *country = [[NSLocale currentLocale] displayNameForKey: NSLocaleIdentifier value: identifier];
        countryAdded.countryCode = countryCode;
        countryAdded.countryName = country;
        [_countries addObject:countryAdded];
    }
    
    //_countries = [NSLocale ISOCountryCodes];
    
    //sortedCountries = [countries sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    // Do any additional setup after loading the view, typically from a nib.
    self.pickerView = [[UIPickerView alloc] init];
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    self.pickerView.showsSelectionIndicator = YES;
    self.textViewCountryCode.inputView = self.pickerView;
    //     [self.pickerView addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    
    [self registerForKeyboardNotifications];


}

-(IBAction)goBack:(id)sender{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Welcome"];
    [self presentViewController:vc animated:YES completion:nil];
}


-(void)viewDidAppear:(BOOL)animated{
    
    [_scrollview setContentOffset:CGPointZero animated:YES];
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
        
        
        // NSString *formattedNumber = [fmt format:numberString];
        //        int length = (int)[self getLength:textView.text];
        //        //NSLog(@"Length  =  %d ",length);
        //
        //        if(length == 10)
        //        {
        //            if(range.length == 0)
        //                return NO;
        //        }
        //
        //        if(length == 3)
        //        {
        //            NSString *num = [self formatNumber:textView.text];
        //            textView.text = [NSString stringWithFormat:@"(%@) ",num];
        //
        //            if(range.length > 0)
        //                textView.text = [NSString stringWithFormat:@"%@",[num substringToIndex:3]];
        //        }
        //        else if(length == 6)
        //        {
        //            NSString *num = [self formatNumber:textView.text];
        //            //NSLog(@"%@",[num  substringToIndex:3]);
        //            //NSLog(@"%@",[num substringFromIndex:3]);
        //            textView.text = [NSString stringWithFormat:@"(%@) %@-",[num  substringToIndex:3],[num substringFromIndex:3]];
        //
        //            if(range.length > 0)
        //                textView.text = [NSString stringWithFormat:@"(%@) %@",[num substringToIndex:3],[num substringFromIndex:3]];
        //        }
    }
    
    
    return YES;
}




- (NSString *)formatNumber:(NSString *)mobileNumber
{
    //    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    //    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    //    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    //    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    //    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    //
    //    NSLog(@"%@", mobileNumber);
    //
    //    int length = (int)[mobileNumber length];
    //    if(length > 10)
    //    {
    //        mobileNumber = [mobileNumber substringFromIndex: length-10];
    //        NSLog(@"%@", mobileNumber);
    //
    //    }
    RMPhoneFormat *fmt = [[RMPhoneFormat alloc] init];
    NSString *formattedNumber = [fmt format:mobileNumber];
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
    Country *countryShown = [[Country alloc]init];
    countryShown = [_countries objectAtIndex:row];
    return [NSString stringWithFormat:@"%@ - %@",countryShown.countryCode, countryShown.countryName];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    RMPhoneFormat *fmt = [RMPhoneFormat instance];
    
    // based on current Region Format (locale)
    Country *countryShown = [[Country alloc]init];
    countryShown = [_countries objectAtIndex:row];
    self.textViewCountryCode.text = [NSString stringWithFormat:@"%@ - %@",countryShown.countryCode, countryShown.countryName];
    NSString *callingCode = [fmt callingCodeForCountryCode:countryShown.countryCode]; // Australia - returns 61
    NSString *defaultCallingCode = [fmt defaultCallingCode];
    self.textViewPhone.textColor = [UIColor blackColor];
    self.textViewPhone.text = [NSString stringWithFormat:@"%@",callingCode];
    NSLog(@"%@",countryShown.countryCode);
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
    if (textView==_textViewPlace) {
        [self checkIn];
    }
    _activeTxtView = textView;
    if([textView.text isEqualToString:@"First Name"]||[textView.text isEqualToString:@"Last Name"]|| [textView.text isEqualToString:@"Search Company"]||[textView.text isEqualToString:@"Category"]||[textView.text isEqualToString:@"Company Name"]||[textView.text isEqualToString:@"Contact Phone"]||[textView.text isEqualToString:@"Email"]||[textView.text isEqualToString:@"COmpany Position"]||[textView.text isEqualToString:@"Password"]||[textView.text isEqualToString:@"Country Code"] ||[textView.text isEqualToString:@"Company Position"]){
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
    [_textViewPlace resignFirstResponder];
    _textViewPlace.textColor = [UIColor blackColor];
    _textViewPlace.text = place.name;
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



- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView == _textViewPhone) {
        RMPhoneFormat *fmt = [[RMPhoneFormat alloc] init];
        NSString *formattedNumber = [fmt format:textView.text];
        textView.text = formattedNumber;
    }
    
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
            textView.text = @"Company Name";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==104) {
            textView.text = @"Search Company";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==105) {
            textView.text = @"Category";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==106) {
            textView.text = @"Country Code";
            textView.textColor = [UIColor lightGrayColor];
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==107) {
            textView.text = @"Contact Phone";
            textView.textColor = [UIColor lightGrayColor];
            textView.secureTextEntry = YES;
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==108) {
            textView.text = @"Company Position";
            textView.textColor = [UIColor lightGrayColor];
            textView.secureTextEntry = YES;
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==109) {
            textView.text = @"Email";
            textView.textColor = [UIColor lightGrayColor];
            textView.secureTextEntry = YES;
            textView.clipsToBounds = YES;
        }
        if (textView.tag ==110) {
            textView.text = @"Password";
            textView.textColor = [UIColor lightGrayColor];
            textView.secureTextEntry = YES;
            textView.clipsToBounds = YES;
        }
    }
}

-(void)dismissKeyboard {
    [_textViewFirstName resignFirstResponder];
    [_textViewLastName resignFirstResponder];
    [_textViewCompanyName resignFirstResponder];
    [_textViewPlace resignFirstResponder];
    [_textViewCategory resignFirstResponder];
    [_textViewEmail resignFirstResponder];
    [_textPosition resignFirstResponder];
    [_textViewPhone resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_textViewCountryCode resignFirstResponder];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

-(IBAction)nextRegister:(id)sender{
    if (_textViewFirstName.text && _textViewFirstName.text.length > 0 && _textViewLastName.text && _textViewLastName.text.length > 0 && _textViewPlace.text && _textViewPlace.text.length > 0 && _textViewEmail.text && _textViewEmail.text.length > 0 && _textViewCategory.text && _textViewCategory.text.length > 0 && _textViewPhone.text && _textViewPhone.text.length > 0 && _txtPassword.text && _txtPassword.text.length > 0 && _textViewCountryCode.text && _textViewCountryCode.text.length > 0 && _textViewCompanyName.text && _textViewCompanyName.text.length > 0 && _textPosition.text && _textPosition.text.length > 0)
    {
        if ([self NSStringIsValidEmail:_textViewEmail.text]) {
            
            [[FIRAuth auth]
             createUserWithEmail:_textViewEmail.text
             password:_txtPassword.text
             completion:^(FIRUser *_Nullable user,
                          NSError *_Nullable error) {
                 if (user) {
                     FIRDatabaseReference *rootRef= [[FIRDatabase database] reference];
                     [[[_ref child:@"business_users"] child:user.uid]
                      setValue:@{@"id": user.uid,
                                 @"first_name": _textViewFirstName.text,
                                 @"last_name": _textViewLastName.text,
                                 @"company_name": _textViewCompanyName.text,
                                 @"email": _textViewEmail.text,
                                 @"password": _txtPassword.text,
                                 @"company_position": _textPosition.text,
                                 @"contact_phone": _textViewPhone.text,
                                 @"company_search": _textViewPlace.text,
                                 @"company_address": _PlaceAddress,
                                 @"company_category": _textViewCategory.text
                                 }];
                     
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
                         [self performSegueWithIdentifier:@"NextRegisterBusiness" sender:self];
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
    
    
    if ([segue.identifier isEqualToString:@"NextRegisterBusiness"]) {
        
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



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
