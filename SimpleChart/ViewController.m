//
//  ViewController.m
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/09.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

@synthesize s7graphView = _s7graphView;

- (void)viewDidLoad
{
    DBGMSG(@"%s", __func__);
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    //self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    //self.s7graphView = [[S7GraphView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	//self.view = self.s7graphView;
	self.s7graphView.dataSource = self;
    //self.view.backgroundColor = [UIColor yellowColor];

    NSNumberFormatter *numberFormatter = [NSNumberFormatter new];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMinimumFractionDigits:0];
    [numberFormatter setMaximumFractionDigits:0];
    
    self.s7graphView.yValuesFormatter = numberFormatter;
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateStyle:NSDateFormatterNoStyle];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    
    self.s7graphView.xValuesFormatter = dateFormatter;
        
    self.s7graphView.backgroundColor = [UIColor blackColor];
    
    self.s7graphView.drawAxisX = YES;
    self.s7graphView.drawAxisY = YES;
    self.s7graphView.drawGridX = YES;
    self.s7graphView.drawGridY = YES;
    
    self.s7graphView.xValuesColor = [UIColor whiteColor];
    self.s7graphView.yValuesColor = [UIColor whiteColor];
    
    self.s7graphView.gridXColor = [UIColor whiteColor];
    self.s7graphView.gridYColor = [UIColor whiteColor];
    
    self.s7graphView.drawInfo = NO;
    self.s7graphView.info = @"Load";
    self.s7graphView.infoColor = [UIColor whiteColor];
    
    [self.s7graphView reloadData];
}

- (void)viewDidUnload
{
    DBGMSG(@"%s", __func__);
    self.s7graphView = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark -
#pragma mark protocol S7GraphViewDataSource methods

- (NSUInteger)graphViewNumberOfPlots:(S7GraphView *)graphView
{
    /* Return the number of plots you are going to have in the view. 1+ */
    DBGMSG(@"%s", __func__);
	return 3;
}

- (NSArray *)graphViewXValues:(S7GraphView *)graphView
{
    /* An array of objects that will be further formatted to be displayed on the X-axis.
	 The number of elements should be equal to the number of points you have for every plot. */
    DBGMSG(@"%s", __func__);
	NSMutableArray  *array = [[NSMutableArray alloc] initWithCapacity:24];
    NSDate          *date_converted;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
	for (int i = 0; i < 24 ; i++) {
		//[array addObject:[NSNumber numberWithInt:i]];
        DBGMSG(@"index: %d", i);
        NSString    *date_source = [NSString stringWithFormat:@"2011/4/30 %02d:00", i];
        DBGMSG(@"%@", date_source);
        date_converted = [formatter dateFromString:date_source];
        DBGMSG(@"%@", date_converted);
        //NSDate  *date = [NSDate dateWithTimeInterval:(86400 * i) sinceDate:today];
        [array addObject:date_converted];
        DBGMSG(@"%@", array);
	}
	return array;
}

- (NSArray *)graphView:(S7GraphView *)graphView yValuesForPlot:(NSUInteger)plotIndex
{
    /* Return the values for a specific graph. Each plot is meant to have equal number of points.
	 And this amount should be equal to the amount of elements you return from graphViewXValues: method. */
    DBGMSG(@"%s", __func__);
	NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:101];
	switch (plotIndex) {
		default:
		case 0:
			for ( int i = 0; i < 24 ; i ++ ) {
				[array addObject:[NSNumber numberWithInt:4000]];		
			}
			break;
		case 1:
            [array addObject:[NSNumber numberWithInt:2613]];
            [array addObject:[NSNumber numberWithInt:2505]];
            [array addObject:[NSNumber numberWithInt:2452]];
            [array addObject:[NSNumber numberWithInt:2418]];
            [array addObject:[NSNumber numberWithInt:2396]];
            [array addObject:[NSNumber numberWithInt:2408]];
            [array addObject:[NSNumber numberWithInt:2597]];
            [array addObject:[NSNumber numberWithInt:2768]];
            [array addObject:[NSNumber numberWithInt:3013]];
            [array addObject:[NSNumber numberWithInt:3195]];
            [array addObject:[NSNumber numberWithInt:3234]];
            [array addObject:[NSNumber numberWithInt:3256]];
            [array addObject:[NSNumber numberWithInt:3080]];
            [array addObject:[NSNumber numberWithInt:3255]];
            [array addObject:[NSNumber numberWithInt:3269]];
            [array addObject:[NSNumber numberWithInt:3245]];
            [array addObject:[NSNumber numberWithInt:3266]];
            [array addObject:[NSNumber numberWithInt:0]];
            [array addObject:[NSNumber numberWithInt:0]];
            [array addObject:[NSNumber numberWithInt:0]];
            [array addObject:[NSNumber numberWithInt:0]];
            [array addObject:[NSNumber numberWithInt:0]];
            [array addObject:[NSNumber numberWithInt:0]];
            [array addObject:[NSNumber numberWithInt:0]];
			break;
		case 2:
            [array addObject:[NSNumber numberWithInt:2643]];
            [array addObject:[NSNumber numberWithInt:2526]];
            [array addObject:[NSNumber numberWithInt:2474]];
            [array addObject:[NSNumber numberWithInt:2442]];
            [array addObject:[NSNumber numberWithInt:2432]];
            [array addObject:[NSNumber numberWithInt:2453]];
            [array addObject:[NSNumber numberWithInt:2648]];
            [array addObject:[NSNumber numberWithInt:2811]];
            [array addObject:[NSNumber numberWithInt:3060]];
            [array addObject:[NSNumber numberWithInt:3220]];
            [array addObject:[NSNumber numberWithInt:3234]];
            [array addObject:[NSNumber numberWithInt:3235]];
            [array addObject:[NSNumber numberWithInt:3045]];
            [array addObject:[NSNumber numberWithInt:3223]];
            [array addObject:[NSNumber numberWithInt:3255]];
            [array addObject:[NSNumber numberWithInt:3237]];
            [array addObject:[NSNumber numberWithInt:3251]];
            [array addObject:[NSNumber numberWithInt:3209]];
            [array addObject:[NSNumber numberWithInt:3343]];
            [array addObject:[NSNumber numberWithInt:3328]];
            [array addObject:[NSNumber numberWithInt:3214]];
            [array addObject:[NSNumber numberWithInt:3095]];
            [array addObject:[NSNumber numberWithInt:3020]];
            [array addObject:[NSNumber numberWithInt:2828]];
			break;
	}
	
	return array;
}

/*
 - (BOOL)graphView:(S7GraphView *)graphView shouldFillPlot:(NSUInteger)plotIndex
 {
 DBGMSG(@"%s", __func__);
 return YES;
 }
 */

@end
