//
//  SignInViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "SignInViewController.h"

@interface SignInViewController ()

@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[_txtPassword layer] setBorderWidth:1.0f];
    [[_txtPassword layer] setBorderColor:self.view.tintColor.CGColor];
    
    [[ _textViewUsername layer] setBorderWidth:1.0f];
    [[_textViewUsername layer] setBorderColor:self.view.tintColor.CGColor];
    
    _txtPassword.clipsToBounds = YES;
    _txtPassword.secureTextEntry = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _txtPassword.delegate = self;
    
    _textViewUsername.clipsToBounds = YES;
    //    _textViewComments.layer.cornerRadius = 10.0f;
    _textViewUsername.delegate = self;
}

-(IBAction)SignIn:(id)sender{
    if (_textViewUsername.text && _textViewUsername.text.length > 0 && _txtPassword.text && _txtPassword.text.length > 0)
    {
        if ([self NSStringIsValidEmail:_textViewUsername.text]) {
            [self performSegueWithIdentifier:@"callHome" sender:self];
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
                                                        message:@"Please fill all the fields."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
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
