package tvmlkit.tvjs.backend;

import js.html.XMLHttpRequest;

/** Represents a back-end string resource */
class BackendResource {

    /** The resource being checked */
    public var url(default,null): String;

    /** The last fetched resource data if any */
    public var data(default,null): Null<String>;

    /** The modification date of last get or head */
    public var lastModified(default,null): Null<String>;

    /** The last status code */
    public var status(default,null): Int = 0;

    /** The last status text */
    public var statusText(default,null): Null<String>;

    var xhr: XMLHttpRequest = null;

    /**
     * @param url the resource to check or fetch
     */
    public function new(url: String) {
        this.url = url;
    }

    /**
     * Fetch the resource and call-back.
     * Cancels any previous request (without calling that associated callback).
     * If the fetch had an error then the data property will be null.
     */
    public function fetch(callback: BackendResource->Void) {
        abortPrevious();

        var thisResource = this;
        var thisXHR = new XMLHttpRequest();
        xhr = thisXHR;
        xhr.open("GET", url);
        xhr.responseType = NONE;
        xhr.onload = function() {
            if(xhr != thisXHR) return;

            status = xhr.status;
            statusText = xhr.statusText;
            data = xhr.responseText;
            lastModified = xhr.getResponseHeader("Last-Modified");

            callback(thisResource);
        };
        xhr.onerror = function() {
            if(xhr != thisXHR) return;

            status = xhr.status;
            statusText = xhr.statusText;
            data = null;

            callback(thisResource);
        };
        xhr.send();
    }


    /**
     * Check the resource via a head request and call-back with the last-modified header.
     * Cancels any previous request (without calling that associated callback).
     * If the fetch had an error then the data property will be null.
     */
    public function checkLastModified(callback: BackendResource->Null<String>->Void) {
        abortPrevious();

        var thisResource = this;
        var thisXHR = new XMLHttpRequest();
        xhr = thisXHR;
        xhr.open("HEAD", url);
        xhr.responseType = NONE;
        xhr.onload = function() {
            if(xhr != thisXHR) return;

            status = xhr.status;
            statusText = xhr.statusText;

            callback(thisResource, xhr.getResponseHeader("Last-Modified"));
        };
        xhr.onerror = function() {
            if(xhr != thisXHR) return;

            status = xhr.status;
            statusText = xhr.statusText;

            callback(thisResource, null);
        };
        xhr.send();
    }


    // if there is a previous request then kill it
    function abortPrevious() {
        if(xhr == null) return;

        var prevXHR = xhr;
        xhr = null;

        prevXHR.abort();
    }


    var timerId: String = null;

    /**
     * Poll the resource for updates and call back only if modified since last full fetch.
     * If there has been no full fetch that returned a modified header then do nothing.
     * Errors are ignored.
     */
    public function startPolling(seconds: Int, callback: BackendResource->Void) {
        cancelPolling();

        timerId = js.Lib.global.setInterval(function() {
            checkLastModified(function(res: BackendResource, lastMod: Null<String>) {
                if(lastMod == null) return;

                trace("POLLING");

                if(lastModified == null) {
                    lastModified = lastMod;
                    return;
                }

                if(lastModified != lastMod) {
                    lastModified = lastMod;
                    callback(this);
                }
            });
        }, seconds * 1000);
    }

    /** Whether there an active poll */
    public var isPolling(get,null): Bool;
    function get_isPolling() {
        return timerId != null;
    }

    /**
     * Cancel the polling
     */
    public function cancelPolling() {
        if(timerId != null) {
            js.Lib.global.clearInterval(timerId);
            timerId = null;
        }
    }
}
