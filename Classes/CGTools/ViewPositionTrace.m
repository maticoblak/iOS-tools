//
//  ViewPositionTrace.m
//  Toshl2.0
//
//  Created by Matic Oblak on 14/05/14.
//  Copyright (c) 2014 Matic Oblak. All rights reserved.
//

#import "ViewPositionTrace.h"
#import "CGPointTools.h"
@interface ViewPositionTrace()
@property (readonly) CGPoint *buffer;
@property (readonly) NSTimeInterval *intervals;
@end
////////////////////////////////////////////////////////
///           ---ViewPositionTrace---
///
///
#pragma mark - ViewPositionTrace
////////////////////////////////////////////////////////
@implementation ViewPositionTrace
///////////////////////////////////////////////////
///       Initializers
#pragma mark Initializers
///////////////////////////////////////////////////
- (void)dealloc {
    if(_buffer) {
        free(_buffer);
    }
    if(_intervals) {
        free(_intervals);
    }
}
- (instancetype)init {
    if((self = [super init])) {
        self.maximumBufferSize = 5;
    }
    return self;
}
///////////////////////////////////////////////////
///       Handles
#pragma mark Handles
///////////////////////////////////////////////////
- (void)begin:(CGPoint)point {
    _pointCount = 1;
    self.buffer[0] = point;
}
- (void)push:(CGPoint)point {
    memmove(self.buffer+1, self.buffer, sizeof(CGPoint)*(_internalBufferSize-1));
    memmove(self.intervals+1, self.intervals, sizeof(NSTimeInterval)*(_internalBufferSize-1));
    self.buffer[0] = point;
    self.intervals[0] = [[NSDate date] timeIntervalSince1970];
    _pointCount++;
    if(_pointCount > _internalBufferSize) _pointCount = _internalBufferSize;
}
- (void)end:(CGPoint)point {
    [self push:point];
}

- (CGFloat)traceLength {
    CGFloat length = .0f;
    for(int i=0; i<_pointCount-1; i++) {
        length += pointDistance(self.buffer[i], self.buffer[i+1]);
    }
    return length;
}
- (CGPoint)traceSpeed {
    if(_pointCount < 2) return CGPointZero;
    CGPoint returnSpeed = CGPointZero;
    for(int i=0; i<_pointCount-1; i++) {
        CGPoint speedFragment = pointMinus(self.buffer[i+1], self.buffer[i]);
        pointScale(speedFragment, 1.0/(self.intervals[i+1]-self.intervals[i]));
        returnSpeed = pointPlus(returnSpeed, speedFragment);
    }
    return returnSpeed;
}
///////////////////////////////////////////////////
///       Buffers
#pragma mark Buffers
///////////////////////////////////////////////////
- (void)_refreshBuffers {
    if(_buffer == nil) {
        _buffer = malloc(sizeof(CGPoint)*self.maximumBufferSize);
        _internalBufferSize = self.maximumBufferSize;
    }
    if(_intervals == nil) {
        _intervals = malloc(sizeof(NSTimeInterval)*self.maximumBufferSize);
        _internalBufferSize = self.maximumBufferSize;
    }
    if(self.maximumBufferSize != _internalBufferSize) {
        NSInteger smaller = self.maximumBufferSize>_internalBufferSize?_internalBufferSize:self.maximumBufferSize;
        CGPoint *newBuffer = malloc(sizeof(CGPoint)*self.maximumBufferSize);
        memcpy(newBuffer, _buffer, smaller*sizeof(CGPoint));
        free(_buffer);
        _buffer = newBuffer;
        NSTimeInterval *newIntervals = malloc(sizeof(NSTimeInterval)*self.maximumBufferSize);
        memcpy(newIntervals, _intervals, smaller*sizeof(CGPoint));
        free(_intervals);
        _intervals = newIntervals;
        
        _pointCount = _pointCount>smaller?smaller:_pointCount;
    }
}
- (CGPoint *)buffer {
    if(self.maximumBufferSize < 1) {
        return NULL;
    }
    [self _refreshBuffers];
    return _buffer;
}
- (NSTimeInterval *)intervals {
    if(self.maximumBufferSize < 1) {
        return NULL;
    }
    [self _refreshBuffers];
    return _intervals;
}
@end
