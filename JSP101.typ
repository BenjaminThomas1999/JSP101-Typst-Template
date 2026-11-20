#import "@preview/itemize:0.2.0" as el

#let jsp101(
  protective-marking,
  file-reference,
  document-date,
) = {
  // ============================================================
  // ANNEX FUNCTION
  // ============================================================

  let annex(letter, title, body) = {
    metadata((
      kind: "annex",
      letter: letter,
      title: title,
    ))

    let end-label = label("annex-" + letter + "-end")

    pagebreak(weak: true)
    counter(page).update(1)

    set page(
      footer: context [
        #grid(
          columns: (1fr, 1fr, 1fr),
          [],

          [
            #align(center)[
              #text(weight: "bold")[
                #upper(protective-marking)
              ]
            ]
          ],

          [
            #align(right)[
              Page
              #text(weight: "bold")[
                #letter\-#counter(page).display()
              ]
              of
              #text(weight: "bold")[
                #counter(page).at(end-label).first()
              ]
            ]
          ],
        )
      ],
    )

    align(right)[
      #text(weight: "bold", size: 12pt)[
        Annex #upper(letter) to \
        #file-reference \
        #document-date
      ]
    ]

    align(left)[
      #text(weight: "bold", size: 12pt)[
        #title
      ]
    ]

    body

    [#box(width: 0pt, height: 0pt) #end-label]
  }

  // ============================================================
  // ANNEX LIST
  // ============================================================

  let annex-list() = [
    *Annexes:* \
    #context {
      let annex-entries = query(metadata).filter(
        entry => entry.value != none and entry.value.kind == "annex",
      )

      for entry in annex-entries {
        [#h(0.8cm)#(entry.value.letter). #entry.value.title \ ]
      }
    }
  ]

  // ============================================================
  // DOCUMENT STYLING
  // ============================================================

  let apply(body) = {
    set text(
      font: "Arial",
      size: 12pt,
    )

    set par(
      justify: false,
    )

    show heading: it => {
      set text(
        font: "Arial",
        size: 12pt,
        weight: "bold",
      )
      upper(it)
    }

    let label-width = 1em
    let body-offset = 1cm
    let line-gap = 1.35em

    show: el.default-enum-list.with(
      label-width: label-width,
      label-align: left,
      body-indent: body-offset - label-width,
      hanging-indent: -body-offset,
      item-spacing: line-gap,
      enum-spacing: line-gap,
    )

    set enum(
      full: true,
      numbering: (..nums, last) => {
        let styles = ("1.", "a.", "(1)", "(a)", "i")
        numbering(
          styles.at(nums.pos().len(), default: "(a)"),
          last,
        )
      },
      indent: 0cm,
    )

    set page(
      margin: 2cm,
      paper: "a4",

      header: context [
        #align(center)[
          #text(weight: "bold")[
            #upper(protective-marking)
          ]
        ]
      ],

      footer: context [
        #grid(
          columns: (1fr, 1fr, 1fr),
          [],

          [
            #align(center)[
              #text(weight: "bold")[
                #upper(protective-marking)
              ]
            ]
          ],

          [
            #align(right)[
              Page
              #text(weight: "bold")[
                #counter(page).display()
              ]
              of
              #text(weight: "bold")[
                #counter(page).at(<main-end>).first()
              ]
            ]
          ],
        )
      ],
    )

    body
  }

  // ============================================================
  // RETURN TEMPLATE FUNCTIONS
  // ============================================================

  (
    apply: apply,
    annex: annex,
    annex_list: annex-list,
  )
}
