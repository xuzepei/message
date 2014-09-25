//
//  FDButton.m
//  Food
//
//  Created by xu zepei on 11/14/11.
//  Copyright (c) 2011 rumtel. All rights reserved.
//

#import "FDButton.h"
#import "RCTool.h"

@implementation FDButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRoundRect:(CGRect)rect
{
    // As a bonus, we'll combine arcs to create a round rectangle! 
    
    // Drawing with a white stroke color 
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1.0);
    CGContextSetLineWidth(context, 5.0);
    
    // If you were making this as a routine, you would probably accept a rectangle 
    // that defines its bounds, and a radius reflecting the "rounded-ness" of the rectangle. 
    CGRect rrect = rect; 
    CGFloat radius = 10.0; 
    // NOTE: At this point you may want to verify that your radius is no more than half 
    // the width and height of your rectangle, as this technique degenerates for those cases. 
    
    // In order to draw a rounded rectangle, we will take advantage of the fact that 
    // CGContextAddArcToPoint will draw straight lines past the start and end of the arc 
    // in order to create the path from the current position and the destination position. 
    
    // In order to create the 4 arcs correctly, we need to know the min, mid and max positions 
    // on the x and y lengths of the given rectangle. 
    CGFloat minx = CGRectGetMinX(rrect), midx = CGRectGetMidX(rrect), maxx = CGRectGetMaxX(rrect); 
    CGFloat miny = CGRectGetMinY(rrect), midy = CGRectGetMidY(rrect), maxy = CGRectGetMaxY(rrect); 
    
    // Next, we will go around the rectangle in the order given by the figure below. 
    //       minx    midx    maxx 
    // miny    2       3       4 
    // midy   1 9              5 
    // maxy    8       7       6 
    // Which gives us a coincident start and end point, which is incidental to this technique, but still doesn't 
    // form a closed path, so we still need to close the path to connect the ends correctly. 
    // Thus we start by moving to point 1, then adding arcs through each pair of points that follows. 
    // You could use a similar tecgnique to create any shape with rounded corners. 
    
    // Start at 1 
    CGContextMoveToPoint(context, minx, midy); 
    // Add an arc through 2 to 3 
    CGContextAddArcToPoint(context, minx, miny, midx, miny, radius); 
    // Add an arc through 4 to 5 
    CGContextAddArcToPoint(context, maxx, miny, maxx, midy, radius); 
    // Add an arc through 6 to 7 
    CGContextAddArcToPoint(context, maxx, maxy, midx, maxy, radius); 
    // Add an arc through 8 to 9 
    CGContextAddArcToPoint(context, minx, maxy, minx, midy, radius); 
    // Close the path 
    CGContextClosePath(context); 
    // Fill & stroke the path 
    CGContextDrawPath(context, kCGPathStroke); 
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
	if(NO == [RCTool isIpad])
	{
		if([_text length])
		{
			[_text drawInRect:CGRectMake(6,4,self.bounds.size.width - 12,CGFLOAT_MAX) 
					 withFont:self.font];
		}
	}
	else
	{
		if([_text length])
		{
			[_text drawInRect:CGRectMake(12,8,self.bounds.size.width - 24,CGFLOAT_MAX) 
					 withFont:self.font];
		}
	}

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    
    UITouch *touch = [touches anyObject];
	CGPoint endPoint = [touch locationInView: self];
	
	if(CGRectContainsPoint(self.bounds,endPoint))
    {
        if(_target)
            [_target performSelector:@selector(clickButton:) withObject:[NSNumber numberWithInt:self.tag]];
    }
}

@end
