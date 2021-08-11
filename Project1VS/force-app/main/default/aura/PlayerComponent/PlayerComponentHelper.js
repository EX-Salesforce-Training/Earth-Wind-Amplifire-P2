({
	  toggleTooltip : function(cmp, id) {
        let tooltip = cmp.find(id);
        console.log(id);
        //console.log(tooltip);
		$A.util.toggleClass(tooltip, "ishidden");
	}
})