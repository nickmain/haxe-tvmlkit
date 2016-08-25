package tvmlkit.tvjs.app;

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
    function onReload(reloadData: {}, options: {}): Void {
        trace('onReload called - data = ${reloadData}');
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
    public function reloadOnResume(reloadData: Null<{}>): Void {
        trace("will reload on resume");
        AppLifecycle.reload({when: "onResume"}, reloadData);
    }

    /** Reload the main js now */
    public function reloadNow(reloadData: Null<{}>): Void {
        trace("will reload now");
        AppLifecycle.reload({when: "now"}, reloadData);
    }

    /** The key-value store that is purged when the app exits */
    public var sessionStore(get,null): Storage;
    function get_sessionStore(): Storage return untyped sessionStorage;

    /** The persistent key-value store */
    public var localStore(get,null): Storage;
    function get_localStore(): Storage return untyped localStorage;

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