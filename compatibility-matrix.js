// compatibility-matrix.js
// Client-side script handling interface data lookups for the Astro component

export function initializeMatrix() {
  const select = document.getElementById('ios-version');
  const resultBox = document.getElementById('result-box');
  const toolName = document.getElementById('tool-name');
  const toolType = document.getElementById('tool-type');
  const toolLink = document.getElementById('tool-link');

  // Guard clause to prevent execution errors if components are missing from the DOM
  if (!select || !resultBox || !toolName || !toolType || !toolLink) return;

  // Local data logic model
  const tools = {
    "15.0-16.6.1": { 
      name: "Dopamine", 
      url: "https://github.com", 
      type: "Semi-Untethered" 
    },
    "15.0-17.x": { 
      name: "Palera1n", 
      url: "https://palera.in", 
      type: "Hardware-Based (A9-A11)" 
    }
  };

  select.addEventListener('change', (e) => {
    const value = e.target.value;
    
    if (tools[value]) {
      toolName.textContent = tools[value].name;
      toolType.textContent = tools[value].type;
      toolLink.href = tools[value].url;
      resultBox.style.display = 'block';
    } else {
      resultBox.style.display = 'none';
    }
  });
}

// Automatically mount the script if running inside a browser environment
if (typeof window !== 'undefined') {
  document.addEventListener('DOMContentLoaded', initializeMatrix);
}
