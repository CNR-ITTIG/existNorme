/*	
	NETMEANS.NET JS ARRAY PAGINATION 
	ver. 0.1
	developed by netmeans.net
	use fairplay
*/

/*
	myElements: Array da paginare
*/

function jsPagination(myElements,itemsPerPage){
	var me 	= this;
	this.page = 1;
	
	if (itemsPerPage > 0){
		this.itemsPerPage = itemsPerPage;	
	}else{
		this.itemsPerPage = 10;
	}
	this.elements = myElements;
	this.pages = Math.ceil(this.elements.length/this.itemsPerPage);
	
	this.getPage = function(pageNum){
		if (pageNum > me.pages){
			pageNum = me.pages;	
		}
		if (pageNum < 1){
			pageNum = 1;	
		}
		pageStart = (pageNum-1)*me.itemsPerPage;
		pageEnd = pageStart+me.itemsPerPage-1;
		if(pageEnd>=me.elements.length){
			pageEnd=me.elements.length-1;
		}
		returnArray = new Array();
		for (ii=pageStart;ii<=pageEnd;ii++){
			returnArray.push(me.elements[ii]);	
		}
		me.page = pageNum;
		return returnArray;
	}
	
	this.getPageNum = function(){
		return me.page;
	}
	
	this.getTotalPages = function(){
		return me.pages;	
	}
	
	this.getElements = function(){
		return me.elements;	
	}
}