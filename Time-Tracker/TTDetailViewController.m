//
//  TTDetailViewController.m
//  Time-Tracker
//
//  Created by TYLER on 4/20/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTDetailViewController.h"
#import "TTProjectController.h"

#import "TTDetailDataSource.h"

#import "TTCustomEntryViewController.h"

#import <MessageUI/MessageUI.h>

@interface TTDetailViewController () <UITableViewDelegate, UITextFieldDelegate, MFMailComposeViewControllerDelegate>

@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UILabel *timeLabel;
@property (nonatomic, strong) IBOutlet UITextField *titleField;

@property (nonatomic, strong) TTDetailDataSource *dataSource;

- (IBAction)add:(id)sender;
- (IBAction)clockIn:(id)sender;
- (IBAction)clockOut:(id)sender;
- (IBAction)report:(id)sender;

@end

@implementation TTDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [TTDetailDataSource new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.titleField.text = self.project.title;
    self.titleField.delegate = self;
    self.timeLabel.text = [self.project projectTime];
    
    self.dataSource.project = self.project;
    self.tableView.dataSource = self.dataSource;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)add:(id)sender {
    
    TTCustomEntryViewController *entryViewController = [TTCustomEntryViewController new];
    entryViewController.project = self.project;
    
    [self presentViewController:entryViewController animated:YES completion:nil];
}

- (IBAction)clockIn:(id)sender {
    
    [self.project startNewEntry];
    [self.tableView reloadData];
}

- (IBAction)clockOut:(id)sender {
    
    [self.project endCurrentEntry];
    [self.tableView reloadData];
}

- (IBAction)report:(id)sender {
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    self.project.title = textField.text;
    [[TTProjectController sharedInstance] synchronize];
    
    return YES;
}

- (IBAction)sendEmail:(id)sender {
    
    MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
    mailViewController.mailComposeDelegate = self;
    
    NSString *messageBody;
    
    for (TTEntry *entry in self.project.entries) {
        
        if (messageBody) {
            messageBody = [NSString stringWithFormat:@"%@\n%@ to %@\n", messageBody, entry.startTime, entry.endTime];
        } else {
            messageBody = [NSString stringWithFormat:@"\n%@ to %@\n", entry.startTime, entry.endTime];
        }
    }
    
    [mailViewController setMessageBody:messageBody isHTML:NO];
    
    [self presentViewController:mailViewController animated:YES completion:nil];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
