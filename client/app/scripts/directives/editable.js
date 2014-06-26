"use strict";

angular.module("ShadowWolf")
.directive("editable", function(Lens, Session, Models, Flash) {
  var editDisabled = false;
  return {
    restrict: "E",
    replace: false,
    transclude: true,
    templateUrl: 'scripts/directives/editable.html',
    scope: true,
    link: function (scope, element, attrs) { 
      if (attrs['editDisabled']) editDisabled = true;
      scope.property = attrs.property;
      scope.label = attrs.label;
      scope.type = attrs.type || 'text';
      scope.rootElement = element[0];
      if (attrs.extra) {
        scope.typeahead = attrs.extra;
      }
    },
    controller: function($scope) {
      $scope.editable = {};
      $scope.editorEnabled= false;

      $scope.get = Lens.get;
      $scope.set = Lens.set;

      // Get the name for the label and input tag
      $scope.getName = function() {
        // TODO properly get the name
        return '';
        var name = $scope.objectName;
        var props = $scope.lens.split('.');
        for (var prop in props) {
          name += "[" + props[prop] + "]";
        }
        return name;
      };

      $scope.enableEditor = function() {
        // only works for editables on person page
        if (editDisabled || Session.getPersonId() != $scope.object.id['$oid']) {
          var name;
          try { name = $scope.object.name.preferred_first }
          catch (e) { name = 'this page\'s user'; }
          Flash.add({
            template: '<p>You need to be logged in as ' + name + ' to change fields.</p>'
          }, 5000);
          return;
        }
        $scope.editorEnabled = true;
        $scope.editable.value = $scope.subobject[$scope.property];
        var input = $scope.rootElement.getElementsByTagName('input');
        if (input.length == 0) {
          input = $scope.rootElement.getElementsByTagName('textarea');
        }
        input = input[0];
        setTimeout(function(){
          input.focus();
        }, 0);
      };

      $scope.disableEditor = function() {
        $scope.editorEnabled = false;
      };

      /**
       * Saves the edited value in the rails database. If the subobject and sublens
       * variables exist then it will send all of the sibling values back to the
       * server, otherwise it just sends back the single field.
       */
      $scope.save = function() {

        // Set the value locally
        var object = $scope.subobject ? $scope.subobject : $scope.target();
        object[$scope.property] = $scope.editable.value;

        // Wrap it for transport
        var diffObject = { id: object.id['$oid'] };
        diffObject[$scope.property] = object[$scope.property];
        var updateObject;
        updateObject = {}; 
        updateObject[$scope.objectName] = Lens.wrapObject( 
            $scope.lens,
            diffObject
        );

        // Set it back on the server
        var flash = {
          template: '<p>Updating {{flash.label()}}...</p>',
          label: function() { return $scope.label; }
        };
        var handle = Flash.add(flash);
        Models.update($scope.objectName)( $scope.object.id['$oid'],
          updateObject,
          function() {
            flash.template = '<p>Updated {{flash.label()}}.</p>';
            flash.css = 'flash-success';
            handle.timeout(5000);
            Models.set($scope.objectName)($scope.object);
          }, function() {
            flash.template = '<p>Update unsuccessful for {{flash.label()}}. You may wish to check your submission.</p>';
            flash.css = 'flash-failure';
            handle.timeout(5000);
            $scope.enableEditor();
          }
        );
        $scope.disableEditor();
      };
      $scope.cancel = function() {
        $scope.disableEditor();
      };
    }
  };
});
