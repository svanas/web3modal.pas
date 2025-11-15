import { defineConfig } from 'vite';

export default defineConfig({
  build: {
    outDir: 'dist',
    emptyOutDir: true,
    rollupOptions: {
      input: 'src/WalletConnect.js',
      output: {
        entryFileNames: 'WalletConnect.js',
        format: 'esm',
        inlineDynamicImports: true,
      },
    },
  },
});