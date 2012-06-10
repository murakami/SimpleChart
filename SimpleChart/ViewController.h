//
//  ViewController.h
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/09.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "S7GraphView.h"

@interface ViewController : UIViewController <S7GraphViewDataSource>

@property (nonatomic, strong) IBOutlet S7GraphView  *s7graphView;

@end
