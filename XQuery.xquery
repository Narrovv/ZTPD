(: 5 :)
doc("db/bib/bib.xml")//author/last

(: 6 :)
for $b in doc("db/bib/bib.xml")//book,
    $t in $b/title,
    $a in $b/author
return
  <ksiazka>
    {$a}
    {$t}
  </ksiazka>

(: 7 :)
for $b in doc("db/bib/bib.xml")//book,
    $t in $b/title,
    $a in $b/author
return
  <ksiazka>
    <autor>{$a/last/text()}{$a/first/text()}</autor>
    <tytul>{$t/text()}</tytul>
  </ksiazka>

(: 8 :)
for $b in doc("db/bib/bib.xml")//book,
    $t in $b/title,
    $a in $b/author
return
  <ksiazka>
    <autor>{concat($a/last, " ", $a/first)}</autor>
    <tytul>{$t/text()}</tytul>
  </ksiazka>

(: 9 :)
<wynik>
{
  for $b in doc("db/bib/bib.xml")//book,
      $t in $b/title,
      $a in $b/author
  return
    <ksiazka>
      <autor>{concat($a/last, " ", $a/first)}</autor>
      <tytul>{$t/text()}</tytul>
    </ksiazka>
}
</wynik>

(: 10 :)
<imiona>
{
  for $a in doc("db/bib/bib.xml")//book[title = "Data on the Web"]/author
  return <imie>{$a/first/text()}</imie>
}
</imiona>

(: 11 - sposób 1 :)
<DataOnTheWeb>
{
  doc("db/bib/bib.xml")//book[title = "Data on the Web"]
}
</DataOnTheWeb>

(: 11 - sposób 2 :)
<DataOnTheWeb>
{
  for $b in doc("db/bib/bib.xml")//book
  where $b/title = "Data on the Web"
  return $b
}
</DataOnTheWeb>

(: 12 :)
<Data>
{
  for $a in doc("db/bib/bib.xml")//book[contains(title, "Data")]/author
  return <nazwisko>{$a/last/text()}</nazwisko>
}
</Data>

(: 13 :)
for $b in doc("db/bib/bib.xml")//book[contains(title, "Data")]
return
  <Data>
    {$b/title}
    {
      for $a in $b/author
      return <nazwisko>{$a/last/text()}</nazwisko>
    }
  </Data>

(: 14 :)
for $b in doc("db/bib/bib.xml")//book[count(author) <= 2]
return $b/title

(: 15 :)
for $b in doc("db/bib/bib.xml")//book
return
  <ksiazka>
    {$b/title}
    <autorow>{count($b/author)}</autorow>
  </ksiazka>

(: 16 :)
let $years := doc("db/bib/bib.xml")//book/@year
return
  <przedział>{concat(min($years), " ", max($years))}</przedział>

(: 17 :)
let $prices := doc("db/bib/bib.xml")//book/price
return
  <różnica>{max($prices) - min($prices)}</różnica>

(: 18 :)
let $min_price := min(doc("db/bib/bib.xml")//book/price)
return
  <najtańsze>
  {
    for $b in doc("db/bib/bib.xml")//book[price = $min_price]
    return
      <najtańsza>
        {$b/title}
        {$b/author}
      </najtańsza>
  }
  </najtańsze>

(: 19 :)
for $last in distinct-values(doc("db/bib/bib.xml")//author/last)
return
  <autor>
    <last>{$last}</last>
    {
      for $b in doc("db/bib/bib.xml")//book[author/last = $last]
      return $b/title
    }
  </autor>

(: 20 :)
<wynik>
{
  for $play in collection("db/shakespeare")//PLAY
  return $play/TITLE
}
</wynik>

(: 21 :)
for $play in collection("db/shakespeare")//PLAY[.//LINE[contains(., "or not to be")]]
return $play/TITLE

(: 22 :)
<wynik>
{
  for $play in collection("db/shakespeare")//PLAY
  return
    <sztuka tytul="{$play/TITLE}">
      <postaci>{count($play//PERSONA)}</postaci>
      <aktow>{count($play//ACT)}</aktow>
      <scen>{count($play//SCENE)}</scen>
    </sztuka>
}
</wynik>