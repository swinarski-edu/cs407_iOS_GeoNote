//
//  InputMessageToUpload.h
//  cs407_iOS_GeoNote
//
//  Created by Krzysztof Swinarski on 4/15/14.
//  Copyright (c) 2014 Krzysztof Swinarski. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface InputMessageToUpload : UIViewController <CLLocationManagerDelegate> {
    float currentLongitude;
    float currentLatitude;
    NSString *messageText;
    __weak IBOutlet UITextView *InputText;
}
- (IBAction)UploadMessage:(UIButton *)sender;
- (void)ReceivedLocation:(CLLocation *)location;

@end
