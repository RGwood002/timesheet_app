// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function(){
    console.log("Dom loaded")
    const clockInButton = document.getElementById("clock-in-button");
    const clockInForm = document.getElementById("clock-in-form");
    
    const clockOutButton = document.getElementById("clock-out-button");
    const clockOutForm = document.getElementById("clock-out-form");

    const lunchInButton = document.getElementById("lunch-in-button");
    const lunchInForm = document.getElementById("lunch-in-form");

    const lunchOutButton = document.getElementById("lunch-out-button");
    const lunchOutForm = document.getElementById("lunch-out-form");


    if (clockInButton && clockInForm){
        clockInButton.addEventListener("click", function(){
        clockInForm.submit();
        })
    }

    if (clockOutButton && clockOutForm){
        clockOutButton.addEventListener("click", function(){
        clockOutForm.submit();
        })
    }

    if (lunchInButton && lunchInForm){
        lunchInButton.addEventListener("click", function(){
            lunchInForm.submit();
        })
    }

    if (lunchOutButton && lunchOutForm){
        lunchOutButton.addEventListener("click", function(){
            lunchOutForm.submit();
        })
    }
})
