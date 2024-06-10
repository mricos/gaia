// src/routes/+page.server.js
export async function load({ fetch }) {

  const apiKey = process.env.API_KEY || 'default_api';
  const commitHash = __COMMIT_HASH__;
  console.log("In load");
  // Pass the cached data to the client through props
  return {
    props: {
        apiKey,
        commitHash,
    }
  };
}