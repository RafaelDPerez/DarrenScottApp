//
//  ReviewViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 4/7/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "ReviewViewController.h"
#import "SDWebImage/UIImageView+WebCache.h"
@interface ReviewViewController ()

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _lblWhere.text = self.review.where;
    _lblAddress.text = self.review.address;
    _lblWhat.text = self.review.what;
    _lblWho.text = self.review.who;
    _lblWhy.text = self.review.why;
    _lblWith.text = self.review.with;
    _lblComments.text = self.review.comments;
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:@selector(handleBack:)];
    
    [backButton setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:@"Syncopate-Bold" size:10.0], NSFontAttributeName,
                                       [UIColor blackColor], NSForegroundColorAttributeName,
                                       nil] 
forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor blackColor];
    
    
    float ratingFloat = [self.review.rating floatValue];
    NSString *url = [self.review.photos objectAtIndex:0];
    [_ivReviewPic sd_setImageWithURL:[NSURL URLWithString:url]
                  placeholderImage:[UIImage imageNamed:@"Garage-50"]];
    [_rating setRating:ratingFloat];
    _rating.canEdit = NO;
}


- (void)handleBack:(id)sender {
    // pop to root view controller
    [self.navigationController popToRootViewControllerAnimated:YES];
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
