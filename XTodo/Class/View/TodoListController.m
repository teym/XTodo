//
//  TodoListController.m
//  TodoX
//
//  Created by teym on 13-6-10.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "TodoListController.h"
#import "StdPch.h"
#import "AppDelegate.h"
#import "TodoDetailController.h"
#import "TodoCell.h"
#import <DragAndDropTableView.h>

@interface TodoListController () <UIGestureRecognizerDelegate,DragAndDropTableViewDelegate>
@property (strong,nonatomic) IBOutlet UIView  * header;
@property (strong,nonatomic) IBOutlet UILabel * Name;
@property (strong,nonatomic) IBOutlet UIProgressView * process;
@property (strong,nonatomic) IBOutlet UILabel * processLabel;
@property (strong,nonatomic) NSArray * todoList;
@property (weak) Group * group;
@property (weak) Member * member;
-(IBAction)onBack:(id)sender;
@end

@implementation TodoListController

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
    
    __weak TodoListController * selfControll = self;
    [self.tableView addPullToRefreshWithActionHandler:^{
        [selfControll performSelector:@selector(addTodo)];
        [selfControll.tableView.pullToRefreshView stopAnimating];
    } position:SVPullToRefreshPositionBottom];
    
    [self.process configureFlatProgressViewWithTrackColor:[UIColor nephritisColor] progressColor:[UIColor sunflowerColor]];
    
    self.tableView.tableHeaderView = self.header;
    if(self.member){
        [self showGroup:self.group forMember:self.member];
    }
    
    UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onPanGesture:)];
    pan.maximumNumberOfTouches = 1;
    pan.minimumNumberOfTouches = 1;
    pan.delegate = self;
    pan.enabled = YES;
    [self.tableView addGestureRecognizer:pan];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - show
-(void) showGroup:(Group *)group forMember:(Member *)member
{
    self.group = group;
    self.member = member;
    self.todoList = [member.todos allKeys];
    [self updateHeadGroup:group forMember:member];
    [self updateTable];
}
-(void) updateHeadGroup:(Group *)group forMember:(Member*)member
{
    ProcessInfo *processInfo = [member process];
    [self.process setProgress:processInfo.process animated:YES];
    [self.processLabel setText:processInfo.description];
}
-(void) updateTable
{
    [self.tableView reloadData];
}
-(void) onBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - add

-(void) addTodo
{
    Todo * todo = [self.group member:MySelf createTodoForMember:MySelf];
    todo.title = @"other todo";
    self.todoList = [self.todoList arrayByAddingObject:todo.iden];
    NSIndexPath * index = [NSIndexPath indexPathForRow:[self.todoList count]-1 inSection:0];
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:@[index] withRowAnimation:UITableViewRowAnimationBottom];
    [self.tableView endUpdates];
}

#pragma mark - process
-(BOOL) gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    CGPoint point = [gestureRecognizer locationInView:self.tableView];
    NSIndexPath * index = [self.tableView indexPathForRowAtPoint:point];
    return index != nil;
}
-(void) onSwipeGesture:(UISwipeGestureRecognizer *) gesture
{
    CGPoint point = [gesture locationInView:self.tableView];
    LogOut(@"on swip %@ :%@ (%f,%f)",self.tableView,gesture.view,point.x,point.y);
}
-(void) onPanGesture:(UIPanGestureRecognizer*) gesture
{
    CGPoint local = [gesture locationInView:self.tableView];
    CGPoint point = [gesture translationInView:self.tableView];
    CGPoint source = CGPointMake(local.x-point.x, local.y-point.y);
    
    NSIndexPath * index = [self.tableView indexPathForRowAtPoint:source];
    if(index)
    {
        Todo * todo = [self.group.todos objectForKey:[self.todoList objectAtIndex:index.row]];
        [todo upToProcess:local.x/self.tableView.bounds.size.width *10];
        TodoCell * cell = (TodoCell*)[self.tableView cellForRowAtIndexPath:index];
        cell.process = todo.process.process;
    }
//    LogOut(@"on pan %@ (%f,%f) :(%f,%f)",index,source.x,source.y,local.x,local.y);
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.todoList count];
}

-(float) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    LogOut(@"load todo");
    static NSString *CellIdentifier = @"Cell";
    TodoCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[TodoCell alloc] initWithReuseIdentifier:CellIdentifier];
        cell.backgroundColor = [UIColor redColor];
        cell.processColor = [UIColor darkGrayColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    Todo * todo = [self.group.todos objectForKey:[self.todoList objectAtIndex:indexPath.row]];
    cell.textLabel.text = todo.title;
    cell.process = todo.process.process;
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
    TodoDetailController * detail = [[TodoDetailController alloc] initWithNibName:@"TodoDetailController" bundle:nil];
    [TheNavigation pushViewController:detail animated:YES];
}

#pragma mark - drag&drop
-(void) tableView:(DragAndDropTableView *)tableView willBeginDraggingCellAtIndexPath:(NSIndexPath *)indexPath placeholderImageView:(UIImageView *)placeHolderImageView
{
    LogOut(@"begin drag %@",indexPath);
}
-(void) tableView:(DragAndDropTableView *)tableView didEndDraggingCellToIndexPath:(NSIndexPath *)indexPath placeHolderView:(UIImageView *)placeholderImageView
{
    LogOut(@"end drag %@",indexPath);
}
@end
