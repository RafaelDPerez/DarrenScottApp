//
//  ReviewsTableViewController.h
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ReviewsTableViewCell.h"
#import "Review.h"

@interface ReviewsTableViewController : UITableViewController
@property (strong, nonatomic) NSMutableArray *reviewsArray;
@property (weak, nonatomic) Review *reviewSelected;
@end
