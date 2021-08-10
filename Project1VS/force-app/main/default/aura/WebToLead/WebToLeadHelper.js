({
    // @desc : given a form DOM node, extract it's input values and return an object with them in it
    // @formElement: <DOM Node>
	extractFormData : function(formElement) {
		const data = {};
        new FormData(formElement).forEach( (value, key) => data[key] = value);
        return data;
	}
})