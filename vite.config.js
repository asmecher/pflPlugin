import { resolve } from 'path'
import { defineConfig } from 'vite'

// https://vitejs.dev/config/
export default defineConfig({
  target: 'es2016',
  build: {
    lib: {
      // Could also be a dictionary or array of multiple entry points
      entry: resolve(__dirname, 'src/main.js'),
      name: 'pflPlugin',
      // the proper extensions will be added
      // important to generate Immediately Invoked Function Expression as output
      // this can be easily loaded via script tag 
      formats: ['iife']
    },
  }
})
