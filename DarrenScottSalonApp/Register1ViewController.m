//
//  Register1ViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "Register1ViewController.h"
#import "ACFloatingTextField.h"
#import "EAIntroView.h"

static NSString * const sampleDescription1 = @"Welcome to clic pic review (CPR), the new exciting app that allows you a fun and simple way to record, review and share your experiences with your friends and the world.";
static NSString * const sampleDescription2 = @"Use it as your personal diary or to promote and share your views on anything and everything.";
static NSString * const sampleDescription3 = @"We need your details in order to comply with various laws, update you with updates to the app and be able to contact you for secutiry issues such as password re-sets";
static NSString * const sampleDescription4 = @"Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit.";


@interface Register1ViewController ()<UITextFieldDelegate,EAIntroDelegate> {
    UIView *rootView;
    EAIntroView *_intro;
}



@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    rootView = self.navigationController.view;
    [self showIntroWithCrossDissolve];
    [[_textViewFirstName layer] setBorderWidth:1.0f];
    [[_textViewFirstName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewLastName layer] setBorderWidth:1.0f];
    [[_textViewLastName layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewDateOfBirth layer] setBorderWidth:1.0f];
    [[_textViewDateOfBirth layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewEmail layer] setBorderWidth:1.0f];
    [[_textViewEmail layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewPhone layer] setBorderWidth:1.0f];
    [[_textViewPhone layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewUsername layer] setBorderWidth:1.0f];
    [[_textViewUsername layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[_textViewPassword layer] setBorderWidth:1.0f];
    [[_textViewPassword layer] setBorderColor:self.view.tintColor.CGColor];
    
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
    
    _textViewDateOfBirth.text = @"Date of Birth";
    _textViewDateOfBirth.textColor = [UIColor lightGrayColor];
    _textViewDateOfBirth.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewDateOfBirth.delegate = self;
    
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
    
    _textViewUsername.text = @"Username";
    _textViewUsername.textColor = [UIColor lightGrayColor];
    _textViewUsername.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewUsername.delegate = self;
    
    _textViewPassword.text = @"Password";
    _textViewPassword.textColor = [UIColor lightGrayColor];
    _textViewPassword.clipsToBounds = YES;
    _textViewPassword.secureTextEntry = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewPassword.delegate = self;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];

    
    
    //    [_txtFirstName setTextFieldPlaceholderText:@"First Name"];
//    _txtFirstName.selectedLineColor = [UIColor blackColor];
//    _txtFirstName.placeHolderColor = [UIColor blackColor];
//    [_txtFirstName setTextColor:[UIColor blackColor]];
//    _txtFirstName.selectedPlaceHolderColor = [UIColor blackColor];
//    _txtFirstName.lineColor = [UIColor blackColor];
//    
//    [_txtLastName setTextFieldPlaceholderText:@"Last Name"];
//    _txtLastName.selectedLineColor = [UIColor blackColor];
//    _txtLastName.placeHolderColor = [UIColor blackColor];
//    [_txtLastName setTextColor:[UIColor blackColor]];
//    _txtLastName.selectedPlaceHolderColor = [UIColor blackColor];
//    _txtLastName.lineColor = [UIColor blackColor];
//    
//    [_txtUsername setTextFieldPlaceholderText:@"Username"];
//    _txtUsername.selectedLineColor = [UIColor blackColor];
//    _txtUsername.placeHolderColor = [UIColor blackColor];
//    [_txtUsername setTextColor:[UIColor blackColor]];
//    _txtUsername.selectedPlaceHolderColor = [UIColor blackColor];
//    _txtUsername.lineColor = [UIColor blackColor];
//    
//    [_txtEmail setTextFieldPlaceholderText:@"Email"];
//    _txtEmail.selectedLineColor = [UIColor blackColor];
//    _txtEmail.placeHolderColor = [UIColor blackColor];
//    [_txtEmail setTextColor:[UIColor blackColor]];
//    _txtEmail.selectedPlaceHolderColor = [UIColor blackColor];
//    _txtEmail.lineColor = [UIColor blackColor];
//    
//    [_txtPassword setTextFieldPlaceholderText:@"Password"];
//    _txtPassword.selectedLineColor = [UIColor blackColor];
//    _txtPassword.placeHolderColor = [UIColor blackColor];
//    [_txtPassword setTextColor:[UIColor blackColor]];
//    _txtPassword.selectedPlaceHolderColor = [UIColor blackColor];
//    _txtPassword.lineColor = [UIColor blackColor];
//    
//    [_txtTelephoneNumber setTextFieldPlaceholderText:@"Telephone Number"];
//    _txtTelephoneNumber.selectedLineColor = [UIColor blackColor];
//    _txtTelephoneNumber.placeHolderColor = [UIColor blackColor];
//    [_txtTelephoneNumber setTextColor:[UIColor blackColor]];
//    _txtTelephoneNumber.selectedPlaceHolderColor = [UIColor blackColor];
//    _txtTelephoneNumber.lineColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}


- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"First Name"]||[textView.text isEqualToString:@"Last Name"]||[textView.text isEqualToString:@"Date of Birth"]||[textView.text isEqualToString:@"Mobile/Cell"]||[textView.text isEqualToString:@"Email"]||[textView.text isEqualToString:@"Username"]||[textView.text isEqualToString:@"Password"]){
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
    }
}

-(void)dismissKeyboard {
    [_textViewFirstName resignFirstResponder];
    [_textViewLastName resignFirstResponder];
    [_textViewDateOfBirth resignFirstResponder];
    [_textViewEmail resignFirstResponder];
    [_textViewUsername resignFirstResponder];
    [_textViewPhone resignFirstResponder];
    [_textViewPassword resignFirstResponder];
    
}


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark - Demo

- (void)showIntroWithCrossDissolve {
    EAIntroPage *page1 = [EAIntroPage page];
    page1.title = @"Welcome";
    page1.desc = sampleDescription1;
    page1.bgImage = [UIImage imageNamed:@"bg1"];
    page1.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img1"]];
    
    EAIntroPage *page2 = [EAIntroPage page];
    page2.title = @"";
    page2.desc = sampleDescription2;
    page2.bgImage = [UIImage imageNamed:@"bg2"];
    page2.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img2"]];
    
    EAIntroPage *page3 = [EAIntroPage page];
    page3.title = @"Sign in!";
    page3.desc = sampleDescription3;
    page3.bgImage = [UIImage imageNamed:@"bg3"];
    page3.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img3"]];
    
    EAIntroPage *page4 = [EAIntroPage page];
    page4.title = @"This is page 4";
    page4.desc = sampleDescription4;
    page4.bgImage = [UIImage imageNamed:@"bg4"];
    page4.titleIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"img4"]];
    
    EAIntroView *intro = [[EAIntroView alloc] initWithFrame:rootView.bounds andPages:@[page1,page2,page3,page4]];
    intro.skipButtonAlignment = EAViewAlignmentCenter;
    intro.skipButtonY = 80.f;
    intro.pageControlY = 42.f;
    
    [intro setDelegate:self];
    
    [intro showInView:rootView animateDuration:0.3];
}

#pragma mark - EAIntroView delegate

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    if(wasSkipped) {
        NSLog(@"Intro skipped");
    } else {
        NSLog(@"Intro finished");
    }
}

#pragma mark - Custom actions

- (IBAction)switchFlip:(id)sender {
    UISwitch *switchControl = (UISwitch *) sender;
    NSLog(@"%@", switchControl.on ? @"On" : @"Off");
    
    // limit scrolling on one, currently visible page (can't go previous or next page)
    //[_intro setScrollingEnabled:switchControl.on];
    
    if(!switchControl.on) {
        // scroll no further selected page (can go previous pages, but not next)
        _intro.limitPageIndex = _intro.visiblePageIndex;
    } else {
        [_intro setScrollingEnabled:YES];
    }
}


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
    if (_textViewFirstName.text && _textViewFirstName.text.length > 0 && _textViewLastName.text && _textViewLastName.text.length > 0 && _textViewDateOfBirth.text && _textViewDateOfBirth.text.length > 0 && _textViewEmail.text && _textViewEmail.text.length > 0 && _textViewUsername.text && _textViewUsername.text.length > 0 && _textViewPhone.text && _textViewPhone.text.length > 0 && _textViewPassword.text && _textViewPassword.text.length > 0)
    {
        
        [self performSegueWithIdentifier:@"NextRegister" sender:self];
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
