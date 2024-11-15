/*

import Header from './components/Header.svelte';
import Content from './components/Content.svelte';
import Footer from './components/Footer.svelte';
const app = new Header({
    target: document.body,
});

const content = new Content({
    target: document.body,
});

const footer = new Footer({
    target: document.body
});
export {Header, Content, Footer};

*/

import App from './App.svelte';

const app = new App({
    target: document.body,
});

export default app;
