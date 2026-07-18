
document.addEventListener("DOMContentLoaded", () => {
  const tabButtons = document.querySelectorAll(".project-tab");
  const tabContents = document.querySelectorAll(".tab-content");
  const projectContent = document.getElementById("project-content");

  function switchTab(tabName) {
    tabContents.forEach((content) => {
      content.classList.toggle("active", content.id === tabName);
    });

    tabButtons.forEach((button) => {
      const isActive = button.dataset.tab === tabName;
      button.classList.toggle("active", isActive);
      button.setAttribute("aria-selected", isActive ? "true" : "false");
    });

    if (projectContent) {
      const topPosition =
        projectContent.getBoundingClientRect().top + window.scrollY;

      window.scrollTo({
        top: topPosition,
        behavior: "smooth"
      });
    }
  }

  tabButtons.forEach((button) => {
    button.setAttribute(
      "aria-selected",
      button.classList.contains("active") ? "true" : "false"
    );

    button.addEventListener("click", () => {
      const selectedTab = button.dataset.tab;

      if (selectedTab) {
        switchTab(selectedTab);
      }
    });
  });
});
