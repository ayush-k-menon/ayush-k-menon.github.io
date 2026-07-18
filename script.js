document.addEventListener("DOMContentLoaded", () => {
    const tabButtons = document.querySelectorAll(".project-tab");
    const tabContents = document.querySelectorAll(".tab-content");
    const projectContent = document.getElementById("project-content");

    function switchTab(tabName) {
        // Show the selected tab content
        tabContents.forEach((content) => {
            if (content.id === tabName) {
                content.classList.add("active");
            } else {
                content.classList.remove("active");
            }
        });

        // Update all tab buttons, including top and bottom tabs
        tabButtons.forEach((button) => {
            const isActive = button.dataset.tab === tabName;

            if (isActive) {
                button.classList.add("active");
            } else {
                button.classList.remove("active");
            }

            button.setAttribute(
                "aria-selected",
                isActive ? "true" : "false"
            );
        });

        // Scroll back to the top of the project content
        if (projectContent) {
            const topPosition =
                projectContent.getBoundingClientRect().top +
                window.scrollY;

            window.scrollTo({
                top: topPosition,
                behavior: "smooth"
            });
        }
    }

    // Add click functionality to each tab
    tabButtons.forEach((button) => {
        button.setAttribute(
            "aria-selected",
            button.classList.contains("active")
                ? "true"
                : "false"
        );

        button.addEventListener("click", () => {
            const selectedTab = button.dataset.tab;

            if (selectedTab) {
                switchTab(selectedTab);
            }
        });
    });
});
