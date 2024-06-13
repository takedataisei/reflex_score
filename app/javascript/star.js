function star(){
  const stars = document.querySelectorAll('.star')
  const scoreInput = document.getElementById('score-input')

  stars.forEach(function(star) {
    star.addEventListener('mouseover', function(){
      resetStars();
      this.classList.add('hover');
      let previousSibling = this.previousElementSibling;
      while(previousSibling){
        previousSibling.classList.add('hover')
        previousSibling = previousSibling.previousElementSibling
      }
    })

    star.addEventListener('mouseout', resetStars)

    star.addEventListener('click', function () {
      stars.forEach(s => s.classList.remove('selected'));
      this.classList.add('selected');
      scoreInput.value = this.getAttribute('data-value');
      let previousSibling = this.previousElementSibling;
      while (previousSibling) {
        previousSibling.classList.add('selected');
        previousSibling = previousSibling.previousElementSibling;
      }
    });
  });

  function resetStars() {
    stars.forEach(star => star.classList.remove('hover'));
  }
  }

  window.addEventListener("turbo:load", star)
  window.addEventListener("turbo:render", star)
