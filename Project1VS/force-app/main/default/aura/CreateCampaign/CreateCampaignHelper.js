({
    nextStage: function(component, event) {
        const stage = component.get('v.stage');
        const stages = component.get('v.stages');
        const index = stages.findIndex(possibleStage => possibleStage === stage);
        component.set('v.stage', stages[index + 1]);
    }
})