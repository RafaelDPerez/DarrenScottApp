//
//  ReviewsTableViewController.m
//  clic pic review
//
//  Created by Rafael Perez on 3/27/17.
//  Copyright © 2017 maranta. All rights reserved.
//

#import "ReviewsTableViewController.h"
#import "Review.h"
#import "VKSideMenu.h"
#import "FDKeychain.h"
#import "ReviewViewController.h"
@import Firebase;

@interface ReviewsTableViewController ()<VKSideMenuDelegate, VKSideMenuDataSource>
@property (strong, nonatomic) FIRDatabaseReference *ref;
@property (nonatomic, strong) VKSideMenu *menuLeft;
@end

@implementation ReviewsTableViewController
@synthesize reviewsArray, reviewSelected;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.menuLeft = [[VKSideMenu alloc] initWithSize:320 andDirection:VKSideMenuDirectionFromLeft];
    self.menuLeft.dataSource = self;
    self.menuLeft.delegate   = self;
    [self.menuLeft addSwipeGestureRecognition:self.view];
    self.menuLeft.backgroundColor = [UIColor whiteColor];
    reviewsArray = [[NSMutableArray alloc]init];
    self.ref = [[FIRDatabase database] reference];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
        }
        
    } withCancelBlock:^(NSError * _Nonnull error) {
        NSLog(@"%@", error.localizedDescription);
    }];
}



-(IBAction)buttonMenuLeft:(id)sender
{
    [self.menuLeft show:self.navigationController.view];
}


#pragma mark - VKSideMenuDataSource

-(NSInteger)numberOfSectionsInSideMenu:(VKSideMenu *)sideMenu
{
    return (sideMenu == self.menuLeft) ? 1 : 2;
}

-(NSInteger)sideMenu:(VKSideMenu *)sideMenu numberOfRowsInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return 3;
    
    return section == 0 ? 1 : 2;
}

-(VKSideMenuItem *)sideMenu:(VKSideMenu *)sideMenu itemForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // This solution is provided for DEMO propose only
    // It's beter to store all items in separate arrays like you do it in your UITableView's. Right?
    VKSideMenuItem *item = [VKSideMenuItem new];
    
    if (sideMenu == self.menuLeft) // All LEFT and TOP menu items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Home";
                item.icon  = [UIImage imageNamed:@"Home-50"];
                break;
                
            case 1:
                item.title = @"Profile";
                item.icon  = [UIImage imageNamed:@"ic_option_1"];
                break;
                
            case 2:
                item.title = @"Log Out";
                item.icon  = [UIImage imageNamed:@"Like-50"];
                break;
                
            default:
                break;
        }
    }
    else if (indexPath.section == 0) // RIGHT menu first section items
    {
        item.title = @"Login";
    }
    else // RIGHT menu second section items
    {
        switch (indexPath.row)
        {
            case 0:
                item.title = @"Like";
                break;
                
            case 1:
                item.title = @"Share";
                break;
            default:
                break;
        }
    }
    
    return item;
}

#pragma mark - VKSideMenuDelegate

-(void)sideMenu:(VKSideMenu *)sideMenu didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        //        FBSDKLoginManager *loginManager = [[FBSDKLoginManager alloc] init];
        //        [loginManager logOut];
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Log Out"
                              message: @"Are you sure?"
                              delegate: self
                              cancelButtonTitle:@"NO"
                              otherButtonTitles:@"YES",nil];
        alert.tag = 1;
        [alert show];
        
        
    }
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:@"callHome" sender:self];
    }
    if (indexPath.row == 1) {
        [self performSegueWithIdentifier:@"callProfile" sender:self];
    }
    
}


- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==1) {
        if (buttonIndex == 1) {
            NSError *signOutError;
            BOOL status = [[FIRAuth auth] signOut:&signOutError];
            if (!status) {
                NSLog(@"Error signing out: %@", signOutError);
                return;
            }
            else{
                // Sign-out succeeded
                [FDKeychain saveItem: @"NO"
                              forKey: @"loggedin"
                          forService: @"ReviewApp"
                               error: nil];
                [FDKeychain deleteItemForKey:@"token" forService:@"ReviewApp" error:nil];
                [self performSegueWithIdentifier:@"callLogIn" sender:self];
            }
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"callLogIn"]) {
        
    }
    if ([segue.identifier isEqualToString:@"ViewReview"]) {
        ReviewViewController *reviewViewController = [segue destinationViewController];
        //     [cell getCurrentIndex];
        //        offerViewController.hola= offerSelected.OfferImage;
        reviewViewController.review = reviewSelected;
        
    }
}

-(void)sideMenuDidShow:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did show", menu);
}

-(void)sideMenuDidHide:(VKSideMenu *)sideMenu
{
    NSString *menu = @"";
    
    if (sideMenu == self.menuLeft)
        menu = @"LEFT";
    
    
    NSLog(@"%@ VKSideMenue did hide", menu);
}

-(NSString *)sideMenu:(VKSideMenu *)sideMenu titleForHeaderInSection:(NSInteger)section
{
    if (sideMenu == self.menuLeft)
        return nil;
    
    switch (section)
    {
        case 0:
            return @"Profile";
            break;
            
        case 1:
            return @"Actions";
            break;
            
        default:
            return nil;
            break;
    }
}



- (BOOL)slideNavigationControllerShouldDisplayLeftMenu
{
    return YES;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return [reviewsArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewsTableViewCell *cell = (ReviewsTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"reviewCell" forIndexPath:indexPath];
    Review *review = [[Review alloc]init];
    review = [reviewsArray objectAtIndex:indexPath.row];
    cell.lblWhat.text = review.what;
    cell.lblWhere.text = review.where;
    cell.lblWhen.text = review.date;
    float ratingFloat = [review.rating floatValue];
    [cell.rating setRating:ratingFloat];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    reviewSelected = [reviewsArray objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"ViewReview" sender:self];
}




/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
