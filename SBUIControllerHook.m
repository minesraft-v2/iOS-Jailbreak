#import <UIKit/UIKit.h>

// 1. Interface Declaration
// Informs the compiler that this class and its specific selector exist in iOS
@interface SBUIController : NSObject
+ (id)sharedInstance;
- (int)batteryCapacityAsPercent;
@end

// 2. Logic Hooking Implementation
// Intercepts the target class during system execution runtime
%hook SBUIController

- (int)batteryCapacityAsPercent {
    // Force the status bar UI layer to consistently read 100% capacity
    // Replaces dynamic kernel hardware calls with a static integer payload
    return 100;
}

%end

// 3. Runtime Initialization
// Executed immediately upon injection of the compiled dynamic library (.dylib)
%ctor {
    %init(SBUIController = objc_getClass("SBUIController"));
}
