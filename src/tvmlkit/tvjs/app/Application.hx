package tvmlkit.tvjs.app;

import tvmlkit.tvjs.externs.NumberFormat;
import tvmlkit.tvjs.dom.TVDocument;
import js.html.Document;
import js.html.Storage;
import tvmlkit.tvjs.externs.AppLifecycle;

/**
 * Base for TVJS applications.
 */
class Application {

    static var appInstance: Application;

    public function new() {
        appInstance = this;
        AppLifecycle.onLaunch  = __onLaunch;
        AppLifecycle.onError   = __onError;
        AppLifecycle.onExit    = __onExit;
        AppLifecycle.onResume  = __onResume;
        AppLifecycle.onSuspend = __onSuspend;
    }

    /** Callback on app launch */
    function onLaunch(options: LaunchOptions): Void {
        trace('onLaunch called - location = ${options.getLocation()} | baseURL = ${options["baseURL"]}');
    }

    /** Callback on app reload (only if reload data was present) */
    function onReload(reloadData: Dynamic, options: LaunchOptions): Void {
        trace('onReload called - data = ${reloadData}');
        onLaunch(options);
    }

    /** Callback on error */
    function onError(message:String, sourceURL: String, line: Null<Int>): Void {
        trace('onError called - message:${message}, sourceURL: ${sourceURL}, line: ${line}');
    }

    /** Callback on app exit */
    function onExit(isReloading: Bool): Void {
        trace('onExit called (isReloading=${isReloading})');
    }

    /** Callback on app resume */
    function onResume(): Void {
        trace("onResume called");
    }

    /** Callback on app suspend */
    function onSuspend(): Void {
        trace("onSuspend called");
    }

    /** Reload the main js when the app resumes */
    public function reloadOnResume(reloadData: Null<{}> = null): Void {
        trace("will reload on resume");
        AppLifecycle.reload({when: "onResume"}, reloadData);
    }

    /** Reload the main js now */
    public function reloadNow(reloadData: Null<{}> = null): Void {
        trace("will reload now");
        AppLifecycle.reload({when: "now"}, reloadData);
    }

    /** The key-value store that is purged when the app exits */
    public var sessionStore(get,null): Storage;
    function get_sessionStore(): Storage return untyped sessionStorage;

    /** The persistent key-value store */
    public var localStore(get,null): Storage;
    function get_localStore(): Storage return untyped localStorage;

    /**
     * Download and evaluate a number of JS files.
     * Callback receives true if successful.
     */
    public function evaluateScripts(scriptURLs: Array<String>, callback: Bool->Void) {
        js.Lib.global.evaluateScripts(scriptURLs, callback);
    }

    /**
     * Open a deep link into another app.
     */
    public function openURL(url: String) {
        js.Lib.global.openURL(url);
    }

    /**
     * Retrieve the currently active document.
     */
    public function getActiveDocument(): TVDocument {
        var doc: TVDocument = js.Lib.global.getActiveDocument();
        return doc;
    }

    /**
     * Generate a new UUID
     */
    public function generateUUID(): String {
        return js.Lib.global.UUID();
    }

    /**
     * Format a date
     */
    public function formatDate(date: Date, format: String): String {
        return js.Lib.global.formatDate(date, format);
    }

    /**
     * Format a duration into the standard tvOS format
     */
    public function formatDuration(duration: Int): String {
        return js.Lib.global.formatDuration(duration);
    }

    /**
     * Format a number
     */
    public function formatNumber(number: Int, style: NumberFormat, positiveNumberFormat: String, negativeNumberFormat:String): String {
        return js.Lib.global.formatNumber(number, style, positiveNumberFormat, negativeNumberFormat);
    }

    /**
     * Call a function after given millisecs.
     * Returns an identifier that can be passed to clearTimeout.
     */
    public function setTimeout(callback: Void->Void, millisecs: Int): String {
        return js.Lib.global.setTimeout(callback, millisecs);
    }

    /**
     * Stops a timeout
     */
    public function clearTimeout(timeoutId: String) {
        js.Lib.global.clearTimeout(timeoutId);
    }

    /**
     * Repeatedly call a function every given millisecs.
     * Returns an identifier that can be passed to clearInterval.
     */
    public function setInterval(callback: Void->Void, millisecs: Int): String {
        return js.Lib.global.setInterval(callback, millisecs);
    }

    /**
     * Stops an interval timer
     */
    public function clearInterval(intervalID: String) {
        js.Lib.global.clearInterval(intervalID);
    }

    // --- Static proxy functions ---

    static function __onLaunch(options: Null<Dynamic>): Void {
        if(options != null) {
            var launchOpts: LaunchOptions = options;
            var reloadData = launchOpts.getReloadData();
            if(reloadData != null) {
                appInstance.onReload(reloadData, options);
            }
            else {
                appInstance.onLaunch(options);
            }
        }
        else {
            appInstance.onLaunch(new LaunchOptions({}));
        }
    }

    static function __onError(message:String, sourceURL: String, line: Null<Int>): Void {
        appInstance.onError(message, sourceURL, line);
    }

    static function __onExit(options: Null<Dynamic>): Void {
        var isReloading = (options != null && options.reloading == true );
        appInstance.onExit(isReloading);
    }

    static function __onResume(options: Null<Dynamic>): Void {
        appInstance.onResume();
    }

    static function __onSuspend(options: Null<Dynamic>): Void {
        appInstance.onSuspend();
    }
}