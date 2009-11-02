<?xml version="1.0" encoding="iso-8859-1"?>
<xsl:stylesheet version="1.0" xmlns:nir = "http://www.normeinrete.it/nir/2.2" 
										xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
										xmlns="http://www.w3.org/HTML/1998/html4" 
										xmlns:h="http://www.w3.org/HTML/1998/html4" 
										xmlns:xlink="http://www.w3.org/1999/xlink"
										xmlns:date="http://exslt.org/dates-and-times">
										
	<xsl:output method="html"  indent="yes"/>	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template principale                                     -->
	<!--                                                          -->
	<!-- ======================================================== -->

	<xsl:param name="doc"></xsl:param>
	<xsl:param name="datafine"></xsl:param>
	<xsl:param name="encoding"></xsl:param>
	<!-- <xsl:value-of select="UTF-8"/> -->

	
	<xsl:template match="/">
   <html>
        <head>
            <title>CNIPA - Normativa ICT</title>
            <link type="text/css" href="css/nir.css" rel="stylesheet"/>
	     <script type="text/javascript" src="./ui/js/norma.js"> var a = 666; </script>
	     
	  
 
        </head>
	<body>
	<div id="body" style="width:80%; padding-left:80px">
	
		<xsl:choose>
				<xsl:when test="//*[name()='eventi']/*[@fonte!='ro1']/@data!=''">
					<div style="font-weight:bold;">
						<xsl:choose>
							<xsl:when test="$datafine!=''">
								<xsl:text>Documento vigente a </xsl:text>
								<xsl:value-of select="concat(substring($datafine,7,2),'/',substring($datafine,5,2),'/',substring($datafine,1,4))"/><!-- <xsl:text>.</xsl:text>	 -->
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>Documento multivigente.</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</div>

					<div id="timeline">
						<xsl:call-template name="TimeLine" />
					</div>
				</xsl:when>
			</xsl:choose>
			<div class="tipodoc">
			<h2><xsl:value-of select="/*[name()='NIR']/*/*/*[name()='tipoDoc']"/>&#160;
			<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='emanante']"/>&#160;
			<xsl:choose>
				<xsl:when test="/*[name()='NIR']/*/*/*[name()='numDoc']!=''">
					n. &#160;<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='numDoc']"/>&#160;
				</xsl:when>
			</xsl:choose>
			
			del&#160;<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='dataDoc']"/></h2>
			</div>

			<xsl:choose>
				<xsl:when test="//*[name()='pubblicazione']/@norm!=''">
					<div class="pubblicazione">
						Pubblicazione <xsl:apply-templates select="//*[name()='pubblicazione']"/>
					</div>
				</xsl:when>
			</xsl:choose>

			<div class="intestazione">
				<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='intestazione']/*[name()='titoloDoc']" />
				</div>
				<hr/>
				<div class="formulainiziale">
		       	<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='formulainiziale']" />
		       	</div>
            	<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='articolato']/* | /*[name()='NIR']/*/*[name()='contenitore']|/*[name()='NIR']/*/*[name()='gerarchia']" />
			  	<div class="formulafinale">
	            	<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='formulafinale']" />
   		       	</div>
 			       	<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='conclusione']" /> 
            	<div class="meta">
            		<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='meta']" />
            	</div>
				<div class="annessi">
            		<xsl:apply-templates select="/*[name()='NIR']/*/*[name()='annessi']" />
            	</div>
	            	  <div>
    	        		<xsl:call-template name="notemultivigente" /> 
        	    	  </div>


       	    <xsl:if test="/*/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']">
				<div>
					<h1>Note della redazione</h1>
					<xsl:apply-templates select="/*/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']" />
				</div>	
			</xsl:if>


	</div>
	</body>
</html>
		</xsl:template>

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template pubblicazione                                  -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="/*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='pubblicazione']">
		<xsl:variable name="mesenum"><xsl:value-of select="substring(@norm,5,2)"/></xsl:variable>
		<xsl:variable name="mesepub">
			<xsl:choose>
				<xsl:when test="$mesenum='01'">Gennaio</xsl:when>
				<xsl:when test="$mesenum='02'">Febbraio</xsl:when>
				<xsl:when test="$mesenum='03'">Marzo</xsl:when>
				<xsl:when test="$mesenum='04'">Aprile</xsl:when>
				<xsl:when test="$mesenum='05'">Maggio</xsl:when>
				<xsl:when test="$mesenum='06'">Giugno</xsl:when>
				<xsl:when test="$mesenum='07'">Luglio</xsl:when>
				<xsl:when test="$mesenum='08'">Agosto</xsl:when>
				<xsl:when test="$mesenum='09'">Settembre</xsl:when>
				<xsl:when test="$mesenum='10'">Ottobre</xsl:when>
				<xsl:when test="$mesenum='11'">Novembre</xsl:when>
				<xsl:when test="$mesenum='12'">Dicembre</xsl:when>
				<xsl:otherwise/>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="giornonum"><xsl:value-of select="substring(@norm,7,2)"/></xsl:variable>
		<xsl:variable name="giornopub">
			<xsl:choose>
				<xsl:when test="$giornonum='01'">1</xsl:when>
				<xsl:when test="$giornonum='02'">2</xsl:when>
				<xsl:when test="$giornonum='03'">3</xsl:when>
				<xsl:when test="$giornonum='04'">4</xsl:when>
				<xsl:when test="$giornonum='05'">5</xsl:when>
				<xsl:when test="$giornonum='06'">6</xsl:when>
				<xsl:when test="$giornonum='07'">7</xsl:when>
				<xsl:when test="$giornonum='08'">8</xsl:when>
				<xsl:when test="$giornonum='09'">9</xsl:when>
				
				<xsl:otherwise><xsl:value-of select="$giornonum"/></xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		in <xsl:value-of select="@tipo" />&#160;<xsl:if test="@norm!=''">del&#160;<xsl:value-of select="$giornopub" />&#160;<xsl:value-of select="$mesepub" />&#160;<xsl:value-of select="substring(@norm,1,4)"/></xsl:if><xsl:if test="@num!=''">, n. <xsl:value-of select="@num" /></xsl:if>
	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template intestazione e relazione                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="nir:intestazione">
		<xsl:apply-templates/>
	<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="nir:emanante">
		<div class="title">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="//*[name()='titoloDoc']">
				<div class="titleLegge">
					<xsl:apply-templates/>
				</div>
	</xsl:template>	
	
	<xsl:template match="//*[name()='preambolo']">
				<div class="preambolo">
					<xsl:apply-templates/>
				</div>
	</xsl:template>	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template articolato                                     -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template match="//*[name()='articolato'] | //*[name()='contenitore']">
		<table border="0" cellpadding="0" cellspacing="10" width="100%">			
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>	
		</table>
	</xsl:template>
	<!-- ========================== 	LIBRO		============================== -->
	<xsl:template match="//*[name()='libro']">
		<a name="{@id}">&#160;</a>		
		<p class="libro">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>

	<!-- ========================== 	PARTE		============================== -->
	<xsl:template match="//*[name()='parte']">
		<a name="{@id}">&#160;</a>		
		<p class="parte">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>

	<!-- ========================== 	TITOLO		============================== -->
	<xsl:template match="//*[name()='titolo']">
		<a name="{@id}">&#160;</a>		
		<p class="titolo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>

	<!-- ========================== 	SEZIONE		============================== -->
	<xsl:template match="//*[name()='sezione']">
		<a name="{@id}">&#160;</a>		
		<p class="sezione">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>

	<!-- ========================== 	CAPO	============================== -->
	<xsl:template match="//*[name()='capo']">
		<hr />
		<a name="{@id}">&#160;</a>		
		<p class="capo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>
	
	<!-- ========================== 	RUBRICA	 	============================== -->
	
	<xsl:template match="//*[name()='rubrica']">
		<p class="rubrica">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</p>
	</xsl:template>

<!--	<xsl:template match="nir:*">
				<div class="{local-name()}">
						<xsl:apply-templates select="nir:num">
						</xsl:apply-templates>
						<xsl:text>&#160;</xsl:text>
						<xsl:apply-templates select="nir:rubrica | nir:corpo| nir:alinea">
						</xsl:apply-templates>
				</div>
		<xsl:apply-templates />
	</xsl:template> -->
	
	
	<!-- =========================	ARTICOLO	=============================== -->
	
	<xsl:template match="//*[name()='articolo']">
		<a name="{@id}">&#160;</a>
		<div class="articolo">
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</div>
	</xsl:template>
	
<!--	<xsl:template match="nir:comma | nir:el | nir:en | nir:ep">
		<xsl:param name="pos">none</xsl:param>
		<div class="{local-name()}">
			<xsl:apply-templates select="nir:num">
				<xsl:with-param name="pos" select="$pos"/>
			</xsl:apply-templates>
			<xsl:text> </xsl:text>
			<xsl:apply-templates select="nir:corpo | nir:alinea">
				<xsl:with-param name="pos" select="$pos"/>
			</xsl:apply-templates>
		</div>
		<xsl:apply-templates select="nir:el | nir:ep | nir:en | nir:coda">
			<xsl:with-param name="pos" select="$pos"/>
		</xsl:apply-templates>
	</xsl:template> -->
	<!-- =========================	COMMA e sotto comma	=============================== -->

	<xsl:template match="//*[name()='comma']">
		<a name="{@id}">&#160;</a>
		<p class="comma">
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</p>
	</xsl:template>

	<xsl:template match="//*[name()='num']">
		<xsl:choose>
			<xsl:when test="parent::node()[name()='el'] or parent::node()[name()='en'] or parent::node()[name()='ep']">
				<em><xsl:apply-templates />&#160;</em>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates />&#160;
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	<!-- =========================	EL , EN , EP	=============================== -->
	<xsl:template match="//*[name()='el'] | //*[name()='en'] | //*[name()='ep']">
	<a name="{@id}">&#160;</a>		
	<p class="{local-name()}">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
	</p>			

	</xsl:template>
	
	<xsl:template match="nir:corpo | nir:alinea">
		<xsl:param name="pos">none</xsl:param>
				<xsl:apply-templates>
					<xsl:with-param name="pos" select="$pos"/>
				</xsl:apply-templates>
	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template sotto il comma                                 -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	
	<xsl:template match="//*[name()='virgolette']">
		<xsl:param name="pos">none</xsl:param>
		<em>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza">
						<xsl:with-param name="pos" select="$pos"/>
					</xsl:call-template>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza">
						<xsl:with-param name="pos" select="$pos"/>
					</xsl:call-template>
				</xsl:otherwise>
			</xsl:choose>
		</em>
	</xsl:template>
	<xsl:template match="//*[name()='nome']">
		<span title="Nome: {.}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="//*[name()='rif']">
		<xsl:variable name="url">
			<xsl:value-of select="@xlink:href" />
		</xsl:variable>
		<xsl:variable name="post">
			<xsl:value-of select="./parent::*" />
		</xsl:variable>			
		<xsl:variable name="strina">
			<xsl:value-of select="substring(substring-after($post,.),1,1)" />
		</xsl:variable>	
		<xsl:choose>
			<xsl:when test="contains($url,'urn:nir:')"> <!-- ho inserito qui i riferimenti di niePACTo -->
				<xsl:choose>
					<xsl:when test="$strina='&#59;' or $strina='&#46;' or $strina='&#58;' or $strina='&#44;'  or $strina='&#45;'">		 
						<a href="./ui/urnResolver.html?urn={@xlink:href}" title="URN = {@xlink:href}">
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>					 
						<a href="./ui/urnResolver.html?urn={@xlink:href}" title="URN = {@xlink:href}">						
							<xsl:apply-templates/>						
						</a>&#160;
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<xsl:when test="$strina='&#59;' or $strina='&#46;' or $strina='&#58;' or $strina='&#44;'  or $strina='&#45;'">		 
						<a href="{@xlink:href}" title="Destinazione: {@xlink:href}">
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>					 
						<a href="{@xlink:href}" title="Destinazione: {@xlink:href}">						
						<xsl:apply-templates/>						
						</a>&#160;
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
		
	</xsl:template>
	<xsl:template match="//*[name()='data']">
		<span title="Data: {concat(substring(@norm,7,2),'/',substring(@norm,5,2),'/',substring(@norm,1,4))}">
			<xsl:apply-templates/>
		</span>
	</xsl:template>
	<xsl:template match="//*[name()='ndr']">
		<sup class="ndr">
		<a name="{concat('tndr',@num)}" href="{concat('#nndr',@num)}" title="Destinazione: {@num}">
				<xsl:attribute name="title">Nota: <xsl:value-of select="."/></xsl:attribute>
				[<xsl:value-of select="substring(.,2,number(string-length(.)-2))"/>]
		</a>
		</sup>
	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template conclusioni e formula finale                   -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='formulafinale']">
		<div class="formulafinale">
			<hr />
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>		
		</div>
	</xsl:template>
	
	<xsl:template match="//*[name()='conclusione']">
		<div class="conclusione">
			<xsl:apply-templates/>
		</div>
	</xsl:template>
	<xsl:template match="//*[name()='dataeluogo']">
		<p class="dataeluogo">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<xsl:template match="//*[name()='firma']">
			<xsl:choose>
			  <xsl:when test="@tipo='visto'">
				<p class="visto">
					<xsl:choose>
						<xsl:when test="$datafine!=''">
							<xsl:call-template name="vigenza"/>
						</xsl:when>
						<xsl:otherwise>
							<xsl:call-template name="multivigenza"/>
			  			</xsl:otherwise>
					</xsl:choose>	
				</p>
			  </xsl:when>
			  <xsl:otherwise>
				<p class="firma">
					<xsl:choose>
					  <xsl:when test="$datafine!=''">
						<xsl:call-template name="vigenza"/>
					  </xsl:when>
					  <xsl:otherwise>
						<xsl:call-template name="multivigenza"/>
					  </xsl:otherwise>
					</xsl:choose>	
				</p>
			  </xsl:otherwise>
			</xsl:choose>	
	</xsl:template>	

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template allegati                                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='annessi']">
		<br/>ALLEGATI:
		<xsl:apply-templates/>
	</xsl:template>
	<xsl:template match="//*[name()='annesso']">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
	</xsl:template>
	<xsl:template match="//*[name()='testata']">
			<hr/>
			<xsl:apply-templates select="*[name()='denAnnesso'] | *[name()='titAnnesso']"/>
			<br/>
	</xsl:template>
	<xsl:template match="*[name()='denAnnesso']">
		<b>
			<xsl:apply-templates select=".//text()"/>
		</b>
		<xsl:if test="following-sibling::*[name()='titAnnesso']"> - </xsl:if>
	</xsl:template>
	<xsl:template match="*[name()='titAnnesso']">
		<a name="{../../@id}">
			<xsl:apply-templates select=".//text()"/>
		</a>
	</xsl:template>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template metadati                                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='meta']"/>
	<xsl:template match="//*[name()='nota']">
		<xsl:variable name="idnota">
			<xsl:value-of select="@id" />
		</xsl:variable>
		<a class="nota" name="{@id}" href="{concat('#ndr',@id)}">

			<xsl:value-of select="//*[name()='ndr'][@num=$idnota]"/>
			<!--	xsl:value-of select="@id"/	-->
			
		</a><span class="nota"><xsl:text>&#160;-&#160;</xsl:text></span>
		<xsl:apply-templates />
	</xsl:template>
	<xsl:template match="nir:confronto"/>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template generici                                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="h:table">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:if test="not(@width)">
	        	<xsl:attribute name="width">95%</xsl:attribute>
	        </xsl:if>
 		    <xsl:if test="not(@border)">
        	    <xsl:attribute name="border">1</xsl:attribute>        
	        </xsl:if>
 		    <xsl:if test="not(@cellpadding)">
        	    <xsl:attribute name="cellpadding">2</xsl:attribute>        
	        </xsl:if>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>	

	<xsl:template match="@*">
		<xsl:attribute name="{local-name()}"><xsl:value-of select="."/></xsl:attribute>
	</xsl:template>

	<xsl:template match="h:*">
		<xsl:param name="pos">none</xsl:param>
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates>
				<xsl:with-param name="pos" select="$pos"/>
			</xsl:apply-templates>&#160;
		</xsl:element>
	</xsl:template>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template riferimenti incompleti                         -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="processing-instruction('rif')">
		<xsl:value-of select="substring-before(substring-after(.,'&gt;'),'&lt;')" />&#160;
	</xsl:template>
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template span 				                              -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='h:span']">
		<span>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</span>
	</xsl:template>	

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template p 				                              -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='h:p']">
		<p>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</p>
	</xsl:template>

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template gestione MULTIvigenze                          -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template name="multivigenza" >
		<xsl:variable name="stato">
		<xsl:value-of select="@status" />
		</xsl:variable>
		<xsl:variable name="inizio_id">
			<xsl:value-of select="@iniziovigore"/>
		</xsl:variable>
		<xsl:variable name="fine_id">
			<xsl:value-of select="@finevigore"/>
		</xsl:variable>		
		
<!--	??
		<xsl:variable name="data_inizio">
			<xsl:value-of select="id($inizio_id)/@data"/>						
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="id($fine_id)/@data"/>			
		</xsl:variable>
-->
		<xsl:variable name="data_inizio">
			<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
		</xsl:variable>



		<xsl:variable name="tooltip">
				<xsl:choose>
					<xsl:when test="$data_fine!=''">In vigore&#160;<xsl:choose>
										<xsl:when test="$data_inizio!=''">dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
										</xsl:when>
										<xsl:otherwise><xsl:text>fino</xsl:text>
										</xsl:otherwise>
									</xsl:choose>&#160;al <xsl:value-of select="concat(substring($data_fine,7,2),'/',substring($data_fine,5,2),'/',substring($data_fine,1,4))"/>
									<xsl:choose>			
										<xsl:when test="$stato!=''">(<xsl:value-of select="$stato"/>)</xsl:when>
									</xsl:choose>		
					</xsl:when>
					<xsl:when test="$data_inizio!=''">In vigore&#160;dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/></xsl:when>
				</xsl:choose>
		</xsl:variable>

			<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>
			<xsl:choose>

			<!-- ========================================== DATA FINE !='' ====================================== -->				
				<xsl:when test="$data_fine!=''">
					<xsl:choose>
						<xsl:when test="$data_fine&lt;$datafine">
							<!--===================== n{@id}, t{@id}:'n' e 't' differenziano il testo dalle note
							    ===================== <xsl:value-of select="@id"/>: il valore accanto a 'VigNota', l'id della partizione
							-->
							
							
							<!--************
							<span>
								<xsl:call-template name="makeNotavigenza" />
							</span>
							-->
							<xsl:variable name="id">
								<xsl:value-of select="@id" />
							</xsl:variable>
							<xsl:for-each select="//@iniziovigore">							
								<xsl:if test="../@id=$id">
									<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
								</xsl:if>		
							</xsl:for-each>
							
							
						</xsl:when>
						<xsl:when test="$data_inizio&gt;number(number($datafine)-1)">
							<span class="span-vigente">
								<xsl:variable name="colore">#060</xsl:variable> 
								<xsl:apply-templates/>
							
								
								<!--************
								<xsl:call-template name="makeNotavigenza" />
								-->
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//@iniziovigore">							
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>
								
								
							</span>
						</xsl:when>						
						<xsl:otherwise>
							<xsl:choose>			
								<xsl:when test="$stato!=''">
									<!-- <span style="color:#f00;" title="{$stato}"><xsl:apply-templates /> -->												
									<span class="span-abrogato">
										<xsl:variable name="colore">#f00</xsl:variable> 
										<xsl:apply-templates/>
										
										
										<!--************
										<xsl:call-template name="makeNotavigenza" />
										-->
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//@iniziovigore">							
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>
										
										
									</span>
								</xsl:when>
								<xsl:otherwise>
									<span class="span-abrogato">
										<xsl:variable name="colore">#f00</xsl:variable> 
										<xsl:apply-templates/>
										
										
										<!--************
										<xsl:call-template name="makeNotavigenza" />
										-->
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//@iniziovigore">							
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>
										
										
									</span>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>	
								<!-- ========================================== DATA inizio !='' ====================================== -->
				<xsl:when test="$data_inizio!=''">
					<xsl:choose>
						<xsl:when test="$data_inizio&gt;$datafine or $data_fine&lt;$datafine">
							<!--===================== n{@id}, t{@id}:'n' e 't' differenziano il testo dalle note
							    ===================== <xsl:value-of select="@id"/>: il valore accanto a 'VigNota', l'id della partizione
							-->
							
							
							<!--************
							<span> 
								<xsl:call-template name="makeNotavigenza" />
							</span>
							-->
							<xsl:variable name="id">
								<xsl:value-of select="@id" />
							</xsl:variable>
							<xsl:for-each select="//@iniziovigore">							
								<xsl:if test="../@id=$id">
									<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
								</xsl:if>		
							</xsl:for-each>							
							
							
						</xsl:when>
						<xsl:otherwise>
							<span class="span-vigente">
								<xsl:variable name="colore">#060</xsl:variable> 
								<xsl:apply-templates/>
								
								
								<!--************
								<xsl:call-template name="makeNotavigenza" />
								-->
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//@iniziovigore">							
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>								
								
								
							</span>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>			


				<xsl:otherwise>
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template gestione vigenze                               -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template name="vigenza" >
		<xsl:variable name="idnota">
			<xsl:value-of select="@id" />
		</xsl:variable>
		<xsl:variable name="stato">
		<xsl:value-of select="@status" />
		</xsl:variable>
		<xsl:variable name="inizio_id">
			<xsl:value-of select="@iniziovigore"/>
		</xsl:variable>
		<xsl:variable name="fine_id">
			<xsl:value-of select="@finevigore"/>
		</xsl:variable>		
		<xsl:variable name="data_entratainvigore">
			<xsl:value-of select="//*[name()='evento'][@fonte='ro1']/@data"/>
		</xsl:variable>

<!--	??
		<xsl:variable name="data_inizio">
			<xsl:value-of select="id($inizio_id)/@data"/>
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="id($fine_id)/@data"/>
		</xsl:variable>
-->
		<xsl:variable name="data_inizio">
			<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
		</xsl:variable>



		<xsl:variable name="tooltip">
				<xsl:choose>
					<xsl:when test="$data_fine!=''">In vigore&#160;<xsl:choose>
										<xsl:when test="$data_inizio!=''">dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
										</xsl:when>
										<xsl:otherwise><xsl:text>fino</xsl:text>
										</xsl:otherwise>
									</xsl:choose>&#160;al <xsl:value-of select="concat(substring($data_fine,7,2),'/',substring($data_fine,5,2),'/',substring($data_fine,1,4))"/>
									<xsl:choose>			
										<xsl:when test="$stato!=''">(<xsl:value-of select="$stato"/>)</xsl:when>
									</xsl:choose>		
					</xsl:when>
					<xsl:when test="$data_inizio!=''">In vigore&#160;dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/></xsl:when>
				</xsl:choose>
		</xsl:variable>

			<xsl:choose>

			<!-- ========================================== DATA FINE !='' ====================================== -->				
				<xsl:when test="$data_fine!=''">
					<xsl:variable name="ittignota">
						<xsl:value-of select="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$idnota]/../../*[name()='dsp:norma']/*[name()='ittig:notavigenza']/@id"/>
					</xsl:variable>		
					<xsl:choose>
						<xsl:when test="$data_fine&lt;number(number($datafine)+1)">
							<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>
 							<xsl:choose>
					  		  <xsl:when test="following-sibling::node()[1][@iniziovigore=$fine_id]">
							  </xsl:when>
					   		  <xsl:when test="preceding-sibling::node()[1][@iniziovigore=$fine_id]">
					 		  </xsl:when>
					 		  <xsl:otherwise>	
					 		  
					 		  
					 		  	<!-- ************
						 		<span style="color:#f00;"> [ ... ] <a href="#n{@id}" name="t{@id}"> <sup>{<xsl:value-of select="substring($ittignota,4,number(string-length($ittignota)))"/>}</sup></a></span>						 								 		
								-->
								<span class="span-abrogato"> 								
								<xsl:choose>
					  		  		<xsl:when test="*[name()='num']">
									  	[ <xsl:value-of select="*[name()='num']"/> ]						  		  		
							  		</xsl:when>
					   		  	    <xsl:otherwise>
							  		  	[ ... ]	
					   		  	    </xsl:otherwise>
								</xsl:choose>
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//@iniziovigore">							
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>	
						 		</span>
						 		
						 		
						 		
						 		
						 		
 							  </xsl:otherwise>
						   </xsl:choose>

						</xsl:when>
						<xsl:when test="$data_inizio&lt;number(number($datafine)+1) and $data_fine&gt;$datafine">
							<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>
 							<xsl:choose>
								<xsl:when test="$data_entratainvigore = $data_inizio">
									<xsl:apply-templates />		
									
									
									<!--************			
									<xsl:call-template name="makeNotavigenza" />
									-->
									<xsl:variable name="id">
										<xsl:value-of select="@id" />
									</xsl:variable>
									<xsl:for-each select="//@iniziovigore">							
										<xsl:if test="../@id=$id">
											<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
										</xsl:if>		
									</xsl:for-each>	
									
									
								</xsl:when>
						 		<xsl:otherwise>
									<span class="span-vigente">
										<xsl:apply-templates />					
										
										
										<!--************
										<xsl:call-template name="makeNotavigenza" />
										-->
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//@iniziovigore">							
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>											
										
										
									</span>
 							  	</xsl:otherwise>
						   	</xsl:choose>
						</xsl:when>						
					</xsl:choose>
				</xsl:when>	
			<!-- ========================================== DATA inizio !='' ====================================== -->
				<xsl:when test="$data_inizio!=''">
					<xsl:choose>
						<xsl:when test="$data_inizio&gt;$datafine">
							<!--===================== n{@id}, t{@id}:'n' e 't' differenziano il testo dalle note
							    ===================== <xsl:value-of select="@id"/>: il valore accanto a 'VigNota', l'id della partizione
							-->
						</xsl:when>
						<xsl:otherwise>
							<xsl:attribute name="title"><xsl:copy-of select="$tooltip" /></xsl:attribute>						
 							<xsl:choose>
								<xsl:when test="$data_entratainvigore = $data_inizio">
									<xsl:apply-templates />				
									
									
									<!--************
									<xsl:call-template name="makeNotavigenza" />
									-->
									<xsl:variable name="id">
										<xsl:value-of select="@id" />
									</xsl:variable>
									<xsl:for-each select="//@iniziovigore">							
										<xsl:if test="../@id=$id">
											<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
										</xsl:if>		
									</xsl:for-each>	
									
									
								</xsl:when>
						 		<xsl:otherwise>
									<span class="span-vigente">
										<xsl:apply-templates />					
										
										
										<!--************
										<xsl:call-template name="makeNotavigenza" />
										-->
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//@iniziovigore">							
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>	
										
										
									</span>
 							  	</xsl:otherwise>
						   	</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:when>			

				<xsl:otherwise>
					<xsl:apply-templates />
				</xsl:otherwise>
			</xsl:choose>
	</xsl:template>

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template nota di vigenza (nel testo)                    --> 
	<!--                                                          -->
	<!-- ======================================================== -->

   <xsl:template name="makeNotavigenza">
   		<xsl:variable name="idnota">
			<xsl:value-of select="@id" />
		</xsl:variable>
		<xsl:variable name="ittignota">
				<xsl:value-of select="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$idnota]/../../*[name()='dsp:norma']/*[name()='ittig:notavigenza']/@id"/>
		</xsl:variable>
		
		<xsl:choose>
			<xsl:when test="$ittignota">
				<xsl:choose>
					<!--  Si potrebbe anche inserire i COMMA che hanno figli -->		
					<xsl:when test="(local-name()='articolo' or local-name()='capo' or local-name()='titolo' or local-name()='libro' or local-name()='parte' or local-name()='sezione')">
						<div class="allineadx"><a href="#n{@id}" name="t{@id}"><sup>{<xsl:value-of select="substring($ittignota,4,number(string-length($ittignota)))"/>}</sup></a></div>
					</xsl:when>
					<xsl:otherwise>
						<a href="#n{@id}" name="t{@id}"><sup>{<xsl:value-of select="substring($ittignota,4,number(string-length($ittignota)))"/>}</sup></a>
					</xsl:otherwise>
				</xsl:choose>									
			</xsl:when>
			<xsl:otherwise>
				<!--  Note in vecchio stile-->		
				<a href="#n{@id}" name="t{@id}"><sup>{??}</sup></a>
			</xsl:otherwise>
		</xsl:choose>												
   </xsl:template>

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template note testo MultiVigente (fondo pagina)         -->
	<!--                                                          -->
	<!-- ======================================================== -->

	   <xsl:template name="notemultivigente">
		<xsl:for-each select="//@iniziovigore">
			<xsl:variable name="id">
				<xsl:value-of select="../@id" />
			</xsl:variable>
			<xsl:variable name="numeronota">
				<xsl:value-of select="position()" />
			</xsl:variable>		
					<xsl:variable name="stato">
						<xsl:value-of select="../@status" />
					</xsl:variable>
					<xsl:variable name="inizio_id">
						<xsl:value-of select="../@iniziovigore"/>
					</xsl:variable>
					<xsl:variable name="fine_id">
						<xsl:value-of select="../@finevigore"/>
					</xsl:variable>

<!--	??
					<xsl:variable name="data_inizio">
						<xsl:value-of select="id($inizio_id)/@data"/>
					</xsl:variable>
					<xsl:variable name="data_fine">
						<xsl:value-of select="id($fine_id)/@data"/>
					</xsl:variable>
					<xsl:variable name="fonte">
						<xsl:choose>
							<xsl:when test="$fine_id!=''">
								<xsl:value-of select="id($fine_id)/@fonte"/>
							</xsl:when>
							<xsl:otherwise>
								<xsl:value-of select="id($inizio_id)/@fonte"/>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:variable>
					<xsl:variable name="urn">
						<xsl:value-of select="id($fonte)/@xlink:href"/>
					</xsl:variable>
-->
		<xsl:variable name="data_inizio">
			<xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/>
		</xsl:variable>
		<xsl:variable name="data_fine">
			<xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/>
		</xsl:variable>
		<xsl:variable name="fonte">
			<xsl:choose>
				<xsl:when test="$fine_id!=''">
					<xsl:value-of select="//*[name()='eventi']/*[@id=$fine_id]/@fonte"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:value-of select="//*[name()='eventi']/*[@id=$inizio_id]/@fonte"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:variable name="urn">
			<xsl:value-of select="//*[name()='relazioni']/*[@id=$fonte]/@xlink:href"/>
		</xsl:variable>



						
			<xsl:choose>
				<xsl:when test="$numeronota=1">
			   		<h1>Note sulla vigenza</h1>
   				</xsl:when>
			</xsl:choose>
			<p>
			<xsl:choose>
				<xsl:when test="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$id]/../../*[name()='dsp:norma']">
					<!--	ho le informazione nei metadati	-->
					<xsl:for-each select="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$id]/../../*[name()='dsp:norma']">
						<xsl:variable name="implicita">
							<xsl:value-of select="../@implicita"/>
						</xsl:variable>	
						<xsl:variable name="urn">
							<xsl:value-of select="../*[name()='dsp:norma']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<xsl:variable name="autonota">
							<xsl:value-of select="../*[name()='dsp:norma']/*[name()='ittig:notavigenza']/@auto"/>
						</xsl:variable>	
						<xsl:variable name="novella">
							<xsl:value-of select="../*[name()='dsp:novella']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<xsl:variable name="novellando">
							<xsl:value-of select="../*[name()='dsp:novellando']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<a name="n{$id}" href="#t{$id}">[<xsl:value-of select="$numeronota"/>]</a>
						<xsl:text> - </xsl:text>
						<xsl:choose>
							<xsl:when test="$novellando">
							<xsl:choose>
								<xsl:when test="$novella">
									<!--	sostituzione	-->
									Sostituzione
		   						</xsl:when>
		   						<xsl:otherwise>
   									<!--	abrogazione		-->
									Abrogazione
								</xsl:otherwise>			
							</xsl:choose>
   						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<xsl:when test="$novella">
									<!--	integrazione	-->
									Integrazione
   								</xsl:when>
							</xsl:choose>
						</xsl:otherwise>			   				
					</xsl:choose>			
					<xsl:if test="$implicita!='no'"> 
						<xsl:text> implicita</xsl:text>
					</xsl:if>
					
					<xsl:if test="$novellando">
						<xsl:if test="$novella">
							<!--	sostituzione	-->
							<xsl:if test="$novella=$id"> (testo inserito)</xsl:if>
		   					<xsl:if test="$novellando=$id"> (testo eliminato)</xsl:if>
	   					</xsl:if>
   					</xsl:if>					
					<xsl:text> da: </xsl:text>
					<a href="./ui/urnResolver.html?urn={$urn}" title=" Dest. = ./ui/urnResolver.html?urn={$urn}"><xsl:value-of select="$autonota"/></a>
			      </xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<!--	NON ho le informazione nei metadati -->			
					<a name="n{$id}" href="#t{$id}">[<xsl:value-of select="$numeronota"/>]</a>
					<xsl:text> - Modificato da: </xsl:text>
					<a href="./ui/urnResolver.html?urn={$urn}" title=" Dest. = ./ui/urnResolver.html?urn={$urn}"> <xsl:value-of select="$urn" /> </a>
				</xsl:otherwise>			
			</xsl:choose>
			<xsl:text>. </xsl:text>
				<xsl:choose>
					<!-- ================= data_fine!='' =========-->
						<xsl:when test="$data_fine!=''">
								In vigore
						 		<xsl:choose>
									<xsl:when test="$data_inizio!=''">
										dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
									</xsl:when>
									<xsl:otherwise>
										<xsl:text>fino</xsl:text>
									</xsl:otherwise>
								</xsl:choose>	
								al <xsl:value-of select="concat(substring($data_fine,7,2),'/',substring($data_fine,5,2),'/',substring($data_fine,1,4))"/>
								
								<!--	xsl:choose>			
									<xsl:when test="$stato!=''">
										(<xsl:value-of select="$stato"/>)
									</xsl:when>
								</xsl:choose	-->		
								
						</xsl:when>
						<!-- ================= data_inizio!='' =========-->
						<xsl:when test="$data_inizio!=''">
								&#160;In vigore	dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
						</xsl:when>
					</xsl:choose>			
	      </p>
		</xsl:for-each>		      
	  </xsl:template>

 

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template TimeLine							              -->
	<!--                                                          -->
	<!-- ======================================================== -->
 
   <xsl:template name="TimeLine">
   	<xsl:variable name="currentdate">
   		<!--2006-11-10T14:54:21+01:00-->
   		<xsl:value-of
   			select="concat(substring(date:date-time(),1,4),substring(date:date-time(),6,2),substring(date:date-time(),9,2))" />
   	</xsl:variable>
   	<p style="clear:both; display:block;">Vedi documento vigente alla data:</p>
   	<ul id="choosedata">
   		<xsl:text></xsl:text>
   		<xsl:for-each select="//*[name()='eventi']/*[@data!='']">
		<xsl:variable name="pos">
			<xsl:value-of select="position()"/>
		</xsl:variable>
   			<xsl:variable name="data">
   				<xsl:value-of
   					select="concat(substring(@data,7,2),'/',substring(@data,5,2),'/',substring(@data,1,4))" />
   			</xsl:variable>
			<xsl:choose>
			<xsl:when test="$datafine=@data">
   				<li class="choosedata-active">
						<xsl:value-of select="$data" />
						<xsl:if test="$pos=1">
							<xsl:text> (Originale) </xsl:text>
						</xsl:if>
				</li>
			</xsl:when>
			<xsl:otherwise>
		 		<li class="choosedata">
					<a
						href="?datafine={@data}&amp;doc={$doc}" title="vedi documento vigente a {$data}">
						<xsl:value-of select="$data" />
						<xsl:if test="$pos=1">
							<xsl:text> (Originale) </xsl:text>
						</xsl:if>
					</a>
				</li>
			</xsl:otherwise>
			</xsl:choose>
   		</xsl:for-each>
		<!--	xsl:choose>
			<xsl:when test="$datafine=$currentdate">
   				<li class="choosedata-active">
						<xsl:value-of select="concat(substring($currentdate,7,2),'/',substring($currentdate,5,2),'/',substring($currentdate,1,4))"/> (Vigente)
				</li>
			</xsl:when>
			<xsl:otherwise>
		 		<li class="choosedata">
					<a
						href="?datafine={$currentdate}"  title="vedi documento vigente a {$currentdate}">
						<xsl:value-of select="concat(substring($currentdate,7,2),'/',substring($currentdate,5,2),'/',substring($currentdate,1,4))"/> (Vigente)
					</a>
				</li>
			</xsl:otherwise>
		</xsl:choose	-->
   	</ul>
   	<p style="clear:both; display:block;">Vedi documento multivigente:</p>
   	<ul>
		<xsl:choose>
			<xsl:when test="$datafine=''">
		 		<li class="choosedata-active">
						Multivigente
				</li>
			</xsl:when>
			<xsl:otherwise>
		 		<li class="choosedata">
					<a
						href="?doc={$doc}"  title="vedi documento multivigente">
						Multivigente
					</a>
				</li>
			</xsl:otherwise>
		</xsl:choose>
   	</ul>
   </xsl:template>
 

</xsl:stylesheet>
