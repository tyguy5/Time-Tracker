//
//  TTCustomEntryViewController.m
//  Time-Tracker
//
//  Created by TYLER on 4/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTCustomEntryViewController.h"

@interface TTCustomEntryViewController ()

@property (nonatomic, strong) IBOutlet UIDatePicker *startDatePicker;
@property (nonatomic, strong) IBOutlet UIDatePicker *endDatePicker;

@end

@implementation TTCustomEntryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];

}

- (IBAction)save:(id)sender {
    
    TTEntry *entry = [TTEntry new];
    entry.startTime = self.startDatePicker.date;
    entry.endTime = self.endDatePicker.date;
    
    [self.project addEntry:entry];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)cancel:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
