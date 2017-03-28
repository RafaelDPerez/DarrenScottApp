//
//  Review.h
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Review : NSObject
@property (weak, nonatomic) NSString *reviewID;
@property (weak, nonatomic) NSString *date;
@property (weak, nonatomic) NSString *where;
@property (weak, nonatomic) NSString *who;
@property (weak, nonatomic) NSString *what;
@property (weak, nonatomic) NSString *with;
@property (weak, nonatomic) NSString *why;
@property (weak, nonatomic) NSString *comments;
@property (weak, nonatomic) NSMutableArray *photos;
@end
