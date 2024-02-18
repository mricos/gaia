<script>
    import { appState } from '../stores/appState.js';
  </script>
  
  <footer 
    class="absolute bottom-0 p-4 w-full text-center ">
    <pre>{$appState.props.commitHash}</pre>
  </footer>
  
  <style>
    footer {
    
     }
  </style>
  