import "bootstrap";

const toggleFixed = () => {
    var parentwidth = $(".question-container").width();
    $(".progress").width(parentwidth).css("position", "fixed").css("bottom", "16px");;
}

if (window.location.pathname.includes('/takedeck')) {
  toggleFixed();
}
