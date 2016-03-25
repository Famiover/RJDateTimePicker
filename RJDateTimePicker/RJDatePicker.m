//
// Created by Famiover on 16/3/17.
// Copyright (c) 2016 Famiover. All rights reserved.
//
#import "NSDate+DateTools.h"
#import <PureLayout/ALView+PureLayout.h>
#import "RJDatePicker.h"

@interface RJDatePicker () <UIPickerViewDataSource, UIPickerViewDelegate>
@property(nonatomic, strong) NSArray *years;
@property(nonatomic, strong) NSArray *months;
@property(nonatomic, strong) NSArray *days;
@property(nonatomic, strong) NSArray *hours;
@property(nonatomic, strong) NSArray *minutes;
@property(nonatomic, strong) UILabel *pickerLabel;

@property(nonatomic, strong) NSString *currentDateTime;
@property(nonatomic, strong) NSString *currentYear;
@property(nonatomic, strong) NSString *currentMonth;
@property(nonatomic, strong) NSString *currentDay;
@property(nonatomic, strong) NSString *currentHour;
@property(nonatomic, strong) NSString *currentMintue;

@end

@implementation RJDatePicker {

}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initData];
        [self setupUI];
    }
    return self;
}


- (void)setupUI {
    self.backgroundColor = [UIColor whiteColor];
    self.toolbar = [UIToolbar newAutoLayoutView];
    [self addSubview:self.toolbar];

    UIButton *rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 35)];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
    [rightBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];

    [rightBtn setTitle:@"取消" forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(cancelPicker) forControlEvents:UIControlEventTouchUpInside];


    UIButton *leftBtn = [[UIButton alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-80, 0, 80, 35)];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:12.5];
    [leftBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [leftBtn setTitle:@"确认" forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(confirmPicker) forControlEvents:UIControlEventTouchUpInside];



    [self.toolbar autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.toolbar autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.toolbar autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [self.toolbar autoSetDimensionsToSize:CGSizeMake([[UIScreen mainScreen] bounds].size.width, 40)];

    [self.toolbar addSubview:leftBtn];
    [self.toolbar addSubview:rightBtn];

    self.pickerView = [UIPickerView newAutoLayoutView];
    self.pickerView.showsSelectionIndicator=YES;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    [self addSubview:self.pickerView];

    [self.pickerView selectRow:[self.years indexOfObject:self.currentYear] inComponent:0 animated:NO];
    [self.pickerView selectRow:[self.months indexOfObject:self.currentMonth] inComponent:1 animated:NO];
    [self.pickerView selectRow:[self.days indexOfObject:self.currentDay] inComponent:2 animated:NO];
    [self.pickerView selectRow:[self.hours indexOfObject:self.currentHour] inComponent:3 animated:NO];
    [self.pickerView selectRow:[self.minutes indexOfObject:self.currentMintue] inComponent:4 animated:NO];

    [self.pickerView autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.toolbar];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0.0f];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [self.pickerView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
}

- (void)confirmPicker {
    if(_block){
        self.block(self.currentDateTime);
    }
}

- (void)cancelPicker {
    if(_block){
        self.block(@"cancle");
    }
}

- (void)initData {
    NSDate *now = [[NSDate alloc] init];
    self.currentYear = [NSString stringWithFormat:@"%@", [self numberToString:now.year]];
    self.currentMonth = [NSString stringWithFormat:@"%@", [self numberToString:now.month]];
    self.currentDay = [NSString stringWithFormat:@"%@", [self numberToString:now.day]];
    self.currentHour = [NSString stringWithFormat:@"%@", [self numberToString:now.hour]];
    self.currentMintue = [NSString stringWithFormat:@"%@", [self numberToString:now.minute]];


    self.currentDateTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", self.currentYear, self.currentMonth, self.currentDay, self.currentHour, self.currentMintue];

    self.years = @[@"2016", @"2017", @"2018", @"2019", @"2020"];
    self.months = @[@"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12"];
    self.days = @[
            @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12",
            @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",
            @"25", @"26", @"27", @"28", @"29", @"30", @"31"
    ];
    self.hours = @[
            @"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11",
            @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23"
    ];

    self.minutes = @[
            @"00", @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11",
            @"12", @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23",
            @"24", @"25", @"26", @"27", @"28", @"29", @"30", @"31", @"32", @"33", @"34", @"35",
            @"36", @"37", @"38", @"39", @"40", @"41", @"42", @"43", @"44", @"45", @"46", @"47",
            @"48", @"49", @"50", @"51", @"52", @"53", @"54", @"55", @"56", @"57", @"58", @"59"
    ];
}

- (NSString *)numberToString:(NSInteger)num {
    if (num < 10) {
        return [NSString stringWithFormat:@"0%d", num];
    }
    return [NSString stringWithFormat:@"%d", num];
}

#pragma mark - PickerView Datasource & delegate

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    self.pickerLabel = (UILabel *) view;
    if (component == 0) {
        self.pickerLabel.text = [NSString stringWithFormat:@"%@年",self.years[row]];
    }
    if (component == 1) {
        self.pickerLabel.text = [NSString stringWithFormat:@"%@月",self.months[row]];
    }
    if (component == 2) {
        self.pickerLabel.text = [NSString stringWithFormat:@"%@日",self.days[row]];
    }
    if (component == 3) {
        self.pickerLabel.text = [NSString stringWithFormat:@"%@时",self.hours[row]];
    }
    if (component == 4) {
        self.pickerLabel.text =  [NSString stringWithFormat:@"%@分",self.minutes[row]];
    }
    return self.pickerLabel;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 5;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.years.count;
    }
    if (component == 1) {
        return self.months.count;
    }
    if (component == 2) {
        return [self getFebDays];
    }
    if (component == 3) {
        return self.hours.count;
    }
    //component == 5
    return self.minutes.count;
}

- (NSInteger)getFebDays {
    if ([self is31Days]) {
        return 31;
    }
    if ([self.currentMonth isEqualToString:@"02"]) {
        int year = [self.currentYear integerValue];
        if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
            return 29;
        } else {
            return 28;
        }
    } else {
        return 30;
    }
}

- (BOOL)is31Days {
    BOOL flag1 = [self.currentMonth isEqualToString:@"01"] || [self.currentMonth isEqualToString:@"03"] || [self.currentMonth isEqualToString:@"05"];
    BOOL flag2 = [self.currentMonth isEqualToString:@"07"] || [self.currentMonth isEqualToString:@"08"] || [self.currentMonth isEqualToString:@"10"];
    BOOL flag3 = [self.currentMonth isEqualToString:@"12"];
    return flag1 || flag2 || flag3;
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return ([[UIScreen mainScreen] bounds].size.width/5.0);
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.currentYear = self.years[row];
        [self reloadDayComponent];
    }
    if (component == 1) {
        self.currentMonth = self.months[row];
        [self reloadDayComponent];
    }
    if (component == 2) {
        self.currentDay = self.days[row];
    }
    if (component == 3) {
        self.currentHour = self.hours[row];
    }
    if (component == 4) {
        self.currentMintue = self.minutes[row];
    }
    self.currentDateTime = [NSString stringWithFormat:@"%@-%@-%@ %@:%@", self.currentYear, self.currentMonth, self.currentDay, self.currentHour, self.currentMintue];
    NSLog(@"当前的时间是:%@", _currentDateTime);
}

- (void)reloadDayComponent {
    if (![self.currentMonth isEqualToString:@"02"]) {
        if ([self is31Days]) {
            self.days = @[
                    @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12",
                    @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",
                    @"25", @"26", @"27", @"28", @"29", @"30", @"31"];
        } else {
            self.days = @[
                    @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12",
                    @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",
                    @"25", @"26", @"27", @"28", @"29", @"30"];
        }
        [self.pickerView reloadComponent:2];
        return;
    }
    int year = [self.currentYear integerValue];
    if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) {
        self.days = @[
                @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12",
                @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",
                @"25", @"26", @"27", @"28", @"29"
        ];
    } else {
        self.days = @[
                @"01", @"02", @"03", @"04", @"05", @"06", @"07", @"08", @"09", @"10", @"11", @"12",
                @"13", @"14", @"15", @"16", @"17", @"18", @"19", @"20", @"21", @"22", @"23", @"24",
                @"25", @"26", @"27", @"28"
        ];
    }
    [self.pickerView reloadComponent:2];
}

- (UILabel *)pickerLabel {
    if (_pickerLabel == nil) {
        CGRect frame = CGRectMake(0.0, 0.0, 55, 60);
        _pickerLabel = [[UILabel alloc] initWithFrame:frame];
        [_pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [_pickerLabel setBackgroundColor:[UIColor clearColor]];
        [_pickerLabel setFont:[UIFont systemFontOfSize:15.0f]];
    }
    return _pickerLabel;
}
- (void)setDateTimeBlock:(DateTimeBlock)block {
    self.block = block;
}
@end