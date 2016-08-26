package tvmlkit.tvjs.backend;

/**
 * Utils for talking to a back-end
 */
import js.html.XMLHttpRequest;
class Backend {

    /**
     * Perform a HEAD against the given url and callback with the Last-Modified header value.
     * Callback with null if error or missing.
     */
    public static function lastModified(url: String, callback: Null<String>->Void) {
        var xhr = new XMLHttpRequest();
        xhr.open("HEAD", url);
        xhr.responseType = NONE;
        xhr.onload = function() {
            callback(xhr.getResponseHeader("Last-Modified"));
        };
        xhr.onerror = function() {
            callback(null);
        };
        xhr.send();
    }

}
