# PDF to Image

PDF to Image is a Powershell script that converts PDFs within the /Communities/<communityname>/Maps folders to images. Once converted to images, the excel report generator can insert them into the final report. After the PDFs are converted to image, the IMG file remains in /Maps/ and the original PDF is moved to /Maps/Archive. If the PDF name matches the existing, a number will be added to the end of name. Anytime a new PDF is added to a folder with an image file already inside, it moves the old Image to /Maps/Archive and converts the newly added PDF. 

## Installation

Drag "PDFtoIMG" folder to your documents. Make sure "ghost" folder exists. If script keeps failing you may need to download and install "Ghostscript". 

## Usage

Right click pdftoimage.ps1 and click "Run with PowerShell", a blue window will pop up and ask you if the path is correct. To change the path to community folders, type in the new one and press Enter, to proceed with existing path press Enter. The script will run and report back how many PDFs were converted. 

## License

MIT License

Copyright (c) 2021 Robert Breese - Jinx-IT

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
