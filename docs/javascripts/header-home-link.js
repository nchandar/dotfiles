(function () {
  var LABELS = {
    "keyboard-shortcuts": "Keyboard Shortcuts",
    "keybindings": "Keybindings",
    "setup": "Setup",
    "bootstrap": "Bootstrap",
    "symlinks": "Symlinks",
    "tools": "Tools",
    "nvim": "Neovim",
    "nushell": "Nushell",
    "ghostty": "Ghostty",
    "starship": "Starship",
    "aerospace": "AeroSpace",
    "hammerspoon": "Hammerspoon",
    "tmux": "tmux",
    "troubleshooting": "Troubleshooting",
    "index": "Home"
  };

  function prettify(segment) {
    var decoded = decodeURIComponent(segment || "").toLowerCase();
    if (LABELS[decoded]) return LABELS[decoded];
    return decoded
      .replace(/[-_]+/g, " ")
      .replace(/\b\w/g, function (ch) { return ch.toUpperCase(); });
  }

  function normalizePath(path) {
    if (!path) return "/";
    return path.endsWith("/") ? path : path + "/";
  }

  function isHomePath(currentPath, rootPath) {
    var current = currentPath.replace(/index\.html$/, "");
    return normalizePath(current) === normalizePath(rootPath);
  }

  function wireHeaderTitleToHome(homeHref) {
    var title = document.querySelector(".md-header__title");
    if (!title) return;
    title.style.cursor = "pointer";
    title.setAttribute("role", "link");
    title.setAttribute("aria-label", "Go to homepage");
    title.onclick = function () { window.location.href = homeHref; };
  }

  function insertHeaderButtons(homeUrl) {
    var inner = document.querySelector(".md-header__inner");
    if (!inner) return;
    var title = inner.querySelector(".md-header__title");
    if (!title) return;

    var existing = inner.querySelector(".custom-header-actions");
    if (existing) existing.remove();

    var wrapper = document.createElement("div");
    wrapper.className = "custom-header-actions";
    var isHome = isHomePath(window.location.pathname, normalizePath(homeUrl.pathname));

    var backBtn = document.createElement("button");
    backBtn.className = "custom-header-btn";
    backBtn.type = "button";
    backBtn.textContent = "← Back";
    backBtn.setAttribute("aria-label", "Go back");
    backBtn.onclick = function () {
      if (window.history.length > 1) {
        window.history.back();
      } else {
        window.location.href = homeUrl.href;
      }
    };

    var homeLink = document.createElement("a");
    homeLink.className = "custom-header-btn";
    homeLink.href = homeUrl.href;
    homeLink.textContent = "⌂ Home";
    homeLink.setAttribute("aria-label", "Go to homepage");

    if (!isHome) wrapper.appendChild(backBtn);
    wrapper.appendChild(homeLink);
    inner.insertBefore(wrapper, title);
  }

  function insertBreadcrumbs(homeUrl, rootPath) {
    var container = document.querySelector(".md-content__inner");
    if (!container) return;

    var existing = container.querySelector(".custom-breadcrumbs");
    if (existing) existing.remove();

    var currentPath = window.location.pathname;
    if (isHomePath(currentPath, rootPath)) return;

    var relative = currentPath;
    if (relative.startsWith(rootPath)) {
      relative = relative.slice(rootPath.length);
    } else {
      relative = relative.replace(/^\/+/, "");
    }

    relative = relative.replace(/index\.html$/, "").replace(/\/$/, "");
    if (!relative) return;

    var segments = relative.split("/").filter(Boolean);
    if (!segments.length) return;

    var nav = document.createElement("nav");
    nav.className = "custom-breadcrumbs";
    nav.setAttribute("aria-label", "Breadcrumb");

    var list = document.createElement("ol");

    var homeLi = document.createElement("li");
    var homeA = document.createElement("a");
    homeA.href = homeUrl.href;
    homeA.textContent = "Home";
    homeLi.appendChild(homeA);
    list.appendChild(homeLi);

    var acc = "";
    var h1 = document.querySelector("article h1");

    for (var i = 0; i < segments.length; i++) {
      var seg = segments[i];
      acc += seg + "/";
      var li = document.createElement("li");
      var isLast = i === segments.length - 1;
      var label = isLast && h1 ? h1.textContent.trim() : prettify(seg);

      if (isLast) {
        var span = document.createElement("span");
        span.textContent = label;
        li.appendChild(span);
      } else {
        var a = document.createElement("a");
        a.href = new URL(acc, homeUrl).href;
        a.textContent = label;
        li.appendChild(a);
      }

      list.appendChild(li);
    }

    nav.appendChild(list);
    container.prepend(nav);
  }

  function enhanceNavigationUi() {
    var logo = document.querySelector(".md-header__button.md-logo[href]");
    if (!logo) return;

    var homeUrl = new URL(logo.getAttribute("href") || ".", window.location.href);
    var rootPath = normalizePath(homeUrl.pathname);

    wireHeaderTitleToHome(homeUrl.href);
    insertHeaderButtons(homeUrl);
    insertBreadcrumbs(homeUrl, rootPath);
  }

  document.addEventListener("DOMContentLoaded", enhanceNavigationUi);
  if (window.document$ && typeof window.document$.subscribe === "function") {
    window.document$.subscribe(enhanceNavigationUi);
  }
})();
