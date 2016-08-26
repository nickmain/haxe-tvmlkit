package tvmlkit.tvjs.app;

/* Application onLaunch options */
abstract LaunchOptions(Dynamic) {
    inline public function new(props: Dynamic) this = props;

    @:arrayAccess
    public inline function get(key: String) { return Reflect.field(this, key); }
    public inline function getReloadData(): Null<Dynamic> { return this.reloadData; }
    public inline function getLocation(): Null<String> { return this.location; }
    public inline function getLaunchContext(): Null<String> { return this.launchContext; }
}