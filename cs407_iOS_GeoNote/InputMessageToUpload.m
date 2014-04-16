//
//  InputMessageToUpload.m
//  cs407_iOS_GeoNote
//
//  Created by Krzysztof Swinarski on 4/15/14.
//  Copyright (c) 2014 Krzysztof Swinarski. All rights reserved.
//

#import "InputMessageToUpload.h"
#import <Parse/Parse.h>

@interface InputMessageToUpload ()

@end

@implementation InputMessageToUpload {
    CLLocationManager *locationManager;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    locationManager = [[CLLocationManager alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)UploadMessage:(UIButton *)sender {
    //Get the current location
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [locationManager startUpdatingLocation];
}

- (void)ReceivedLocation:(CLLocation *)location {
    //assign the new location
    currentLongitude = location.coordinate.longitude;
    currentLatitude = location.coordinate.latitude;
    messageText = InputText.text;
    
    //Preview the entered text on the console
    NSLog(@"Entered text is: %@", InputText.text);
    NSLog(@"   Longitude: %@", [NSString stringWithFormat:@"%f", currentLongitude]);
    NSLog(@"   Latitude: %@", [NSString stringWithFormat:@"%f", currentLatitude]);
    NSLog(@"\n");
    
    //Create Parse.com object for the message
    PFObject *newMessage = [PFObject objectWithClassName:@"Message"];
    [newMessage setObject:[NSNumber numberWithFloat:currentLongitude] forKey:@"longitude"];
    [newMessage setObject:[NSNumber numberWithFloat:currentLatitude] forKey:@"latitude"];
    [newMessage setObject:messageText forKey:@"msgText"];
    
    //Upload the object to Parse.com
    [newMessage saveInBackground];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    CLLocation *currentLocation = newLocation;
    
    //only print the current location when the location has been updated
    if (currentLocation != nil) {
        //stop updating the location, as we have found a pair of coordinates that contain data
        [locationManager stopUpdatingLocation];
        
        //call the ReceivedLocation method when we have a location in order to print the received coordinates
        [self ReceivedLocation:currentLocation];
    }
}
@end
