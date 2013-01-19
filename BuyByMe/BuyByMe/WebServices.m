//
//  WebServices.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices
@synthesize loggedInUser, allItems, delegate, sellingUser;

+(id)sharedInstance
{
    static id sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}


-(void)retrieveAllPostedItems {
    
    NSURLRequest *main = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://buybyme.herokuapp.com/api/api/api/item/"]]];
    
    allItems = [[NSMutableArray alloc]init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:main
                                             returningResponse:&response
                                                         error:&error];
        
        NSString *json = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        id parsedObject = nil;
        NSError *parseError = nil;
        
        if (json != nil && [json isKindOfClass:[NSString class]] && [json length] > 0) {
            parsedObject = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSASCIIStringEncoding]
                                                           options:0
                                                             error:&parseError];
        }
        
        if ([parsedObject isKindOfClass:[NSArray class]]) {
            NSArray *parsedArray = (NSArray *)parsedObject;
            
            for (NSDictionary *dict in parsedArray) {
                NSNumberFormatter * formatter = [[NSNumberFormatter alloc] init];
                [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
                NSLog(@"Dict is %@", dict);
                Item *newItem = [[Item alloc]init];
                NSDictionary *poster = [dict objectForKey:@"poster"];
                [newItem setTitle:[dict objectForKey:@"title"]];
                NSString *priceString = [[dict objectForKey:@"price"] stringValue];
                NSLog(@"price string %@", priceString);
                NSNumber *price = [formatter numberFromString:priceString];
                [newItem setPrice:price];
                [newItem setTitle:[dict objectForKey:@"description"]];
                [newItem setPosterId:[poster objectForKey:@"id"]];
                [newItem convertStringToCategory:[dict objectForKey:@"category"]];
                NSLog(@"item is %@",newItem);
                [allItems addObject:newItem];

                NSLog(@"AllItems is Chris %@",allItems);
                [[self delegate] reloadTableView];

            }
        }
       
        [[self delegate] reloadTableView];
    });
    [[self delegate] reloadTableView];

}

-(void)retrieveAllUserData {
    
}


-(void)sendNewItemToServer:(Item*)newItem {
  
    
}

-(void)retrieveSellerUserData:(NSString*)postedID {
    
    NSURLRequest *main = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://buybyme.herokuapp.com/api/api/api/user/%@", postedID]]];
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:main
                                             returningResponse:&response
                                                         error:&error];
        
        NSString *json = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        id parsedObject = nil;
        NSError *parseError = nil;
        
        if (json != nil && [json isKindOfClass:[NSString class]] && [json length] > 0) {
            parsedObject = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSASCIIStringEncoding]
                                                           options:0
                                                             error:&parseError];
        }
        
        if ([parsedObject isKindOfClass:[NSDictionary class]]) {
            NSDictionary *parsedDict = (NSDictionary *)parsedObject;
            sellingUser = [NSMutableDictionary dictionaryWithDictionary:parsedDict];
        }
    });
}

- (NSData *) takeNewItemAndCreateJSON:(Item*)newItem
{
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:newItem.description,@"description", newItem.price, @"price", newItem.title, @"title", nil];
    
    NSMutableData *jsonData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:jsonData];
    [archiver encodeObject:jsonDictionary forKey:@"item"];
    
    NSData *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return data;
}


@end
