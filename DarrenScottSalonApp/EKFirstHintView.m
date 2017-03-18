//
//  EKFirstHintView.m
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//

#import "EKFirstHintView.h"

@interface EKFirstHintView ()

@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UILabel *hint2;
@property (nonatomic, strong) UILabel *hint3;
@property (nonatomic, strong) UIImageView *img1;
@property (nonatomic, strong) UIImageView *img2;

@end


@implementation EKFirstHintView

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		//self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg1"]];

        self.backgroundColor = [UIColor whiteColor];

	}
	
	self.hint = [[UILabel alloc] init];
	self.hint.backgroundColor = [UIColor clearColor];
	self.hint.textAlignment = NSTextAlignmentCenter;
    self.hint.numberOfLines = 5;
    self.hint.font = [UIFont systemFontOfSize:10];
	self.hint.text = @"Welcome to clic pic review (CPR), the new exciting app that allows you a fun and simple way to record, review and share your experiences with your friends and the world.";
	self.hint.textColor = [UIColor blackColor];
	[self addSubview:self.hint];
    
    self.hint2 = [[UILabel alloc] init];
    self.hint2.backgroundColor = [UIColor clearColor];
    self.hint2.textAlignment = NSTextAlignmentCenter;
    self.hint2.numberOfLines = 5;
    self.hint2.font = [UIFont systemFontOfSize:10];
    self.hint2.text = @"Register your social media, and share with a swipe of the finger. CPR saves you time and helps you save, share and store your memories.";
    self.hint2.textColor = [UIColor blackColor];
    [self addSubview:self.hint2];
    
    self.hint3 = [[UILabel alloc] init];
    self.hint3.backgroundColor = [UIColor clearColor];
    self.hint3.textAlignment = NSTextAlignmentCenter;
    self.hint3.numberOfLines = 5;
    self.hint3.font = [UIFont systemFontOfSize:10];
    self.hint3.text = @"Start your adventure now with Clic Pic Review";
    self.hint3.textColor = [UIColor blackColor];
    [self addSubview:self.hint3];
    
    self.img1 = [[UIImageView alloc]init];
    self.img1.image = [UIImage imageNamed:@"img4"];
   [self addSubview:self.img1];
    
    self.img2 = [[UIImageView alloc]init];
    self.img2.image = [UIImage imageNamed:@"img1"];
    [self addSubview:self.img2];
    
    
	
	return self;
}

- (void)layoutSubviews
{
	self.hint.frame = CGRectMake(self.bounds.origin.x + 10.0f, self.bounds.origin.y + (self.bounds.size.height / 4.0f) +30.0f, self.frame.size.width - 40.0f, self.bounds.size.height / 10.0f);
    
    self.hint2.frame = CGRectMake(self.bounds.origin.x + 20.0f, self.bounds.origin.y + ((self.bounds.size.height / 3.0f)+55.0f), self.frame.size.width - 40.0f, self.bounds.size.height / 10.0f);
    
    self.hint3.frame = CGRectMake(self.bounds.origin.x + 20.0f, self.bounds.origin.y + ((self.bounds.size.height / 3.0f)+115.0f), self.frame.size.width - 40.0f, self.bounds.size.height / 10.0f);
    
    self.img1.frame = CGRectMake(self.bounds.origin.x + 30.0f, self.bounds.origin.y+30.0f, self.frame.size.width - 80.0f, self.bounds.size.height / 4.0f);
    
    self.img2.frame = CGRectMake(30.0f, self.bounds.origin.y + 350.0f, self.frame.size.width - 80.0f, self.bounds.size.height / 4.0f);
    
//    self.hint.frame = CGRectMake(0.0f, self.frame.origin.y + 40.0f, self.bounds.size.width, self.bounds.size.height - 90.0f);

}

@end
