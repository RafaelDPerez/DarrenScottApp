//
//  ReviewViewController.h
//  clic pic review
//
//  Created by Rafael Perez on 4/7/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"
#import "ASStarRatingView.h"

@interface ReviewViewController : UIViewController
@property(weak, nonatomic) Review *review;
@property (weak, nonatomic) IBOutlet UILabel *lblWhere;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;
@property (weak, nonatomic) IBOutlet UILabel *lblWhat;
@property (weak, nonatomic) IBOutlet UILabel *lblWhy;
@property (weak, nonatomic) IBOutlet UILabel *lblWho;
@property (weak, nonatomic) IBOutlet UILabel *lblWith;
@property (weak, nonatomic) IBOutlet UILabel *lblComments;
@property (weak, nonatomic) IBOutlet UIImageView *ivReviewPic;
@property (weak, nonatomic) IBOutlet ASStarRatingView *rating;

@end
