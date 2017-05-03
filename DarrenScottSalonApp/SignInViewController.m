//
//  SignInViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "SignInViewController.h"
@import Firebase;
#import "FDKeychain.h"

@interface SignInViewController ()<UITextFieldDelegate>
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation SignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _ref = [[FIRDatabase database] reference];
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [_txtPassword resignFirstResponder];
    [_textViewUsername resignFirstResponder];
    
}

-(IBAction)SignIn:(id)sender{
    if (_textViewUsername.text && _textViewUsername.text.length > 0 && _txtPassword.text && _txtPassword.text.length > 0)
    {
        if ([self NSStringIsValidEmail:_textViewUsername.text]) {
            
            [[FIRAuth auth] signInWithEmail:_textViewUsername.text
                                   password:_txtPassword.text
                                 completion:^(FIRUser *user, NSError *error) {
                                     if (user) {
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
                                             [[[_ref child:@"users"] child:user.uid] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                                                 NSLog(@"%@",snapshot.value[@"user_type"]);
                                                 if ([snapshot.value[@"user_type"] isEqualToString:@"0"]) {
                                                     [FDKeychain saveItem: @"0"
                                                                   forKey: @"userType"
                                                               forService: @"ReviewApp"
                                                                    error: nil];
                                                     [self performSegueWithIdentifier:@"callHome" sender:self];
                                                     }
                                                 else{
                                                     [FDKeychain saveItem: @"1"
                                                                   forKey: @"userType"
                                                               forService: @"ReviewApp"
                                                                    error: nil];
                                                 [self performSegueWithIdentifier:@"callHomeBusiness" sender:self];
                                                 }
                                                 
//                                                 for ( FIRDataSnapshot *child in snapshot.children) {
//                                                     
//                                                     //  NSLog(@"child.value = %@",child.value[@"station_name"]);
//                                                     Review *rev = [[Review alloc]init];
//                                                     rev.what = child.value[@"what"];
//                                                     rev.where = child.value[@"where"];
//                                                     rev.who = child.value[@"who"];
//                                                     rev.why = child.value[@"why"];
//                                                     rev.with = child.value[@"with"];
//                                                     rev.comments = child.value[@"comments"];
//                                                     rev.date = child.value[@"date"];
//                                                     rev.categories = child.value[@"categories"];
//                                                     rev.photos = child.value[@"photos"];
//                                                     rev.rating = child.value[@"rating"];
//                                                     rev.address = child.value[@"address"];
//                                                     
//                                                     [reviewsArray addObject:rev];
//                                                     
//                                                     [self.tableView reloadData];
//                                                 }
                                                 
                                             } withCancelBlock:^(NSError * _Nonnull error) {
                                                 NSLog(@"%@", error.localizedDescription);
                                             }];

                                             
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
                                                        message:@"Please fill all the fields."
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
        
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    return YES;
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
