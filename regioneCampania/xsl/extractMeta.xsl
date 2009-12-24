<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:nir="http://www.normeinrete.it/nir/2.2/"
	xmlns:h="http://www.w3.org/HTML/1998/html4"
	xmlns:dsp="http://www.normeinrete.it/nir/disposizioni/2.2/">


<xsl:template match="/">
	<meta>
			<xsl:copy-of select ="//nir:proprietario"/>
	</meta>
</xsl:template>

</xsl:stylesheet>