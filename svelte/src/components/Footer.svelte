<script>
    import { appState } from '../stores/appState.js';
  </script>
  
  <footer 
    class="absolute bottom-0 w-full text-center ">
    <pre>{JSON.stringify($appState.props)}</pre>
  </footer>
  
  <style>
    footer {
     }
  </style>
  