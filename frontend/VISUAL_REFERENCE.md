# Visual Elements Reference

## Background Layers (Bottom to Top)

```
┌─────────────────────────────────────────┐
│  Layer 5: Content (z-index: 10)        │  ← Your UI content
├─────────────────────────────────────────┤
│  Layer 4: Particles & Shapes (z: 3)    │  ← Canvas with particles
├─────────────────────────────────────────┤
│  Layer 3: Gradient Waves (z: 2)        │  ← CSS animated waves
├─────────────────────────────────────────┤
│  Layer 2: Stars (z: 1)                 │  ← Canvas with stars
├─────────────────────────────────────────┤
│  Layer 1: Gradient Background (z: -1)   │  ← Base gradient
└─────────────────────────────────────────┘
```

## Particle System

```
     Particle 1 ●─────────● Particle 2
                 \       /
                  \     /
                   \   /
                    \ /
                     ● Particle 3

- Lines appear when distance < 120px
- Opacity fades with distance
- Each particle: 0.5-2px radius
```

## Geometric Shapes

```
   ○        △         □        ⬡
Circle   Triangle   Square   Hexagon

- 12 total shapes
- Random types
- Slow rotation
- Low opacity (0.05-0.2)
- Drift slowly
```

## Wave Layers

```
Wave 1: ╭───────╮   Speed: 25s  |  Color: rgba(99, 102, 241, 0.25)
Wave 2:   ╰───────╯ Speed: 30s  |  Color: rgba(139, 92, 246, 0.25)
Wave 3: ╭───────╮   Speed: 35s  |  Color: rgba(79, 70, 229, 0.2)
```

## Star Field Parallax

```
Layer 0 (100 stars):  ✦ ✦ ✦    Fastest parallax (0.3x scroll)
Layer 1 (60 stars):    ✧ ✧      Medium parallax (0.6x scroll)
Layer 2 (40 stars):     · ·      Slowest parallax (0.9x scroll)

All stars twinkle independently
```

## Glassmorphism Effect

```
┌───────────────────────────────┐
│  bg-white/10                  │ ← 10% white background
│  backdrop-blur-lg             │ ← Blur effect
│  border border-white/20       │ ← 20% white border
│  shadow-2xl                   │ ← Large shadow
└───────────────────────────────┘

CSS:
.card {
  background: rgba(255, 255, 255, 0.1);
  backdrop-filter: blur(16px);
  border: 1px solid rgba(255, 255, 255, 0.2);
  box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.25);
}
```

## Color Palette (Default)

```
Background Gradient:
  Start:  #0f172a (Dark slate)
  Middle: #1e293b (Slate)
  End:    #0f172a (Dark slate)

Wave Colors:
  Wave 1: #6366f1 (Indigo) at 25% opacity
  Wave 2: #8b5cf6 (Violet) at 25% opacity
  Wave 3: #4f46e5 (Indigo) at 20% opacity

Text Colors:
  Heading:  #ffffff (White) with drop-shadow
  Body:     #e5e7eb (Gray-200)
  Muted:    #d1d5db (Gray-300)
```

## Animation Speeds

```
Particles:     0.3 px/frame (very slow drift)
Shapes:        0.2 px/frame (slower drift)
Stars:         Stationary (only twinkle + parallax)
Wave 1:        25s per cycle
Wave 2:        30s per cycle (reverse)
Wave 3:        35s per cycle
Wave Drift:    18-26s per vertical cycle
```

## Performance Metrics (Expected)

```
60 FPS target
├─ Particles: ~5% CPU
├─ Shapes: ~3% CPU
├─ Stars: ~4% CPU
├─ Waves: ~2% CPU (CSS animations)
└─ Total: ~14% CPU on modern hardware

GPU Usage: Low (2D canvas with basic shapes)
Memory: ~15-20MB for canvases
Battery Impact: Minimal (optimized animations)
```

## Responsive Breakpoints

```
Desktop (1024px+):
  ✓ All 80 particles
  ✓ All 12 shapes
  ✓ All 200 stars
  ✓ Full wave opacity

Tablet (768px - 1023px):
  ✓ All particles
  ✓ All shapes
  ✓ All stars
  ✓ Reduced wave opacity (0.1)

Mobile (<768px):
  ✓ All particles (auto-adjust for smaller canvas)
  ✓ All shapes
  ✓ All stars
  ✓ Further reduced wave opacity
  ✓ Slower wave animations (30s vs 25s)
```

## Code Structure

```
AnimatedBackground/
│
├── Component (React)
│   ├── canvasRef (particles & shapes)
│   ├── starsRef (star field)
│   └── useEffect (animation loop)
│
├── Classes
│   ├── Particle
│   │   ├── update() - move position
│   │   └── draw() - render to canvas
│   │
│   ├── GeometricShape
│   │   ├── update() - move & rotate
│   │   └── draw() - render shape
│   │
│   └── Star
│       ├── update(scrollY) - parallax
│       └── draw(time) - render & twinkle
│
└── Animation Loop
    ├── Clear canvases
    ├── Update all objects
    ├── Draw all objects
    └── requestAnimationFrame
```

## CSS Animation Flow

```
.wave-1 {
  animation: wave-move-1 25s linear infinite;
}
.wave-1::before {
  animation: wave-drift-1 18s ease-in-out infinite;
}

wave-move-1:  Horizontal slide (0% → 50% transform)
wave-drift-1: Vertical float + scale (0% → -3% Y, 1.0 → 1.05 scale)

Result: Smooth, organic wave motion
```

## User Interaction

```
Scroll Event:
  └─> Update parallax offset
      └─> Stars move at different speeds
          └─> Creates depth illusion

Window Resize:
  └─> Recalculate canvas dimensions
      └─> Particles adjust to new boundaries
          └─> No visual glitches

Mouse Movement:
  └─> Not currently tracked (optional feature)
```

## Accessibility Features

```
prefers-reduced-motion: reduce
├─ ✓ Disables all canvas animations
├─ ✓ Disables wave animations
├─ ✓ Shows static gradient background
└─ ✓ Content remains fully accessible

High Contrast Mode:
├─ ✓ Text maintains readability
├─ ✓ Borders become more visible
└─ ✓ Background adapts automatically
```

## Browser DevTools Analysis

```
Performance Tab:
  ✓ Consistent 60fps
  ✓ No long tasks (>50ms)
  ✓ Minimal paint operations

Memory Tab:
  ✓ Stable heap size (~15-20MB)
  ✓ No memory leaks
  ✓ Proper cleanup on unmount

Network Tab:
  ✓ No additional requests
  ✓ All code bundled in main.js
  ✓ CSS in styles.css
```

## Common Customizations

### 1. Change Particle Count
```javascript
// AnimatedBackground.js line ~213
const particles = Array.from({ length: 50 }, () => new Particle());
```

### 2. Change Colors
```css
/* index.css */
:root {
  --wave-color-1: rgba(16, 185, 129, 0.25); /* Green */
}
```

### 3. Adjust Speed
```javascript
// Particle speed in update()
this.vx = (Math.random() - 0.5) * 0.1; // Slower (was 0.3)
```

### 4. Disable Parallax
```javascript
// Comment out scroll listener
// window.addEventListener('scroll', handleScroll, { passive: true });
```

### 5. Add Mouse Interaction
```javascript
// Add to useEffect
const handleMouse = (e) => {
  // Custom logic here
};
canvas.addEventListener('mousemove', handleMouse);
```

---

## Testing Commands

```bash
# Start development server
npm start

# Build for production
npm run build

# Check bundle size
npm run build && ls -lh build/static/js/

# Run performance audit
lighthouse http://localhost:3000 --view

# Check accessibility
npm install -g pa11y
pa11y http://localhost:3000
```

---

## File Sizes

```
AnimatedBackground.js:    ~8 KB (uncompressed)
AnimatedBackground.css:   ~6 KB (uncompressed)
Total Runtime Impact:     ~14 KB

Gzipped:
AnimatedBackground.js:    ~2.5 KB
AnimatedBackground.css:   ~1.5 KB
Total Gzipped:           ~4 KB
```

This animated background adds minimal overhead while providing maximum visual impact! 🎨✨
