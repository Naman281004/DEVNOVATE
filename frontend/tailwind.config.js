/** @type {import('tailwindcss').Config} */
export default {
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
  ],
  theme: {
    extend: {
      backgroundImage: {
        'gradient-radial': 'radial-gradient(var(--tw-gradient-stops))',
        'gradient-conic': 'conic-gradient(from 180deg at 50% 50%, var(--tw-gradient-stops))',
      },
      animation: {
        'aurora': 'aurora 15s ease infinite',
      },
      keyframes: {
        aurora: {
          '0%, 100%': { transform: 'scale(1.0) rotate(0deg)' },
          '50%': { transform: 'scale(1.2) rotate(10deg)' },
        },
      },
    },
  },
  plugins: [],
} 