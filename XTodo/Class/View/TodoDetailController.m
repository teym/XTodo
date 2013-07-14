//
//  TodoDetailController.m
//  XTodo
//
//  Created by teym on 13-6-30.
//  Copyright (c) 2013年 xiami. All rights reserved.
//

#import "TodoDetailController.h"
#import "StdPch.h"

@interface TodoDetailController ()
@property (strong,nonatomic) IBOutlet UITextField * titleText;
@property (strong,nonatomic) IBOutlet UITextView * descriptionText;
@property (strong,nonatomic) IBOutlet UISegmentedControl * levelSegment;
@property (strong,nonatomic) IBOutlet UIImageView * fromUsrImg;
@property (strong,nonatomic) IBOutlet UILabel * fromUsrLabel;
@property (strong,nonatomic) IBOutlet UIImageView * toUsrImg;
@property (strong,nonatomic) IBOutlet UILabel * toUsrLabel;
@end

@implementation TodoDetailController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(NSUInteger) levelToIndex:(TodoLevel)level
{
    switch (level) {
        case Emergency:
            return 2;
        case High:
            return 1;
            break;
        default:
            break;
    }
    return 0;
}
-(TodoLevel) indexToLevel:(NSUInteger) index
{
    switch (index) {
        case 2:
            return Emergency;
        case 1:
            return High;
            break;
        default:
            break;
    }
    return Normal;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    if(self.todo)
    {
        self.titleText.text = self.todo.title;
        self.descriptionText.text = self.todo.todoDescription;
        [self.levelSegment setSelectedSegmentIndex:[self levelToIndex:self.todo.level]];
        self.fromUsrLabel.text = self.todo.creater.name;
        self.toUsrLabel.text = self.todo.owner.name;
    }
}
- (void) done
{
    if(!self.todo)
         self.todo = [TheRuntime.group member:MySelf createTodoForMember:MySelf];
    
    self.todo.title = self.titleText.text;
    self.todo.todoDescription = self.descriptionText.text;
    self.todo.level = [self indexToLevel:self.levelSegment.selectedSegmentIndex];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
-(void) viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}
@end
