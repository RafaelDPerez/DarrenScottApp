//
//  User.h
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
@property (weak, nonatomic) NSString *userID;
@property (weak, nonatomic) NSString *first_name;
@property (weak, nonatomic) NSString *last_name;
@property (weak, nonatomic) NSString *username;
@property (weak, nonatomic) NSString *email;
@property (weak, nonatomic) NSString *password;
@property (weak, nonatomic) NSString *birth_date;
@property (weak, nonatomic) NSString *mobile_phone;
@property (weak, nonatomic) NSMutableArray *reviews;
@end
