#import "JSP101.typ": jsp101

// ----------- Metadata --------------

#let protective-marking = "OFFICIAL-SENSITIVE"
#let file-reference = "20261120_JSP_101_in_typst-OS"
#let document-date = "11 Nov 26"
#let author_rank = "Capt"
#let author_initials = "BL"
#let author_surname = "Thomas"

#let doc = jsp101(
  protective-marking,
  file-reference,
  document-date,
)
#show: doc.apply

// ----------- File content --------------


#document-date\
File reference: *#file-reference*\

= Hello, Typst!

+ *First item.* #lorem(100)
+ *Second item.* #lorem(100)
  + *Third item.* #lorem(100)
    + *Third item.* #lorem(100)
    + *Third item.* #lorem(100)
    + *Third item.* #lorem(100)




#(doc.annex_list)()
#metadata(none) <main-end>

#(doc.annex)("A", "Example Annex Title")[
  Your annex content goes here.

  #lorem(100)
]

#(doc.annex)("B", "Second Annex Title")[
  #lorem(10000)
]

#(doc.annex)("C", "Third Annex Title")[
  #lorem(10000)
]
