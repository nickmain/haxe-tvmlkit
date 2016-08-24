package tvmlkit.tvjs.externs;

import js.html.Document;

@:native("navigationDocument")
extern class NavigationDocument {


    /**
     * Inserts a new document directly before a document currently on the stack.
     * @param document The DOM document that is to be added onto the stack.
     * @param beforeDocument A DOM document currently on the stack. The new document is placed on the stack directly after this document.
     */
    static function insertBeforeDocument(document: Document, beforeDocument: Document = null): Void;

    /**
     * Pushes the specified document onto the stack.
     * @param document The DOM document that is to be added onto the stack.
     */
    static function pushDocument(document: Document): Void;

    // TODO - all the rest of the methods...
}
