// lib/features/procurement/services/python_script_generator.dart

import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../models/purchase_requisition.dart';

class PythonScriptGenerator {
  static Future<File> generatePRAutomationScript({
    required PurchaseRequisition pr,
    required List<PRLineItem> items,
    required String sapUsername,
    required String sapPassword,
  }) async {
    final script = _buildPRScript(pr, items, sapUsername, sapPassword);

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/PR_${pr.prNumber}_automation.py');
    await file.writeAsString(script);

    return file;
  }

  static String _buildPRScript(
    PurchaseRequisition pr,
    List<PRLineItem> items,
    String username,
    String password,
  ) {
    return '''
import subprocess
import time
import pyautogui
import pandas as pd
import json
from datetime import datetime


# ===== CONFIGURATION =====
SAP_SYSTEM = "S4P"
SAP_CLIENT = "300"
SAP_USERNAME = "$username"
SAP_PASSWORD = "$password"
SAP_LANGUAGE = "EN"
CSV_FILE = "PR_${pr.prNumber}.csv"
JSON_CONFIG = "PR_${pr.prNumber}_workflow.json"
TCODE = "ME51N"

# Delay configuration
TYPING_SPEED = 0.01
SCREEN_WAIT = 2
LOG_FILE = "automation_log_${pr.prNumber}.txt"


# ===== LOGGING =====
def log_message(message, level="INFO"):
    """Log messages to console and file"""
    timestamp = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_entry = f"[{timestamp}] [{level}] {message}"
    print(log_entry)
    
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(log_entry + "\\n")


def log_separator():
    """Print separator line"""
    separator = "=" * 80
    print(separator)
    with open(LOG_FILE, "a", encoding="utf-8") as f:
        f.write(separator + "\\n")


# ===== SAP CONNECTION =====
def login_to_sap():
    """Login to SAP using sapshcut.exe"""
    log_separator()
    log_message("LOGGING INTO SAP")
    log_separator()
    
    try:
        subprocess.Popen([
            r"C:\\Program Files (x86)\\SAP\\FrontEnd\\SAPgui\\sapshcut.exe",
            f"-system={SAP_SYSTEM}",
            f"-client={SAP_CLIENT}",
            f"-user={SAP_USERNAME}",
            f"-pw={SAP_PASSWORD}",
            f"-language={SAP_LANGUAGE}"
        ])
        
        log_message("Waiting for SAP to load...")
        time.sleep(12)
        log_message("✓ SAP logged in successfully!", "SUCCESS")
        return True
        
    except Exception as e:
        log_message(f"✗ Error logging into SAP: {e}", "ERROR")
        return False


# ===== WORKFLOW EXECUTION =====
def execute_tcode(tcode):
    """Execute transaction code"""
    log_message(f"Executing T-code: {tcode}")
    
    try:
        pyautogui.write(f'/n{tcode}', interval=TYPING_SPEED)
        pyautogui.press('enter')
        time.sleep(SCREEN_WAIT)
        log_message(f"✓ {tcode} opened successfully", "SUCCESS")
        return True
        
    except Exception as e:
        log_message(f"✗ Error executing T-code: {e}", "ERROR")
        return False


def fill_document_type():
    """Fill document type on initial screen"""
    log_message("Selecting document type: ${pr.documentType}")
    
    try:
        # Document type is usually the first field
        pyautogui.write('${pr.documentType}', interval=TYPING_SPEED)
        time.sleep(SCREEN_WAIT)
        log_message("✓ Document type filled", "SUCCESS")
        return True
        
    except Exception as e:
        log_message(f"✗ Error filling document type: {e}", "ERROR")
        return False


def fill_header_data(row):
    """Fill Purchase Requisition header data"""
    log_message("Filling header data...")
    
    try:
        # Purchase Organization (usually pre-filled with 1000)
        pyautogui.press('tab')
        if pd.notna(row['Purchase_Org']):
            pyautogui.write(str(row['Purchase_Org']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Purchasing Group
        pyautogui.press('tab')
        if pd.notna(row['Purchase_Group']):
            pyautogui.write(str(row['Purchase_Group']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Press Enter to go to item overview
        pyautogui.press('enter')
        time.sleep(SCREEN_WAIT)
        
        log_message("✓ Header data filled successfully", "SUCCESS")
        return True
        
    except Exception as e:
        log_message(f"✗ Error filling header data: {e}", "ERROR")
        return False


def fill_line_item(item_data, item_number):
    """Fill individual line item"""
    log_message(f"Filling item {item_number}...")
    
    try:
        # Material (if exists)
        if pd.notna(item_data['Material']) and str(item_data['Material']).strip():
            pyautogui.write(str(item_data['Material']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Short Text
        pyautogui.press('tab')
        if pd.notna(item_data['Short_Text']):
            pyautogui.write(str(item_data['Short_Text']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Quantity
        pyautogui.press('tab')
        if pd.notna(item_data['Quantity']):
            pyautogui.write(str(item_data['Quantity']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Unit
        pyautogui.press('tab')
        if pd.notna(item_data['Unit']):
            pyautogui.write(str(item_data['Unit']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Delivery Date
        pyautogui.press('tab')
        if pd.notna(item_data['Delivery_Date']):
            pyautogui.write(str(item_data['Delivery_Date']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Plant
        pyautogui.press('tab')
        if pd.notna(item_data['Plant']):
            pyautogui.write(str(item_data['Plant']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Storage Location
        pyautogui.press('tab')
        if pd.notna(item_data['Storage_Location']) and str(item_data['Storage_Location']).strip():
            pyautogui.write(str(item_data['Storage_Location']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Material Group
        pyautogui.press('tab')
        if pd.notna(item_data['Material_Group']):
            pyautogui.write(str(item_data['Material_Group']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        # Valuation Price
        pyautogui.press('tab')
        if pd.notna(item_data['Valuation_Price']):
            pyautogui.write(str(item_data['Valuation_Price']), interval=TYPING_SPEED)
            time.sleep(SCREEN_WAIT)
        
        log_message(f"✓ Item {item_number} filled successfully", "SUCCESS")
        return True
        
    except Exception as e:
        log_message(f"✗ Error filling item {item_number}: {e}", "ERROR")
        return False


def fill_account_assignment(item_data):
    """Fill account assignment for item"""
    log_message("Filling account assignment...")
    
    try:
        # Check account assignment category
        acct_cat = str(item_data.get('Account_Assignment_Category', '')).strip()
        
        if acct_cat == 'A':
            # Asset account assignment
            log_message("Processing Asset account assignment")
            
            # Navigate to account assignment screen (usually a button or F5)
            pyautogui.press('f5')
            time.sleep(SCREEN_WAIT)
            
            # Asset Number
            if pd.notna(item_data.get('Asset_Number')):
                pyautogui.write(str(item_data['Asset_Number']), interval=TYPING_SPEED)
                time.sleep(SCREEN_WAIT)
            
        elif acct_cat == 'K':
            # Cost Center account assignment
            log_message("Processing Cost Center account assignment")
            
            # Navigate to account assignment screen
            pyautogui.press('f5')
            time.sleep(SCREEN_WAIT)
            
            # Cost Center
            if pd.notna(item_data.get('Cost_Center')):
                pyautogui.write(str(item_data['Cost_Center']), interval=TYPING_SPEED)
                time.sleep(SCREEN_WAIT)
            
            # G/L Account
            pyautogui.press('tab')
            if pd.notna(item_data.get('GL_Account')):
                pyautogui.write(str(item_data['GL_Account']), interval=TYPING_SPEED)
                time.sleep(SCREEN_WAIT)
        
        # Return to item overview
        pyautogui.press('enter')
        time.sleep(SCREEN_WAIT)
        
        log_message("✓ Account assignment filled", "SUCCESS")
        return True
        
    except Exception as e:
        log_message(f"✗ Error filling account assignment: {e}", "ERROR")
        return False


def save_document():
    """Save the purchase requisition document"""
    log_message("Saving document...")
    
    try:
        # Save using Ctrl+S
        pyautogui.hotkey('ctrl', 's')
        time.sleep(3)
        
        log_message("✓ Document saved successfully", "SUCCESS")
        
        # Try to capture PR number from screen
        # This is environment-specific and may need adjustment
        time.sleep(1)
        
        return True
        
    except Exception as e:
        log_message(f"✗ Error saving document: {e}", "ERROR")
        return False


def process_purchase_requisition():
    """Main function to process PR from CSV"""
    log_separator()
    log_message("STARTING PURCHASE REQUISITION AUTOMATION")
    log_message(f"PR Number: ${pr.prNumber}")
    log_message(f"Document Type: ${pr.documentType}")
    log_message(f"Total Items: ${items.length}")
    log_separator()
    
    # Step 1: Login to SAP
    if not login_to_sap():
        log_message("Failed to login to SAP. Aborting.", "ERROR")
        return False
    
    # Step 2: Execute T-code
    if not execute_tcode(TCODE):
        log_message("Failed to execute T-code. Aborting.", "ERROR")
        return False
    
    time.sleep(SCREEN_WAIT)
    
    # Step 3: Fill document type
    if not fill_document_type():
        log_message("Failed to fill document type. Aborting.", "ERROR")
        return False
    
    # Step 4: Read CSV data
    log_message(f"Reading data from {CSV_FILE}...")
    
    try:
        df = pd.read_csv(CSV_FILE)
        log_message(f"✓ Found {len(df)} item(s) to process", "SUCCESS")
    except FileNotFoundError:
        log_message(f"✗ Error: {CSV_FILE} not found!", "ERROR")
        return False
    except Exception as e:
        log_message(f"✗ Error reading CSV: {e}", "ERROR")
        return False
    
    # Step 5: Fill header data (using first row)
    if not df.empty:
        if not fill_header_data(df.iloc[0]):
            log_message("Failed to fill header data. Aborting.", "ERROR")
            return False
    
    # Step 6: Process each line item
    success_count = 0
    
    for index, row in df.iterrows():
        log_separator()
        log_message(f"PROCESSING ITEM {row['Item_Number']}")
        log_separator()
        
        try:
            # Fill line item data
            if fill_line_item(row, row['Item_Number']):
                # Fill account assignment if needed
                if str(row.get('Account_Assignment_Category', '')).strip():
                    fill_account_assignment(row)
                
                # Move to next item
                pyautogui.press('enter')
                time.sleep(SCREEN_WAIT)
                
                success_count += 1
            else:
                log_message(f"Skipping item {row['Item_Number']} due to error", "WARNING")
                
        except Exception as e:
            log_message(f"✗ Error processing item {row['Item_Number']}: {e}", "ERROR")
            continue
    
    # Step 7: Save document
    if success_count > 0:
        if save_document():
            log_separator()
            log_message("AUTOMATION COMPLETED SUCCESSFULLY", "SUCCESS")
            log_message(f"Successfully processed: {success_count}/{len(df)} items")
            log_separator()
            return True
    
    log_separator()
    log_message("AUTOMATION COMPLETED WITH ERRORS", "WARNING")
    log_message(f"Successfully processed: {success_count}/{len(df)} items")
    log_separator()
    
    return False


# ===== MAIN EXECUTION =====
def main():
    """Main entry point"""
    print("=" * 80)
    print("SAP PURCHASE REQUISITION AUTOMATION")
    print("PR Number: ${pr.prNumber}")
    print("Document Type: ${pr.documentType} - ${pr.documentTypeDescription}")
    print("=" * 80)
    print()
    
    # Initialize log file
    with open(LOG_FILE, "w", encoding="utf-8") as f:
        f.write("SAP Purchase Requisition Automation Log\\n")
        f.write(f"Started: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}\\n")
        f.write("=" * 80 + "\\n\\n")
    
    # Check prerequisites
    print("Checking prerequisites...")
    
    if not os.path.exists(CSV_FILE):
        print(f"✗ Error: {CSV_FILE} not found!")
        print("Please ensure the CSV file is in the same directory as this script.")
        return
    
    if not os.path.exists(JSON_CONFIG):
        print(f"⚠ Warning: {JSON_CONFIG} not found!")
        print("Workflow configuration file is missing but automation will continue.")
    
    print("✓ Prerequisites check completed")
    print()
    
    # Confirmation
    print("IMPORTANT: This script will take control of your mouse and keyboard.")
    print("Make sure SAP login window is ready and no other applications are interfering.")
    print()
    
    response = input("Press Enter to start automation (or 'q' to quit)... ")
    
    if response.lower() == 'q':
        print("Automation cancelled by user.")
        return
    
    print()
    print("Starting automation in 3 seconds...")
    time.sleep(3)
    
    # Execute automation
    success = process_purchase_requisition()
    
    # Final summary
    print()
    print("=" * 80)
    if success:
        print("✓ AUTOMATION COMPLETED SUCCESSFULLY")
    else:
        print("✗ AUTOMATION COMPLETED WITH ERRORS")
    print(f"Check log file for details: {LOG_FILE}")
    print("=" * 80)


if __name__ == "__main__":
    # Install required packages
    print("Required packages: pyautogui, pandas")
    print("Install with: pip install pyautogui pandas")
    print()
    
    try:
        main()
    except KeyboardInterrupt:
        print()
        print("Automation interrupted by user.")
    except Exception as e:
        print()
        print(f"Fatal error: {e}")
        with open(LOG_FILE, "a", encoding="utf-8") as f:
            f.write(f"\\n[FATAL ERROR] {e}\\n")
''';
  }

  // Generate batch file for easy execution
  static Future<File> generateBatchFile(String prNumber) async {
    final batchScript =
        '''
@echo off
title SAP PR Automation - ${prNumber}
color 0A

echo ========================================
echo SAP Purchase Requisition Automation
echo PR Number: ${prNumber}
echo ========================================
echo.

REM Check if Python is installed
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Error: Python is not installed or not in PATH
    echo Please install Python 3.7+ from https://www.python.org/
    pause
    exit /b 1
)

REM Check if required packages are installed
echo Checking required packages...
pip show pyautogui >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pyautogui...
    pip install pyautogui
)

pip show pandas >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing pandas...
    pip install pandas
)

echo.
echo Ready to start automation...
echo.

REM Run the Python script
python PR_${prNumber}_automation.py

echo.
echo Automation finished!
pause
''';

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/run_PR_${prNumber}_automation.bat');
    await file.writeAsString(batchScript);

    return file;
  }
}
//   // Generate README
//   static Future<File> generateReadme(String prNumber) async {
//     final readme = '''
// # SAP Purchase Requisition Automation

// ## PR Number: ${prNumber}

// ### Files Included

// 1. **PR_${prNumber}_automation.py** - Main automation script
// 2. **PR_${prNumber}_workflow.json** - Workflow configuration
// 3. **PR_${prNumber}.csv** - Line item data
// 4. **run_PR_${prNumber}_automation.bat** - Batch file to run automation (Windows)

// ### Prerequisites

// - Python 3.7 or higher
// - SAP GUI installed on your system
// - Required Python packages:
//   - pyautogui
//   - pandas

// ### Installation

// 1. Install Python from https://www.python.org/ if not already installed

// 2. Install required packages:
