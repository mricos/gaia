import { sveltekit } from '@sveltejs/kit/vite';
import { exec } from 'child_process';
import { promisify } from 'util';
import { defineConfig, loadEnv } from 'vite';

// Get current commit from git
const pexec = promisify(exec);

// A study in promises
//let [commitHash] = await Promise.allSettled([pexec('git rev-parse HEAD')]);
//let commitHash = (await pexec('git rev-parse HEAD')).stdout.trim();
let { stdout } = await pexec('git rev-parse HEAD');

export default defineConfig({
	plugins: [sveltekit()],
	define: {
		__COMMIT_HASH__: JSON.stringify(stdout.substring(0,6)),
		__APP_VERSION__: JSON.stringify('003m3') || 'default_version',
		__API_KEY__: JSON.stringify('api_key_vite_define') || 'default_version',
	},
	test: {
		include: ['src/**/*.{test,spec}.{js,ts}']
	}
});
