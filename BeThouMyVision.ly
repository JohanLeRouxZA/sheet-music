\version "2.24.0"

%% ---------------------------------------------------------------
%%  Be Thou My Vision  —  SLANE  —  hymnal no. 352
%% ---------------------------------------------------------------

\header {
  dedication = "SUBMISSION AND PROFESSION"
  title      = "Be Thou My Vision"
  number     = "352"
  poet = \markup \left-column {
    "Irish hymn, 8th cent."
    "trans. Mary Elizabeth Byrne, 1905"
    "vers. Eleanor Hull, 1912, alt."
  }
  meter = \markup \center-column { "SLANE" "10 11 11 11" }
  composer = "Irish folk melody"
  tagline = ##f
}

\paper {
  #(set-paper-size "letter")
  top-margin    = 14\mm
  bottom-margin = 14\mm
  left-margin   = 18\mm
  right-margin  = 18\mm
  ragged-bottom = ##t
  print-page-number = ##f
  markup-system-spacing.padding = #7
  system-system-spacing.padding = #6


  bookTitleMarkup = \markup {
    \column {
      \fill-line { \null \bold \fromproperty #'header:dedication }
      \vspace #0.8
      \fill-line {
        \null
        \fontsize #8 \fromproperty #'header:title
        \fontsize #8 \fromproperty #'header:number
      }
      \vspace #0.6
      \fill-line {
        \fromproperty #'header:poet
        \fromproperty #'header:meter
        \fromproperty #'header:composer
      }
      \vspace #0.5
    }
  }
}

global = {
  \key ees \major
  \time 3/4
}

%% ---------------------------------------------------------------
%%  Split helpers
%%
%%  Each staff is normally ONE voice writing two-note chords on a
%%  single stem.  Where the two parts need to be seen apart — they
%%  move in different note values, or they sit a second apart — wrap
%%  that moment in \tsplit (treble) or \bsplit (bass):
%%
%%      \tsplit { upper-part music } { lower-part music }
%%
%%  The upper argument stays in the enclosing voice, so lyrics keep
%%  following it without interruption.  Afterwards the staff returns
%%  to single-stem chords automatically.
%% ---------------------------------------------------------------

tsplit =
#(define-music-function (up down) (ly:music? ly:music?)
   #{
     << { \voiceOne #up } \new Voice { \voiceTwo #down } >>
     \oneVoice \stemUp
   #})

bsplit =
#(define-music-function (up down) (ly:music? ly:music?)
   #{
     << { \voiceOne #up } \new Voice { \voiceTwo #down } >>
     \oneVoice \stemDown
   #})

%% ---------------------------------------------------------------
%%  Music  —  absolute pitch
%%
%%  Phrase plan (16 bars, 10.11.11.11):
%%    line 1  bars  1– 4        line 3  bars  8–12
%%    line 2  bars  4– 8        line 4  bars 12–16
%%  Each line ends on a half note, with the next line's first
%%  syllable as an upbeat on beat 3.  Systems break after bars 5
%%  and 10, as on the printed page.
%% ---------------------------------------------------------------

upper = {
  \global
  \stemUp

  <bes ees'>4 <bes ees'> \tsplit { f'8 (ees'8) } { bes4 } |  % Be Thou My
  <aes c'>4 \tsplit { bes } { bes } <aes c'>4          |  % Vi--sion, O
  <bes ees'>4 <c' ees'> <f' d'>                 |  % Lord of my;
  <g' bes>2 \tsplit { bes'8 (g'8) } { ees'4 }                              |  % heart;     be
  <f' d'>4 <f' d'> \tsplit { f' } { ees' }                  |  % all else but
  \break
  \tsplit { f' } { f' } <g' ees'> <bes' ees'>                  |  % naught to me,
  <c'' ees'>4 <bes' ees'> <g' ees'>                   |  % save that Thou
  <bes' f'>2 <bes' g'>4                             |  % art;          be
  <c'' ees'>4 \tsplit {c''8 ([d'']) } {ees'4} \tsplit {ees''8 ([d'']) } {ees'4}                |  % Thou my best
  <c'' ees'>4 <bes' ees'> <g' ees'>                 |  % thought in the
  \break
  <bes' ees'>4 <ees' c'> <d' bes> |  % day and the
  \tsplit {c'2} {c'2} \tsplit {bes4} {bes4}                           |  % night,        both
  <ees' bes>4 <g' ees'> <bes' ees'>                  |  % wak -- ing and
  <c'' ees'>8( <bes' d'>8) <g' ees'>4 \tsplit { ees'8( g'8) } { ees'4 }                 |  % sleep -- ing, Thy
  <f' c'>4 <ees' c'> <ees' aes>                   |  % pres -- ence my
  <ees' bes>2.                                       |  % light.
  \bar "|."
}

lower = {
  \global
  \stemDown

  <ees g>4 <ees g> <ees g,>                  |
  <ees aes,>4 <d bes,> <ees aes,>     |
  <ees g,>4 <g c> <bes bes,>                    |
  <ees bes>2 <bes g,>4                                |
  <bes bes,>4 <bes bes,> <a c>                       |
  <bes d>4 <bes ees> <bes g,>                       |
  <aes aes,>4 <bes g,> <c' c>                          |
  <d' bes,>2 <d' bes,>4                               |
  <aes aes,>4 \bsplit {aes8[ bes]} {aes,4} \bsplit {c'8[ bes]} {aes4}                        |
  <aes ees>4 <g ees> <bes ees>                         |
  <bes g,>4 <g c> <g g,>                      |
  <ees aes,>2 <d bes,>4                                |
  <g ees>4 <bes ees> <bes g,>                         |
  \bsplit { aes4 } { aes,8[ bes,]} <g c>4 \bsplit {g8 bes} {c4}                         |
  <aes aes,>4 <aes aes,> <aes c>                          |
  <g ees>2.                                        |
}

%% ---------------------------------------------------------------
%%  Text
%%
%%  \lineStart left-aligns a syllable on its note instead of
%%  centring it.  Put it on the first syllable of each system in
%%  every stanza so the left edges line up vertically.  Systems
%%  begin at bars 1, 6 and 11, i.e. syllables 1, 15 and 29.
%% ---------------------------------------------------------------

lineStart = \once \override LyricText.self-alignment-X = #LEFT

verseOne = \lyricmode {
  \set stanza = "1."
  \lineStart Be Thou my Vi -- sion, O Lord of my heart;
  be all else but \lineStart naught to me, save that Thou art;
  be Thou my best thought in the \lineStart day and the night,
  both wak -- ing and sleep -- ing, Thy pres -- ence my light.
}

verseTwo = \lyricmode {
  \set stanza = "2."
  \lineStart Be Thou my Wis -- dom, be Thou my true Word;
  be Thou ev -- er \lineStart with me and I with Thee, Lord;
  be Thou my great Fa -- ther, and \lineStart I Thy true son,
  be Thou in me dwell -- ing, and I with Thee one.
}

verseThree = \lyricmode {
  \set stanza = "3."
  \lineStart Be Thou my Breast -- plate, my Sword for the fight;
  be Thou my whole \lineStart Ar -- mor, be Thou my true Might;
  be Thou my soul's Shel -- ter, be \lineStart Thou my strong Tow'r,
  O raise Thou me heav'n -- ward, great Pow'r of my pow'r.
}

verseFour = \lyricmode {
  \set stanza = "4."
  \lineStart Rich -- es I heed not, nor man's emp -- ty praise,
  be Thou mine in -- \lineStart her -- i -- tance, now and al -- ways;
  be Thou and Thou on -- ly the \lineStart first in my heart,
  O High King of heav -- en, my Trea -- sure Thou art.
}

verseFive = \lyricmode {
  \set stanza = "5."
  \lineStart High King of heav -- en, Thou heav -- en's bright Sun,
  O grant me its \lineStart joys, af -- ter vic -- t'ry is won;
  Great Heart of my own heart, what -- \lineStart ev -- er be -- fall,
  still be Thou my Vi -- sion, O Rul -- er of all.
}

%% ---------------------------------------------------------------
%%  Score
%% ---------------------------------------------------------------

\score {
  \new ChoirStaff <<
    \new Staff = "upper" \new Voice = "melody" \upper

    \new Lyrics \lyricsto "melody" \verseOne
    \new Lyrics \lyricsto "melody" \verseTwo
    \new Lyrics \lyricsto "melody" \verseThree
    \new Lyrics \lyricsto "melody" \verseFour
    \new Lyrics \lyricsto "melody" \verseFive

    \new Staff = "lower" { \clef bass \lower }
  >>

  \layout {
    indent = 0
    \context {
      \Score
      \override BarNumber.break-visibility = ##(#f #f #f)
      \override SpacingSpanner.uniform-stretching = ##t
    }
    \context {
      \Staff
      \override NoteCollision.merge-differently-headed = ##t
      \override NoteCollision.merge-differently-dotted = ##t
    }
    \context {
      \ChoirStaff
      \override SystemStartBracket.stencil = ##f
    }
    \context {
      \Lyrics
      \override LyricText.font-size = #0.5
      %% centre the stanza block between the two staves
      \override VerticalAxisGroup.staff-affinity = #CENTER
      %% gap up to the treble staff
      \override VerticalAxisGroup.nonstaff-relatedstaff-spacing =
        #'((basic-distance . 9) (minimum-distance . 5) (padding . 0.5))
      %% gap down to the bass staff
      \override VerticalAxisGroup.nonstaff-unrelatedstaff-spacing =
        #'((basic-distance . 5) (minimum-distance . 3) (padding . 0.5))
      %% gap between the stanzas themselves
      \override VerticalAxisGroup.nonstaff-nonstaff-spacing =
        #'((basic-distance . 2.6) (padding . 0.2))
    }
  }

  \midi { \tempo 4 = 96 }
}
