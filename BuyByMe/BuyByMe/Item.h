//
//  Item.h
//  BuyByMe
//
//  Created by Chris Wendel on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import <CoreLocation/CoreLocation.h>

typedef enum{
    kCategory1,
    kCategeory2,
    kCategory3
}Category;

@interface Item : NSObject{
/* Will we use all these? Probably not, but still. Fuck you */
    
    NSString        *title;
    NSString        *description;
    NSString        *category;
    CLLocation      *originalLocation;
    Category        cat;
    NSNumber        *price;
    bool            isNegotiable;
    NSString        *template_id;
    User            *poster;
    NSDate          *posted_date;
    NSDate          *end_date;
    UIImage         *picture;
    
}

@property(nonatomic,retain) NSString *title;
@property(nonatomic,retain) NSString *description;
@property(nonatomic,retain) NSString *category;
@property(nonatomic,retain) CLLocation *originalLocation;
@property(nonatomic) Category cat;
@property(nonatomic) bool isNegotiable;
@property(nonatomic,retain) NSNumber *price;
@property(nonatomic,retain) User *poster;
@property(nonatomic,retain) NSDate *posted_date;
@property(nonatomic,retain) NSDate *end_date;
@property(nonatomic, retain)UIImage *picture;

@end
