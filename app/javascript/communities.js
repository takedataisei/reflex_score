document.addEventListener('turbo:load', function(){
  const toggle = document.getElementById('community-list-toggle')
  const communityList = document.getElementById('community-list')

  toggle.addEventListener('mouseover', function(){
    this.setAttribute('style', 'background-color: #0056b3;')
  })

  toggle.addEventListener('mouseout', function(){
    this.removeAttribute('style', 'background-color: #0056b3;')
  })

  toggle.addEventListener('click', function(){
    if (communityList.getAttribute('style') == 'display:block;'){
      communityList.removeAttribute('style')
    } else {
      communityList.setAttribute('style', 'display:block;')
    }
  })
})