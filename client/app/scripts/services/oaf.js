'use strict';
angular.module('ShadowWolf')
.service('Oaf', function(Config, $http) {
  var projects = {};
  var buffer = []; // list of project numbers
  var bufferTimer; // time until buffer will be used
  var config = {};

  /**
   * Will return a timer that when it completes in 100ms will send all buffered
   * projectNumbers off to Oaf to retrieve their project images. At the end of
   * the 100ms it will reset buffer and bufferTime and when the results come
   * back from Oaf it will merge them with the existing projectImages then
   * trigger a $digest cycle.
   */
  function resetBufferTimer(newConfig) {
    config = newConfig;
    return setTimeout(function() {
      console.log('Querying Oaf at ' + Config.getOaf() + ' with ' + buffer.length + ' project numbers.'  );
      $http.put(Config.getOaf() + '/projects', buffer, {
        params: { update_cache: config.updateCache }
      }).then(function(result) {
        var projectImagesMap = result.data;
        for (var projectNumber in projectImagesMap) {
          projects[projectNumber] = projectImagesMap[projectNumber];
        }
      });
      buffer = [];
      bufferTimer = undefined;
    }, 100);
  }

  var imagesByTags = {};
  this.getImagesByTags = function(project_number, tags) {
    if (imagesByTags[project_number]) return imagesByTags[project_number];

    $http.put(Config.getOaf() + '/project_by_tags/' + project_number, tags)
      .then(function(result) {
        imagesByTags[project_number] = result.data;
        debugger;
      }.bind(this));
    imagesByTags[project_number] = {};
    return imagesByTags[project_number];
  };

  /**
   * Will return the project image if it exists. If it does not exist it will
   * return null and buffer requests for images for 100ms then send them off to
   * Oaf. When they come back the digest cycle will be run.
   */
  this.getProjectImage = function(projectNumber, newConfig) {
    newConfig = newConfig || {};
    if ( projects[projectNumber] !== undefined && newConfig.updateCache !== true) {
      return projects[projectNumber];
    }

    if (!bufferTimer) bufferTimer = resetBufferTimer(config);
    if (buffer.indexOf(projectNumber) == -1) buffer.push(projectNumber);
    if (newConfig.updateCache) config.updateCache = true;
    projects[projectNumber] = '';
    return projects[projectNumber];
  };
});
