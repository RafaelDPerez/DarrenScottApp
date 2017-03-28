//
//  ReviewsTableViewCell.h
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASStarRatingView.h"

@interface ReviewsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblWhen;
@property (weak, nonatomic) IBOutlet UILabel *lblWhat;
@property (weak, nonatomic) IBOutlet UILabel *lblWhere;
@property (weak, nonatomic) IBOutlet ASStarRatingView *rating;

@end
