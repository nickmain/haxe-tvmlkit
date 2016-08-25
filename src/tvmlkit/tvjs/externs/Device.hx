package tvmlkit.tvjs.externs;

/** Apple TV and app info */
@:native("Device")
extern class Device {

    /** The unique identifier for the app */
    static var appIdentifier(default,null): String;

    /** The current app version */
    static var appVersion(default,null): String;

    /** A string that identifies the device model, for example, AppleTV. */
    static var model(default,null): String;

    /** An identifier for the device, for example, AppleTV 3,1. */
    static var productType(default,null): String;

    /** The tvOS version */
    static var systemVersion(default,null): String;

    /** The UUID of the device */
    static var vendorIdentifier(default,null): String;
}
