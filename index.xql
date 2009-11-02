xquery version "1.0" encoding "iso-8859-15";

(: $Id: admin.xql 6739 2007-10-19 14:24:20Z deliriumsky $ :)
(:
    Main module of the database administration interface.
:)

declare namespace admin = "http://xmlgroup.iit.cnr.it/nir";

declare namespace request = "http://exist-db.org/xquery/request";
declare namespace session = "http://exist-db.org/xquery/session";
declare namespace util = "http://exist-db.org/xquery/util";
declare namespace xdb = "http://exist-db.org/xquery/xmldb";

declare option exist:serialize "method=xhtml media-type=text/html omit-xml-declaration=no indent=yes 
        doctype-public=-//W3C//DTD&#160;XHTML&#160;1.0&#160;Strict//EN
        doctype-system=http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd";
		
import module namespace search = "http://xmlgroup.iit.cnr.it/nir/search" at "search.xqm";
import module namespace browse = "http://xmlgroup.iit.cnr.it/nir/browse" at "browse.xqm";
import module namespace clustering = "http://xmlgroup.iit.cnr.it/nir/clustering" at "clustering.xqm";

(:
    Select the page to show. Every page is defined in its own module 
:)
declare function admin:panel() as element()
{
    let $panel := request:get-parameter("panel", "search") return
         if($panel eq "search") then
        (
            search:main()
        )
		else  if($panel eq "browse") then
		(
            browse:main()
		)
		else  
        (
            clustering:main()
        ) 
};

(:~  
    Display the login form.
:)
declare function admin:display-login-form() as element()
{
   <DIV id="contenuto">
      <DIV class="spazioPiccolo">.</DIV>
      <H3>Norme In Rete</H3><IMG class="pallainterna" height="50" alt="" src="./img/palla_elearning.gif" width="45"/> 
      
      <TABLE cellSpacing="0" cellPadding="0" border="0">
        <TBODY>
        <TR>
          <TD>
	  <div class="panel">
        <div class="panel-head">Login</div>
        <p>Questa è una risorsa protetta. Solo gli utenti registrati possono accedervi. 
		Per ogni problema contattare l'<a href="mailto:maurizio.tesconi@iit.cnr.it">amministratore</a> del sito.
        </p>

        <form action="{session:encode-url(request:get-uri())}" method="post">
            <table class="login" cellpadding="5">
                <tr>
                    <th colspan="2" align="left">Login</th>
                </tr>
                <tr>
                    <td align="left">Username:</td>
                    <td><input name="user" type="text" size="20"/></td>
                </tr>
                <tr>
                    <td align="left">Password:</td>
                    <td><input name="pass" type="password" size="20"/></td>
                </tr>
                <tr>
                    <td colspan="2" align="left"><input type="submit"/></td>
                </tr>
            </table>
        </form>
    </div>
     </TD></TR></TBODY></TABLE></DIV>
};
(:
let $tmp := session:set-current-user("admin", "")
:)
(: main entry point :)
(: let $isLoggedIn :=  true()  :)
let $isLoggedIn :=  
	if(xdb:get-current-user() eq "guest")then
    (
        (: is this a login attempt? :)
        if(request:get-parameter("user", ()) and not(empty(request:get-parameter("pass", ()))))then
        (
            if(request:get-parameter("user", ()) eq "guest")then
            (
                (: prevent the guest user from accessing the admin webapp :)
                false()
            )
            else
            (
                (: try and log the user in :)
                xdb:login("/db", request:get-parameter("user", ()), request:get-parameter("pass", ()))
            )
        )
        else
        (
            (: prevent the guest user from accessing the admin webapp :)
            false()
        )
    )
    else
    (
        (: if we are already logged in, are we logging out - i.e. set permissions back to guest :)
        if(request:get-parameter("logout",()))then
        (
        	let $null := xdb:login("/db", "guest", "guest") return
        	    false()
        )
        else
        (
             (: we are already logged in and we are not the guest user :)
            true()
        )
    )
   
return

    <html>
        <head>
            <title>Regione Campania - Raccolta normativa</title>
           	 <link type="text/css" href="css/cmsNIR.css" rel="stylesheet"/>
           	 <link type="text/css" href="css/tables.css" rel="stylesheet"/>
			<script src="js/jquery-1.2.3.js" type="text/javascript" ><!-- jquery library --></script>
			<script src="js/main.js" type="text/javascript"><!-- main code --></script>

			<script type="text/javascript" language="JavaScript"><!--
			function ReverseContentDisplay(d) {
					if(d.length < 1) { return; }
					if(document.getElementById(d).style.display == "none") { document.getElementById(d).style.display = "block"; }
					else { document.getElementById(d).style.display = "none"; }
			}
			//--></script>
			
        </head>
        <body>

	<!--servono per la fare la finestra modale -->
   		<div id="background">.</div>
		<div id="modalContainer">.</div>

	<!--inizio head -->

<!--inizio loghi -->
<div id="Contieneheader">
	<div id="header">
		<div class="nobannerimm">
			<div  id="bannerimm1"><img  src="img/banner.jpg" alt="Regione Campania" id="bannerimm2" /></div>
			<div  id="bannerimm3"  class="fwd001bannerimm3" title="Regione Campania" ></div>
		</div>
	</div>
</div>
<!--fine loghi -->
 
<!--inizio path -->
<HR/>
  
<!--inizio menu Horizzontale alto -->
<a name="menu_utility"></a>
<div id="menuHor">
	<ul>    
	         
	         <!-- modifica michele li><a href="index.xql?panel=clustering&amp;tipo=annoDoc">Suddividi per anno</a></li-->
		 <li><a href="index.xql?panel=clustering&amp;tipo=annoDoc&amp;valore={max(collection(/db/nir/RegioneCampania)//annoDoc/@valore[1])}">Suddividi per anno</a></li>
		 <li><a href="index.xql?panel=search">Cerca Legge</a></li>
		 <li><a href="index.xql?panel=browse">CMS</a></li>
		 {
		 if (xdb:get-current-user() eq "guest") then
						<li><a href="index.xql?logout=true">Login</a></li>
						else 
						(
						<li><a href="index.xql?logout=true">LogOut</a></li>,
						<li>Benvenuto {xdb:get-current-user()}</li>
						)
		 }
	</ul>
</div>
<!--fine menu Horizzontale alto -->

<!--fine head -->  
	   
<!--inizio corpo centrale -->
<DIV id="corpo">
	      <DIV id="contieneLinkinterniDx">
				 {
		            if($isLoggedIn)then
		                    (
		                        admin:panel()
		                    )
		                    else
		                    (
		                        admin:display-login-form()
		                    )
		          }           
			<HR/>
		</DIV>
</DIV>

<!--inizio footer-->
<DIV class="hrpiepagina">Copyright
- <A href="">IIT - ITTIG - CNIPA</A></DIV>
<DIV class="spazioPiccolo">.</DIV>
<!--fine footer-->
        </body>
    </html>
