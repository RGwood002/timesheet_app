// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function(){
    console.log("Dom loaded")
    const clockInButton = document.getElementById("clock-in-button");
    const clockInForm = document.getElementById("clock-in-form");
    
    const clockOutButton = document.getElementById("clock-out-button");
    const clockOutForm = document.getElementById("clock-out-form");

    if (clockInButton && clockInForm){
        clockInButton.addEventListener("click", function(){
        clockInForm.submit();
        })
    }

    if (clockOutButton && clockOutForm){
        clockInButton.addEventListener("click", function(){
        clockOutForm.submit();
        })
    }
})
