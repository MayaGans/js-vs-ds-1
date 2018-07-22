---
layout: default
permalink: "/en/viz/"
title: "Visualizing Data"
questions:
- "How can I visualize data on the web?"
- "Why is this so hard?"
keypoints:
- "D3 is a toolkit for building data visualizations."
- "None of the libraries that combine D3 with React are ready for use by beginners yet."
- "Chart.js isn't great either, but it and its React wrappers are usable."
---

## Introduction

- Tables are great, but visualizations are often more effective
  - At least if they're well designed...
  - ...and your audience is sighted
- Many ways to do data visualization in the browser
- Unfortunately, none "just work" for this tutorial's audience

## Drawing Options

- Server-side generation of static images
- HTML `canvas` element
  - Element specifies drawing region
  - Use JavaScript commands to draw lines, place text, etc.
- [Scalable Vector Graphics](../gloss/#svg) (SVG)
  - Represent stroke-based graphics using the same kinds of tags as HTML
  - Can be rendered by many applications (not just browsers)

```html
<svg width="400" height="300">
      
  <circle cx="100" cy="100" r="30" 
    fill="pink" stroke="red" stroke-width="2"/>
      
  <rect x="200" y="20" width="100" height="60"
    fill="lightblue"/>
      
  <line x1="300" y1="200" x2="400" y2="300"
    stroke="plum" stroke-width="5"/>
      
  <text x="50" y="200"
    font-family="serif" font-size="16">
    Hello World
  </text>

</svg>
```
{: title="src/viz/svg.html"}

- Note that SVG's coordinate system starts in the upper left
  - There is a special corner in Hell reserved for people who do this...

<svg width="400" height="300" style="border: 1px solid black;">
      
  <circle cx="100" cy="100" r="30" 
    fill="pink" stroke="red" stroke-width="2"/>
      
  <rect x="200" y="20" width="100" height="60"
    fill="lightblue"/>
      
  <line x1="300" y1="200" x2="400" y2="300"
    stroke="plum" stroke-width="5"/>
      
  <text x="50" y="200"
    font-family="serif" font-size="16">
    Hello World
  </text>

</svg>
