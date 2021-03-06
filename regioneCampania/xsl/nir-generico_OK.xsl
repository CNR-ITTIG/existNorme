<?xml version="1.0" encoding="UTF-8"?> 
<xsl:stylesheet version="1.0" xmlns:nir = "http://www.normeinrete.it/nir/2.2" 
										xmlns:xsl="http://www.w3.org/1999/XSL/Transform"  
										xmlns="http://www.w3.org/HTML/1998/html4" 
										xmlns:h="http://www.w3.org/HTML/1998/html4" 
										xmlns:xlink="http://www.w3.org/1999/xlink"
										xmlns:date="http://exslt.org/dates-and-times">
										
	<xsl:output method="html"  indent="yes"/>
	
	<xsl:include href="nir-xslt-utility.xsl"/>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template principale                                     -->
	<!--                                                          -->
	<!-- ======================================================== -->

	<xsl:param name="datafine"></xsl:param>
	<xsl:param name="encoding"/>
	<xsl:param name="baseurl"/>

	<xsl:template match="/">
		<html>
			<head>
				<title>
					<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='tipoDoc']"/>&#160;
					n. &#160;<xsl:value-of select="/*[name()='NIR']/*/*/*[name()='numDoc']"/>	
					&#160; del &#160; <xsl:value-of select="/*[name()='NIR']/*/*/*[name()='dataDoc']"/>
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset= {$encoding}"/>

				<link href="nir-generico-style.css" rel="stylesheet"/>
			</head>
			<body>
			<p style="font-weight:bold;">
				<xsl:text>Urn del documento: </xsl:text><xsl:call-template name="urnvigente"/>
			</p>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<p style="font-weight:bold;">
						<xsl:text>Documento vigente al </xsl:text>
						<xsl:value-of select="concat(substring($datafine,7,2),'/',substring($datafine,5,2),'/',substring($datafine,1,4))"/><xsl:text>.</xsl:text>	
					</p>
				</xsl:when>
			</xsl:choose>
			<xsl:choose>
				<!--	xsl:when test="//*[name()='evento']/@data!=''"	-->
				<xsl:when test="//*[name()='evento']/@fonte!='ro1'">
					<div id="timeline">
						<xsl:call-template name="TimeLine" />
					</div>
				</xsl:when>
			</xsl:choose>

			<xsl:apply-templates select="/*[name()='NIR']/*" />
           	<div class="allineasx">
   	        	<xsl:call-template name="notemultivigente" /> 
       	    </div>
       	    <xsl:if test="/*/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']">
				<div class="allineasx">
					<h1>Note della redazione</h1>
					<xsl:apply-templates select="/*/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']" />
				</div>	
			</xsl:if>		
			<xsl:if test="/*/*/*[name()='annessi']/*[name()='annesso']/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']">
				<div class="allineasx">
					<h1>Note in allegati</h1>
					<xsl:apply-templates select="/*/*/*[name()='annessi']/*[name()='annesso']/*/*[name()='meta']/*[name()='redazionale']/*[name()='nota']" />
				</div>	
			</xsl:if>
			</body>
		</html>
	</xsl:template>
	
	
	<xsl:template match="text()">&#160;<xsl:value-of select="."/>&#160;</xsl:template>
	

	<xsl:template match="/*[name()='NIR']/*">	
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div>
		<xsl:choose>
			<xsl:when test="$datafine!=''">		
				<xsl:variable name="fine_id">
					<xsl:value-of select="@finevigore"/>
				</xsl:variable>		
				<xsl:variable name="inizio_id">
					<xsl:value-of select="@iniziovigore"/>
				</xsl:variable>
				<xsl:variable name="data_fine">
					<!--	xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/	-->
				<xsl:value-of select="id($fine_id)/@data"/>
				</xsl:variable>
				<xsl:choose>
					<xsl:when test="$data_fine&lt;number(number($datafine)+1)">
						<!--	eccezione intera legge abrogata	-->	
						<span style="color:#f00;"> 								
							[<xsl:apply-templates select="*[name()='intestazione']"/>
							]<a href="#n{@id}" name="t{@id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
					 	</span>
					</xsl:when>
					<xsl:otherwise>
						<xsl:call-template name="vigenza"/>
					</xsl:otherwise>							
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>
	</xsl:template>		
	

	<xsl:template match="/*[name()='NIR']/*/*[name()='formulainiziale']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="formulainiziale">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
				
			</xsl:otherwise>			
		</xsl:choose>
		
		<hr/>
	</xsl:template>
	
	<xsl:template match="*[name()='tipoDoc']">
		&#160;<xsl:value-of select="."/>&#160;
	</xsl:template>
	
	<xsl:template match="*[name()='numDoc']">
		&#160;<xsl:value-of select="."/>&#160;
	</xsl:template>
	
	<xsl:template match="*[name()='dataDoc']">
		&#160;<xsl:value-of select="."/>&#160;
	</xsl:template>	
		
	<xsl:template match="/*/*/*[name()='meta']/*[name()='descrittori']/*[name()='materie']">		
		<br/>MATERIE: 
	  	<xsl:for-each select="*[name()='materia']">
			<xsl:value-of select="@valore"/><xsl:text>, </xsl:text>	
	  	</xsl:for-each>
	</xsl:template>

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template intestazione e relazione                       -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template match="/*[name()='NIR']/*/*[name()='intestazione']">
		<div class="intestazione">
			<xsl:apply-templates/>

			<div class="meta">
				<xsl:apply-templates select="/*/*/*[name()='meta']/*[name()='descrittori']/*[name()='materie']" />
			</div>	
		</div>
		<hr/>
	</xsl:template>
	
	<xsl:template match="//*[name()='emanante']">
		<div class="title">
			<xsl:apply-templates/>
		</div>
	</xsl:template>

	<xsl:template match="//*[name()='titoloDoc']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="titoloDoc">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>
		
	</xsl:template>
	
	
	<xsl:template match="//*[name()='preambolo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="preambolo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
				
			</xsl:otherwise>			
		</xsl:choose>
		
	</xsl:template>	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template articolato                                     -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template match="//*[name()='articolato'] | //*[name()='contenitore']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div width="100%">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	LIBRO		============================== -->
	<xsl:template match="//*[name()='libro']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="libro">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	PARTE		============================== -->
	<xsl:template match="//*[name()='parte']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="parte">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	TITOLO		============================== -->
	<xsl:template match="//*[name()='titolo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="titolo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	SEZIONE		============================== -->
	<xsl:template match="//*[name()='sezione']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="sezione">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>

	<!-- ========================== 	CAPO	============================== -->
	<xsl:template match="//*[name()='capo']">
		<hr />
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="capo">
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>
		
			</xsl:otherwise>			
		</xsl:choose>

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
	
	<xsl:template match="//*[name()='decorazione']">
		<p class="decorazione">
			<xsl:apply-templates/>
		</p>
	</xsl:template>
	
	<!-- =========================	ARTICOLO	=============================== -->
	
	<xsl:template match="//*[name()='articolo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

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
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<!-- =========================	COMMA e sotto comma	=============================== -->

	<xsl:template match="//*[name()='comma']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

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
		
			</xsl:otherwise>			
		</xsl:choose>

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
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

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
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<xsl:template match="//*[name()='corpo']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<!--	div class="corpo">	
		<xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>
		</div	-->			
		<xsl:apply-templates/>			
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<xsl:template match="//*[name()='alinea']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<!--	div class="alinea">
		<xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>
		</div	-->	
		<xsl:apply-templates/>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template sotto il comma                                 -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
		<xsl:template match="//*[name()='mmod']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<span class="mmod">
	        <xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
			</xsl:choose>
		</span>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template> 
	
	<xsl:template match="//*[name()='mod']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<span class="mod">
	        <xsl:choose>		
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
			</xsl:choose>
		</span>
		
			</xsl:otherwise>			
		</xsl:choose>

	</xsl:template> 
		
	<xsl:template match="//*[name()='virgolette']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<xsl:choose>
		<xsl:when test="@tipo='struttura'">
	   		<table><tr><td class="virgolette">
				<xsl:apply-templates/>
			</td></tr></table>	
		</xsl:when>
		<xsl:otherwise>
	    	<span class="virgolette">
				<xsl:apply-templates/>
			</span>	
		</xsl:otherwise>
		</xsl:choose>
		
			</xsl:otherwise>			
		</xsl:choose>

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
			<xsl:when test="contains($url,'urn:nir:')">
				<xsl:choose>
					<xsl:when test="$strina='&#59;' or $strina='&#46;' or $strina='&#58;' or $strina='&#44;'  or $strina='&#45;'">		 
						<a href="http://www.nir.it/cgi-bin/N2Ln?{@xlink:href}" title="URN = {@xlink:href}">
							<xsl:apply-templates/>
						</a>
					</xsl:when>
					<xsl:otherwise>					 
						<a href="http://www.nir.it/cgi-bin/N2Ln?{@xlink:href}" title="URN = {@xlink:href}">						
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
		<a name="{concat('ndr',@num)}" href="#{@num}" title="Destinazione: {@num}">
			<sup class="ndr">
				<xsl:attribute name="title">Nota: <xsl:value-of select="."/></xsl:attribute>
				<xsl:value-of select="."/>
			</sup>
		</a>
	</xsl:template>
	
	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  Template conclusioni e formula finale                   -->
	<!--                                                          -->
	<!-- ======================================================== -->
	<xsl:template match="//*[name()='formulafinale']">
		<a name="{@id}">&#160;</a>
		<xsl:choose>
			<xsl:when test="@status = 'omissis'">
				<div class="omissis">
					<xsl:apply-templates select="*[name()='num']"/>
					<xsl:if test="*[name()='rubrica']">
						- <xsl:apply-templates select="*[name()='rubrica']/text()"/>
					</xsl:if>
					<xsl:text> ( Omissis )</xsl:text>
				</div>
			</xsl:when>
			<xsl:otherwise>

		<div class="formulafinale">
		<hr/>
		<xsl:choose>
			<xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			</xsl:otherwise>
		</xsl:choose>				
		</div>		
		
			</xsl:otherwise>			
		</xsl:choose>

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
	
		
	
	<!--	RIMOSSI DALLA DTD 2.2
	<xsl:template match="//*[name()='sottoscrizioni']">
		<ul class="sottoscrizioni">
			<xsl:apply-templates/>
		</ul>
	</xsl:template>
	<xsl:template match="//*[name()='sottoscrivente']">
		<li class="li">
			<xsl:choose>
			  <xsl:when test="$datafine!=''">
				<xsl:call-template name="vigenza"/>
			  </xsl:when>
			  <xsl:otherwise>
				<xsl:call-template name="multivigenza"/>
			  </xsl:otherwise>
			</xsl:choose>			
		</li>
	</xsl:template	-->

	<!--	RIMOSSI DALLA DTD 2.2
	<xsl:template match="//*[name()='visto']">
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
	</xsl:template		-->

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
	<!--	xsl:template match="//*[name()='urn']">
		<tr>
			<td class="small">
				<a href="http://www.senato.it/japp/bgt/showdoc/frame.jsp?tipodoc={//nir:approvazione/@tipodoc}&amp;leg={//nir:approvazione/@leg}&amp;id={//nir:approvazione/@internal_id}">
					<xsl:value-of select="."/>
				</a>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="//*[name()='redazionale']">
		<div class="redazionale">
			<xsl:apply-templates />
		</div>
	</xsl:template	-->
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

	<xsl:template match="//*[name()='confronto']"/>
	
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
	
	<xsl:template match="@*" mode="object">
		<xsl:choose>
			<xsl:when test="name()='src'">
				<xsl:variable name="nome"><xsl:value-of select="." /></xsl:variable>
				<xsl:attribute name="src"><xsl:value-of select="concat('file://',$baseurl,$nome)"/></xsl:attribute>
			</xsl:when>
			<xsl:otherwise>
				<xsl:attribute name="{name()}"><xsl:value-of select="."/></xsl:attribute>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>	
	
	<xsl:template match="h:*">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>&#160;
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="h:img">
		<xsl:element name="{local-name()}">
			<xsl:apply-templates select="@*" mode="object"/>
			<xsl:apply-templates/>
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
		&#160;<span>
			<xsl:choose>
				<xsl:when test="$datafine!=''">
					<xsl:call-template name="vigenza"/>
				</xsl:when>
				<xsl:otherwise>
					<xsl:call-template name="multivigenza"/>
				</xsl:otherwise>
			</xsl:choose>				
		</span>&#160;
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
		<xsl:variable name="data_inizio">

			<!--	xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/	-->
			<!--	xsl:for-each select="key('dateventi',$inizio_id)">
				<xsl:value-of select="@data"/>
			</xsl:for-each	-->
			<!--	xsl:value-of select="key('dateventi',$inizio_id)" /	-->
			<xsl:value-of select="id($inizio_id)/@data"/>			
		</xsl:variable>
		<xsl:variable name="data_fine">
		
			<!--	xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/		-->
			<!--	xsl:for-each select="key('dateventi',$fine_id)">
				<xsl:value-of select="@data"/>
			</xsl:for-each	-->
			<!--	xsl:value-of select="key('dateventi',$fine_id)" /	-->
			<xsl:value-of select="id($fine_id)/@data"/>
		</xsl:variable>
		<xsl:variable name="giornoprima">		
			<xsl:call-template name="finevigenza">
				<xsl:with-param name="datafinevigenza" select="$data_fine" />
			</xsl:call-template>
		</xsl:variable>						
		<xsl:variable name="tooltip">
				<xsl:choose>
					<xsl:when test="$data_fine!=''">In vigore&#160;<xsl:choose>
										<xsl:when test="$data_inizio!=''">dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
										</xsl:when>
										<xsl:otherwise><xsl:text>fino</xsl:text>
										</xsl:otherwise>
									</xsl:choose>&#160;al <xsl:value-of select="$giornoprima"/>
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

							<xsl:variable name="id">
								<xsl:value-of select="@id" />
							</xsl:variable>
							<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
								<xsl:if test="../@id=$id">
									<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
								</xsl:if>		
							</xsl:for-each>
							
							
						</xsl:when>
						<xsl:when test="$data_inizio&gt;number(number($datafine)-1)">
							<span style="color:#060;">
							 	[<xsl:apply-templates/>]
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//*[name()!='urn']/@iniziovigore">	
									<xsl:if test="../@id=$id">
										<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
									</xsl:if>		
								</xsl:for-each>
							</span>
						</xsl:when>						
						<xsl:otherwise>
							<xsl:choose>			
								<xsl:when test="$stato!=''">
									<span style="color:#f00;">
										[<xsl:apply-templates/>]
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">							
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>
									</span>
								</xsl:when>
								<xsl:otherwise>
									<span style="color:#f00;">
										[<xsl:apply-templates/>]
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
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
							<xsl:variable name="id">
								<xsl:value-of select="@id" />
							</xsl:variable>
							<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
								<xsl:if test="../@id=$id">
									<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
								</xsl:if>		
							</xsl:for-each>							
						</xsl:when>
						<xsl:otherwise>
							<span style="color:#060;">
								<xsl:apply-templates/>
								<xsl:variable name="id">
									<xsl:value-of select="@id" />
								</xsl:variable>
								<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
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
	<!--  template gestione urnvigente                            -->
	<!--                                                          -->
	<!-- ======================================================== -->
	
	<xsl:template name="urnvigente" >
		<xsl:choose>
			<xsl:when test="/*[name()='NIR']/@tipo!='multivigente'">
				<xsl:value-of select="/*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='urn']/@valore"/>
			</xsl:when>	
			<xsl:otherwise>
				<xsl:for-each select="/*[name()='NIR']/*/*[name()='meta']/*[name()='descrittori']/*[name()='urn']">
					<xsl:choose>
						<xsl:when test="$datafine!=''">
							<xsl:variable name="inizio_id">
								<xsl:value-of select="@iniziovigore"/>
							</xsl:variable>
							<xsl:variable name="fine_id">
								<xsl:value-of select="@finevigore"/>
							</xsl:variable>
							<xsl:variable name="data_inizio">
								<!--	xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/	-->
								<xsl:value-of select="id($inizio_id)/@data"/>
							</xsl:variable>
							<xsl:variable name="data_fine">
								<!--	xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/	-->
								<xsl:value-of select="id($fine_id)/@data"/>
							</xsl:variable>
							<xsl:choose>
								<xsl:when test="$data_fine!=''">
									<xsl:if test="$data_inizio&lt;number(number($datafine)+1) and $data_fine&gt;$datafine">
										<xsl:value-of select="@valore" />
									</xsl:if>
								</xsl:when>	
								<xsl:otherwise>	
									<xsl:if test="$data_inizio&lt;number(number($datafine)+1)">
										<xsl:value-of select="@valore" />
									</xsl:if>
								</xsl:otherwise>	
							</xsl:choose>
						</xsl:when>	
						<xsl:otherwise>
				       	    <xsl:if test="@iniziovigore='t1'">
								<xsl:value-of select="@valore" />
							</xsl:if>
						</xsl:otherwise>				
					</xsl:choose>
				</xsl:for-each>
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
		
<!--		NON LO USO + PER IL TEST
		<xsl:variable name="data_entratainvigore">
			<xsl:value-of select="//*[name()='evento'][@fonte='ro1']/@data"/>
		</xsl:variable>
-->
		
		<xsl:variable name="data_inizio">
			<!--	xsl:value-of select="//*[name()='evento'][@id=$inizio_id]/@data"/	-->
			<xsl:value-of select="id($inizio_id)/@data"/>
		</xsl:variable>
		<xsl:variable name="data_fine">
			<!--	xsl:value-of select="//*[name()='evento'][@id=$fine_id]/@data"/	-->
			<xsl:value-of select="id($fine_id)/@data"/>
		</xsl:variable>
		<xsl:variable name="giornoprima">		
			<xsl:call-template name="finevigenza">
				<xsl:with-param name="datafinevigenza" select="$data_fine" />
			</xsl:call-template>
		</xsl:variable>		
		<xsl:variable name="tooltip">
				<xsl:choose>
					<xsl:when test="$data_fine!=''">In vigore&#160;<xsl:choose>
										<xsl:when test="$data_inizio!=''">dal <xsl:value-of select="concat(substring($data_inizio,7,2),'/',substring($data_inizio,5,2),'/',substring($data_inizio,1,4))"/>
										</xsl:when>
										<xsl:otherwise><xsl:text>fino</xsl:text>
										</xsl:otherwise>
									</xsl:choose>&#160;al <xsl:value-of select="$giornoprima"/>
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
						<xsl:value-of select="/*[name()='NIR']/*/*[name()='meta']/*[name()='disposizioni']/*[name()='modifichepassive']/*/*/*[name()='dsp:pos'][@xlink:href=$idnota]/../../*[name()='dsp:norma']/*[name()='dsp:subarg']/*[name()='ittig:notavigenza']/@id"/>
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
								<span style="color:#f00;"> 								
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
								<xsl:for-each select="//*[name()!='urn']/@iniziovigore">	
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
								<xsl:when test="$data_inizio and $inizio_id!='t1'">
									<span style="color:#060;">
										<xsl:apply-templates />															
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
											<xsl:if test="../@id=$id">
												<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
											</xsl:if>		
										</xsl:for-each>											
									</span>									
								</xsl:when>
						 		<xsl:otherwise>
									<xsl:apply-templates />		
									<xsl:variable name="id">
										<xsl:value-of select="@id" />
									</xsl:variable>
									<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
										<xsl:if test="../@id=$id">
											<a href="#n{$id}" name="t{$id}"><sup>[<xsl:value-of select="position()" />]</sup></a>
										</xsl:if>		
									</xsl:for-each>	
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
									<span style="color:#060;">
										<xsl:apply-templates />					
										
										
										<xsl:variable name="id">
											<xsl:value-of select="@id" />
										</xsl:variable>
										<xsl:for-each select="//*[name()!='urn']/@iniziovigore">
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
	<!--  template note testo MultiVigente (fondo pagina)         -->
	<!--                                                          -->
	<!-- ======================================================== -->

   <xsl:template name="notemultivigente">
	  <xsl:for-each select="//*[name()!='urn']/@iniziovigore">
    	<xsl:variable name="saltare">
			<xsl:value-of select="../@valore" />
		</xsl:variable>
		<xsl:choose>
		<xsl:when test="$saltare">
		</xsl:when>
		<xsl:otherwise>		
			<xsl:variable name="idNoPound">
				<xsl:value-of select="../@id" />
			</xsl:variable>
			<xsl:variable name="id">
				<xsl:value-of select="concat('#',$idNoPound)"/>
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
					<xsl:variable name="data_inizio">
						<xsl:value-of select="id($inizio_id)/@data"/>
					</xsl:variable>
					<xsl:variable name="data_fine">
						<xsl:value-of select="id($fine_id)/@data"/>
					</xsl:variable>
					<xsl:variable name="giornoprima">		
						<xsl:call-template name="finevigenza">
							<xsl:with-param name="datafinevigenza" select="$data_fine" />
						</xsl:call-template>
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
						<xsl:variable name="urn_meta">
							<xsl:value-of select="../*[name()='dsp:norma']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<xsl:variable name="autonota">
							<xsl:value-of select="../*[name()='dsp:norma']/*[name()='dsp:subarg']/*[name()='ittig:notavigenza']/@auto"/>
						</xsl:variable>	
						<xsl:variable name="novella">
							<xsl:value-of select="../*[name()='dsp:novella']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	
						<xsl:variable name="novellando">
							<xsl:value-of select="../*[name()='dsp:novellando']/*[name()='dsp:pos']/@xlink:href"/>
						</xsl:variable>	

						<xsl:if test="position()=1">
							<a name="n{$idNoPound}" href="#t{$idNoPound}">[<xsl:value-of select="$numeronota"/>]</a>
		   				</xsl:if>

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
					<a href="http://www.nir.it/cgi-bin/N2Ln?{$urn_meta}" title="URN = {$urn_meta}"><xsl:value-of select="$autonota"/></a>
					<xsl:text>. </xsl:text>
			      </xsl:for-each>
				</xsl:when>
				<xsl:otherwise>
					<!--	NON ho le informazione nei metadati -->			
					<a name="n{$idNoPound}" href="#t{$idNoPound}">[<xsl:value-of select="$numeronota"/>]</a>
					<xsl:text> - Modificato da: </xsl:text>
					<a href="http://www.nir.it/cgi-bin/N2Ln?{$urn}" title="URN = {$urn}"> <xsl:value-of select="$urn" /> </a>
					<xsl:text>. </xsl:text>
				</xsl:otherwise>			
			</xsl:choose>
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
								al <xsl:value-of select="$giornoprima"/>
								
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
		</xsl:otherwise>
		</xsl:choose>		
	  </xsl:for-each>		      
   </xsl:template>
 

	<!-- ======================================================== -->
	<!--                                                          -->
	<!--  template TimeLine							              -->
	<!--                                                          -->
	<!-- ======================================================== -->
 
	<xsl:template name="TimeLine">
	 <xsl:variable name="currentdate">
		<xsl:value-of select="concat(substring(date:date-time(),1,4),substring(date:date-time(),6,2),substring(date:date-time(),9,2))"/>
	 </xsl:variable>
	 <p>
		- Date di vigenza che interessano il documento:
		<xsl:text> </xsl:text> 
		<xsl:for-each select="//*[name()='eventi']/*[@data!='']">
			<xsl:variable name="fonte">
				<xsl:value-of select="substring(@fonte,1,2)"/>
			</xsl:variable>
			<xsl:if test="$fonte!='ra'">
				<xsl:variable name="data">
					<xsl:value-of select="concat(substring(@data,7,2),'/',substring(@data,5,2),'/',substring(@data,1,4))"/>
				</xsl:variable>
				<xsl:value-of select="$data"/>
				<xsl:text> - </xsl:text> 
			</xsl:if>
		</xsl:for-each>
	 </p>		
	</xsl:template>
	
</xsl:stylesheet>
