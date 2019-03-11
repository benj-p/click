// Show add new resource form if selected whan making new card
const checkbox = document.querySelector("#new_resource");
const fakeButton = document.querySelector("#fake-button");

if (checkbox.checked === true) {
      console.log("second hi!!");
      fakeButton.click();
    }

if (window.location.pathname.includes('/cards')) {
  showResourceForm()
}
