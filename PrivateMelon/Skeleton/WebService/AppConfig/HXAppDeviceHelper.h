

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum {
    HXDeviceUnknown,
    
    HXDeviceSimulator,
    HXDeviceSimulatoriPhone,
    HXDeviceSimulatoriPad,
    HXDeviceSimulatorAppleTV,
    
    HXDevice1GiPhone,
    HXDevice3GiPhone,
    HXDevice3GSiPhone,
    HXDevice4iPhone,
    HXDevice4SiPhone,
    HXDevice5iPhone,
    HXDevice5CiPhone,
    HXDevice5SiPhone,
    
    HXDevice1GiPod,
    HXDevice2GiPod,
    HXDevice3GiPod,
    HXDevice4GiPod,
    HXDevice5GiPod,//15
    
    HXDevice1GiPad,
    HXDevice2GiPad,
    HXDevice3GiPad,
    HXDevice4GiPad,
    HXDeviceMiniPad,
    HXDeviceiPadAir,
    HXDeviceMiniPad2G,
    
    HXDeviceAppleTV2,
    HXDeviceAppleTV3,
    HXDeviceAppleTV4,
    
    HXDeviceUnknowniPhone,
    HXDeviceUnknowniPod,
    HXDeviceUnknowniPad,
    HXDeviceUnknownAppleTV,
    HXDeviceIFPGA,
    
    HXDevice6iPhone,
    HXDevice6PlusiPhone,
    
} HXDeviceModel;

typedef enum {
    HXDeviceFamilyiPhone,
    HXDeviceFamilyiPod,
    HXDeviceFamilyiPad,
    HXDeviceFamilyAppleTV,
    HXDeviceFamilyUnknown,
    
} HXDeviceFamily;

@interface HXAppDeviceHelper : NSObject {
    
}

+ (BOOL)isDeviceIPad;
+ (BOOL)isDeviceIPhone;
+ (BOOL)deviceHasRetinaScreen;
+ (CGFloat)iosVersion;

+ (NSNumber *)totalDiskSpace;
+ (NSNumber *)freeDiskSpace;
+ (HXDeviceModel)modelType;
+ (NSString*)modelTypeString;

+ (NSString *)modelString;
+ (HXDeviceFamily)deviceFamily;

+ (NSUInteger)userMemory;
+ (NSUInteger)totalMemory;
+ (NSUInteger)cpuCount;
+ (NSUInteger)busFrequency;
+ (NSUInteger)cpuFrequency;

+ (BOOL)isInternetConnectionAvailable;

+ (NSString *)uniqueDeviceIdentifier;
+ (NSString *)currentLocaleId;
+ (CGSize)currentScreenSize;
+ (BOOL)isScreen480Height;
+ (BOOL)isScreen568Height;
+ (BOOL)isScreen667Height;
+ (BOOL)isScreen736Height;
+ (BOOL)isScreenMoreThanOrEqualTo568Height;

+ (BOOL)isIPhone5;
+ (BOOL)isIPhone6;
+ (BOOL)isIPhone6Plus;

+ (BOOL)canBlur;

+ (BOOL)isJailbroken;

@end
