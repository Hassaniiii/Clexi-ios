#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "BLEManager.h"
#import "CentralManager.h"
#import "ErrorCodes.h"
#import "ErrorHandler.h"
#import "PeripheralManager.h"

FOUNDATION_EXPORT double BLEManagerVersionNumber;
FOUNDATION_EXPORT const unsigned char BLEManagerVersionString[];

