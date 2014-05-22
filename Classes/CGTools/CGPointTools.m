#import "CGPointTools.h"

static CGFloat __pointRoundingScale = 2.0f;

CGFloat pointSquareDistance(CGPoint p1, CGPoint p2) {
    return (p1.x-p2.x)*(p1.x-p2.x)+(p1.y-p2.y)*(p1.y-p2.y);
}

CGFloat pointDistance(CGPoint p1, CGPoint p2) {
    return sqrtf(pointSquareDistance(p1, p2));
}
CGFloat square(CGFloat value) {
    return value*value;
}
CGPoint pointMinus(CGPoint p1, CGPoint p2) {
    return CGPointMake(p1.x-p2.x, p1.y-p2.y);
}
CGPoint pointPlus(CGPoint p1, CGPoint p2) {
    return CGPointMake(p1.x+p2.x, p1.y+p2.y);
}
CGFloat pointDot(CGPoint p1, CGPoint p2) {
    return p1.x*p2.x + p1.y*p2.y;
}
CGPoint pointNormalize(CGPoint p) {
    CGFloat distance = sqrtf(square(p.x) + square(p.y));
    return CGPointMake(p.x/distance, p.y/distance);
}
CGPoint pointNormal(CGPoint p1,CGPoint p2) {
    CGPoint p = pointNormalize(pointMinus(p2, p1));
    return CGPointMake(p.y, -p.x);
}
CGPoint pointScale(CGPoint p, CGFloat scale) {
    return CGPointMake(p.x*scale, p.y*scale);
}
CGPoint pointInterpolate(CGPoint a, CGPoint b, CGFloat scale) {
    return pointPlus(a, pointScale(pointMinus(b, a), scale));
}
void setPointRoundingScale(CGFloat scale) {
    __pointRoundingScale = scale;
}
CGPoint pointRound(CGPoint input) {
    return CGPointMake(round(__pointRoundingScale*input.x)/__pointRoundingScale, round(__pointRoundingScale*input.y)/__pointRoundingScale);
}
