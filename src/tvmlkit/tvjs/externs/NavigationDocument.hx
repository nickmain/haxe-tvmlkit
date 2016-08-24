package tvmlkit.tvjs.externs;

import js.html.Document;

@:native("navigationDocument")
extern class NavigationDocument {


    /* Inserts a new document directly before a document currently on the stack. */
    static extern function insertBeforeDocument(document: Document, beforeDocument: Document = null);

/*
document
The DOM document that is to be added onto the stack.
    beforeDocument
    A DOM document currently on the stack. The new document is placed on the stack directly after this document.
    Discussion
    This function searches the stack for the first instance of the document contained in the beforeDocument parameter and inserts the document contained in the document parameter on top of it.

Availability
Available in tvOS 9.0 and later.

/ *
pushDocument
Pushes the specified document onto the stack.

Declaration
void pushDocument (in Document document)
Parameters
document
The DOM document that is to be added onto the stack.
Discussion
The document being pushed onto the stack must be a valid parsed DOM object.

Availability
Available in tvOS 9.0 and later.
replaceDocument
Replaces a document on the stack with a new document.

Declaration
void replaceDocument (in Document document, in Document oldDocument)
Parameters
document
The DOM document that is to be added onto the stack.
oldDocument
The DOM document that is being replaced.
Discussion
This function searches the stack for the first instance of the document to be replaced and replaces it with the new document.

Availability
Available in tvOS 9.0 and later.
Overlaying Document
dismissModal
Dismisses the document displayed in modal view.

Declaration
void dismissModal ()
Discussion
When the document is dismissed, the previous document is brought into focus.

Availability
Available in tvOS 9.0 and later.
presentModal
Displays the passed document on top of the current document.

Declaration
void presentModal (in Document document)
Parameters
document
A DOM document created by parsing a TVML file.
Discussion
The passed document is presented on top of the current document. The current document is blurred and is used as the background for the modal document.

Availability
Available in tvOS 9.0 and later.
Viewing the Stack
documents  Property
The documents currently on the stack.

Declaration
readonly attribute Array documents
Discussion
Contains an array consisting of all of the documents currently on the stack.

Availability
Available in tvOS 9.0 and later.
Removing Documents from the Stack
clear
Removes all documents currently on the stack.

Declaration
void clear ()
Discussion
No animations are performed when this function is called. All documents currently on the stack are immediately removed.

Availability
Available in tvOS 9.0 and later.
popDocument
Removes the top most document from the stack.

Declaration
void popDocument ()
Availability
Available in tvOS 9.0 and later.
popToDocument
Removes all of the documents on the stack that are above the passed document.

Declaration
void popToDocument (in Document document)
Parameters
document
A DOM document created by parsing a TVML file.
Availability
Available in tvOS 9.0 and later.
popToRootDocument
Removes all documents from the stack except for the bottom-most document, which is the root document.

Declaration
void popToRootDocument ()
Discussion
Use this function to quickly return to the root document from any other document in the stack.

Availability
Available in tvOS 9.0 and later.
removeDocument
Removes the specified document from the stack.

Declaration
void removeDocument (in Document document)
Parameters
document
A DOM document created by parsing a TVML file.
Availability
Available in tvOS 9.0 and later.

*/
}
