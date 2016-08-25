package tvmlkit.tvjs.externs;

import js.html.Document;

@:native("navigationDocument")
extern class NavigationDocument {

    /**
     * Searches the stack for the first instance of the beforeDocument and inserts the new document on top of it
     */
    static function insertBeforeDocument(document: Document, beforeDocument: Document = null): Void;

    /**
     * Pushes the specified document onto the stack
     */
    static function pushDocument(document: Document): Void;

    /**
     * Searches the stack for the first instance of the old document to be replaced and replaces it with the new document
     */
    static function replaceDocument(document: Document, oldDocument: Document): Void;

    /**
     * Displays the document on top of the current document
     */
    static function presentModal(document: Document): Void;

    /**
     * Dismisses the document displayed in modal view and brings the previous document into focus
     */
    static function dismissModal(): Void;

    /**
     * Read-only array of documents currently on the stack
     */
    static var documents(default,null): Array<Document>;

    /**
     * Removes all documents on the stack without animation
     */
    static function clear(): Void;

    /**
     * Removes the topmost document from the stack
     */
    static function popDocument(): Void;

    /**
     * Removes all the documents on the stack above the document
     */
    static function popToDocument(document: Document): Void;

    /**
     * Removes all documents from the stack except for the bottom one
     */
    static function popToRootDocument(): Void;

    /**
     * Removes the specified document from the stack
     */
    static function removeDocument(document: Document): Void;
}
