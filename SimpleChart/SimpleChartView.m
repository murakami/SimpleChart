//
//  SimpleChartView.m
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/10.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "SimpleChartView.h"

@interface SimpleChartView ()
@property (nonatomic, strong) NSMutableArray    *xValues;
@property (nonatomic, strong) NSMutableArray    *yValues;
@property (nonatomic, strong) NSDateFormatter   *xValuesFormatter;
@property (nonatomic, strong) NSNumberFormatter *yValuesFormatter;
- (void)_init;
@end

@implementation SimpleChartView

@synthesize xValues = _xValues;
@synthesize yValues = _yValues;
@synthesize xValuesFormatter = _xValuesFormatter;
@synthesize yValuesFormatter = _yValuesFormatter;

- (id)initWithFrame:(CGRect)frame
{
    DBGMSG(@"%s", __func__);
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self _init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)decoder
{
    DBGMSG(@"%s", __func__);
    self = [super initWithCoder:decoder];
    if (self) {
        [self _init];
    }
    return self;
}

- (void)_init
{
    DBGMSG(@"%s", __func__);

    /* X軸 */
	self.xValues = [[NSMutableArray alloc] initWithCapacity:24];
    NSDate          *date_converted;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    [formatter setDateFormat:@"yyyy/MM/dd HH:mm"];
	for (int i = 0; i < 24 ; i++) {
        NSString    *date_source = [NSString stringWithFormat:@"2011/4/30 %02d:00", i];
        date_converted = [formatter dateFromString:date_source];
        [self.xValues addObject:date_converted];
	}

    /* Y軸 */
    self.yValues = [[NSMutableArray alloc] initWithCapacity:101];
    [self.yValues addObject:[NSNumber numberWithInt:2643]];
    [self.yValues addObject:[NSNumber numberWithInt:2526]];
    [self.yValues addObject:[NSNumber numberWithInt:2474]];
    [self.yValues addObject:[NSNumber numberWithInt:2442]];
    [self.yValues addObject:[NSNumber numberWithInt:2432]];
    [self.yValues addObject:[NSNumber numberWithInt:2453]];
    [self.yValues addObject:[NSNumber numberWithInt:2648]];
    [self.yValues addObject:[NSNumber numberWithInt:2811]];
    [self.yValues addObject:[NSNumber numberWithInt:3060]];
    [self.yValues addObject:[NSNumber numberWithInt:3220]];
    [self.yValues addObject:[NSNumber numberWithInt:3234]];
    [self.yValues addObject:[NSNumber numberWithInt:3235]];
    [self.yValues addObject:[NSNumber numberWithInt:3045]];
    [self.yValues addObject:[NSNumber numberWithInt:3223]];
    [self.yValues addObject:[NSNumber numberWithInt:3255]];
    [self.yValues addObject:[NSNumber numberWithInt:3237]];
    [self.yValues addObject:[NSNumber numberWithInt:3251]];
    [self.yValues addObject:[NSNumber numberWithInt:3209]];
    [self.yValues addObject:[NSNumber numberWithInt:3343]];
    [self.yValues addObject:[NSNumber numberWithInt:3328]];
    [self.yValues addObject:[NSNumber numberWithInt:3214]];
    [self.yValues addObject:[NSNumber numberWithInt:3095]];
    [self.yValues addObject:[NSNumber numberWithInt:3020]];
    [self.yValues addObject:[NSNumber numberWithInt:2828]];
        
    self.xValuesFormatter = [[NSDateFormatter alloc] init];
    [self.xValuesFormatter setTimeStyle:NSDateFormatterShortStyle];
    [self.xValuesFormatter setDateStyle:NSDateFormatterNoStyle];
    [self.xValuesFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]];
    
    self.yValuesFormatter = [[NSNumberFormatter alloc] init];
    [self.yValuesFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [self.yValuesFormatter setMinimumFractionDigits:0];
    [self.yValuesFormatter setMaximumFractionDigits:0];
}

- (void)dealloc
{
    DBGMSG(@"%s", __func__);
    self.xValues = nil;
    self.yValues = nil;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    DBGMSG(@"%s", __func__);
    // Drawing code

    CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextFillRect(context, rect);
    
    CGFloat offsetX = 10.0f;
	CGFloat offsetY = 10.0f;
    
    //CGFloat minY = 0.0;
	CGFloat maxY = 0.0;

    for (NSUInteger valueIndex = 0; valueIndex < self.yValues.count; valueIndex++) {
        if ([[self.yValues objectAtIndex:valueIndex] floatValue] > maxY) {
            maxY = [[self.yValues objectAtIndex:valueIndex] floatValue];
        }
    }

	if (maxY < 100) {
		maxY = ceil(maxY / 10) * 10;
	} 
	
	if (maxY > 100 && maxY < 1000) {
		maxY = ceil(maxY / 100) * 100;
	} 
	
	if (maxY > 1000 && maxY < 10000) {
		maxY = ceil(maxY / 1000) * 1000;
	}
	
	if (maxY > 10000 && maxY < 100000) {
		maxY = ceil(maxY / 10000) * 10000;
	}

    //CGFloat step = (maxY - minY) / 5;
	CGFloat stepY = (self.frame.size.height - (offsetY * 2)) / maxY;

    NSUInteger xValuesCount = self.xValues.count;
    
    CGFloat stepX = (self.frame.size.width - (offsetX * 2)) / (xValuesCount - 1);

    CGContextSetLineDash(context, 0, NULL, 0);
		
	CGColorRef plotColor = [UIColor whiteColor].CGColor;
		
	for (NSUInteger valueIndex = 0; valueIndex < self.yValues.count - 1; valueIndex++) {
        NSUInteger x = valueIndex * stepX;
        NSUInteger y = [[self.yValues objectAtIndex:valueIndex] intValue] * stepY;
			
        CGContextSetLineWidth(context, 1.5f);
			
        CGPoint startPoint = CGPointMake(x + offsetX, self.frame.size.height - y - offsetY);
			
        x = (valueIndex + 1) * stepX;
        y = [[self.yValues objectAtIndex:valueIndex + 1] intValue] * stepY;
			
        CGPoint endPoint = CGPointMake(x + offsetX, self.frame.size.height - y - offsetY);
			
        CGContextMoveToPoint(context, startPoint.x, startPoint.y);
        CGContextAddLineToPoint(context, endPoint.x, endPoint.y);
        CGContextClosePath(context);

        CGContextSetStrokeColorWithColor(context, plotColor);
        CGContextStrokePath(context);
    }
}

@end
