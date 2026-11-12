(: 27 :)
for $k in doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/swiat.xml')/SWIAT/KRAJE/KRAJ
return <KRAJ>
    {$k/NAZWA, $k/STOLICA}
</KRAJ>

(: 28 :)
for $k in doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/swiat.xml')/SWIAT/KRAJE/KRAJ[starts-with(NAZWA, 'A')]
return <KRAJ>
    {$k/NAZWA, $k/STOLICA}
</KRAJ>

(: 29 :)
for $k in doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/swiat.xml')/SWIAT/KRAJE/KRAJ[substring(NAZWA, 1, 1) = substring(STOLICA, 1, 1)]
return <KRAJ>
    {$k/NAZWA, $k/STOLICA}
</KRAJ>

(: 30 :)
doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/swiat.xml')//KRAJ

(: 31 :)
doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')

(: 32 :)
doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY//NAZWISKO

(: 33 :)
doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY/*[ID_ZESP = doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//ZESPOLY/*[NAZWA = 'SYSTEMY EKSPERCKIE']/@ID_ZESP or ID_ZESP = doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//ZESPOLY/*[NAZWA = 'SYSTEMY EKSPERCKIE']/ID_ZESP]/NAZWISKO/text()

(: 34 :)
countdoc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY/*[ID_ZESP = 10 or @ID_ZESP = 10])

(: 35 :)
docdoc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY/*[ID_SZEFA = 100 or @ID_SZEFA = 100]/NAZWISKO

(: 36 :)
sum(docdoc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY/*[ID_ZESP = docdoc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY/*[NAZWISKO = 'BRZEZINSKI']/ID_ZESP or @ID_ZESP = doc('file:///C:/Users/kaczm/Downloads/XPath-XSLT/XPath-XSLT/zesp_prac.xml')//PRACOWNICY/*[NAZWISKO = 'BRZEZINSKI']/@ID_ZESP]/PLACA_POD)