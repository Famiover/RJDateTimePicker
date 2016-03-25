//
// Created by Famiover on 16/3/17.
// Copyright (c) 2016 Famiover. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^DateTimeBlock)(NSString *dateTime);
@interface RJDatePicker : UIView
@property (nonatomic, strong) UIView *toolbar;
@property (nonatomic, strong) UIPickerView *pickerView;
@property(nonatomic, copy) DateTimeBlock block;
- (void)setDateTimeBlock:(DateTimeBlock)block ;
@end