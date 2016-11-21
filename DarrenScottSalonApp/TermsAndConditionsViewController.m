//
//  TermsAndConditionsViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 11/20/16.
//  Copyright © 2016 maranta. All rights reserved.
//

#import "TermsAndConditionsViewController.h"

@interface TermsAndConditionsViewController ()

@end

@implementation TermsAndConditionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TermsAccepted"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)AcceptTerms:(id)sender{
[[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"TermsAccepted"];
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
