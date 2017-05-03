//
//  RegisterSelectViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 4/30/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "RegisterSelectViewController.h"

@interface RegisterSelectViewController ()

@end

@implementation RegisterSelectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[_btnCustomer layer] setBorderWidth:1.0f];
    [[_btnCustomer layer] setBorderColor:self.view.tintColor.CGColor];
    _btnCustomer.layer.cornerRadius = 15.0f;
    
    [[_btnBusiness layer] setBorderWidth:1.0f];
    [[_btnBusiness layer] setBorderColor:self.view.tintColor.CGColor];
    _btnBusiness.layer.cornerRadius = 15.0f;
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
