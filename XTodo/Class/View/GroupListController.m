//
//  GroupListController.m
//  TodoX
//
//  Created by teym on 13-6-12.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "GroupListController.h"
#import "GroupCell.h"
#import "StdPch.h"
#import "AppDelegate.h"
#import "GroupDetailController.h"
#import "SlideController.h"

@interface GroupListController ()
@property (strong,nonatomic) IBOutlet UIView * header;
@property (strong,nonatomic) IBOutlet UILabel* nameLabel;
@property (strong,nonatomic) IBOutlet UIProgressView * process;
@property (strong,nonatomic) IBOutlet UILabel * processLabel;
@property (strong,nonatomic) IBOutlet UITextView * text;
@property (strong,nonatomic) NSArray * groups;
@end

@implementation GroupListController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.tableHeaderView = self.header;
    
    __weak GroupListController * selfControll = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [selfControll performSelector:@selector(addGroup)];
        [selfControll.tableView.pullToRefreshView stopAnimating];
    } position:SVPullToRefreshPositionBottom];
    
    NSArray * arr = [[TheRuntime groups] allValues];
    self.groups = [arr sort:^NSComparisonResult(id obj1, id obj2) {
        return [[(Group*)obj1 date] compare:[(Group*)obj1 date]];
    }];
    
    [self updateHeaderFor:MySelf];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- show
-(void) updateHeaderFor:(Member*) member
{
    [self.nameLabel setText:member.name];
    ProcessInfo *info = [member process];
    [self.process setProgress:info.process];
    [self.processLabel setText:[info description]];
}
-(void)addGroup
{
    GroupDetailController * detail = [[GroupDetailController alloc] initWithNibName:@"GroupDetailController" bundle:nil];
    [TheNavigation pushViewController:detail animated:YES];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.groups count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GroupCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[GroupCell alloc] initWithReuseIdentifier:CellIdentifier];
    }
    Group * group = [self.groups objectAtIndex:indexPath.row];
    cell.textLabel.text = group.name;
    cell.process.progress = [group process].process;
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Group * group = [self.groups objectAtIndex:indexPath.row];
    SlideController * todos = [SlideController slideControllForMemberTodos:MySelf group:group];
    [TheNavigation pushViewController:todos animated:YES];
}

@end
