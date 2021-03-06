//
//  SimpleChartView.h
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/10.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SimpleChartView;

/*!
 * @@protocol SimpleChartViewDataSource
 * @abstract SimpleChartViewDataSourceプロトコル
 * @discussion SimpleChartViewDataSourceのデリゲートの為のプロトコル。
 */
@protocol SimpleChartViewDataSource
- (NSUInteger)numberOfPlotsInSimpleChartView:(SimpleChartView *)simpleChartView;
- (NSUInteger)numberOfXValuesInSimpleChartView:(SimpleChartView *)simpleChartView;
- (NSUInteger)simpleChartView:(SimpleChartView *)simpleChartView numberOfYValuesInPlot:(NSUInteger)plotIndex;
- (id)simpleChartView:(SimpleChartView *)simpleChartView XValueAtIndex:(NSUInteger)index;
- (NSNumber *)simpleChartView:(SimpleChartView *)simpleChartView YValueAtPlot:(NSUInteger)plotIndex value:(NSUInteger)valueIndex;
@optional
- (BOOL)simpleChartView:(SimpleChartView *)simpleChartView shouldFillPlot:(NSUInteger)plotIndex;
@end

@protocol SimpleChartViewDelegate
@optional
@end

/*!
 * @class SimpleChartView
 * @abstract SimpleChartViewクラス
 * @discussion 単純なチャート・ビュー。
 */
@interface SimpleChartView : UIView

@property (nonatomic, weak) IBOutlet id<SimpleChartViewDataSource, NSObject> dataSource;
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
