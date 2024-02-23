// ---------------------------------------------------------------------------
// Copyright © 2024 Haute école d'ingénierie et d'architecture de Fribourg
// SPDX-License-Identifier: Apache-2.0
// ---------------------------------------------------------------------------
// Author : Jacques Supcik <jacques.supcik@hefr.ch>
// Date   : 23 February 2024
// ---------------------------------------------------------------------------
// Example of a student reports at the Haute école d'ingénierie et
// d'architecture de Fribourg
// ---------------------------------------------------------------------------

#import "lib/heiafr.typ": report
#import "@preview/big-todo:0.2.0": *
#import "@preview/tablex:0.0.8": tablex, hlinex, vlinex

#set text(region: "ch", lang: "fr")

//
// N.B. : The versions array need to be ordered from the oldest to the newest
//
#let versions = ((
  version: "0.1.0",
  date: datetime(year: 2024, month: 2, day: 20),
  author: [B. Vonlanthen],
  changes: [Version initiale],
), (
  version: "0.1.1",
  date: datetime(year: 2024, month: 2, day: 22),
  author: [B. Vonlanthen],
  changes: lorem(10),
),)

#let authors = ((
    firstname: "Margaret",
    lastname: "Hamilton",
    email: "margaret.hamilton@nasa.org",
    gender: "f",
  ), (
    firstname: "Martin",
    lastname: "Luther King",
    email: "martin.luther-king@dream.net",
    gender: "m",
  ),)

#show: doc => report(
  type: "Projet de bachelor",
  year: [2023/2024],
  profile: [Orientation Ingénierie des données],
  title: [
    Vers une unification de la physique
  ],
  subtitle: [
    Comprendre les mystères du monde qui nous entoure
  ],
  authors: authors,
  supervisors: ("Albert Einstein", "Nikola Tesla"),
  versions: versions,
  doc,
)

= Introduction
<intro>

#lorem(10)

== #lorem(3)
<label>
#lorem(50)
@electronic

La @usoftime illustre #lorem(10)

#figure(
  image("Graphjam-Essay.jpg", width: 80%),
  caption: [Utilisation du temps les les 12 heures avant la remise d'un rapport de 60 pages ],
) <usoftime>

#todo("structure du rapport")

= Analyse

comme vu dans le @intro et le @label...
#lorem(50)

= Conception

#lorem(50)

= Réalisation

#lorem(50)

= Tests et validations

#lorem(50)

= Conclusion

#lorem(50)

= Annexes

#set heading(numbering: none)

= Glossaire

= Remerciements

#bibliography(style: "association-for-computing-machinery", "bibliography.yml")
