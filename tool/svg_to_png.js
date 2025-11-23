#!/usr/bin/env node
/**
 * Convert SVG to PNG using sharp (Node.js)
 * Install: npm install -g sharp
 * Or: npx sharp-cli
 */

const fs = require('fs');
const path = require('path');

async function convertSvgToPng() {
  const svgPath = 'assets/logo.svg';
  const pngPath = 'assets/icon/app_icon.png';
  const size = 1024;

  if (!fs.existsSync(svgPath)) {
    console.error(`Error: ${svgPath} not found`);
    process.exit(1);
  }

  try {
    // Try to use sharp
    const sharp = require('sharp');
    
    console.log(`Converting ${svgPath} to ${pngPath} (${size}x${size})...`);
    
    await sharp(svgPath)
      .resize(size, size)
      .png()
      .toFile(pngPath);
    
    console.log(`✓ Successfully converted to ${pngPath}`);
  } catch (error) {
    if (error.code === 'MODULE_NOT_FOUND') {
      console.log('sharp not found. Installing...');
      const { execSync } = require('child_process');
      try {
        execSync('npm install sharp --save-dev', { stdio: 'inherit' });
        const sharp = require('sharp');
        await sharp(svgPath)
          .resize(size, size)
          .png()
          .toFile(pngPath);
        console.log(`✓ Successfully converted to ${pngPath}`);
      } catch (installError) {
        console.error('Error installing sharp:', installError.message);
        console.log('\nPlease install sharp manually:');
        console.log('  npm install sharp');
        console.log('Or use npx:');
        console.log(`  npx sharp-cli -i ${svgPath} -o ${pngPath} -w ${size} -h ${size}`);
        process.exit(1);
      }
    } else {
      console.error('Error converting:', error.message);
      process.exit(1);
    }
  }
}

convertSvgToPng();

