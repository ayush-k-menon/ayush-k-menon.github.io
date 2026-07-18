
document.addEventListener("DOMContentLoaded", () => {

    /* ===========================================
       PROJECT TAB NAVIGATION
    =========================================== */

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

            button.setAttribute(
                "aria-selected",
                isActive ? "true" : "false"
            );
        });

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


    /* ===========================================
       DASHBOARD FULLSCREEN IMAGE VIEWER
    =========================================== */

    const dashboardImages =
        document.querySelectorAll(".fullscreen-trigger");

    const lightbox =
        document.getElementById("image-lightbox");

    const lightboxImage =
        document.getElementById("lightbox-image");

    const closeButton =
        document.getElementById("lightbox-close");


    function openLightbox(image) {

        if (!lightbox || !lightboxImage) {
            return;
        }

        lightboxImage.src = image.src;
        lightboxImage.alt = image.alt;

        lightbox.classList.add("active");

        lightbox.setAttribute(
            "aria-hidden",
            "false"
        );

        document.body.classList.add(
            "lightbox-open"
        );

        if (closeButton) {
            closeButton.focus();
        }
    }


    function closeLightbox() {

        if (!lightbox || !lightboxImage) {
            return;
        }

        lightbox.classList.remove("active");

        lightbox.setAttribute(
            "aria-hidden",
            "true"
        );

        document.body.classList.remove(
            "lightbox-open"
        );

        lightboxImage.src = "";
        lightboxImage.alt = "";
    }


    /* Open dashboard in fullscreen */

    dashboardImages.forEach((image) => {

        image.addEventListener("click", () => {
            openLightbox(image);
        });


        /* Keyboard accessibility */

        image.addEventListener(
            "keydown",
            (event) => {

                if (
                    event.key === "Enter" ||
                    event.key === " "
                ) {
                    event.preventDefault();

                    openLightbox(image);
                }
            }
        );
    });


    /* Close using Back button */

    if (closeButton) {

        closeButton.addEventListener(
            "click",
            closeLightbox
        );
    }


    /* Close by clicking outside image */

    if (lightbox) {

        lightbox.addEventListener(
            "click",
            (event) => {

                if (event.target === lightbox) {
                    closeLightbox();
                }
            }
        );
    }


    /* Close using Escape key */

    document.addEventListener(
        "keydown",
        (event) => {

            if (
                event.key === "Escape" &&
                lightbox &&
                lightbox.classList.contains("active")
            ) {
                closeLightbox();
            }
        }
    );

});
