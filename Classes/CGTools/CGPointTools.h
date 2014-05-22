#import <Foundation/Foundation.h>

CGFloat pointSquareDistance(CGPoint p1, CGPoint p2);
CGFloat pointDistance(CGPoint p1, CGPoint p2);
CGFloat square(CGFloat value);
CGPoint pointMinus(CGPoint p1, CGPoint p2);
CGPoint pointPlus(CGPoint p1, CGPoint p2);
CGPoint pointNormalize(CGPoint p);
CGPoint pointNormal(CGPoint p1,CGPoint p2);
CGPoint pointScale(CGPoint p, CGFloat scale);
CGFloat pointDot(CGPoint p1, CGPoint p2);
CGPoint pointInterpolate(CGPoint a, CGPoint b, CGFloat scale);
void setPointRoundingScale(CGFloat scale);
CGPoint pointRound(CGPoint input);