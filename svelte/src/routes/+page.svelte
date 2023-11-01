<script>
    import '../styles/slider.css';
    import '../global.css';
    
    let sliderValue = 8;
    $: titleColor = `var(--brown-${sliderValue})`;
</script>

<style>
    h1 {
        color: var(--brown-8); /* This will be overridden by the style applied in the script */
        text-align: center;
        position: absolute;
        top: 5%;
        width: 100%;
    }

    .text-content {
        text-align: center;
        margin-top: 20px;
        color: var(--brown-4);
        position: absolute;
        top: 15%;
        width: 100%;
    }

    .text-content a {
        color: var(--brown-3);
        text-decoration: underline;
        transition: color 0.3s;
    }

    .text-content a:hover {
        color: var(--brown-2);
    }

    .slider {
        position: absolute;
        top: 60%;
        width: 80%; /* Adjust width to your preference */
        left: 10%; /* Center the slider */
    }
</style>

<h1 style="color: {titleColor};">Gaia NLP</h1>

<p class="text-content">
    See
    <a href="https://nodeholder.notion.site/SvelteKit-Development-log-e5af6bedf1de46af846195e7c555cfaf?pvs=4">
        Gaia NLP Development log
    </a>
</p>

<input type="range" min="1" max="16" step="1" bind:value={sliderValue} class="slider" />
