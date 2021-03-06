'use strict';

angular.module("ShadowWolf")
.service('Models',function(Person,Project){
  function getModel(modelName) {
    if (modelName == "person") return Person;
    if (modelName == "project") return Project;
    
    return {};
  }

  this.update = function(objectName) {
    var updateMethod = getModel(objectName)._get().update;
    return function(id, postData, success, error) {
      var idObject = {};
      idObject[objectName + 'IdOr' + (objectName == 'person' ? 'Login' : 'ProjectNumber') ] = id;
      return updateMethod(idObject, postData, success, error);
    };
  };

  this.set = function(objectName) {
    return getModel(objectName).set;
  };
});
