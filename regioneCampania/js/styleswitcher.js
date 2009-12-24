var min=0.44;
var max=1.76;
function increaseFontSize() {
   var body = document.getElementsByTagName('body');
   for(i=0;i<body.length;i++) {
      if(body[i].style.fontSize) {
         var s = parseFloat(body[i].style.fontSize.replace("em",""));
      } else {
         var s = 0.88;
      }
      if(s!=max) {
         s += 0.05;
      }
      body[i].style.fontSize = s+"em"
   }
}
function defaultFontSize() {
   var body = document.getElementsByTagName('body');
   for(i=0;i<body.length;i++) {
      
      body[i].style.fontSize = "0.88em"
   }
}
function decreaseFontSize() {
   var body = document.getElementsByTagName('body');
   for(i=0;i<body.length;i++) {
      if(body[i].style.fontSize) {
         var s = parseFloat(body[i].style.fontSize.replace("em",""));
      } else {
         var s = 0.88;
      }
      if(s!=min) {
         s -= 0.05;
      }
      body[i].style.fontSize = s+"em"
   }   
}
function staticContainer() {
   var pippo = document.getElementById('contenitore');
  
     pippo.style.width="780px";
   }
function fluidContainer() {
   var pippo = document.getElementById('contenitore');
  
     pippo.style.width="95%";
   }

