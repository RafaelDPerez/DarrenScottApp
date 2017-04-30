//
//  EKSecondHintView.m
//  EKWelcomeView
//
//  Created by EvgenyKarkan on 09.08.13.
//  Copyright (c) 2013 EvgenyKarkan. All rights reserved.
//


#import "EKSecondHintView.h"
#import "EKWelcomeView.h"

@interface EKSecondHintView ()
@property (nonatomic, strong) UILabel *hint;
@property (nonatomic, strong) UILabel *hint2;
@property (nonatomic, strong) UIImageView *img1;
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UIButton *btn2;
@end
@implementation EKSecondHintView



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
    }
    
    self.hint = [[UILabel alloc] init];
    self.hint.backgroundColor = [UIColor clearColor];
    self.hint.textAlignment = NSTextAlignmentCenter;
    self.hint.numberOfLines = 5;
    self.hint.font = [UIFont fontWithName:@"Syncopate" size:10];
    self.hint.text = @"Use it as your personal diary using the calendar functinos found in the top right if the main screen once you've registered. Then when you're asked what did you do on the weekend, you can tell and show them where, who, what, why, with and write about your overall experience";
    self.hint.textColor = [UIColor blackColor];
    [self addSubview:self.hint];
    
    self.hint2 = [[UILabel alloc] init];
    self.hint2.backgroundColor = [UIColor clearColor];
    self.hint2.textAlignment = NSTextAlignmentCenter;
    self.hint2.numberOfLines = 5;
    self.hint2.font = [UIFont fontWithName:@"Syncopate" size:10];
    self.hint2.text = @"Promote and share your veiws on anything and everything";
    self.hint2.textColor = [UIColor blackColor];
    [self addSubview:self.hint2];
    
    self.btn = [[UIButton alloc]init];
    [self.btn setTitle:@"New? Start now!" forState:UIControlStateNormal];
    [self.btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    self.btn2 = [[UIButton alloc]init];
    [self.btn2 setTitle:@"Log In" forState:UIControlStateNormal];
    [self.btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //self.btn.titleLabel.tintColor = [UIColor blackColor];
    
    [[self.btn layer] setBorderWidth:1.0f];
    [[self.btn layer] setBorderColor:self.tintColor.CGColor];
    self.btn.layer.cornerRadius = 15.0f;
    self.btn.backgroundColor = [UIColor clearColor];
    [self.btn addTarget:self action:@selector(goNext) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn];
    
    [[self.btn2 layer] setBorderWidth:1.0f];
    [[self.btn2 layer] setBorderColor:self.tintColor.CGColor];
    self.btn2.layer.cornerRadius = 15.0f;
    self.btn2.backgroundColor = [UIColor clearColor];
    [self.btn2 addTarget:self action:@selector(goNext2) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.btn2];
    
    
    
    self.img1 = [[UIImageView alloc]init];
    self.img1.image = [UIImage imageNamed:@"img1"];
    [self addSubview:self.img1];
    

    
    
    return self;
}

- (void)layoutSubviews
{
    self.hint.frame = CGRectMake(self.bounds.origin.x + 10.0f, self.bounds.origin.y + (self.bounds.size.height / 3.0f) + 30.0f, self.frame.size.width - 60.0f, self.bounds.size.height / 10.0f);
    
    self.hint2.frame = CGRectMake(self.bounds.origin.x + 20.0f, self.bounds.origin.y + (self.bounds.size.height / 3.0f) +115.0f, self.frame.size.width - 40.0f, self.bounds.size.height / 10.0f);
    
    
    self.img1.frame = CGRectMake(self.bounds.origin.x + 30.0f, self.bounds.origin.y + 30.0f, self.frame.size.width - 80.0f, self.bounds.size.height / 4.0f);
    
    self.btn.frame =  CGRectMake(self.bounds.size.width/2 -80.0f, self.bounds.origin.y + 450.0f, 150.0f, 40.0f);
    
    self.btn2.frame =  CGRectMake(self.bounds.size.width/2 -55.0f, self.bounds.origin.y + 500.0f, 100.0f, 40.0f);
    

    
    //    self.hint.frame = CGRectMake(0.0f, self.frame.origin.y + 40.0f, self.bounds.size.width, self.bounds.size.height - 90.0f);
    
}

- (void)goNext
{
    EKWelcomeView *hola = [[EKWelcomeView alloc]init];
    hola = self.superview.superview;
    
    //hola = (EKWelcomeView *)self.inputView;
    [hola goNext];
    
}

- (void)goNext2
{
    EKWelcomeView *hola = [[EKWelcomeView alloc]init];
    hola = self.superview.superview;
    
    //hola = (EKWelcomeView *)self.inputView;
    [hola goNext2];
    
}

@end
