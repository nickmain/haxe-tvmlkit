package tvmlkit.tvjs.app;

import tvmlkit.tvjs.externs.NavigationDocument;
import tvmlkit.tvjs.app.LaunchOptions;

/** Hello World Demo app */
class DemoApp extends Application {

    public function new () {
        super();
    }

    override function onLaunch(options: LaunchOptions): Void {
        super.onLaunch(options); //just for the trace

        var alertDoc = new js.html.DOMParser().parseFromString(
            '<document>
              <alertTemplate>
                <title>Hello World</title>
                <description>This is a minimal TVML app written in Haxe</description>
              </alertTemplate>
            </document>',
            APPLICATION_XML);

        NavigationDocument.pushDocument(alertDoc);
    }
}

/** Dummy main class */
class Main {
    static var theApp: Application;

    public static function main() {
        theApp = new DemoApp();
    }
}
