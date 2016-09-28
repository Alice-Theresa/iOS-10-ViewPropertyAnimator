//
//  ViewController.h
//  ViewPropertyAnimator
//
//  Created by S.C. on 2016/9/21.
//  Copyright © 2016年 Kabylake. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

/**底色*/
@property (nonatomic, readwrite, strong) UIView                 *backgroundView;

/**头像*/
@property (nonatomic, readwrite, strong) UIImageView            *imageView;

/**TableView*/
@property (nonatomic, readwrite, strong) UITableView            *tableView;

/**个人属性*/
@property (nonatomic, readwrite, strong) NSArray                *property;

/**个人资料*/
@property (nonatomic, readwrite, strong) NSArray                *personData;

/**动画操作*/
@property (nonatomic, readwrite, strong) NSArray                *action;

/**Animator*/
@property (nonatomic, readwrite, strong) UIViewPropertyAnimator *animator;

@end

