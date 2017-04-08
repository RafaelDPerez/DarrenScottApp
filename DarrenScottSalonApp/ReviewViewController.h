//
//  ReviewViewController.h
//  clic pic review
//
//  Created by Rafael Perez on 4/7/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Review.h"

@interface ReviewViewController : UIViewController
@property(weak, nonatomic) Review *review;
@property (weak, nonatomic) IBOutlet UILabel *lblWhere;
@property (weak, nonatomic) IBOutlet UILabel *lblAddress;

@end
