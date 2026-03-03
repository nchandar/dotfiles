(function () {
  function wireHeaderTitleToHome() {
    var logo = document.querySelector('.md-header__button.md-logo[href]');
    var title = document.querySelector('.md-header__title');
    if (!logo || !title) return;

    var homeHref = logo.getAttribute('href') || '.';
    title.style.cursor = 'pointer';
    title.setAttribute('role', 'link');
    title.setAttribute('aria-label', 'Go to homepage');

    title.addEventListener('click', function () {
      window.location.href = homeHref;
    });
  }

  document.addEventListener('DOMContentLoaded', wireHeaderTitleToHome);
  if (window.document$ && typeof window.document$.subscribe === 'function') {
    window.document$.subscribe(wireHeaderTitleToHome);
  }
})();
