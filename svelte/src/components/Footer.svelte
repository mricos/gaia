<script>
    import { appState } from '../stores/appState.js';
  </script>
  
  <footer >
    <pre>{$appState.props.commitHash}</pre>
  </footer>
  
  <style>
    footer {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      padding: 1rem;
      opacity: 0.5;
      font-size: 0.75rem;
      text-align: center;
      z-index: 100;
    }
  </style>
  