import "bootstrap";

// Get container width for progress bar
const toggleFixed = () => {
  var parentwidth = $(".question-container").width();
  $(".progress").width(parentwidth).css("position", "fixed").css("bottom", "16px");
}

// Expand answer card
const expandCard = () => {
  document.querySelectorAll(".expand-card").forEach((expand) => {
    expand.addEventListener("click", (event) => {
      event.currentTarget.parentElement.style.display = 'none';
      event.currentTarget.parentElement.parentElement.querySelector(".long-answer").style.display = 'block';
    });
  });
}

// Collapse answer card
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

// Left Navbar Selection
const toggleSelectedMenuItem = () => {
  const menuLinks = document.querySelectorAll(".menu-item");
  const sections = document.querySelectorAll(".sections");
  const curriculums = document.querySelectorAll(".curriculums");
  menuLinks.forEach ((link) => {
    link.addEventListener("click", (event) => {
      const selected = document.querySelector(".selected");
      selected.classList.toggle("selected");
      event.currentTarget.classList.toggle("selected");
      if (event.currentTarget.innerText === "My Sections") {
        curriculums.forEach ((curriculum) => {
          curriculum.setAttribute("hidden", "")
        });
        sections.forEach ((section) => {
          section.removeAttribute("hidden", "")
        });
      };
      if (event.currentTarget.innerText === "My Curriculums") {
        curriculums.forEach ((curriculum) => {
          curriculum.removeAttribute("hidden", "")
        });
        sections.forEach ((section) => {
          section.setAttribute("hidden", "")
        });
      };
    });
  });
}

toggleSelectedMenuItem()

if (window.location.pathname.includes('/decksummary')) {
  expandCard();
  collapseCard();
}

// Show add new resource form if selected whan making new card
const showResourceForm = () => {
  const addResourceLink = document.querySelector(".add-resource");
  addResourceLink.addEventListener("click", (event) => {
    console.log("HI!!");
    event.currentTarget.insertAdjacentHTML("afterend", `<form class="simple_form new_resource" id="new_resource" novalidate="novalidate" action="/curriculums/11/decks/50/resources" accept-charset="UTF-8" method="post"><input name="utf8" type="hidden" value="✓"><input type="hidden" name="authenticity_token" value="ycN+nxcMXq48btNmqtSCgvBIk7x3WbfB134PyAx2jQChalDQIhoUENsspwbNfjxm/vSDZivFiS/N86cKWTobdQ==">
      <div class="col-12 col-md-6">
        <div class="form-group string required resource_name"><label class="form-control-label string required" for="resource_name">Name <abbr title="required">*</abbr></label><input class="form-control string required" type="text" name="resource[name]" id="resource_name" data-keeper-lock-id="k-z12i1zx0zbf"><keeper-lock id="k-z12i1zx0zbf" class="" style="top: 43px; left: 512px; z-index: 1; filter: grayscale(100%); height: 16px !important;"></keeper-lock></div>
      </div>
      <div class="col-12 col-md-6">
        <div class="form-group text optional resource_text"><label class="form-control-label text optional" for="resource_text">Text</label><textarea class="form-control text optional" name="resource[text]" id="resource_text"></textarea></div>
      </div>
      <div class="col-12 col-md-6">
        <div class="form-group url optional resource_url"><label class="form-control-label url optional" for="resource_url">Url</label><input class="form-control string url optional" type="url" name="resource[url]" id="resource_url"></div>
      </div>
      <div class="col-12 col-md-6">
        <div class="form-group select optional resource_card"><label class="form-control-label select optional" for="resource_card">Card</label><select class="form-control select optional" name="resource[card]" id="resource_card"><option value=""></option>
<option value="371">how about now?</option>
<option value="370">This is a test card! Does it work?</option>
<option value="369">In 1705, Russian Emperor Peter the Great placed a tax on beards, hoping to force men to adopt the clean-shaven look that was common in Western Europe.</option>
<option value="368">In 1712, England imposed a tax on printed wallpaper. Builders avoided the tax by hanging plain wallpaper and then painting patterns on the walls."</option>
<option value="367">During the Middle Ages, European governments placed a tax on soap. France didn\'t repeal its soap tax until 1835</option></select></div>
      </div>
      <div class="col-md-12">
        <input type="submit" name="commit" value="Create Resource" data-disable-with="Create Resource">
      </div>
</form>`);
  });
}

if (window.location.pathname.includes('/cards')) {
  showResourceForm()
}














