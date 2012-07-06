//
//  SimpleChartView.h
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/10.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleChartView;

@protocol SimpleChartViewDataSource <NSObject>

@optional
- (BOOL)simpleChartView:(SimpleChartView *)simpleChartView shouldFillPlot:(NSUInteger)plotIndex;

@required
- (NSUInteger)simpleChartViewNumberOfPlots:(SimpleChartView *)simpleChartView;
- (NSArray *)simpleChartViewXValues:(SimpleChartView *)simpleChartView;
- (NSArray *)simpleChartView:(SimpleChartView *)simpleChartView yValuesForPlot:(NSUInteger)plotIndex;

@end

@interface SimpleChartView : UIView

@property (nonatomic, weak) IBOutlet id<SimpleChartViewDataSource> dataSource;
@property (nonatomic, strong) IBOutlet NSFormatter *xValuesFormatter;
@property (nonatomic, strong) IBOutlet NSFormatter *yValuesFormatter;
@property (nonatomic, assign) BOOL drawAxisX;
@property (nonatomic, assign) BOOL drawAxisY;
@property (nonatomic, assign) BOOL drawGridX;
@property (nonatomic, assign) BOOL drawGridY;
@property (nonatomic, strong) UIColor *xValuesColor;
@property (nonatomic, strong) UIColor *yValuesColor;
@property (nonatomic, strong) UIColor *gridXColor;
@property (nonatomic, strong) UIColor *gridYColor;
@property (nonatomic, assign) BOOL drawInfo;
@property (nonatomic, copy) NSString *info;
@property (nonatomic, strong) UIColor *infoColor;

- (void)reloadData;

@end
