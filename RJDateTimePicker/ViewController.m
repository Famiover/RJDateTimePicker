//
//  ViewController.m
//  RJDateTimePicker
//
//  Created by Famiover on 16/3/25.
//  Copyright (c) 2016 Famiover. All rights reserved.
//


#import "ViewController.h"
#import "RJDatePicker.h"


@interface ViewController ()

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    UITextField *textField= [[UITextField alloc] initWithFrame:CGRectMake(60,240,180,30)];
    textField.borderStyle=UITextBorderStyleLine;
    textField.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:textField];
    RJDatePicker *datePicker= [[RJDatePicker alloc] initWithFrame:CGRectMake(0,0,[[UIScreen mainScreen] bounds].size.width,180)];
    textField.inputView=datePicker;
    [datePicker setDateTimeBlock:^(NSString *dateTime) {
        if(![@"cancle" isEqualToString:dateTime]){
            textField.text=dateTime;
        }
        [textField resignFirstResponder];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end