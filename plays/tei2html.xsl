<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:tei="http://www.tei-c.org/ns/1.0"
                exclude-result-prefixes="tei"
                version="1.0">

<xsl:strip-space elements="*"/>

<xsl:template match="tei:TEI">
  <html>
    <head>
      <title>
        <xsl:value-of select="tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
      </title>
      <link rel="stylesheet" type="text/css" href="tei.css" />
    </head>
    <body>
      <xsl:apply-templates/>
    </body>
  </html>
</xsl:template>

<xsl:template match="tei:teiHeader">
  <div>
    <xsl:call-template name="attrs"/>
    <xsl:apply-templates select="tei:fileDesc"/>
  </div>
</xsl:template>

<xsl:template match="tei:fileDesc">
  <h1>
    <xsl:apply-templates select="tei:titleStmt/tei:title"/>
  </h1>

  <xsl:apply-templates select="tei:titleStmt/tei:author"/>
  <xsl:apply-templates select="tei:publicationStmt/tei:distributor/tei:name"/>
  <xsl:apply-templates select="tei:publicationStmt/tei:license"/>
</xsl:template>

<xsl:template match="tei:titleStmt/tei:title">
  <h1>
    <xsl:call-template name="attrs"/>
    <xsl:apply-templates/>
  </h1>
</xsl:template>

<xsl:template match="tei:titleStmt/tei:author
                     |tei:publicationStmt/tei:distributor/tei:name
                     |tei:publicationStmt/tei:license">
  <div>
    <xsl:call-template name="attrs"/>
    <xsl:apply-templates/>
  </div>
</xsl:template>

<xsl:template match="tei:head">
  <h2>
    <xsl:call-template name="attrs"/>
    <xsl:apply-templates/>
  </h2>
</xsl:template>

<xsl:template match="tei:lb">
  <br/>
</xsl:template>

<xsl:template match="tei:lb[not(preceding-sibling::node()) and parent::tei:ab]">
  <!-- nop -->
</xsl:template>

<xsl:template match="tei:text|tei:body|tei:div|tei:stage|tei:sp|tei:speaker|tei:ab">
  <div>
    <xsl:call-template name="attrs"/>
    <span>
      <xsl:apply-templates/>
    </span>
  </div>
</xsl:template>

<xsl:template match="tei:hi">
  <span>
    <xsl:call-template name="attrs"/>
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:seg">
  <span class="seg {@type} {@rend}">
    <xsl:apply-templates/>
  </span>
</xsl:template>

<xsl:template match="tei:choice">
  <span class="choice">
    <xsl:apply-templates select="tei:reg"/>
  </span>
</xsl:template>

<xsl:template match="tei:choice/tei:reg">
  <xsl:apply-templates/>
</xsl:template>

<xsl:template match="tei:pb|tei:milestone"/>

<xsl:template match="*">
  <span style="color:red">&lt;<xsl:value-of select="local-name(.)"/>&gt;</span>
</xsl:template>

<!-- ====================================================================== -->

<xsl:template name="attrs">
  <xsl:param name="node" select="."/>

  <xsl:attribute name="class">
    <xsl:choose>
      <xsl:when test="$node/@rend">
        <xsl:value-of select="concat(local-name($node), ' ', @rend)"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="local-name($node)"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:attribute>
  <xsl:attribute name="id">
    <xsl:value-of select="generate-id($node)"/>
  </xsl:attribute>
</xsl:template>

</xsl:stylesheet>
