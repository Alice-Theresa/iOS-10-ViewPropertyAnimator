//
//  ViewController.m
//  ViewPropertyAnimator
//
//  Created by S.C. on 2016/9/21.
//  Copyright © 2016年 Kabylake. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {

    [super viewDidLoad];
    
    //界面布置
    self.property                         = [NSArray arrayWithObjects:@"First Name", @"Family Name", @"Gender", @"City", nil];
    self.personData                       = [NSArray arrayWithObjects:@"Maihime", @"Tenkawa", @"Female", @"Kanagawa", nil];
    self.action                           = [NSArray arrayWithObjects:@"Pause", @"Resume", @"Stop", @"Reverse", nil];
    
    self.backgroundView                   = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 250)];
    self.backgroundView.backgroundColor   = [UIColor colorWithRed:166 / 255.0 green:186 / 255.0 blue:237 / 255.0 alpha:1];
    
    self.imageView                        = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image"]];
    self.imageView.bounds                 = CGRectMake(0, 0, 120, 120);
    self.imageView.center                 = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 125);
    self.imageView.userInteractionEnabled = YES;
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 250, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 250)
                                                  style:UITableViewStyleGrouped];
    self.tableView.dataSource             = self;
    self.tableView.delegate               = self;
    
    [self.view insertSubview:self.backgroundView atIndex:0];
    [self.view insertSubview:self.tableView atIndex:1];
    [self.view insertSubview:self.imageView atIndex:2];

    UIPanGestureRecognizer *dragGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)];
    [self.imageView addGestureRecognizer:dragGesture];
    
    //创建并配置Animator
    UISpringTimingParameters *spring = [[UISpringTimingParameters alloc] initWithMass:1
                                                                            stiffness:80
                                                                              damping:5
                                                                      initialVelocity:CGVectorMake(0, 0)];
    self.animator = [[UIViewPropertyAnimator alloc] initWithDuration:0 timingParameters:spring];
}

- (void)drag:(UIPanGestureRecognizer *)sender {
    
    self.imageView.center = [sender locationInView:self.view.superview];
    
    //手动中断动画操作
    if (sender.state == UIGestureRecognizerStateBegan) {
        if (self.animator.state == UIViewAnimatingStateActive) {
            [self.animator stopAnimation:YES];
        }
    }
    
    //执行复位动画
    if (sender.state == UIGestureRecognizerStateEnded) {
        
        __weak typeof(self.imageView) weakImageView = self.imageView;
        [self.animator addAnimations:^{
            __strong typeof(self.imageView) strongImageView = weakImageView;
            strongImageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width / 2, 125);
        }];
        [self.animator startAnimation];
    }
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    BOOL isInactive = self.animator.state == UIViewAnimatingStateInactive;
    
    [self.tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.section == 1) {
        switch (indexPath.row) {
                
                //暂停动画
            case 0:
                [self.animator pauseAnimation];
                break;
                
                //恢复动画
            case 1:
                isInactive ? : [self.animator startAnimation];
                break;
                
                //停止动画
            case 2: {
                [self.animator stopAnimation:NO];
                [self.animator finishAnimationAtPosition:UIViewAnimatingPositionEnd];
            }
                break;
                
                //反转动画
            case 3:
                self.animator.reversed = isInactive ? NO : YES;
                break;
        }
    }
}

#pragma mark - TableView DataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
        if (indexPath.section == 0) {
            cell.textLabel.text       = [self.property objectAtIndex:indexPath.row];
            cell.detailTextLabel.text = [self.personData objectAtIndex:indexPath.row];
        } else {
            cell.textLabel.text       = [self.action objectAtIndex:indexPath.row];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 4;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

@end
