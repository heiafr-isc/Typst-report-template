// ---------------------------------------------------------------------------
// Copyright © 2024 Haute école d'ingénierie et d'architecture de Fribourg
// SPDX-License-Identifier: Apache-2.0
// ---------------------------------------------------------------------------
// Author : Jacques Supcik <jacques.supcik@hefr.ch>
// Date   : 23 February 2024
// ---------------------------------------------------------------------------
// Template for student reports at the Haute école d'ingénierie et
// d'architecture de Fribourg
// ---------------------------------------------------------------------------

#import "@preview/tablex:0.0.8": tablex, hlinex, vlinex
#import "french_date.typ": short_date, long_date

#let main_text(..content) = text(font: "Noto Sans", ..content)
#let heading_text(..content) = text(font: "Noto Serif", ..content)

//
// Version Table
//
#let version_table(
  reverse: true,
  versions
) = {
  if reverse  { 
    versions = versions.rev()
  }
  heading(numbering: none, outlined: false, [Tableau des versions])
  set par(justify: false)
  tablex(
    columns: (5em, 5em, auto, 1fr),  // 4 columns
    rows: auto,  // at least 1 row of auto size
    align: (center+top, center+top, top, top),
    auto-lines: false,
    (), vlinex(), vlinex(), vlinex(), (),
    [*Version*], [*Date*], [*Auteur(s)*], [*Modifications*],
    hlinex(),
    // [0.1.0], [1.1.2024], [B. Vonlanthen], [Version initiale],
    //[0.1.1], [2.1.2024], [B. Vonlanthen], lorem(10),
    ..(..versions.map(v => {(
      v.version,
      short_date(v.date),
      v.author,
      v.changes)
    })).flatten()
  )
}

//
// Declaration of Honor
//
#let declaration_of_honor(authors) = {
  set heading(numbering: none)

  [= Déclaration d'honneur]

  for author in authors [
    Je, soussigné#if author.gender == "f" [e],
    #author.firstname #author.lastname, déclare sur
    l'honneur que le travail rendu est le fruit d'un travail
    personnel. Je certifie ne pas avoir eu recours au plagiat ou à
    toute autre forme de fraude. Toutes les sources d'information
    utilisées et les citations d'auteur ont été clairement mentionnées.
    #v(4cm)
  ]
}

//
// Report
//
#let report(
  title: none,
  subtitle: none,
  type: none,
  year: none,
  location: [Fribourg],
  versions: (),
  profile: none,
  authors: (),
  supervisors: (),
  experts: (),
  clients: (),
  doc,
) = {
  set text(font: "Noto Sans")
  set heading(numbering: "1.")
  set par(justify: true)
  
  // Heading formating for level 1
  show heading.where(level: 1): it => {
    if (it.numbering != none) {
      block(fill: rgb(195, 40, 35, 40), width: 100%, inset: 20pt, {
        heading_text(weight: "medium", size: 22pt,
          stack(dir: ttb,
            [#it.supplement  #numbering("1", ..counter(heading).at(it.location()))],
            v(5mm),
            heading_text(weight: "semibold", size: 24pt, it.body)
          )
        )
      })
      v(20pt)
    } else {
      heading_text(weight: "semibold", size: 22pt, it)
      v(12pt)
    }
  }

  // Heading formating for all levels
  show heading: it => {
    if it.level <= 1 {
      pagebreak(weak: true)
      it
    } else {
      block(inset: (y: 10pt), heading_text(it))
    }
  }

  // Title page : Logo header
  block(
    inset: (top: -30pt),
    image("img/logo-heiafr.svg")
  )
  v(1fr)

  // Document type
  set align(center)
  block(
    heading_text(
      size: 17pt,
      weight: "semibold" ,
      [Filière Informatique et Systèmes de Communication]
    )
  )
  if profile != none {
    block(
      heading_text(
        size: 15pt,
        weight: "semibold" ,
        profile
      )
    )
  }
  v(1fr)

  block(
    heading_text(size: 17pt, weight: "semibold" , type)
  )
  block(
    heading_text(size: 17pt, weight: "semibold" , year)
  )
  v(1fr)

  // Document title and subtitle in a red block
  {
    set text(fill: white)
    block(fill: rgb(195, 40, 35, 255), width: 100%, inset: 10mm, {
      heading_text(weight: "black", size: 28pt, title)
      if subtitle != none {
        parbreak()
        heading_text(weight: "semibold", size: 18pt, subtitle)
     }
    })
  }
  v(1fr)
  
  // Author
  set text(fill: black, size: 16pt)
  set align(center)
  let count = authors.len()
  let ncols = calc.min(count, 3)
  grid(
    columns: (1fr,) * ncols,
    row-gutter: 24pt,
    ..authors.map(author => [
      #text(
        size: 18pt,
        weight: "semibold",
        heading_text(author.firstname + " " + author.lastname)) \
        #main_text(size: 12pt, author.email)
    ]),
  )
  v(1fr)
  
  // Clients (if dedfined)
  if clients.len() > 0 {
    parbreak()
    grid(
      columns: (1fr,1fr),
      row-gutter: 6pt,
      align(right, heading_text([_Mandants_ : #h(5mm)])),
     align(left, heading_text(clients.join(linebreak()))),
    )
  }

  // Supervisors
  parbreak()
  grid(
    columns: (1fr,1fr),
    row-gutter: 6pt,
    align(right, heading_text([_Superviseurs_ : #h(5mm)])),
    align(left, heading_text(supervisors.join(linebreak()))),
  )

  // Experts (if defined)
  if experts.len() > 0 {
    parbreak()
    grid(
      columns: (1fr,1fr),
      row-gutter: 6pt,
      align(right, heading_text([_Experts_ : #h(5mm)])),
      align(left, heading_text(experts.join(linebreak()))),
    )
  }
  v(2fr)

  // Title page : Footer
  set text(size: 14pt)
  tablex(
    columns: (9em, 1fr, 9em),
    align: (left+horizon, center+horizon, right+horizon),
    auto-lines: false, 
    image("img/logo-isc.svg", width: 22mm),
    block(
        heading_text(location + [, ] + long_date(versions.last().date)) + linebreak() +
        heading_text([Version ] + versions.last().version)
      ),
    image("img/logo-hesso.svg", width: 35mm)
  )
  set align(left)

  // Table of version
  pagebreak()
  set page(numbering: "i")
  version_table(versions)

  // Table of content
  outline()
  pagebreak()

  // Main content
  set page(numbering: "1")
  counter(page).update(1)
  main_text(size: 11pt, doc)

  // Declaration of honor
  declaration_of_honor(authors)
}