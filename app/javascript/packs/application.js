import "bootstrap";

const toggleFixed = () => {
  var parentwidth = $(".question-container").width();
  $(".progress").width(parentwidth).css("position", "fixed").css("bottom", "16px");
}

const expandCard = () => {
  document.querySelectorAll(".expand-card").forEach((expand) => {
    expand.addEventListener("click", (event) => {
      event.currentTarget.parentElement.style.display = 'none';
      event.currentTarget.parentElement.parentElement.querySelector(".long-answer").style.display = 'block';
    });
  });
}

const collapseCard = () => {
  document.querySelectorAll(".collapse-card").forEach((collapse) => {
    collapse.addEventListener("click", (event) => {
      event.currentTarget.parentElement.style.display = 'none';
      event.currentTarget.parentElement.parentElement.querySelector(".short-answer").style.display = 'block';
    });
  });
}

if (window.location.pathname.includes('/takedeck')) {
  toggleFixed();
}

if (window.location.pathname.includes('/decksummary')) {
  expandCard();
  collapseCard();
}
