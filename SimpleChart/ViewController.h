//
//  ViewController.h
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/09.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SimpleChartView.h"

@interface ViewController : UIViewController <SimpleChartViewDataSource>

@property (nonatomic, strong) IBOutlet SimpleChartView  *simpleChartView;

- (IBAction)drawAxisX:(id)sender;
- (IBAction)drawAxisY:(id)sender;
- (IBAction)drawGridX:(id)sender;
- (IBAction)drawGridY:(id)sender;
- (IBAction)drawInfo:(id)sender;

@end
