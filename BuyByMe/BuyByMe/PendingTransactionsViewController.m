//
//  PendingTransactionsViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "PendingTransactionsViewController.h"
#import "CompleteTransactionViewController.h"

@interface PendingTransactionsViewController ()

@end

@implementation PendingTransactionsViewController
@synthesize mytableView;

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
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//TableView Delegate methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows called");
    // Return the number of rows in the section.
    return 9;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"chris2.png"]];
    [cell.detailTextLabel setText:@""];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CompleteTransactionViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"CompleteVC"];
//    [controller setSelectedItem:[webServices.allItems objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:controller animated:YES];

//    [self.navigationController pushViewController:controller animated:YES];
}

- (void) reloadTableView{
    [mytableView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:YES];
}

@end
