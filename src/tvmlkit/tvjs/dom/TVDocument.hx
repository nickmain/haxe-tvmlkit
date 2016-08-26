package tvmlkit.tvjs.dom;

import js.html.Document;

/** Abstract over DOM Document with parsing from String */
@:forward
abstract TVDocument(Document) from Document to Document {
    inline function new(doc: Document) this = doc;

    @:from
    static public function fromString(s:String) {
        return new TVDocument(new js.html.DOMParser().parseFromString(s, APPLICATION_XML));
    }

    /** Add a select event handler to the element with the given id */
    public function onSelect(id: String, handler: haxe.Constraints.Function) {
        this.getElementById(id).addEventListener(TVElementEventType.Select, handler, false);
    }

    /** Add a play event handler to the element with the given id */
    public function onPlay(id: String, handler: haxe.Constraints.Function) {
        this.getElementById(id).addEventListener(TVElementEventType.Play, handler, false);
    }

    /** Add a select and a play event handler to the element with the given id */
    public function onSelectOrPlay(id: String, handler: haxe.Constraints.Function) {
        this.getElementById(id).addEventListener(TVElementEventType.Select, handler, false);
        this.getElementById(id).addEventListener(TVElementEventType.Play, handler, false);
    }

    /** set the textContent of the element with the given id */
    public function setText(id: String, text: String) {
        this.getElementById(id).textContent = text;
    }
}
