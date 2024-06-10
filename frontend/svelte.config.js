import adapter from '@sveltejs/adapter-auto'; // Or any other adapter you're using
import preprocess from 'svelte-preprocess';
import path from 'path';


const config = {
  kit: {
    adapter: adapter(),
    // Other kit options...
  },
  preprocess: preprocess(),
  vite: { // Note: `vite` is at the top level, not inside `kit`
    server:{
      host: '0.0.0.0'
    },
    resolve: {
      alias: {
        $stores: path.resolve('./src/stores'),
        $components: path.resolve('./src/components'),
        
        // Other aliases...
      },
    },
    // Other Vite-specific configurations...
  },
};

export default config;
