//
//  LeeWaveView.m
//  MMMMM
//
//  Created by jmit on 16/8/25.
//  Copyright © 2016年 godHands. All rights reserved.
//

#import "LeeWaveView.h"


static int count=0;

//波浪高低系数
static float waveHeightP=3;

//波浪衰减速度
static float decrease=0.1;

//波浪变化快慢系数
static float waveChangeRate=0.1;


@interface LeeWaveView ()
{
    float b;
    CADisplayLink *waveDisplayLink;
    CAShapeLayer *waveShapeLayer;
}
@end

@implementation LeeWaveView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setBackgroundColor:[UIColor clearColor]];
        b = 0;
        waveShapeLayer = [CAShapeLayer layer];
        waveShapeLayer.fillColor = [UIColor redColor].CGColor;
        [self.layer addSublayer:waveShapeLayer];
        
        [self start];
    }
    return self;
}

-(void)wave
{
    if (count>100) {
        waveHeightP-=decrease;
        if (waveHeightP<0) {
            waveHeightP=0;
            [self stop];
            return;
        }
    }
    count++;
    
    b+=waveChangeRate;
    
    CGRect rect=self.frame;
    CGMutablePathRef path = CGPathCreateMutable();
    
    float y=0;
    CGPathMoveToPoint(path, NULL, 0, y);
    for(float x=0;x<=(int)rect.size.width;x++){
        /**
         *  y=sin(cx+b)*h
         *  c控制波浪个数
         *  b控制波浪变化快慢
         *  h控制波浪高度
         */
        y=sin(x/50+b)*waveHeightP;
        CGPathAddLineToPoint(path, NULL, x, y);
    }
    
    CGPathAddLineToPoint(path, NULL, rect.size.width, rect.size.height);
    CGPathAddLineToPoint(path, NULL, 0, rect.size.height);
    
    waveShapeLayer.path = path;
    CGPathRelease(path);
    
}

-(void)start{
    if (!waveDisplayLink) {
        waveDisplayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(wave)];
        [waveDisplayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}
-(void)stop{
    [waveDisplayLink invalidate];
    waveDisplayLink = nil;
    //waveShapeLayer.path = nil;
}

@end
