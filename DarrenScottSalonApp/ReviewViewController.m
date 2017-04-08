//
//  ReviewViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 4/7/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lblWhere.text = self.review.where;
    _lblAddress.text = self.review.address;
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
