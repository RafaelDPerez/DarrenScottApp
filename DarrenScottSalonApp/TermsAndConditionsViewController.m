//
//  TermsAndConditionsViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 11/20/16.
//  Copyright © 2016 maranta. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "NavigationViewController.h"
#import "ViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)AcceptConditions:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"YES" forKey:@"Terms"];
    if ([self.userType isEqualToString:@"0"]) {
        [self performSegueWithIdentifier:@"callHomeUser" sender:self];
    }
    else
        [self performSegueWithIdentifier:@"callHomeBusiness" sender:self];
    

}


-(IBAction)DeclineConditions:(id)sender{
    [[NSUserDefaults standardUserDefaults] setValue:@"NO" forKey:@"Terms"];
}


//- (IBAction)AcceptTerms:(id)sender{
//[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TermsAccepted"];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
