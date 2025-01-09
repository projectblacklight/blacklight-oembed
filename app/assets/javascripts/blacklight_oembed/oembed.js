(function (global, factory) {
  typeof exports === 'object' && typeof module !== 'undefined' ? module.exports = factory() :
  typeof define === 'function' && define.amd ? define(factory) :
  (global = typeof globalThis !== 'undefined' ? globalThis : global || self, global.BlacklightOembed = factory());
})(this, (function () { 'use strict';

  function oEmbed(elements) {
    if (!elements) return;

    // Ensure elements is an array-like collection
    elements = elements instanceof NodeList ? Array.from(elements) : [elements];

    elements.forEach(function(embedViewer) {
      const embedURL = embedViewer.dataset.embedUrl; // Get the embed URL from the data attribute

      if (!embedURL) return;

      // Fetch JSON data from the embed URL
      fetch(embedURL)
        .then(response => {
          if (!response.ok) {
            throw new Error('Network response was not ok');
          }
          return response.json();
        })
        .then(data => {
          if (data === null) {
            return;
          }
          // Set the inner HTML of the element
          embedViewer.innerHTML = data.html;
        })
        .catch(error => {
          console.error('Error fetching embed data:', error);
        });
    });
  }

  return oEmbed;

}));
//# sourceMappingURL=oembed.js.map
