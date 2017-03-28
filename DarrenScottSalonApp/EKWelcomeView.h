//
//  EKWelcomeView.h
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EKDismissWelcomeScreenDelegate <NSObject>

- (void)dismissWelcomeScreen;
-(void)goToLogIn;

@end


@interface EKWelcomeView : UIView

@property (nonatomic, unsafe_unretained) id <EKDismissWelcomeScreenDelegate> delegate;

- (void)goNext;
- (void)goNext2;
@end
