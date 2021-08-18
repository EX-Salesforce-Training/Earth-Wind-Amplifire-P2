({
	  toggleTooltip : function(cmp, id) {
        let tooltip = cmp.find(id);
		$A.util.toggleClass(tooltip, "ishidden");
	}
})