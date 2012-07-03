//
//  SimpleChartView.m
//  SimpleChart
//
//  Created by 村上 幸雄 on 12/06/10.
//  Copyright (c) 2012年 ビッツ有限会社. All rights reserved.
//

#import "SimpleChartView.h"

@interface SimpleChartView ()
//@property (nonatomic, strong) NSMutableArray    *xValues;
//@property (nonatomic, strong) NSMutableArray    *yValues;
//@property (nonatomic, strong) NSDateFormatter   *xValuesFormatter;
//@property (nonatomic, strong) NSNumberFormatter *yValuesFormatter;
- (void)_init;
- (UIColor *)uiColorByIndex:(NSInteger)index;
- (void)drawBackground:(CGContextRef)context rect:(CGRect)rect;
@end

@implementation SimpleChartView

//@synthesize xValues = _xValues;
//@synthesize yValues = _yValues;
//@synthesize xValuesFormatter = _xValuesFormatter;
//@synthesize yValuesFormatter = _yValuesFormatter;
@synthesize dataSource = _dataSource;
@synthesize xValuesFormatter = _xValuesFormatter;
@synthesize yValuesFormatter = _yValuesFormatter;
@synthesize drawAxisX = _drawAxisX;
@synthesize drawAxisY = _drawAxisY;
@synthesize drawGridX = _drawGridX;
@synthesize drawGridY = _drawGridY;
@synthesize xValuesColor = _xValuesColor;
@synthesize yValuesColor = _yValuesColor;
@synthesize gridXColor = _gridXColor;
@synthesize gridYColor = _gridYColor;
@synthesize drawInfo = _drawInfo;
@synthesize info = _info;
@synthesize infoColor = _infoColor;

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

    self.dataSource = nil;
    self.xValuesFormatter = nil;
    self.yValuesFormatter = nil;
    self.drawAxisX = YES;
	self.drawAxisY = YES;
	self.drawGridX = YES;
	self.drawGridY = YES;
	self.xValuesColor = [UIColor blackColor];
	self.yValuesColor = [UIColor blackColor];
	self.gridXColor = [UIColor blackColor];
	self.gridYColor = [UIColor blackColor];
	self.drawInfo = NO;
    self.info = nil;
	self.infoColor = [UIColor blackColor];
}

- (void)dealloc
{
    DBGMSG(@"%s", __func__);
    //self.xValues = nil;
    //self.yValues = nil;

    self.dataSource = nil;
    self.xValuesFormatter = nil;
    self.yValuesFormatter = nil;
    self.drawAxisX = YES;
	self.drawAxisY = YES;
	self.drawGridX = YES;
	self.drawGridY = YES;
	self.xValuesColor = nil;
	self.yValuesColor = nil;
	self.gridXColor = nil;
	self.gridYColor = nil;
	self.drawInfo = NO;
    self.info = nil;
	self.infoColor = [UIColor blackColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    DBGMSG(@"%s", __func__);
    // Drawing code

    CGContextRef c = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(c, self.backgroundColor.CGColor);
	CGContextFillRect(c, rect);
	
	NSUInteger numberOfPlots = [self.dataSource simpleChartViewNumberOfPlots:self];
	
	if (!numberOfPlots) {
		return;
	}
	
	CGFloat offsetX = _drawAxisY ? 60.0f : 10.0f;
	CGFloat offsetY = (_drawAxisX || _drawInfo) ? 30.0f : 10.0f;
	
	CGFloat minY = 0.0;
	CGFloat maxY = 0.0;
	
	UIFont *font = [UIFont systemFontOfSize:11.0f];
	
	for (NSUInteger plotIndex = 0; plotIndex < numberOfPlots; plotIndex++) {
		
		NSArray *values = [self.dataSource simpleChartView:self yValuesForPlot:plotIndex];
		
		for (NSUInteger valueIndex = 0; valueIndex < values.count; valueIndex++) {
			
			if ([[values objectAtIndex:valueIndex] floatValue] > maxY) {
				maxY = [[values objectAtIndex:valueIndex] floatValue];
			}
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
	
	CGFloat step = (maxY - minY) / 5;
	CGFloat stepY = (self.frame.size.height - (offsetY * 2)) / maxY;
	
	for (NSUInteger i = 0; i < 6; i++) {
		
		NSUInteger y = (i * step) * stepY;
		NSUInteger value = i * step;
		
		if (_drawGridY) {
			
			CGFloat lineDash[2];
			lineDash[0] = 6.0f;
			lineDash[1] = 6.0f;
			
			CGContextSetLineDash(c, 0.0f, lineDash, 2);
			CGContextSetLineWidth(c, 0.1f);
			
			CGPoint startPoint = CGPointMake(offsetX, self.frame.size.height - y - offsetY);
			CGPoint endPoint = CGPointMake(self.frame.size.width - offsetX, self.frame.size.height - y - offsetY);
			
			CGContextMoveToPoint(c, startPoint.x, startPoint.y);
			CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
			CGContextClosePath(c);
			
			CGContextSetStrokeColorWithColor(c, self.gridYColor.CGColor);
			CGContextStrokePath(c);
		}
		
		if (i > 0 && _drawAxisY) {
			
			NSNumber *valueToFormat = [NSNumber numberWithInt:value];
			NSString *valueString;
			
			if (_yValuesFormatter) {
				valueString = [_yValuesFormatter stringForObjectValue:valueToFormat];
			} else {
				valueString = [valueToFormat stringValue];
			}
			
			[self.yValuesColor set];
			CGRect valueStringRect = CGRectMake(0.0f, self.frame.size.height - y - offsetY, 50.0f, 20.0f);
			
			[valueString drawInRect:valueStringRect withFont:font
					  lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentRight];
		}
	}
	
	NSUInteger maxStep;
	
	NSArray *xValues = [self.dataSource simpleChartViewXValues:self];
	NSUInteger xValuesCount = xValues.count;
	
	if (xValuesCount > 5) {
		
		NSUInteger stepCount = 5;
		NSUInteger count = xValuesCount - 1;
		
		for (NSUInteger i = 4; i < 8; i++) {
			if (count % i == 0) {
				stepCount = i;
			}
		}
		
		step = xValuesCount / stepCount;
		maxStep = stepCount + 1;
		
	} else {
		
		step = 1;
		maxStep = xValuesCount;
	}
	
	CGFloat stepX = (self.frame.size.width - (offsetX * 2)) / (xValuesCount - 1);
	
	for (NSUInteger i = 0; i < maxStep; i++) {
		
		NSUInteger x = (i * step) * stepX;
		
		if (x > self.frame.size.width - (offsetX * 2)) {
			x = self.frame.size.width - (offsetX * 2);
		}
		
		NSUInteger index = i * step;
		
		if (index >= xValuesCount) {
			index = xValuesCount - 1;
		}
		
		if (_drawGridX) {
			
			CGFloat lineDash[2];
			
			lineDash[0] = 6.0f;
			lineDash[1] = 6.0f;
			
			CGContextSetLineDash(c, 0.0f, lineDash, 2);
			CGContextSetLineWidth(c, 0.1f);
			
			CGPoint startPoint = CGPointMake(x + offsetX, offsetY);
			CGPoint endPoint = CGPointMake(x + offsetX, self.frame.size.height - offsetY);
			
			CGContextMoveToPoint(c, startPoint.x, startPoint.y);
			CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
			CGContextClosePath(c);
			
			CGContextSetStrokeColorWithColor(c, self.gridXColor.CGColor);
			CGContextStrokePath(c);
		}
		
		if (_drawAxisX) {
			
			id valueToFormat = [xValues objectAtIndex:index];
			NSString *valueString;
			
			if (_xValuesFormatter) {
				valueString = [_xValuesFormatter stringForObjectValue:valueToFormat];
			} else {
				valueString = [NSString stringWithFormat:@"%@", valueToFormat];
			}
			
			[self.xValuesColor set];
			[valueString drawInRect:CGRectMake(x, self.frame.size.height - 20.0f, 120.0f, 20.0f) withFont:font
					  lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
		}
	}
	
	stepX = (self.frame.size.width - (offsetX * 2)) / (xValuesCount - 1);
	
	CGContextSetLineDash(c, 0, NULL, 0);
	
	for (NSUInteger plotIndex = 0; plotIndex < numberOfPlots; plotIndex++) {
		
		NSArray *values = [self.dataSource simpleChartView:self yValuesForPlot:plotIndex];
		BOOL shouldFill = NO;
		
		if ([self.dataSource respondsToSelector:@selector(simpleChartView:shouldFillPlot:)]) {
			shouldFill = [self.dataSource simpleChartView:self shouldFillPlot:plotIndex];
		}
		
		CGColorRef plotColor = [SimpleChartView colorByIndex:plotIndex].CGColor;
		
		for (NSUInteger valueIndex = 0; valueIndex < values.count - 1; valueIndex++) {
			
			NSUInteger x = valueIndex * stepX;
			NSUInteger y = [[values objectAtIndex:valueIndex] intValue] * stepY;
			
			CGContextSetLineWidth(c, 1.5f);
			
			CGPoint startPoint = CGPointMake(x + offsetX, self.frame.size.height - y - offsetY);
			
			x = (valueIndex + 1) * stepX;
			y = [[values objectAtIndex:valueIndex + 1] intValue] * stepY;
			
			CGPoint endPoint = CGPointMake(x + offsetX, self.frame.size.height - y - offsetY);

#if 1
			CGContextMoveToPoint(c, startPoint.x, startPoint.y);
			CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
			CGContextClosePath(c);
#else
            if (([[values objectAtIndex:valueIndex] intValue] != 0)
                && ([[values objectAtIndex:valueIndex + 1] intValue] != 0)) {
                CGContextMoveToPoint(c, startPoint.x, startPoint.y);
                CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
                CGContextClosePath(c);
            }
#endif
			
			CGContextSetStrokeColorWithColor(c, plotColor);
			CGContextStrokePath(c);
			
			if (shouldFill) {
				
				CGContextMoveToPoint(c, startPoint.x, self.frame.size.height - offsetY);
				CGContextAddLineToPoint(c, startPoint.x, startPoint.y);
				CGContextAddLineToPoint(c, endPoint.x, endPoint.y);
				CGContextAddLineToPoint(c, endPoint.x, self.frame.size.height - offsetY);
				CGContextClosePath(c);
				
				CGContextSetFillColorWithColor(c, plotColor);
				CGContextFillPath(c);
			}
		}
	}
	
	if (_drawInfo) {
		
		font = [UIFont boldSystemFontOfSize:13.0f];
		[self.infoColor set];
		[_info drawInRect:CGRectMake(0.0f, 5.0f, self.frame.size.width, 20.0f) withFont:font
			lineBreakMode:UILineBreakModeTailTruncation alignment:UITextAlignmentCenter];
	}
}

- (UIColor *)uiColorByIndex:(NSInteger)index
{
	UIColor *uiColor = nil;
	
	switch (index) {
		case 0: uiColor = [UIColor redColor]; break;
		case 1: uiColor = [UIColor greenColor]; break;		
		case 2: uiColor = [UIColor blueColor]; break;
		case 3: uiColor = [UIColor cyanColor]; break;
		case 4: uiColor = [UIColor yellowColor]; break;
		case 5: uiColor = [UIColor magentaColor]; break;
		case 6: uiColor = [UIColor orangeColor]; break;
		case 7: uiColor = [UIColor purpleColor]; break;
		default: uiColor = [UIColor brownColor]; break;
	}	
	return uiColor;
}

- (void)drawBackground:(CGContextRef)context rect:(CGRect)rect
{
    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
	CGContextFillRect(context, rect);
}

+ (UIColor *)colorByIndex:(NSInteger)index
{
	UIColor *color;
	
	switch (index) {
		case 0: color = RGB(5, 141, 191);
			break;
		case 1: color = RGB(80, 180, 50);
			break;		
		case 2: color = RGB(255, 102, 0);
			break;
		case 3: color = RGB(255, 158, 1);
			break;
		case 4: color = RGB(252, 210, 2);
			break;
		case 5: color = RGB(248, 255, 1);
			break;
		case 6: color = RGB(176, 222, 9);
			break;
		case 7: color = RGB(106, 249, 196);
			break;
		case 8: color = RGB(178, 222, 255);
			break;
		case 9: color = RGB(4, 210, 21);
			break;
		default: color = RGB(204, 204, 204);
			break;
	}
	
	return color;
}

- (void)reloadData
{
	[self setNeedsDisplay];
}

@end
