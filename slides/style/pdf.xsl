<?xml version="1.0"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
		xmlns:db="http://docbook.org/ns/docbook"
		xmlns:h="http://www.w3.org/1999/xhtml"
                xmlns:m="http://docbook.org/xslt/ns/mode"
                xmlns:ext="http://docbook.org/extensions/xslt20"
                xmlns:f="http://docbook.org/xslt/ns/extension"
                xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xs="http://www.w3.org/2001/XMLSchema"
                xmlns:rx="http://www.renderx.com/XSL/Extensions"
                xmlns:p="http://pygments.org/"
                exclude-result-prefixes="f t db xs m h ext"
                version="2.0">

<xsl:import href="docbook/slides/fo/plain.xsl"/>

<xsl:param name="slide.font.family">Verdana</xsl:param>
<xsl:param name="slide.title.font.family">Verdana</xsl:param>
<xsl:param name="foil.title.master">28</xsl:param>
<xsl:param name="body.font.size">24pt</xsl:param>

<xsl:attribute-set name="verbatim.properties">
  <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
  <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
  <xsl:attribute name="space-after.maximum">1.2em</xsl:attribute>
  <xsl:attribute name="hyphenate">false</xsl:attribute>
  <xsl:attribute name="wrap-option">no-wrap</xsl:attribute>
  <xsl:attribute name="white-space-collapse">false</xsl:attribute>
  <xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
  <xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
  <xsl:attribute name="text-align">start</xsl:attribute>
  <xsl:attribute name="keep-with-previous.within-column">always</xsl:attribute>
  <xsl:attribute name="keep-with-next.within-column">auto</xsl:attribute>
  <xsl:attribute name="border-width" select="'1pt'"/>
  <xsl:attribute name="border-color" select="'black'"/>
  <xsl:attribute name="border-style" select="'solid'"/>
  <xsl:attribute name="background-color" select="'#E6E6E6'"/>
  <xsl:attribute name="padding" select="'4pt'"/>
</xsl:attribute-set>

<xsl:attribute-set name="subtitle.properties">
  <xsl:attribute name="font-family" select="$title.font.family"/>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
</xsl:attribute-set>

<xsl:attribute-set name="title.properties">
  <xsl:attribute name="font-family" select="$title.font.family"/>
  <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
</xsl:attribute-set>

<!-- ============================================================ -->

<xsl:template name="t:user-localization-data">
  <i18n xmlns="http://docbook.sourceforge.net/xmlns/l10n/1.0">
    <l:l10n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0" language="en">
      <l:gentext key="Continued" text="(Continued)"/>
      <l:context name="title">
        <l:template name="slides" text="%t"/>
        <l:template name="foilgroup" text="%t"/>
        <l:template name="foil" text="%t"/>
      </l:context>
      <l:context name="subtitle">
        <l:template name="slides" text="%s"/>
        <l:template name="foilgroup" text="%s"/>
        <l:template name="foil" text="%s"/>
      </l:context>
      <l:context name="datetime">
        <l:template name="format">[D01] [MNn] [Y0001]</l:template>
      </l:context>
    </l:l10n>
  </i18n>
</xsl:template>

<xsl:template name="t:user-titlepage-templates" as="element()?">
  <templates-list xmlns="http://docbook.org/xslt/titlepage-templates">
    <templates name="slides" namespace="http://docbook.org/ns/docbook">
      <titlepage>
        <fo:block font-family="Verdana, sans-serif" margin-left="2.5in" font-size="26pt">
          <fo:block margin-top="0.25in">
            <db:title/>
          </fo:block>
          <fo:block font-size="20pt">
            <db:pubdate/>
          </fo:block>
          <fo:block line-height="2" margin-top="3.75in">
            <fo:block>
              <db:subtitle/>
            </fo:block>
            <fo:block>
              <db:author/>
            </fo:block>
          </fo:block>
        </fo:block>
      </titlepage>
    </templates>

    <templates name="foilgroup" namespace="http://docbook.org/ns/docbook">
      <titlepage/>
    </templates>

    <templates name="foil" namespace="http://docbook.org/ns/docbook">
      <titlepage/>
    </templates>
  </templates-list>
</xsl:template>

<!-- ============================================================ -->

<xsl:template name="t:user-pagemasters">
  <fo:simple-page-master master-name="slides-titlepage-master"
                         page-width="{$page.width}"
                         page-height="{$page.height}"
                         margin-top="{$page.margin.top}"
                         margin-bottom="{$page.margin.bottom}"
                         margin-left="{$page.margin.inner}"
                         margin-right="{$page.margin.outer}">
    <fo:region-body margin-bottom="0pt"
                    margin-top="0pt"
                    column-count="{$column.count.body}"
                    background-image="url(images/print/xmlss-titlebg.png)"
                    background-attachment="fixed"
                    background-repeat="no-repeat"
                    background-position-horizontal="center"
                    background-position-vertical="center">
    </fo:region-body>
    <fo:region-after region-name="xsl-region-after-foil"
                     extent="{$region.after.extent}"
                     display-align="after"/>
  </fo:simple-page-master>

  <fo:simple-page-master master-name="slides-foil-master"
                         page-width="{$page.width}"
                         page-height="{$page.height}"
                         margin-top="{$page.margin.top}"
                         margin-bottom="{$page.margin.bottom}"
                         margin-left="{$page.margin.inner}"
                         margin-right="{$page.margin.outer}">
    <fo:region-body margin-bottom="0.5in"
                    margin-top="1.75in"
                    column-count="{$column.count.body}">
    </fo:region-body>
    <fo:region-before region-name="xsl-region-before-foil"
                      extent="1.5in"
                      background-color="#fffc84"
                      display-align="before"
                      background-image="url(images/print/xmlss-bglogo.png)"
                      background-attachment="fixed"
                      background-repeat="no-repeat"
                      background-position-horizontal="left"
                      background-position-vertical="top"/>
    <fo:region-after region-name="xsl-region-after-foil"
                     extent="{$region.after.extent}"
                     display-align="after"/>
  </fo:simple-page-master>

  <fo:simple-page-master master-name="slides-foil-continued-master"
                         page-width="{$page.width}"
                         page-height="{$page.height}"
                         margin-top="{$page.margin.top}"
                         margin-bottom="{$page.margin.bottom}"
                         margin-left="{$page.margin.inner}"
                         margin-right="{$page.margin.outer}">
    <fo:region-body margin-bottom="0.5in"
                    margin-top="1.75in"
                    column-count="{$column.count.body}">
    </fo:region-body>
    <fo:region-before region-name="xsl-region-before-foil-continued"
                      extent="1.5in"
                      background-color="#fffc84"
                      display-align="before"
                      background-image="url(images/print/xmlss-bglogo.png)"
                      background-attachment="fixed"
                      background-repeat="no-repeat"
                      background-position-horizontal="left"
                      background-position-vertical="top"/>
    <fo:region-after region-name="xsl-region-after-foil-continued"
                     extent="{$region.after.extent}"
                     display-align="after"/>
  </fo:simple-page-master>

  <fo:page-sequence-master master-name="slides-titlepage">
    <fo:repeatable-page-master-alternatives>
      <fo:conditional-page-master-reference master-reference="slides-titlepage-master"
                                            odd-or-even="any"/>
    </fo:repeatable-page-master-alternatives>
  </fo:page-sequence-master>

  <fo:page-sequence-master master-name="slides-foil">
    <fo:repeatable-page-master-alternatives>
      <fo:conditional-page-master-reference master-reference="slides-foil-master"
                                            page-position="first"
                                            odd-or-even="any"/>
      <fo:conditional-page-master-reference master-reference="slides-foil-continued-master"/>
    </fo:repeatable-page-master-alternatives>
  </fo:page-sequence-master>

  <fo:page-sequence-master master-name="slides-foilgroup">
    <fo:repeatable-page-master-alternatives>
      <fo:conditional-page-master-reference master-reference="slides-titlepage-master"
                                            page-position="first"
                                            odd-or-even="any"/>
      <fo:conditional-page-master-reference master-reference="slides-foil-continued-master"
                                            page-position="rest"
                                            odd-or-even="any"/>
    </fo:repeatable-page-master-alternatives>
  </fo:page-sequence-master>
</xsl:template>

<xsl:template match="*" mode="m:running-head-mode">
  <xsl:param name="master-reference" select="'unknown'"/>
  <!-- use the foilgroup title if there is one -->
  <fo:static-content flow-name="xsl-region-before-foil">
    <fo:block background-color="#fffc84"
              color="black"
              font-size="{$foil.title.size}"
              margin-top="0.5in"
              margin-left="2in"
              text-align="center"
              font-family="{$slide.title.font.family}">
      <xsl:apply-templates select="db:title" mode="m:titlepage-mode"/>
    </fo:block>
  </fo:static-content>

  <fo:static-content flow-name="xsl-region-before-foil-continued">
    <fo:block background-color="#fffc84"
              color="black"
              margin-top="0.5in"
              margin-left="2in"
              text-align="center"
              font-family="{$slide.title.font.family}">
      <fo:block>
        <xsl:apply-templates select="db:title" mode="m:titlepage-mode"/>
      </fo:block>
      <fo:block font-size="16pt">
        <xsl:call-template name="gentext">
          <xsl:with-param name="key" select="'Continued'"/>
        </xsl:call-template>
      </fo:block>
    </fo:block>
  </fo:static-content>
</xsl:template>

<xsl:template match="*" mode="m:running-foot-mode">
  <xsl:param name="master-reference" select="'unknown'"/>

  <xsl:variable name="content">
    <fo:block background-color="#fffc84">
      <fo:table table-layout="fixed" width="100%"
                color="black" font-family="Verdana, Tahoma, Arial, sans-serif">
        <fo:table-column column-number="1" column-width="1.3in"/>
        <fo:table-column column-number="2" column-width="4.5in"/>
        <fo:table-column column-number="3"/>
        <fo:table-column column-number="4" column-width="2in"/>
        <fo:table-body>
          <fo:table-row height="0.5in">
            <fo:table-cell text-align="left" display-align="center">
              <fo:block margin-left="0.05in" margin-top="0.01in">
                <fo:external-graphic src="url(images/print/cc-1280.png)"/>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="left" display-align="center">
              <fo:block font-size="10pt">
                <fo:block>Licensed under a Creative Commons Attribution-</fo:block>
                <fo:block>Noncommercial-Share Alike 3.0 Unported License</fo:block>
              </fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="left" display-align="center">
              <fo:block font-size="16pt" color="#DD4831">www.xmlsummerschool.com</fo:block>
            </fo:table-cell>
            <fo:table-cell text-align="right" font-size="10pt" display-align="center">
              <fo:block font-size="10pt" margin-right="0.25in">
                <xsl:text>Slide </xsl:text>
                <fo:page-number/>
              </fo:block>
            </fo:table-cell>
          </fo:table-row>
        </fo:table-body>
      </fo:table>
    </fo:block>
  </xsl:variable>

  <fo:static-content flow-name="xsl-region-after-foil">
    <xsl:sequence select="$content"/>
  </fo:static-content>

  <fo:static-content flow-name="xsl-region-after-foil-continued">
    <xsl:sequence select="$content"/>
  </fo:static-content>
</xsl:template>

<xsl:template match="db:slides">
  <xsl:variable name="master-reference" select="'slides-titlepage'"/>

  <fo:page-sequence hyphenate="{$hyphenate}"
                    master-reference="{$master-reference}"
                    force-page-count="no-force">
    <xsl:attribute name="language" select="f:l10n-language(.)"/>

    <fo:static-content flow-name="xsl-region-after-foil">
      <fo:block background-color="#fffc84">
        <fo:table table-layout="fixed" width="100%"
                  color="black" font-family="Verdana, Tahoma, Arial, sans-serif">
          <fo:table-column column-number="1" column-width="1.3in"/>
          <fo:table-column column-number="2" column-width="4.5in"/>
          <fo:table-column column-number="3"/>
          <fo:table-body>
            <fo:table-row height="0.5in">
              <fo:table-cell text-align="left" display-align="center">
                <fo:block margin-left="0.05in" margin-top="0.01in">
                  <fo:external-graphic src="url(images/print/cc-1280.png)"/>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="left" display-align="center">
                <fo:block font-size="10pt">
                  <fo:block>Licensed under a Creative Commons Attribution-</fo:block>
                  <fo:block>Noncommercial-Share Alike 3.0 Unported License</fo:block>
                </fo:block>
              </fo:table-cell>
              <fo:table-cell text-align="left" display-align="center">
                <fo:block font-size="18pt">www.xmlsummerschool.com</fo:block>
              </fo:table-cell>
            </fo:table-row>
          </fo:table-body>
        </fo:table>
      </fo:block>
    </fo:static-content>

    <fo:flow flow-name="xsl-region-body">
      <fo:block>
        <xsl:call-template name="t:id">
          <xsl:with-param name="force" select="1"/>
        </xsl:call-template>

        <xsl:call-template name="t:titlepage"/>
      </fo:block>
    </fo:flow>
  </fo:page-sequence>
  <xsl:apply-templates select="db:foil|db:foilgroup"/>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:author" mode="m:titlepage-mode">
  <fo:block>
    <xsl:apply-templates select="db:personname"/>
  </fo:block>
  <fo:block>
    <xsl:value-of select="db:affiliation/db:orgname"/>
  </fo:block>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:foilgroup">
  <xsl:variable name="master-reference" select="'slides-foilgroup'"/>

  <fo:page-sequence hyphenate="{$hyphenate}"
                    master-reference="{$master-reference}">
    <xsl:if test="empty(preceding-sibling::db:foilgroup) and empty(preceding-sibling::db:foil)">
      <xsl:attribute name="initial-page-number" select="1"/>
    </xsl:if>

    <xsl:call-template name="t:id">
      <xsl:with-param name="force" select="1"/>
    </xsl:call-template>
    <xsl:attribute name="language" select="f:l10n-language(.)"/>

    <xsl:apply-templates select="." mode="m:running-head-mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="m:running-foot-mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <fo:block xsl:use-attribute-sets="foil.properties" space-after="1em">
        <fo:block font-size="28pt" padding-top="5in" text-align="right">
          <xsl:value-of select="db:title"/>
        </fo:block>
      </fo:block>
    </fo:flow>
  </fo:page-sequence>
  <xsl:apply-templates select="db:foil"/>
</xsl:template>

<xsl:template match="db:title" mode="m:foilgroup-titlepage-recto-mode">
  <fo:block>
    <fo:inline color="white">.</fo:inline>
    <fo:block space-before="2in">
      <xsl:apply-templates select="." mode="m:titlepage-mode"/>
    </fo:block>
  </fo:block>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:foil">
  <xsl:variable name="master-reference" select="'slides-foil'"/>

  <fo:page-sequence hyphenate="{$hyphenate}"
                    master-reference="{$master-reference}">
    <xsl:if test="empty(preceding::db:foil) and empty(parent::db:foilgroup)">
      <xsl:attribute name="initial-page-number" select="1"/>
    </xsl:if>

    <xsl:call-template name="t:id">
      <xsl:with-param name="force" select="1"/>
    </xsl:call-template>
    <xsl:attribute name="language" select="f:l10n-language(.)"/>

    <xsl:apply-templates select="." mode="m:running-head-mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="m:running-foot-mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <fo:block>
        <xsl:call-template name="t:titlepage"/>
	<fo:block xsl:use-attribute-sets="foil.properties">
          <xsl:apply-templates/>
        </fo:block>
      </fo:block>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<xsl:template match="db:foil[preceding-sibling::db:foilgroup]">
  <xsl:variable name="master-reference" select="'slides-foilgroup'"/>

  <fo:page-sequence hyphenate="{$hyphenate}"
                    master-reference="{$master-reference}">
    <xsl:if test="empty(preceding-sibling::db:foilgroup) and empty(preceding-sibling::db:foil)">
      <xsl:attribute name="initial-page-number" select="1"/>
    </xsl:if>

    <xsl:call-template name="t:id">
      <xsl:with-param name="force" select="1"/>
    </xsl:call-template>
    <xsl:attribute name="language" select="f:l10n-language(.)"/>

    <xsl:apply-templates select="." mode="m:running-head-mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>
    <xsl:apply-templates select="." mode="m:running-foot-mode">
      <xsl:with-param name="master-reference" select="$master-reference"/>
    </xsl:apply-templates>

    <fo:flow flow-name="xsl-region-body">
      <fo:block xsl:use-attribute-sets="foil.properties" space-after="1em">
        <fo:block font-size="28pt" padding-top="5in" text-align="right">
          <xsl:value-of select="db:title"/>
        </fo:block>
      </fo:block>
      <xsl:apply-templates/>
    </fo:flow>
  </fo:page-sequence>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:phrase[@role='oneinch']">
  <fo:inline font-family="Symbol" font-size="72pt">
    <xsl:apply-templates/>
  </fo:inline>
</xsl:template>

<xsl:template match="*[@role='reveal1']" priority="1000">
  <xsl:if test="not(following-sibling::*[@role='reveal1'])">
    <xsl:next-match/>
  </xsl:if>
</xsl:template>

<!-- ============================================================ -->

<xsl:template match="db:programlisting|db:screen|db:synopsis
		     |db:literallayout[@class='monospaced']"
	      mode="m:verbatim">
  <xsl:param name="suppress-numbers" select="'0'"/>
  <xsl:variable name="id" select="f:node-id(.)"/>

  <xsl:variable name="pygments-pi" as="xs:string?"
                select="f:pi(/processing-instruction('dbhtml'), 'pygments')"/>

  <xsl:variable name="use-pygments" as="xs:boolean"
                select="$pygments-pi = 'true' or $pygments-pi = 'yes' or $pygments-pi = '1'
                        or (contains(@role,'pygments') and not(contains(@role,'nopygments')))"/>

  <xsl:variable name="verbatim" as="node()*">
    <!-- n.b. look below where the class attribute is computed -->
    <xsl:choose>
      <xsl:when test="contains(@role,'nopygments') or string-length(.) &gt; 9000
                      or self::db:literallayout or exists(*)">
        <xsl:sequence select="node()"/>
      </xsl:when>
      <xsl:when test="$pygments-default = 0 and not($use-pygments)">
        <xsl:sequence select="node()"/>
      </xsl:when>
      <xsl:when use-when="function-available('ext:highlight')"
                test="true()">
        <xsl:sequence select="ext:highlight(string(.), string(@language))"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:sequence select="node()"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:variable>

  <xsl:choose>
    <xsl:when test="$shade.verbatim != 0">
      <fo:block id="{$id}" p:class="{@language}"
		xsl:use-attribute-sets="monospace.verbatim.properties
					shade.verbatim.style">
	<xsl:apply-templates select="$verbatim" mode="m:verbatim"/>
      </fo:block>
    </xsl:when>
    <xsl:otherwise>
      <fo:block id="{$id}" p:class="{@language}"
                xsl:use-attribute-sets="monospace.verbatim.properties">
	<xsl:apply-templates select="$verbatim" mode="m:verbatim"/>
      </fo:block>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

</xsl:stylesheet>
