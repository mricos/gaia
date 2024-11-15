<script>
  import { xaxis, yaxis} from '../stores/joystickStore.js';
  import { quantizedXaxis, quantizedYaxis } from '../stores/joystickStore.js';
  import { normalizedXaxis, normalizedYaxis } from '../stores/joystickStore.js';

  $: x = xaxis;
  $: y = yaxis;
  $: xn = normalizedXaxis;
  $: yn = normalizedYaxis;
  $: xq = quantizedXaxis;
  $: yq = quantizedYaxis;
</script>

<footer>
  <pre>{JSON.stringify({ x: $x, y: $y })}</pre>
  <p>Normalized Axis Values: {$xn.toFixed(2)},{$yn.toFixed(2)} </p>
  <p>Quantized X Axis Values: {$xq},{$yq}</p>
  

</footer>
  
  <style>
    footer {
      position: absolute;
      bottom: 0;
      left: 0;
      right: 0;
      padding: 1rem;
      opacity: 0.5;
      font-size: 0.6rem;
      text-align: center;
      z-index: 100;
    }
  </style>
  