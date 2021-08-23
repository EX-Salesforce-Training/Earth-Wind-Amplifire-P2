({
    handleUploadFinished: function (component, event, helper) {
		const [file] = event.target.files;
        const reader = new FileReader();
        function saveImage() {
            const recordId = component.get('v.recordId');
            const uploadAction = component.get('c.uploadImage');
            uploadAction.setParams({
                recordId: recordId,
                imgSrc: reader.result
            });
            uploadAction.setCallback(this, function(response) {
                if(response.getState() === 'SUCCESS') {
                    helper.nextStage(component, event);
                }
            })
            $A.enqueueAction(uploadAction);
            component.set('v.imgSrc', reader.result);
        }
        function logError(error) {
            console.log(error)
        }
        reader.onload = saveImage;
        reader.onerror = logError;
        reader.readAsDataURL(file);
    },
    handleCreateSuccess: function(component, event, helper) {
        const recordId = event.getParam("id");
        component.set('v.recordId', recordId);
        helper.nextStage(component, event);
    }
})