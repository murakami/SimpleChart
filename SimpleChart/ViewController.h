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

@end
