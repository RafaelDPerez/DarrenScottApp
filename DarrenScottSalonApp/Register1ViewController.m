//
//  Register1ViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "Register1ViewController.h"
#import "ACFloatingTextField.h"

@interface Register1ViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtFirstName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtLastName;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtUsername;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtPassword;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtTelephoneNumber;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;


@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_txtFirstName setTextFieldPlaceholderText:@"First Name"];
    _txtFirstName.selectedLineColor = [UIColor blackColor];
    _txtFirstName.placeHolderColor = [UIColor blackColor];
    [_txtFirstName setTextColor:[UIColor blackColor]];
    _txtFirstName.selectedPlaceHolderColor = [UIColor blackColor];
    _txtFirstName.lineColor = [UIColor blackColor];
    
    [_txtLastName setTextFieldPlaceholderText:@"Last Name"];
    _txtLastName.selectedLineColor = [UIColor blackColor];
    _txtLastName.placeHolderColor = [UIColor blackColor];
    [_txtLastName setTextColor:[UIColor blackColor]];
    _txtLastName.selectedPlaceHolderColor = [UIColor blackColor];
    _txtLastName.lineColor = [UIColor blackColor];
    
    [_txtUsername setTextFieldPlaceholderText:@"Username"];
    _txtUsername.selectedLineColor = [UIColor blackColor];
    _txtUsername.placeHolderColor = [UIColor blackColor];
    [_txtUsername setTextColor:[UIColor blackColor]];
    _txtUsername.selectedPlaceHolderColor = [UIColor blackColor];
    _txtUsername.lineColor = [UIColor blackColor];
    
    [_txtEmail setTextFieldPlaceholderText:@"Email"];
    _txtEmail.selectedLineColor = [UIColor blackColor];
    _txtEmail.placeHolderColor = [UIColor blackColor];
    [_txtEmail setTextColor:[UIColor blackColor]];
    _txtEmail.selectedPlaceHolderColor = [UIColor blackColor];
    _txtEmail.lineColor = [UIColor blackColor];
    
    [_txtPassword setTextFieldPlaceholderText:@"Password"];
    _txtPassword.selectedLineColor = [UIColor blackColor];
    _txtPassword.placeHolderColor = [UIColor blackColor];
    [_txtPassword setTextColor:[UIColor blackColor]];
    _txtPassword.selectedPlaceHolderColor = [UIColor blackColor];
    _txtPassword.lineColor = [UIColor blackColor];
    
    [_txtTelephoneNumber setTextFieldPlaceholderText:@"Telephone Number"];
    _txtTelephoneNumber.selectedLineColor = [UIColor blackColor];
    _txtTelephoneNumber.placeHolderColor = [UIColor blackColor];
    [_txtTelephoneNumber setTextColor:[UIColor blackColor]];
    _txtTelephoneNumber.selectedPlaceHolderColor = [UIColor blackColor];
    _txtTelephoneNumber.lineColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}
#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_txtTelephoneNumber resignFirstResponder];
    [_txtPassword resignFirstResponder];
    [_txtUsername resignFirstResponder];
    [_txtFirstName resignFirstResponder];
    [_txtLastName resignFirstResponder];
    [_txtEmail resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)nextRegister:(id)sender{
    if (_txtFirstName.text && _txtFirstName.text.length > 0 && _txtLastName.text && _txtLastName.text.length > 0 && _txtUsername.text && _txtUsername.text.length > 0 && _txtEmail.text && _txtEmail.text.length > 0 && _txtPassword.text && _txtPassword.text.length > 0 && _txtTelephoneNumber.text && _txtTelephoneNumber.text.length > 0)
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
