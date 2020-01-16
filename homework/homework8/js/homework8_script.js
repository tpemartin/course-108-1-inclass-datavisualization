window.onload = function() {
  var bar=document.getElementById('barChart').contentDocument
  var tBar=bar.getElementById('toysBar')
  var mBar=bar.getElementById('movieBar')
  var xBar=bar.getElementById('XmasBar')

  var fbT=document.getElementById('fbToys')
  var fbM=document.getElementById('fbMovie')
  var fbX=document.getElementById('fbXmas')
  var webT=document.getElementById('webToys')
  var webM=document.getElementById('webMovie')
  var webX=document.getElementById('webXmas')
  var pstT=document.getElementById('posterToys')
  var pstM=document.getElementById('posterMovie')
  var pstX=document.getElementById('posterXmas')


  function showT(){
      fbT.setAttribute("style", "display: block"); 
      webT.setAttribute("style", "display: block"); 
      pstT.setAttribute("style", "display: block"); 
      fbM.setAttribute("style", "display: none"); 
      webM.setAttribute("style", "display: none"); 
      pstM.setAttribute("style", "display: none"); 
      fbX.setAttribute("style", "display: none"); 
      webX.setAttribute("style", "display: none"); 
      pstX.setAttribute("style", "display: none")
  }

  function showM(){
      fbT.setAttribute("style", "display: none"); 
      webT.setAttribute("style", "display: none"); 
      pstT.setAttribute("style", "display: none"); 
      fbM.setAttribute("style", "display: block"); 
      webM.setAttribute("style", "display: block"); 
      pstM.setAttribute("style", "display: block"); 
      fbX.setAttribute("style", "display: none"); 
      webX.setAttribute("style", "display: none"); 
      pstX.setAttribute("style", "display: none")
  }

  function showX(){
      fbT.setAttribute("style", "display: none"); 
      webT.setAttribute("style", "display: none"); 
      pstT.setAttribute("style", "display: none"); 
      fbM.setAttribute("style", "display: none"); 
      webM.setAttribute("style", "display: none"); 
      pstM.setAttribute("style", "display: none"); 
      fbX.setAttribute("style", "display: block"); 
      webX.setAttribute("style", "display: block"); 
      pstX.setAttribute("style", "display: block")
  }


  tBar.addEventListener("click", showT)
  mBar.addEventListener("click", showM)
  xBar.addEventListener("click", showX)
}


