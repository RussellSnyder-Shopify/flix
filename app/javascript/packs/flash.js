const flashMessage = document.getElementById("flash-message");
const closeButton = document.getElementById("close-flash-message");

const fadeInAnimation = function () {
    flashMessage.classList.remove('h-0')
    flashMessage.classList.remove('opacity-0')
}

setTimeout(fadeInAnimation, 200)

closeButton.onclick = () => {
    flashMessage.classList.add('h-0')
    flashMessage.classList.add('opacity-0')

    setTimeout(function() {
        flashMessage.remove()
    }, 1000)

}