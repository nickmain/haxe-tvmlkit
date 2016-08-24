package tvmlkit.tvjs.externs;

/*
    The global App object to which application lifecycle callbacks can be added
 */
@:native("App")
extern class AppLifecycle {

    /**
     * The onLaunch callback is invoked after the application JavaScript
     * has been parsed into a JavaScript context. The handler is passed an object
     * that contains options. These options are defined in the Swift or objective-c client code.
     * Options can be used to communicate data and state information to your JavaScript code.
     *
     * The location attribute is automatically added to the options object and represents
     * the URL that was used to retrieve the application JavaScript.
     */
    static var onLaunch: Null<Dynamic> -> Void;

    /**
     * Error callback - function(message:String, sourceURL: String, line: Null<Int>)
     */
    static var onError: String -> String -> Null<Int> -> Void;

    /**
     * Exit callback - function(options)
     */
    static var onExit: Null<Dynamic> -> Void;

    /**
     * Callback when the app moves from the background to the foreground - function(options)
     * The options argument is always set to null.
     */
    static var onResume: Null<Dynamic> -> Void;

    /**
     * Callback when the app moves from the foreground to the background - function(options)
     * The options argument is always set to null.
     */
    static var onSuspend: Null<Dynamic> -> Void;

    /**
     * This function reloads the initial JavaScript file without quitting the app. The optional reloadData parameter
     * enables you to capture and restart the app in its current state.
     * If the reloadData parameter is not present, the app is restarted in its initial state.
     */
    static function reload(options: {when: String}, reloadData: Null<Dynamic> = null): Void;
}
