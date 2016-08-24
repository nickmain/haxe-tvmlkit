package tvmlkit.tvjs.app;

import tvmlkit.tvjs.externs.NavigationDocument;
import tvmlkit.tvjs.externs.AppLifecycle;

/* onLaunch options */
abstract LaunchOptions(Dynamic) {
    inline public function new(props: Dynamic) this = props;

    @:arrayAccess
    public inline function get(key: String) { return Reflect.field(this, key); }
    public inline function getReloadData(): Null<{}> { return this.reloadData; }
    public inline function getLocation(): Null<String> { return this.location; }
    public inline function getLaunchContext(): Null<String> { return this.launchContext; }
}

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

        var alertDoc = new js.html.DOMParser().parseFromString(
            '<document>
              <alertTemplate>
                <title>Hello</title>
                <description>This is a minimal TVML app written in Haxe</description>
              </alertTemplate>
            </document>',
            APPLICATION_XML);

        NavigationDocument.pushDocument(alertDoc);
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