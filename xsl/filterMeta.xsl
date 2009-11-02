<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:nir="http://www.normeinrete.it/nir/2.2/"
	xmlns:h="http://www.w3.org/HTML/1998/html4"
	xmlns:dsp="http://www.normeinrete.it/nir/disposizioni/2.2/">

<!-- FILTRO-->
<xsl:template match="@*">
	<xsl:attribute name = "{name()}">
		<xsl:value-of select = "."/>
	</xsl:attribute>
</xsl:template>

<xsl:template match="*">
	<xsl:if test="not(name()='proprietario')">
		<xsl:copy>
			<xsl:apply-templates select ="text()|*|@*|comment()"/>
		</xsl:copy>
	</xsl:if>
</xsl:template>

<xsl:template match="comment()">
  <xsl:comment><xsl:value-of select="."/></xsl:comment>
</xsl:template>

<xsl:template match="text()">
	<xsl:value-of select="." disable-output-escaping="yes" />
</xsl:template>

</xsl:stylesheet>