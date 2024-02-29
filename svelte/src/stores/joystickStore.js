import { writable, derived } from 'svelte/store';

export let N=16;

// Function to quantize a value to the nearest multiple of N
function quantizeValue(value, N) {
  return Math.floor(value / N) * N;
}

// Function to quantize a value from 0 to 1 to a value from 0 to N-1
function quantizeNormalizedValue(value, N) {
  return Math.floor(value * N);
}

// Function to map a value from 0 to N-1 to a value from 0 to 1
function mapQuantizedValue(value, N) {
  return value / (N - 1);
}


export let xAxisMax = 1;
export let xAxisMin = -1;
export let yAxisMax = 1;
export let yAxisMin = -1;

export const xaxis = writable(0);
export const yaxis = writable(0);
export const quantizedXaxis = derived(xaxis, ($xaxis, set) => {
  set(quantizeValue($xaxis, N));
});
export const quantizedYaxis = derived(yaxis, ($yaxis, set) => {
  set(quantizeValue($yaxis, N));
});
export const normalizedXaxis = derived(xaxis, ($xaxis, set) => {
  set(mapQuantizedValue(quantizeValue($xaxis, N), N));
});
export const normalizedYaxis = derived(yaxis, ($yaxis, set) => {
  set(mapQuantizedValue(quantizeValue($yaxis, N), N));
});