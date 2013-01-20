//
//  ViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "WebServices.h"

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, ProcessDataDelegate> {
    CLLocationManager       *locationManager;
    CLLocation              *userLocation;
    
}

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic,strong)CLLocation *userLocation;
@property (nonatomic, strong) IBOutlet UITableView *tbView;

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation;

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error;

@end
