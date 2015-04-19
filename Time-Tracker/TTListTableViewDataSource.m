//
//  TTListTableViewDataSource.m
//  Time-Tracker
//
//  Created by TYLER on 4/18/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "TTListTableViewDataSource.h"

@implementation TTListTableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[TTListTableViewDataSource sharedInstance].projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableView *cell = [tableView dequeueReusableCellWithIdentifier:@"ListCell"];
    if (cell == nil) {
        cell = [UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"ListCell"
    }
    
    Project *project = [ProjectController sharedInstance].projects[indexPath.row];
    
    cell.textLabel.text = project.title;
    cell.detailTextLabel.text = projectTime;
    
    return cell;
}

@end
