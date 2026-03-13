(function () {
  var SITE_TITLE = "Niranjan's Dotfiles";
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
    "oh-my-posh": "Oh My Posh",
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

  function currentPageLabel(rootPath) {
    var h1 = document.querySelector("article h1");
    if (h1 && h1.textContent.trim()) return h1.textContent.trim();

    var path = window.location.pathname;
    var relative = path.startsWith(rootPath) ? path.slice(rootPath.length) : path.replace(/^\/+/, "");
    relative = relative.replace(/index\.html$/, "").replace(/\/$/, "");
    var parts = relative.split("/").filter(Boolean);
    return parts.length ? prettify(parts[parts.length - 1]) : "Home";
  }

  function renderHeaderTitle(homeUrl, rootPath) {
    var title = document.querySelector(".md-header__title");
    if (!title) return;

    var isHome = isHomePath(window.location.pathname, rootPath);
    var currentLabel = currentPageLabel(rootPath);

    title.innerHTML = "";

    var wrap = document.createElement("span");
    wrap.className = "custom-title-wrap";

    var homeLink = document.createElement("a");
    homeLink.className = "custom-site-title";
    homeLink.href = homeUrl.href;
    homeLink.textContent = SITE_TITLE;
    homeLink.setAttribute("aria-label", "Go to homepage");

    wrap.appendChild(homeLink);

    if (!isHome && currentLabel !== "Home") {
      var sep = document.createElement("span");
      sep.className = "custom-title-sep";
      sep.textContent = " / ";

      var page = document.createElement("span");
      page.className = "custom-current-page";
      page.textContent = currentLabel;

      wrap.appendChild(sep);
      wrap.appendChild(page);
    }

    title.appendChild(wrap);
    title.style.cursor = "pointer";
    title.onclick = function (event) {
      if (event.target && event.target.tagName && event.target.tagName.toLowerCase() === "a") return;
      window.location.href = homeUrl.href;
    };
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
    var isHome = isHomePath(window.location.pathname, rootPath);

    document.body.classList.toggle("home-page", isHome);

    renderHeaderTitle(homeUrl, rootPath);
    insertBreadcrumbs(homeUrl, rootPath);
  }

  document.addEventListener("DOMContentLoaded", enhanceNavigationUi);
  if (window.document$ && typeof window.document$.subscribe === "function") {
    window.document$.subscribe(enhanceNavigationUi);
  }
})();
