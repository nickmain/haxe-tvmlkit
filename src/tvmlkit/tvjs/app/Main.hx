package tvmlkit.tvjs.app;

import tvmlkit.tvjs.externs.Settings;
import tvmlkit.tvjs.dom.TVElementEventType;
import tvmlkit.tvjs.externs.NavigationDocument;
import tvmlkit.tvjs.externs.Device;
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
                <description>This is a minimal TVML app written in Haxe.</description>
                <button id="butt1">
                    <text id="buttext">Press Me</text>
                </button>
                <text>Device: ${Device.productType}&#10;Language: ${Settings.language}</text>
              </alertTemplate>
            </document>',
            APPLICATION_XML);

        NavigationDocument.pushDocument(alertDoc);

        var count = 1;

        alertDoc.getElementById("butt1").addEventListener(
            TVElementEventType.Select,
            function() {
                alertDoc.getElementById("buttext").textContent = 'Press Me [${count++}]';
            },
            false );
    }
}

/** Dummy main class */
class Main {
    static var theApp: Application;

    public static function main() {
        theApp = new DemoApp();
    }
}
