```objectivec
#import <Foundation/Foundation.h>

@interface ObservedObject : NSObject
@property (nonatomic, strong) NSString *observedString;
@end

@implementation ObservedObject
- (void)dealloc {
    NSLog(@"ObservedObject deallocated");
}
@end

@interface ObserverObject : NSObject
@property (nonatomic, weak) ObservedObject *observed;
@end

@implementation ObserverObject
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"Observer received KVO notification");
}

- (void)startObserving:(ObservedObject *)observed {
    self.observed = observed;
    [observed addObserver:self forKeyPath:@"observedString" options:NSKeyValueObservingOptionNew context:NULL];
}

- (void)stopObserving {
    [self.observed removeObserver:self forKeyPath:@"observedString"];
}

- (void)dealloc {
    NSLog(@"ObserverObject deallocated");
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        ObservedObject *observed = [[ObservedObject alloc] init];
        observed.observedString = @"Initial value";

        ObserverObject *observer = [[ObserverObject alloc] init];
        [observer startObserving:observed];

        observed.observedString = @"Changed value";

        [observer stopObserving]; //Crucial step to prevent crash
        [observed release];
        [observer release];
    }
    return 0;
}
```