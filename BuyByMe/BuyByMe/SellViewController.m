//
//  SellViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "SellViewController.h"
#import "Item.h"
#import <Parse/Parse.h>

@interface SellViewController () {
    BOOL newMedia;
}

@end

@implementation SellViewController
@synthesize titleItem,description,price,picture, venmoClient;

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
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    locationManager.delegate = self;
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    userLocation = newLocation;
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

-(IBAction)addOrTakePic:(id)sender {
    NSString *other1 = @"Take Picture";
    NSString *other2 = @"Choose From Camera Roll";
    NSString *cancelTitle = @"Cancel Button";
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:nil
                                  delegate:self
                                  cancelButtonTitle:cancelTitle
                                  destructiveButtonTitle:nil
                                  otherButtonTitles:other1, other2, nil];
    [actionSheet showInView:self.view];
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0) {
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypeCamera;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString *) kUTTypeImage,
                                      nil];
            imagePicker.allowsEditing = NO;
            [self presentModalViewController:imagePicker animated:YES];
            newMedia = YES;
        }
    }
    else if (buttonIndex == 1) {
        if ([UIImagePickerController isSourceTypeAvailable:
             UIImagePickerControllerSourceTypeSavedPhotosAlbum]) {
            
            UIImagePickerController *imagePicker =
            [[UIImagePickerController alloc] init];
            imagePicker.delegate = self;
            imagePicker.sourceType =
            UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.mediaTypes = [NSArray arrayWithObjects:
                                      (NSString *) kUTTypeImage,
                                      nil];
            imagePicker.allowsEditing = NO;
            [self presentModalViewController:imagePicker animated:YES];
            newMedia = NO;

        }
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    [self dismissModalViewControllerAnimated:YES];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        picture.image = image;
        
        if (newMedia){
            UIImageWriteToSavedPhotosAlbum(image,
                                           self,
                                           @selector(image:finishedSavingWithError:contextInfo:),
                                           nil);}
    }
    else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie]) {
		// Code here to support video if enabled
	}
}


- (void)image:(UIImage *)image
finishedSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo {
    if (error) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Save failed"
                              message: @"Failed to save image"
                              delegate: nil
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil];
        [alert show];
    }
}

-(IBAction)didPressDone:(id)sender {
    Item *newItem = [[Item alloc]init];
    [newItem setTitle:titleItem.text];
    [newItem setDescription:description.text];
    [newItem setPrice:[NSNumber numberWithInt:[price.text integerValue]]];
    [newItem setPicture:picture.image];
    
    PFGeoPoint *point = [PFGeoPoint geoPointWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    
    
    // Create the Item
    PFObject *myItem = [PFObject objectWithClassName:@"Item"];
    [myItem setObject:point forKey:@"location"];
    [myItem setObject:newItem.title forKey:@"title"];
    [myItem setObject:[NSNumber numberWithBool:YES] forKey:@"active"];
    [myItem setObject:[NSNumber numberWithBool:NO] forKey:@"negotiable"];
    [myItem setObject:newItem.description forKey:@"description"];
    [myItem setObject:[NSNumber numberWithInt:[price.text integerValue]] forKey:@"price"];
    
    NSData *imageData = UIImagePNGRepresentation(picture.image);
    PFFile *imageFile = [PFFile fileWithName:@"User picture" data:imageData];
    [imageFile save];
    
    [myItem setObject:imageFile forKey:@"image"];
    
    // This will save both myPost and myComment
    [myItem saveInBackground];

    
}
@end
