//
//  Register2ViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "Register2ViewController.h"


@interface Register2ViewController ()


@end

@implementation Register2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)RegisterUser:(id)sender{
[self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
    //
//    if (_txtEmail.text && _txtEmail.text.length > 0 && _txtMobile.text && _txtMobile.text.length > 0 &&_txtPassword.text && _txtPassword.text.length > 0 && _txtConfirmPassword.text && _txtConfirmPassword.text.length > 0 )
//    {
//        
////        self.user.password = _txtPassword.text;
////        self.user.passwordConfirm = _txtConfirmPassword.text;
////        self.user.phone1 = _txtMobile.text;
////        self.user.email = _txtEmail.text;
////        NSLog(@"%@ - %@ -%@ -%@ -%@ -%@ -%@",self.user.password, self.user.passwordConfirm, self.user.gender, self.user.email, self.user.firstName, self.user.age, self.user.phone1);
//        [self performSegueWithIdentifier:@"RegisterCompleted" sender:self];
//    }
//    else {
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Required Fields"
//                                                        message:@"Please fill all the fileds."
//                                                       delegate:nil
//                                              cancelButtonTitle:@"OK"
//                                              otherButtonTitles:nil];
//        [alert show];
//        [alert show];
//        
//    }
    
    
    
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