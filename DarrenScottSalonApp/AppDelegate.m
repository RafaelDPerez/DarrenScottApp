//
//  AppDelegate.m
//  DarrenScottSalonApp
//
//  Created by maricarmen peignand  on 10/27/16.
//  Copyright (c) 2016 maranta. All rights reserved.
//

#import "TermsAndConditionsViewController.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <GooglePlaces/GooglePlaces.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import "FDKeychain.h"
#import "ProfileViewController.h"
#import "PDKClient.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>





@import Firebase;
@import GooglePlaces;
@import GoogleMaps;


@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize loggedIn = _loggedIn;
@synthesize userType = _userType;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     [FIRApp configure];
    [[Twitter sharedInstance] startWithConsumerKey:@"b9Lztf5aMSTc2bZbeBIb9EkRq" consumerSecret:@"ypCbRgCq3HcklSit9U6y2qM9qePtif8rGBtG9DCUv1LYzBq5B1"];
  //  [Fabric with:@[[Twitter class]]];
    [PDKClient configureSharedInstanceWithAppId:@"4893039640897927918"];
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    [GMSPlacesClient provideAPIKey:@"AIzaSyDegZLmKL9c42BLpAAJGtNNFu7Dc7pabW0"];
    // Provide the Maps API with your API key. You may not need this in your app, however we do need
    // this for the demo app as it uses Maps.
    [GMSServices provideAPIKey:@"AIzaSyDegZLmKL9c42BLpAAJGtNNFu7Dc7pabW0"];
    // Override point for customization after application launch.
    //first-time ever defaults check and set
//    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
//    
//    TermsAndConditionsViewController *controller = (TermsAndConditionsViewController *)[mainStoryboard instantiateViewControllerWithIdentifier: @"TermsAndConditions"];
//    [self.window.rootViewController presentViewController: controller animated:YES completion:nil];
    _loggedIn = [FDKeychain itemForKey: @"loggedin"
                            forService: @"ReviewApp"
                                 error: nil];
    _userType = [FDKeychain itemForKey: @"userType"
                            forService: @"ReviewApp"
                                 error: nil];
    
    if ([_loggedIn isEqualToString:@"YES"]) {
      // self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
//                self.window.rootViewController = vc;
//                [self.window makeKeyAndVisible];
        
//        LeftMenuViewController *leftMenu = (LeftMenuViewController*)[storyboard instantiateViewControllerWithIdentifier: @"LeftMenuViewController"];
//        [FDKeychain saveItem: @"0"
//                      forKey: @"userType"
//                  forService: @"ReviewApp"
//                       error: nil];
      
        
        if ([_userType isEqualToString:@"0"]) {
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Slide"];
            self.window.rootViewController = vc;
            [self.window makeKeyAndVisible];
        }
        else{
            self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Business"];
            self.window.rootViewController = vc;
            [self.window makeKeyAndVisible];
        }
        
        // Creating a custom bar button for right menu
               
        
    }
    else{
        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Welcome"];
            self.window.rootViewController = vc;
            [self.window makeKeyAndVisible];
        
    }
    
    


//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"login"];
//    self.window.rootViewController = vc;
//    [self.window makeKeyAndVisible];
    
    
    
//    
//    if([value isEqualToString:@"(null)"] || ![value isEqualToString: @"YES"])
//    {
//    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"TermsAndConditions"];
//    self.window.rootViewController = vc;
//    [self.window makeKeyAndVisible];
//    }
//    else
//    {
//        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"NavigationController"];
//        self.window.rootViewController = vc;
//        [self.window makeKeyAndVisible];
//    }
    
    
    
//    if([[NSUserDefaults standardUserDefaults] boolForKey:@"TermsAccepted"]!=YES)
//    {
//        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"TermsAccepted"];
//        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//        TermsAndConditionsViewController *viewController =  (TermsAndConditionsViewController *)[storyboard instantiateViewControllerWithIdentifier: @"TermsAndConditions"];
//        
//        self.window.rootViewController = viewController;
//        [self.window makeKeyAndVisible];
//    }
//    else{
//        self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
//        
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        
//        ViewController *viewController =  (ViewController *)[storyboard instantiateViewControllerWithIdentifier: @"Reviews"];
//        
//        self.window.rootViewController = viewController;
//        [self.window makeKeyAndVisible];
//    
//    }
    return YES;
}


- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    
    BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
                                                                  openURL:url
                                                        sourceApplication:sourceApplication
                                                               annotation:annotation
                    ];
    // Add any custom logic here.
    return handled;
} 




//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
//{
//    if ([[Twitter sharedInstance] application:app openURL:url options:options]) {
//        return YES;
//    }
//    
//    // If you handle other (non Twitter Kit) URLs elsewhere in your app, return YES. Otherwise
//    return YES;
//}

/*
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return [[PDKClient sharedInstance] handleCallbackURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options
{
    return [[PDKClient sharedInstance] handleCallbackURL:url];
}
*/
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.maranta.darrenscott.DarrenScottSalonApp" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DarrenScottSalonApp" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DarrenScottSalonApp.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
