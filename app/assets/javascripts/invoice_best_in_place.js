jQuery(document).ready(function() {

  jQuery(".best_in_place").bind("ajax:success", function () {
  	jQuery(this).closest('tr').effect('highlight');
  });

  jQuery(".best_in_place").best_in_place();

});