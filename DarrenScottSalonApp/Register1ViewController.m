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
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtNombre;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEdad;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtSexo;
@property (weak, nonatomic) IBOutlet ACFloatingTextField *txtEmail;


@end

@implementation Register1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_txtNombre setTextFieldPlaceholderText:@"First Name"];
    _txtNombre.selectedLineColor = [UIColor blackColor];
    _txtNombre.placeHolderColor = [UIColor blackColor];
    [_txtNombre setTextColor:[UIColor blackColor]];
    _txtNombre.selectedPlaceHolderColor = [UIColor blackColor];
    _txtNombre.lineColor = [UIColor blackColor];
    
    [_txtEdad setTextFieldPlaceholderText:@"Last Name"];
    _txtEdad.selectedLineColor = [UIColor blackColor];
    _txtEdad.placeHolderColor = [UIColor blackColor];
    [_txtEdad setTextColor:[UIColor blackColor]];
    _txtEdad.selectedPlaceHolderColor = [UIColor blackColor];
    _txtEdad.lineColor = [UIColor blackColor];
    
    [_txtSexo setTextFieldPlaceholderText:@"Date of Birth"];
    _txtSexo.selectedLineColor = [UIColor blackColor];
    _txtSexo.placeHolderColor = [UIColor blackColor];
    [_txtSexo setTextColor:[UIColor blackColor]];
    _txtSexo.selectedPlaceHolderColor = [UIColor blackColor];
    _txtSexo.lineColor = [UIColor blackColor];
    
    [_txtEmail setTextFieldPlaceholderText:@"Email Address"];
    _txtEmail.selectedLineColor = [UIColor blackColor];
    _txtEmail.placeHolderColor = [UIColor blackColor];
    [_txtEmail setTextColor:[UIColor blackColor]];
    _txtEmail.selectedPlaceHolderColor = [UIColor blackColor];
    _txtEmail.lineColor = [UIColor blackColor];
    // Do any additional setup after loading the view.
}
#pragma mark  UITextfield Delegates
-(void)textFieldDidBeginEditing:(UITextField *)textField {
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField {
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [_txtNombre resignFirstResponder];
    [_txtEdad resignFirstResponder];
    [_txtSexo resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)nextRegister:(id)sender{
    if (_txtNombre.text && _txtNombre.text.length > 0 && _txtSexo.text && _txtSexo.text.length > 0 &&_txtEdad.text && _txtEdad.text.length > 0  )
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
