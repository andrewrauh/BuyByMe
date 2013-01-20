//
//  PendingTransactionsViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface PendingTransactionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, retain) NSArray *pendingTransactions;
@property (nonatomic, retain) IBOutlet UITableView *mytableView;
@property (nonatomic, retain) IBOutlet UILabel *transactionHeaderLabel;



@end
