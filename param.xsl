<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns="http://www.w3.org/1999/xhtml"
version="1.0">
<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/xhtml/chunk.xsl" />

<xsl:param name="html.stylesheet" select="'../style/style.css'" />
<xsl:param name="chunker.output.encoding" select="'utf-8'" />
<xsl:param name="chunker.output.indent" select="'yes'" />
<xsl:param name="chunk.section.depth" select="0" />
<xsl:param name="suppress.navigation" select="1" />
<xsl:param name="use.id.as.filename" select="1" />
<xsl:param name="root.filename" select="'root'" />
<xsl:param name="toc.max.depth" select="0" />
<xsl:param name="css.decoration" select="0" />
<xsl:param name="generate.toc">
book nop
</xsl:param>

<xsl:template name="chunk-element-content">
  <xsl:param name="prev"/>
  <xsl:param name="next"/>
  <xsl:param name="nav.context"/>
  <xsl:param name="content">
    <xsl:apply-imports/>
  </xsl:param>

  <xsl:call-template name="user.preroot"/>

  <html>
    <xsl:call-template name="html.head"></xsl:call-template>

    <body>
      <xsl:call-template name="body.attributes"/>
      <xsl:call-template name="user.header.navigation"/>

      <xsl:call-template name="header.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.header.content"/>

      <div id="content-wrapper">
        <div id="sidebar">
          <xsl:apply-templates select="//bookinfo/*/formalpara" />
          <xsl:apply-templates select="//bookinfo/*/para[@id='sidebar-credits']" />
        </div>
        <div id="content">
          <xsl:copy-of select="$content"/>
        </div>
      </div>

      <xsl:call-template name="user.footer.content"/>

      <xsl:call-template name="footer.navigation">
        <xsl:with-param name="prev" select="$prev"/>
        <xsl:with-param name="next" select="$next"/>
        <xsl:with-param name="nav.context" select="$nav.context"/>
      </xsl:call-template>

      <xsl:call-template name="user.footer.navigation"/>
    </body>
  </html>
  <xsl:value-of select="$chunk.append"/>
</xsl:template>

<xsl:template name="html.head">
	<head>
	<xsl:call-template name="system.head.content"/>
	<xsl:if test="$html.stylesheet != ''">
		<xsl:call-template name="output.html.stylesheets">
			<xsl:with-param name="stylesheets" select="normalize-space($html.stylesheet)"/>
		</xsl:call-template>
	</xsl:if>
	<meta name="generator" content="DocBook {$DistroTitle} V{$VERSION}"/>
	<title>
		<xsl:value-of select="sect1/title"/>
		- <xsl:value-of select="//bookinfo/title"/>
		- <xsl:value-of select="//bookinfo/subtitle"/>
	</title>

	<xsl:call-template name="user.head.content"/>
	</head>
</xsl:template>

<xsl:template name="user.header.navigation">
	<xsl:apply-templates select="//bookinfo" />
</xsl:template>

<!-- <xsl:template name="user.header.content"></xsl:template> -->

<xsl:template name="footer.navigation">
	<xsl:apply-templates select="//bookinfo/*/para[@id='footer']" />
</xsl:template>

<xsl:template name="article.titlepage"></xsl:template>

<xsl:template name="article.titlepage.separator">
</xsl:template>

<xsl:template match="bookinfo">
	<div id="header">
		<div class="content">
			<h1><xsl:value-of select="title" /></h1>
			<p><xsl:value-of select="subtitle" /></p>
		</div>
		<div class="banner">
			<xsl:apply-templates select="//para[@id='banner']/itemizedlist" />
		</div>
	</div>
</xsl:template>

<xsl:template match="listitem/para">
  <xsl:apply-templates />
</xsl:template>

<xsl:template match="bookinfo/*/formalpara">
	<div id="{@id}">
		<h2><xsl:value-of select="title" /></h2>
		<xsl:apply-templates select="para" />
  </div>
</xsl:template>

<xsl:template match="bookinfo/*/para[@id='sidebar-credits']">
	<div id="{@id}">
    <xsl:apply-templates />
  </div>
</xsl:template>

<xsl:template match="bookinfo/*/para[@id='footer']">
	<div id="footer">
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="highlights">
	<div class="highlight">
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="application">
	<strong><xsl:value-of select="." /></strong>
</xsl:template>

<xsl:template match="command">
  <pre class="command"><xsl:value-of select="." /></pre>
</xsl:template>

<xsl:template match="informalfigure">
  <a href="{ulink/@url}"><xsl:apply-templates select="mediaobject/imageobject" /></a>
</xsl:template>
</xsl:stylesheet>
