$(function() {
  $(".vote").on("click", ".upvote, .downvote", function() {
      var post_id = $(this).parent().data("id"),
          is_upvote = $(this).hasClass("upvote");

      // console.log('vote for post ' + post_id);
      // console.log('is an upvote: ' + is_upvote);

      $.ajax({
        url: "/post/vote",
        method: "POST",
        data: { 
            post_id: post_id, 
            upvote: is_upvote,
            authenticity_token: $('meta[name="csrf-token"]').attr('content')
        },
        success: function(response) {
            console.log("Vote successful!", response);
        },
      });
  });
});