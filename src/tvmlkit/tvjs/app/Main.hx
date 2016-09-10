package tvmlkit.tvjs.app;

import tvmlkit.tvjs.backend.BackendResource;
import tvmlkit.tvjs.dom.TVDocument;
import tvmlkit.tvjs.externs.Settings;
import tvmlkit.tvjs.externs.NavigationDocument;
import tvmlkit.tvjs.externs.Device;
import tvmlkit.tvjs.app.LaunchOptions;

/** Hello World Demo app */
class DemoApp extends Application {

    var count = 1;
    var baseUrl: String;
    var appJS: BackendResource;

    public function new () {
        super();
    }

    override function onReload(reloadData: Dynamic, options: LaunchOptions) {
        count = reloadData.count;
        super.onReload(reloadData, options); //just for the trace
    }

    override function onLaunch(options: LaunchOptions) {
        super.onLaunch(options); //just for the trace
        baseUrl = options["baseURL"];
        appJS = new BackendResource(options.getLocation());

        var alertDoc: TVDocument =
            '<document>
              <alertTemplate>
                <title>Hello World !!!</title>
                <description>This is a minimal TVML app written in Haxe.</description>
                <button id="butt1"><text id="buttext">Press Me</text></button>
                <button id="reload"><text>Reload</text></button>
                <text>Device: ${Device.productType} | tvOS: ${Device.systemVersion}&#10;Language: ${Settings.language}</text>
              </alertTemplate>
            </document>';

        NavigationDocument.pushDocument(alertDoc);

        alertDoc.onSelect("butt1", function() {
            alertDoc.setText("buttext", 'Press [${count++}]');
        });

        alertDoc.onPlay("butt1", function() {
            alertDoc.setText("buttext", 'Play [${count++}]');
        });

        alertDoc.onSelectOrPlay("reload", function() {
            reloadNow({count: count});
        });

        appJS.startPolling(2, appModified);
    }

    override function onResume(): Void {
        appJS.startPolling(2, appModified);
    }

    override function onSuspend(): Void {
        appJS.cancelPolling();
    }

    // reload the app, saving state
    function appModified(res: BackendResource) {
        reloadNow({count: count});
    }
}

/** Dummy main class */
class Main {
    static var theApp: Application;

    public static function main() {
        theApp = new DemoApp();
    }
}
