# Animated Background Component - Usage Guide

## Overview
The AnimatedBackground component provides an elegant, performant animated background with multiple visual layers that don't distract from the main content.

## Features Implemented

### 1. **Floating Particles with Connecting Lines**
- 80 particles that drift smoothly across the screen
- Dynamic connecting lines appear between nearby particles
- Configurable opacity and motion speed

### 2. **Gradient Wave Layers**
- 3 separate wave layers moving at different speeds
- Smooth, GPU-accelerated animations
- Radial gradient effects with soft blending

### 3. **Geometric Shapes**
- 12 floating shapes (circles, triangles, squares, hexagons)
- Low opacity to avoid distraction
- Gentle rotation and drift

### 4. **Parallax Star Field**
- 200 stars across 3 parallax layers
- Twinkling effect for realism
- Responds to page scrolling

## Color Customization

All colors can be customized using CSS variables in `src/index.css`:

```css
:root {
  /* Background gradients */
  --bg-gradient-start: #0f172a;
  --bg-gradient-middle: #1e293b;
  --bg-gradient-end: #0f172a;
  
  /* Wave colors */
  --wave-color-1: rgba(99, 102, 241, 0.25);
  --wave-color-2: rgba(139, 92, 246, 0.25);
  --wave-color-3: rgba(79, 70, 229, 0.2);
  
  /* Theme colors */
  --primary-color: #6366f1;
  --accent-color: #8b5cf6;
  --secondary-color: #4f46e5;
}
```

### Example Color Schemes

**Blue/Purple (Default)**
```css
--wave-color-1: rgba(99, 102, 241, 0.25);
--wave-color-2: rgba(139, 92, 246, 0.25);
--wave-color-3: rgba(79, 70, 229, 0.2);
```

**Green/Teal**
```css
--wave-color-1: rgba(16, 185, 129, 0.25);
--wave-color-2: rgba(20, 184, 166, 0.25);
--wave-color-3: rgba(5, 150, 105, 0.2);
```

**Orange/Red**
```css
--wave-color-1: rgba(249, 115, 22, 0.25);
--wave-color-2: rgba(239, 68, 68, 0.25);
--wave-color-3: rgba(220, 38, 38, 0.2);
```

## Usage

### Import and Add to Pages

```javascript
import AnimatedBackground from '../components/AnimatedBackground';

const MyPage = () => {
  return (
    <div className="min-h-screen py-8">
      <AnimatedBackground />
      <div className="relative z-10">
        {/* Your content here */}
      </div>
    </div>
  );
};
```

### Glassmorphism UI Components

The background works best with glassmorphism effects:

```jsx
<div className="bg-white/10 backdrop-blur-lg shadow-2xl rounded-lg border border-white/20">
  {/* Content */}
</div>
```

## Performance Optimizations

### GPU Acceleration
- All animations use `transform` and `opacity` properties
- `will-change` hints for smoother rendering
- Hardware acceleration via `translateZ(0)`

### Canvas Optimization
- Separate canvases for stars and particles (better layer management)
- RequestAnimationFrame for smooth 60fps animations
- Efficient particle system with object pooling

### Reduced Motion Support
Automatically respects user preferences:

```css
@media (prefers-reduced-motion: reduce) {
  /* Animations are disabled */
}
```

### Responsive Behavior
- Canvas automatically resizes on window resize
- Particle count optimized for mobile devices
- Wave opacity reduced on smaller screens

## Browser Compatibility

- ✅ Chrome 90+
- ✅ Firefox 88+
- ✅ Safari 14+
- ✅ Edge 90+

## Adjusting Performance

### Reduce Particle Count
Edit `AnimatedBackground.js` line ~213:

```javascript
const particles = Array.from({ length: 50 }, () => new Particle()); // Reduced from 80
```

### Reduce Shapes
Edit line ~214:

```javascript
const shapes = Array.from({ length: 6 }, () => new GeometricShape()); // Reduced from 12
```

### Reduce Stars
Edit lines ~215-219:

```javascript
const stars = [
  ...Array.from({ length: 50 }, () => new Star(0)), // Reduced from 100
  ...Array.from({ length: 30 }, () => new Star(1)), // Reduced from 60
  ...Array.from({ length: 20 }, () => new Star(2)), // Reduced from 40
];
```

## Troubleshooting

### Performance Issues
1. Reduce particle/shape/star counts
2. Disable parallax scrolling (remove scroll listener)
3. Check browser console for errors

### Colors Not Applying
1. Ensure CSS variables are defined in `:root`
2. Clear browser cache
3. Check for CSS specificity conflicts

### Background Not Showing
1. Verify `z-index: -1` on `.animated-background`
2. Ensure content has `position: relative` and `z-index: 10`
3. Check if AnimatedBackground is imported correctly

## Files Created

1. **`frontend/src/components/AnimatedBackground.js`** - Main component
2. **`frontend/src/components/AnimatedBackground.css`** - Styles and animations
3. **`frontend/src/index.css`** - Updated with CSS variables

## Pages Updated

- ✅ Login.js
- ✅ Dashboard.js
- ✅ AddStudent.js
- ✅ EditStudent.js
- ✅ ViewStudents.js

All pages now feature:
- Animated background
- Glassmorphism UI cards
- Proper text contrast
- Responsive design
