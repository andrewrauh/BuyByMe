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
    kTechnology
}Category;

@interface Item : NSObject{
/* Will we use all these? Probably not, but still. Fuck you */
    
    NSString        *title;
    NSString        *description;
    NSString        *category;
    CLLocation      *originalLocation;
    NSString        *itemId;
    Category        cat;
    NSNumber        *price;
    bool            isNegotiable;
    NSString        *template_id;
    User            *poster;
    NSString        *posterId;
    NSDate          *posted_date;
    NSDate          *end_date;
    UIImage         *picture;
    
}

@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *description;
@property(nonatomic, strong ) NSString *category;
@property(nonatomic, strong) CLLocation *originalLocation;
@property(nonatomic) Category cat;
@property(nonatomic) bool isNegotiable;
@property(nonatomic, strong) NSNumber *price;
@property(nonatomic, strong) User *poster;
@property(nonatomic, strong) NSDate *posted_date;
@property(nonatomic, strong) NSString *posterId;
@property(nonatomic, strong) NSDate *end_date;
@property(nonatomic, strong)UIImage *picture;
@property(nonatomic, strong) NSString *itemId;

-(void)convertStringToCategory:(NSString*)category_string;

@end
