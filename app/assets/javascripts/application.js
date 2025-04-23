//= require rails-ujs
//= require activestorage
//= require bootstrap
//= require_tree .
document.addEventListener("DOMContentLoaded", function() {
    const flash = document.getElementById("flash-message");
    if (flash && flash.innerText.trim() !== "") {
      flash.style.display = "block";
      flash.style.opacity = 0;
      let opacity = 0;
  
      const fadeIn = setInterval(() => {
        if (opacity >= 1) clearInterval(fadeIn);
        flash.style.opacity = opacity;
        opacity += 0.1;
      }, 50);
  
      // Hide after 3 seconds
      setTimeout(() => {
        const fadeOut = setInterval(() => {
          if (opacity <= 0) {
            clearInterval(fadeOut);
            flash.style.display = "none";
          }
          flash.style.opacity = opacity;
          opacity -= 0.1;
        }, 50);
      }, 3000);
    }
  });
  