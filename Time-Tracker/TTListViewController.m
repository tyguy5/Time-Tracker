//
//  TTListViewController.m
//  Time-Tracker
//
//  Created by TYLER on 4/18/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTListViewController.h"
#import "TTListTableViewDataSource.h"

#import "TTProjectController.h"
#import "TTDetailViewController.h"

@interface TTListViewController ()

@property (nonatomic, strong) TTListTableViewDataSource *dataSource;
@property (nonatomic, strong) UITableView *tableView;


@end

@implementation TTListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.dataSource = [TTListTableViewDataSource new];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.tableView];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self.dataSource;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(newProject)];
    
    self.navigationItem.rightBarButtonItem = addButton;

}

- (void)newProject {
    TTProject *project = [TTProject new];
    [[TTProjectController sharedInstance] addProject:project];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TTProject *project = [TTProjectController sharedInstance].projects[indexPath.row];
    
    TTDetailViewController *viewController = [TTDetailViewController new];
    viewController.project = project;
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

@end
