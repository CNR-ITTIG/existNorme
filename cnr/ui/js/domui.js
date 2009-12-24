//
// This work is licensed under the Creative Commons Attribution 2.5 License. To 
// view a copy of this license, visit
// http://creativecommons.org/licenses/by/2.5/
// or send a letter to Creative Commons, 543 Howard Street, 5th Floor, San
// Francisco, California, 94105, USA.
//
// All copies and derivatives of this source must contain the license statement 
// above and the following attribution:
//
// Author: Kyle Scholz      http://kylescholz.com/
// Copyright: 2006
//

NODE_RADIUS=14;





//var jg = new jsGraphics("edgeCanvas");

// GraphUI:
var GraphUI = function(){};
GraphUI.prototype = {

  initialize: function( frame, origin, displayOriginEdges, displayEdges ) {
    
	this['frame']=frame;    // frame dom object
    this['origin']=origin;  // origin dom object

    this['frame_width']=parseInt(frame.style.width);
    this['frame_height']=parseInt(frame.style.height);
    this['frame_top']=parseInt(frame.style.top);
    this['frame_left']=parseInt(frame.style.left);

    // switch for displaying origin edges
    this['displayOriginEdges'] = true;
    if ( displayOriginEdges != null ) {
      this['displayOriginEdges'] = displayOriginEdges;
    }

    // switch for displaying non-origin edges
    this['displayEdges'] = true;
    if ( displayEdges != null ) {
      this['displayEdges'] = displayEdges;
    }

  },

  // draw all nodes
  drawNodes: function() {
    for( var i=0; i<graph['nodes'].length; i++ ) {
      this.drawNode( graph.nodes[i] );
    }
  },

  // draw all edges
  drawEdges: function() {
  	if (jg) {
  		jg.clear();
  	}
    for( var i=0; i<graph.nodes.length; i++ ) {
      if ( this['displayOriginEdges'] ) {
        if ( graph.originEdges[i] ) {
          nodeI = graph.getNode(i);
          nodeJ = graph.origin;
          var distance = new Distance();
          distance.calculate( nodeI.position, nodeJ.position );
          this.drawEdge( nodeI, nodeJ, distance );
        }
      }
      
      if ( this['displayEdges'] ) {
        for( var j=0; j<graph.nodes.length; j++ ) {
          if ( graph.edges[i] && graph.edges[i][j] ) {
            nodeI = graph.getNode(i);
            nodeJ = graph.getNode(j);
            var distance = new Distance();
            distance.calculate( nodeI.position, nodeJ.position );
            this.drawEdge( nodeI, nodeJ, distance );
          }
        }
      }
    }
    if (jg)
	    jg.paint();

  },

  //
  setOrigintext: function( text ) {
    this['origin'].innerHTML=text;
  },

  nodeRadius: function( node ) {
//    return( NODE_RADIUS );
    return( node.mass*4 );
  },

  // draw the node at it's current position
  drawNode: function( node ) {
    try {
      this.getNode(node.id).style.left = (this['frame_left'] + node['position']['x']);
      this.getNode(node.id).style.top = (this['frame_top'] + node['position']['y']);
    } catch( e ) {
    }
  },

  // draw the frame
  drawFrame: function( frame_width, frame_height ) {
    this['frame_width']=frame_width;
    this['frame_height']=frame_height;
    this.frame.style.width=frame_width;
    this.frame.style.height=frame_height;
  },

  // draw the origin
  drawOrigin: function( node ) {
    this.origin.style.left = (this['frame_left'] + node['position']['x']);
    this.origin.style.top = (this['frame_top'] + node['position']['y']);
  },

  // add an edge to the display
  addEdge: function( nodeI, nodeJ ) {
    var edge = document.createElement("div");
    edge.id = 'edge'+nodeI.id+':'+nodeJ.id;
    document.body.appendChild(edge);
  },
	
  // add a node to the display

  // Modificata per visualizzare le norme, gestendo il centra grafo e l'apri norma
  addNode: function( node, type, date, number, urn, queryType ) {
    var domNode;

	urn =  urn.replace(/%20/, " ");


	if ( type && date && number && urn && queryType) {

	  domNode = textNodeTmpl.cloneNode(true);
	 for (var i=0; i<urnList.length; i++ ){
		
		  var centerGraph = "&nbsp;&nbsp;&nbsp;";
		
		 if(urn.match(urnList[i]) || (urn==urnList[i])){
	
			 centerGraph = "<img src='./img/centro.gif' alt='Centra questo Atto' onclick='sendFirstQuery(\""+queryType+"\",\""+urn+"\");' class='pointer'/>";
			  break;
		 } 

	  } 

	  var openNorma ="<img src='./img/freccia.gif' alt='Visualizza questo Atto' onclick='location.href=\"./urnResolver.html?urn="+urn+"\";' class='pointer'/>";
	  domNode.innerHTML = "<table width='100%'><tr><td colspan='3' class='nodo'>"+type+"</td></tr><tr><td>"+centerGraph+"</td><td class='nodo'>" + date +"</td><td>"+openNorma+"</td></tr><tr><td colspan='3' class='nodo'>"+number+"</td></tr></table>";
	} else {
      var radius = this.nodeRadius(node);
	  domNode = nodeTmpl.cloneNode(true);
      domNode.style.MozBorderRadius = (radius * 4);
      domNode.style.width = (radius*2) + "px";
      domNode.style.height = (radius*2) + "px";
	}
    domNode.id='node'+node.id;
    document.body.appendChild(domNode);
    
    domNode.style.left = parseInt(node['position']['x']);
    domNode.style.top = parseInt(node['position']['y']);

    return domNode;
  },

  // return the UI representation of the graph node
  getNode: function( nodeId ) {
    if ( nodeId == 'origin' ) {
      return document.getElementById( 'origin' );
    }
    return document.getElementById( 'node' + nodeId );
  },
 removeNode: function( nodeId ) {
	
    try
 {		 node = document.getElementById('node' + nodeId);
			 node.parentNode.removeChild(node);
 }
 catch ( e ) {
      alert( "Error Removing Nodes: " + e );
    }
  
  },

  drawEdge: function ( nodeI, nodeJ, distance ) {
    var centeri = new Object();
    centeri['x'] = this['frame_left'] + nodeI['position']['x'] + this.nodeRadius( nodeI )+40;
    centeri['y'] = this['frame_top'] + nodeI['position']['y'] + this.nodeRadius( nodeI )+27;

    var centerj = new Object();
    centerj['x'] = this['frame_left'] + nodeJ['position']['x'] + this.nodeRadius( nodeJ )+40;
    centerj['y'] = this['frame_top'] + nodeJ['position']['y'] + this.nodeRadius( nodeJ )+27;
	if (jg) {
	jg.setColor("#000000");
	//jg.drawLine(0,0,100,100);
	jg.drawLine(centeri.x, centeri.y, centerj.x, centerj.y);
	}
  },

  // render an edge
  drawEdgeOld: function ( nodeI, nodeJ, distance ) {

    // edges should appear between center of nodes
    var centeri = new Object();
    centeri['x'] = this['frame_left'] + nodeI['position']['x'] + this.nodeRadius( nodeI );
    centeri['y'] = this['frame_top'] + nodeI['position']['y'] + this.nodeRadius( nodeI );

    var centerj = new Object();
    centerj['x'] = this['frame_left'] + nodeJ['position']['x'] + this.nodeRadius( nodeJ );
    centerj['y'] = this['frame_top'] + nodeJ['position']['y'] + this.nodeRadius( nodeJ );

    // get a distance vector between nodes
    var distance = new Distance();
    distance.calculate( centeri, centerj );

    // draw line
    // k+factor at end determines dot frequency
    var l = 8;
    for ( var k=0; k<l; k++ ) {
      var p = (distance['d'] / l) * k;
      var pix;

      try {
        // dom updates are expensive ... recycle where we can
        if ( !document.getElementById('edge' + nodeI.id + ':' + nodeJ.id + ':' + k) ) {
          pix = pixTmpl.cloneNode(true);
          pix.id = 'edge' + nodeI.id + ':' + nodeJ.id + ':' + k;
          document.getElementById('edge' + nodeI.id + ':' + nodeJ.id).appendChild(pix);
        } else {
          pix = document.getElementById('edge' + nodeI.id + ':' + nodeJ.id + ':' + k);
        }
        pix.style.left=centeri['x'] +(-1)*p*(distance['dx']/distance['d']);
        pix.style.top=centeri['y'] +(-1)*p*(distance['dy']/distance['d']);
      } catch ( e ) {

      }

    }
  }
}
    
// text Node Template
var textNodeTmpl = document.createElement('div');
textNodeTmpl.setAttribute("name","graphCanvas");
textNodeTmpl.style.height = "54px";
textNodeTmpl.style.width = "80px";
textNodeTmpl.style.position = 'absolute';
textNodeTmpl.style.zIndex = 3;


// Synset Node Template
var color = new Object();
color['adjective']="http://youarehere.kylescholz.com/cgi-bin/pinpoint.pl?title=&r=" +
  (NODE_RADIUS*2) + "&pt=8&b=656565&c=99ee55";
color['adverb']="http://youarehere.kylescholz.com/cgi-bin/pinpoint.pl?title=&r=" +
  (NODE_RADIUS*2) + "&pt=8&b=656565&c=eeee66";
color['verb']="http://youarehere.kylescholz.com/cgi-bin/pinpoint.pl?title=&r=" +
  (NODE_RADIUS*2) + "&pt=8&b=656565&c=ee9944";
color['noun']="http://youarehere.kylescholz.com/cgi-bin/pinpoint.pl?title=&r=" +
  (NODE_RADIUS*2) + "&pt=8&b=656565&c=6688ee";

var nodeTmpl = document.createElement('div');
nodeTmpl.style.position = 'absolute';
nodeTmpl.style.zIndex = 2;
nodeTmpl.style.width = (NODE_RADIUS*2) + "px";
nodeTmpl.style.height = (NODE_RADIUS*2) + "px";
nodeTmpl.innerHTML="<img height=1 width=1/>";

// Edge Point Template
var pixTmpl = document.createElement( 'div' );
pixTmpl.style.width = 2;
pixTmpl.style.height = 2;
pixTmpl.style.backgroundColor = '#888888';
pixTmpl.style.position = 'absolute';
pixTmpl.innerHTML="<img height=1 width=1/>";

