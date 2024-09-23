<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://purl.oclc.org/dsdl/schematron" queryBinding="xslt2" >
 <ns prefix="org" uri="https://nwalsh.com/ns/org-to-xml"/>
    <title>Paragraph Word Count Validation</title>
    <pattern id="paragraph-word-count">
        <title>Check word count in paragraph elements</title>
        <rule context="org:document/org:headline/org:section/org:paragraph">
            <report test="count(tokenize(normalize-space(.), '\s+')) ge 100">
                The paragraph must contain at least 100 words.
            </report>
            <report test="count(tokenize(normalize-space(.), '\s+')) le 200">
                The paragraph must contain no more than 200 words.
            </report>
        </rule>
    </pattern>
</schema>

