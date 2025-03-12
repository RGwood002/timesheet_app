// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

document.addEventListener("DOMContentLoaded", function(){
    console.log("Dom loaded")
    const clockInButton = document.getElementById("clock-in-button");
    const clockInForm = document.getElementById("clock-in-form");
    if(clockInForm){
        console.log("Its found")
    } else{
        console.log("its not found")
    }

    if(clockInButton){
        console.log("Its found")
    } else{
        console.log("its not found")
    }
    clockInButton.addEventListener("click", function(){
        clockInForm.submit();
    })
})
