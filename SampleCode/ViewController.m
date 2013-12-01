//
//  ViewController.m
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/09.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, strong) NSMutableArray    *dateValues;
@property (nonatomic, strong) NSMutableArray    *supplyYValues;
@property (nonatomic, strong) NSMutableArray    *actualYValues;
@property (nonatomic, strong) NSMutableArray    *forecastYValues;
- (void)_init;
@end

@implementation ViewController

@synthesize simpleChartView = _simpleChartView;
@synthesize dateValues = _dateValues;
@synthesize supplyYValues = _supplyYValues;
@synthesize actualYValues = _actualYValues;
@synthesize forecastYValues = _forecastYValues;

- (void)viewDidLoad
{
    DBGMSG(@"%s", __func__);
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self _init];
    
    /* InterfaceBuilderでフレームワークのクラスを認識できない問題の対処 */
    [SimpleChartView class];

    DBGMSG(@"%s simpleChartView:%@", __func__, self.simpleChartView);
    DBGMSG(@"%s dataSource:%@", __func__, self.simpleChartView.dataSource);
	self.simpleChartView.dataSource = self;

    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setMaximumFractionDigits:0];
    
    self.simpleChartView.yValuesFormatter = numberFormatter;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    
    self.simpleChartView.xValuesFormatter = dateFormatter;
    
    self.simpleChartView.drawAxisX = YES;
    self.simpleChartView.drawAxisY = YES;
    self.simpleChartView.drawGridX = YES;
    self.simpleChartView.drawGridY = YES;
    
    self.simpleChartView.xValuesColor = [UIColor whiteColor];
    self.simpleChartView.yValuesColor = [UIColor whiteColor];
    
    self.simpleChartView.gridXColor = [UIColor whiteColor];
    self.simpleChartView.gridYColor = [UIColor whiteColor];
    
    self.simpleChartView.drawInfo = YES;
    self.simpleChartView.info = @"SimpleChart demonstration";
    self.simpleChartView.infoColor = [UIColor whiteColor];
    
    [self.simpleChartView reloadData];
}

- (void)viewDidUnload
{
    DBGMSG(@"%s", __func__);
    self.simpleChartView = nil;
    self.dateValues = nil;
    self.supplyYValues = nil;
    self.actualYValues = nil;
    self.forecastYValues = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)_init
{
    DBGMSG(@"%s", __func__);

    self.dateValues = [[NSMutableArray alloc] initWithCapacity:24];
    NSDate          *date_converted;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
	for (int i = 0; i < 24 ; i++) {
        NSString    *date_source = [NSString stringWithFormat:@"2011/4/30 %02d:00", i];
        date_converted = [formatter dateFromString:date_source];
        [self.dateValues addObject:date_converted];
	}
    
    self.supplyYValues = [[NSMutableArray alloc] initWithCapacity:101];
    for ( int i = 0; i < 24 ; i ++ ) {
        [self.supplyYValues addObject:[NSNumber numberWithInt:4000]];		
    }

    self.actualYValues = [[NSMutableArray alloc] initWithCapacity:101];
    [self.actualYValues addObject:[NSNumber numberWithInt:2613]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2505]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2452]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2418]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2396]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2408]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2597]];
    [self.actualYValues addObject:[NSNumber numberWithInt:2768]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3013]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3195]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3234]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3256]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3080]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3255]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3269]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3245]];
    [self.actualYValues addObject:[NSNumber numberWithInt:3266]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];
    [self.actualYValues addObject:[NSNumber numberWithInt:0]];

    self.forecastYValues = [[NSMutableArray alloc] initWithCapacity:101];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2643]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2526]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2474]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2442]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2432]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2453]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2648]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2811]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3060]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3220]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3234]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3235]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3045]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3223]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3255]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3237]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3251]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3209]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3343]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3328]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3214]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3095]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:3020]];
    [self.forecastYValues addObject:[NSNumber numberWithInt:2828]];
}

- (IBAction)drawAxisX:(id)sender
{
    if (self.simpleChartView.drawAxisX == YES)
        self.simpleChartView.drawAxisX = NO;
    else
        self.simpleChartView.drawAxisX = YES;
    
    [self.simpleChartView reloadData];
}

- (IBAction)drawAxisY:(id)sender
{
    if (self.simpleChartView.drawAxisY == YES)
        self.simpleChartView.drawAxisY = NO;
    else
        self.simpleChartView.drawAxisY = YES;

    [self.simpleChartView reloadData];
}

- (IBAction)drawGridX:(id)sender
{
    if (self.simpleChartView.drawGridX == YES)
        self.simpleChartView.drawGridX = NO;
    else
        self.simpleChartView.drawGridX = YES;

    [self.simpleChartView reloadData];
}

- (IBAction)drawGridY:(id)sender
{
    if (self.simpleChartView.drawGridY == YES)
        self.simpleChartView.drawGridY = NO;
    else
        self.simpleChartView.drawGridY = YES;

    [self.simpleChartView reloadData];
}

- (IBAction)drawInfo:(id)sender
{
    if (self.simpleChartView.drawInfo == YES)
        self.simpleChartView.drawInfo = NO;
    else
        self.simpleChartView.drawInfo = YES;
    
    [self.simpleChartView reloadData];
}

#pragma mark -
#pragma mark protocol S7GraphViewDataSource methods

- (NSUInteger)numberOfPlotsInSimpleChartView:(SimpleChartView *)simpleChartView
{
    return 3;
}

- (NSUInteger)numberOfXValuesInSimpleChartView:(SimpleChartView *)simpleChartView
{
    return self.dateValues.count;
}

- (NSUInteger)simpleChartView:(SimpleChartView *)simpleChartView numberOfYValuesInPlot:(NSUInteger)plotIndex
{
    NSArray *array = nil;
    if (0 == plotIndex) {
        array = self.supplyYValues;
    }
    else if (1 == plotIndex) {
        array = self.actualYValues;
    }
    else if (2 == plotIndex) {
        array = self.forecastYValues;
    }
    return array.count;
}

- (id)simpleChartView:(SimpleChartView *)simpleChartView XValueAtIndex:(NSUInteger)index
{
    return [self.dateValues objectAtIndex:index];
}


- (NSNumber *)simpleChartView:(SimpleChartView *)simpleChartView YValueAtPlot:(NSUInteger)plotIndex value:(NSUInteger)valueIndex
{
    NSArray *array = nil;
    if (0 == plotIndex) {
        array = self.supplyYValues;
    }
    else if (1 == plotIndex) {
        array = self.actualYValues;
    }
    else if (2 == plotIndex) {
        array = self.forecastYValues;
    }
    NSNumber    *number = [array objectAtIndex:valueIndex];
    return number;
}

- (BOOL)simpleChartView:(SimpleChartView *)simpleChartView shouldFillPlot:(NSUInteger)plotIndex
{
    DBGMSG(@"%s", __func__);
    return NO;
}

#pragma mark -
#pragma mark protocol SimpleChartViewDelegate methods

@end
