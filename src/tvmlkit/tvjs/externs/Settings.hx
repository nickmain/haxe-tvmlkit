package tvmlkit.tvjs.externs;

/** Device settings */
@:native("Settings")
extern class Settings {

    /** Restriction information on the device */
    static var restrictions(default,null): Restrictions;

    /** The language used to display information by the device */
    static var language(default,null): String;

    /** The country code used by the store on the device */
    static var storefrontCountryCode(default,null): String;

    /** Callback for restrictions changes */
    static var onRestrictionsChange: Void->Void;
}
