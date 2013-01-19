//
//  Offer.h
//  BuyByMe
//
//  Created by Chris Wendel on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "User.h"

@interface Offer : NSObject{
    
    Item        *item;
    NSDate      *date;
    User        *seller;
    User        *pot_seller; // Don't get excited, I don't have bud :(
    bool        accepted;
    NSDate      *accepted_date;
    Offer       *counterOffer;
    
}
@property(nonatomic,retain) Item *item;
@property(nonatomic,retain) NSDate *date;
@property(nonatomic,retain) User *seller;
@property(nonatomic,retain) User *pot_seller; // STILL NO POT, SORRY
@property(nonatomic) bool accepted;
@property(nonatomic,retain) NSDate *accepted_date;
@property(nonatomic,retain) Offer *counterOffer;

@end
