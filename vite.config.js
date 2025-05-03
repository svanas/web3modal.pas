import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    rollupOptions: {
      input: 'src/web3modal.js',
      output: {
        entryFileNames: 'web3modal.js',
        format: 'esm',
        inlineDynamicImports: true,
      },
    },
  },
});