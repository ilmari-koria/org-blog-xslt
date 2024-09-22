xquery version "3.1";

declare namespace b = "http://ilmarikoria.xyz/bib";

declare variable $bibtex := fn:unparsed-text("../../bib/bibliography.bib");

declare function b:bibtex-to-json($bibtex as xs:string) as xs:string {
	let $entries :=
  	for $entry in tokenize($bibtex, "\n@")
    return fn:normalize-space($entry)
    return string-join($entries, ", ")
};

let $json := b:bibtex-to-json($bibtex)
return $json
