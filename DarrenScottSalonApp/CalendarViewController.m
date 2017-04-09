//
//  CalendarViewController.m
//  DarrenScottSalonApp
//
//  Created by Rafael Perez on 2/6/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "CalendarViewController.h"
@import Firebase;
@interface CalendarViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) FIRDatabaseReference *ref;
@end

@implementation CalendarViewController
@synthesize reviewsArray, reviewSelected;
-(UITableView *)makeTableView
{
    CGFloat x = 0;
    CGFloat y = 300;
    CGFloat width = self.view.frame.size.width;
    CGFloat height = self.view.frame.size.height - 300;
    CGRect tableFrame = CGRectMake(x, y, width, height);
    
    UITableView *tableView = [[UITableView alloc]initWithFrame:tableFrame style:UITableViewStylePlain];
    
    tableView.rowHeight = 45;
    tableView.sectionFooterHeight = 22;
    tableView.sectionHeaderHeight = 22;
    tableView.scrollEnabled = YES;
    tableView.showsVerticalScrollIndicator = YES;
    tableView.userInteractionEnabled = YES;
    tableView.bounces = YES;
    
    tableView.delegate = self;
    tableView.dataSource = self;
    
    return tableView;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.title = @"FSCalendar";
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    
    self.tableView = [self makeTableView];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"newFriendCell"];
    [self.view addSubview:self.tableView];
    


    
    [self.view addSubview:_hola];
    // 450 for iPad and 300 for iPhone
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0, 64, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.backgroundColor = [UIColor whiteColor];
    calendar.appearance.headerMinimumDissolvedAlpha = 0;
    calendar.appearance.caseOptions = FSCalendarCaseOptionsHeaderUsesUpperCase;
    [self.view addSubview:calendar];
    self.calendar = calendar;
    
    UIButton *previousButton = [UIButton buttonWithType:UIButtonTypeCustom];
    previousButton.frame = CGRectMake(0, 64+5, 95, 34);
    previousButton.backgroundColor = [UIColor whiteColor];
    previousButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [previousButton setImage:[UIImage imageNamed:@"icon_prev"] forState:UIControlStateNormal];
    [previousButton addTarget:self action:@selector(previousClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousButton];
    self.previousButton = previousButton;
    
    UIButton *nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nextButton.frame = CGRectMake(CGRectGetWidth(self.view.frame)-95, 64+5, 95, 34);
    nextButton.backgroundColor = [UIColor whiteColor];
    nextButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [nextButton setImage:[UIImage imageNamed:@"icon_next"] forState:UIControlStateNormal];
    [nextButton addTarget:self action:@selector(nextClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextButton];
    self.nextButton = nextButton;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"newFriendCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //etc.
    Review *review = [[Review alloc]init];
    review = [reviewsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@",review.where,review.date];
    cell.detailTextLabel.text = @"detalle";
    return cell;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //[self performSegueWithIdentifier:@"detailsView" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //I set the segue identifier in the interface builder
    if ([segue.identifier isEqualToString:@"detailsView"])
    {
        
        NSLog(@"segue"); //check to see if method is called, it is NOT called upon cell touch
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        ///more code to prepare next view controller....
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [reviewsArray count];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    reviewsArray = [[NSMutableArray alloc]init];
    self.ref = [[FIRDatabase database] reference];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    self.fillDefaultColors = [[NSMutableDictionary alloc]init];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[_ref child:@"reviews"] observeSingleEventOfType:FIRDataEventTypeValue withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        for ( FIRDataSnapshot *child in snapshot.children) {
            
            //  NSLog(@"child.value = %@",child.value[@"station_name"]);
            Review *rev = [[Review alloc]init];
            rev.what = child.value[@"what"];
            rev.where = child.value[@"where"];
            rev.who = child.value[@"who"];
            rev.why = child.value[@"why"];
            rev.with = child.value[@"with"];
            rev.comments = child.value[@"comments"];
            rev.date = child.value[@"date"];
            rev.categories = child.value[@"categories"];
            rev.photos = child.value[@"photos"];
            rev.rating = child.value[@"rating"];
            rev.address = child.value[@"address"];
            
            [reviewsArray addObject:rev];
            
            [self.tableView reloadData];
            for (int i=0; i<[reviewsArray count]-1; i++) {
                Review *thisReview = [[Review alloc]init];
                thisReview = [reviewsArray objectAtIndex:i];
              [self.fillDefaultColors setObject:[UIColor greenColor] forKey:thisReview.date];
            
            }
            [self.calendar reloadData];
        }
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];

    
    
    
    self.gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"dd-MM-yyyy";
    NSString *dateString = [formatter stringFromDate:[NSDate date]];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our input string
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *dateFromString = [[NSDate alloc] init];
    dateFromString = [dateFormatter dateFromString:dateString];
    [self.calendar selectDate:dateFromString];
    //
    //    self.calendar.selectedDate
//    self.fillDefaultColors = @{@"2017/02/03":[UIColor purpleColor],
//                               @"2015/10/06":[UIColor greenColor],
//                               @"2015/10/18":[UIColor cyanColor],
//                               @"2015/10/22":[UIColor yellowColor],
//                               @"2015/11/08":[UIColor purpleColor],
//                               @"2015/11/06":[UIColor greenColor],
//                               @"2015/11/18":[UIColor cyanColor],
//                               @"2015/11/22":[UIColor yellowColor],
//                               @"2015/12/08":[UIColor purpleColor],
//                               @"2015/12/06":[UIColor greenColor],
//                               @"2015/12/18":[UIColor cyanColor],
//                               @"2015/12/22":[UIColor magentaColor]};
//    self.dateFormatter1 = [[NSDateFormatter alloc] init];
//    self.dateFormatter1.dateFormat = @"yyyy/MM/dd";
    
     //   self.fillDefaultColors = @{@"06/01/2017":[UIColor purpleColor]};
    
   // [self.fillDefaultColors setObject:[UIColor purpleColor] forKey:@"06/01/2017"];
        self.dateFormatter1 = [[NSDateFormatter alloc] init];
        self.dateFormatter1.dateFormat = @"dd-MM-yyyy";
    
    
    
    
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition{
    NSLog(@"%@",date);
    
}

- (UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance fillDefaultColorForDate:(NSDate *)date
{
    NSString *key = [self.dateFormatter1 stringFromDate:date];
    if ([_fillDefaultColors.allKeys containsObject:key]) {
        return _fillDefaultColors[key];
    }
    return nil;
}

- (void)previousClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *previousMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:-1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:previousMonth animated:YES];
}

- (void)nextClicked:(id)sender
{
    NSDate *currentMonth = self.calendar.currentPage;
    NSDate *nextMonth = [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:1 toDate:currentMonth options:0];
    [self.calendar setCurrentPage:nextMonth animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
