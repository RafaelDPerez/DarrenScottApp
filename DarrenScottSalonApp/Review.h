//
//  Review.h
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject
@property (strong, nonatomic) NSString *reviewID;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *where;
@property (strong, nonatomic) NSString *who;
@property (strong, nonatomic) NSString *what;
@property (strong, nonatomic) NSString *with;
@property (strong, nonatomic) NSString *why;
@property (strong, nonatomic) NSString *comments;
@property (strong, nonatomic) NSMutableArray *photos;
@property (strong, nonatomic) NSString *categories;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *rating;
@end
