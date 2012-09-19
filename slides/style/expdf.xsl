<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
		exclude-result-prefixes="xs"
                version="2.0">

<xsl:import href="docbook/base/fo/docbook.xsl"/>

<xsl:param name="linenumbering" as="element()*">
  <ln xmlns="http://docbook.org/ns/docbook" path="programlisting" everyNth="0"/>
</xsl:param>

</xsl:stylesheet>
