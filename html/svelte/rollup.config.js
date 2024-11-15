import svelte from 'rollup-plugin-svelte';
import css from 'rollup-plugin-css-only';
import livereload from 'rollup-plugin-livereload';
import { terser } from 'rollup-plugin-terser';
import resolve from '@rollup/plugin-node-resolve';

const production = !process.env.ROLLUP_WATCH;

function serve() {
  let started = false;

  return {
    writeBundle() {
      if (!started) {
        started = true;

        require('child_process').spawn('npm', ['run', 'start', '--', '--dev'], {
          stdio: ['ignore', 'inherit', 'inherit'],
          shell: true
        });
      }
    }
  };
}

console.log("Rollup production", production);

export default {
  input: 'src/main.js',
  output: {
    sourcemap: true,
    format: 'iife',
    name: 'app',
    file: 'public/build/bundle.js'
  },
  plugins: [
    resolve({
      browser: true,  // Ensures module resolution suitable for browser
      dedupe: ['svelte']  // Avoids duplicate inclusion of Svelte
    }),
    svelte({
      compilerOptions: {
        dev: !production,  // Enables run-time checks when not in production
      },
      emitCss: true  // Extracts CSS into a separate file
    }),
    css({ output: 'bundle.css' }),  // Outputs the CSS to bundle.css
    !production && serve(),
    !production && livereload('public'),
    production && terser()  // Minifies the bundle for production
  ],
  watch: {
    clearScreen: false
  }
};
