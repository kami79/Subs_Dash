# Huawei Sync & Core Subscriber Dump Automation & Online NOC Dashboard

Independent production automation toolkit & live interactive web dashboard located on the Desktop:
`C:\Users\kamiran.gabriel\Desktop\Subs_Dash\`

---

## 🌟 New Feature: Live Online Dashboard Portal

A web-based Core Network Operations Center (NOC) dashboard providing real-time telemetry, interactive Apache ECharts time-series, automated anomaly detection, and pipeline orchestration.

### Quick Start Portal:
Double-click:
```bat
Run_Dashboard_Portal.bat
```
- **Local URL:** `http://localhost:8080`
- **Company Network URL:** `http://10.10.103.59:8080` (or `http://HQ-TECH-L309:8080`)

### Sharing on the Company Network:
1. Ensure `Run_Dashboard_Portal.bat` is running on your machine.
2. If other employees or engineers cannot reach the portal, right-click and run:
   ```bat
   Open_Firewall_Port_8080.bat (Run as administrator)
   ```
   This opens inbound TCP Port 8080 in Windows Defender Firewall.
3. Share either link with colleagues:
   - **`http://10.10.103.59:8080`**
   - **`http://HQ-TECH-L309:8080`**

### Dashboard Capabilities:
1. **Executive Overview Page:**
   - Real-time VLR & Active Data KPIs with dynamic sparklines.
   - Status vs ~4.78M / ~2.95M baselines.
   - Live regional health status cards for Erbil, Rezan (5G), Kirkuk, Musol, Baghdad, and Basra.
   - Dual side-by-side interactive time-series charts.
2. **VLR Subscribers Page:**
   - Full interactive hourly curve with zoom brush and day background bands.
   - Daily aggregate summary table (average, peak, min, status).
   - Per-node VLR snapshot table (ARBC01, ARBC02, ARMSS5, BGBC01, BGBC02, BSMSS2).
3. **Active Data Subscribers Page:**
   - Regional breakdown across Erbil, Rezan (5G SA), Musol, and Baghdad.
   - Technology evolution stacked area chart: 4G LTE, 3G (UTRAN), 2G (GSM).
4. **HLR & UDM Base Page:**
   - Huawei UDM 5G core base tracking (`ERB2UDMFE01`).
   - Correlation of total provisioned subscribers vs active VLR penetration rate.
5. **Incidents & Outages Center:**
   - Data-driven anomaly detection (no hard-coded dates).
   - Flags node outages, missing feeds (Baghdad & Mosul zero-traffic), and steep drops.
   - Severity tags (Critical, Warning, Info) with an "Acknowledge" button.
6. **Reports & Archive Center:**
   - Download past high-resolution PNG charts and Excel workbooks.
   - In-app preview of the executive email report (rich HTML and plain text).
7. **Pipeline Operations Page:**
   - Trigger on-demand runs of any stage or the full pipeline directly from the browser.
   - Live execution log console for `full_pipeline.log`, `portal_fetcher.log`, `dump_bc_vlr_hlr.log`, etc.

---

## Key Core Pipeline Features

1. **Fast Query Mode ('Yesterday' Preset)**:
   - In `portal_fetcher.py`, the date range radio option **`Yesterday`** is chosen on the Huawei Portal `#newQueryBox`.
   - Bypasses custom date inputs and queries only the 24 hours of yesterday (48 half-hour intervals).

2. **Incremental Table Append (End of Table)**:
   - Automatically adds yesterday's new rows to the **end of each table** across all sheets in:
     - `output/Network Data Attach Users.xlsx`
     - `output/BC_VLR_HLR_Dump.xlsx`
   - Idempotent and maintains formatting, formulas, and column widths.

3. **Blade Cluster (BC), VLR & HLR Subscriber Dump**:
   - Queries Sybase IQ ENIQ `ar3ens1` ODBC database directly for `DC.DC_E_CNAXE_VLRSUBSCR_DAY` on nodes:
     - `ARBC01`, `ARBC02`, `ARMSS5` (North Region)
     - `BGBC01`, `BGBC02`, `BSMSS2` (South Region)
   - Filters UDM subscribers to keep **`ERB2UDMFE01` ONLY**.

4. **Standard Output Folder**:
   - Files reside in `output/` and are synchronized to Desktop upon every run:
     - `output/Network Data Attach Users.xlsx` <-> `Desktop/Network Data Attach Users.xlsx`
     - `output/BC_VLR_HLR_Dump.xlsx` <-> `Desktop/BC_VLR_HLR_Dump.xlsx`

---

## Quick Start (Batch Scripts)

| Script | Purpose |
| :--- | :--- |
| **`Run_Dashboard_Portal.bat`** | **Launches the online web dashboard on port 8080 and opens the browser.** |
| **`Run_Full_Pipeline.bat`** | Runs Stage 1 (Portal Fetch) -> Stage 2 (Sync Attached Users) -> Stage 3 (Sub Dump) -> Stage 4 (Charts & Email). |
| **`Run_Portal_Fetcher_Yesterday.bat`** | Downloads reports from Huawei Portal using the **Yesterday** preset and updates tables. |
| **`Run_Sync_Attached_Users.bat`** | Parses raw Huawei files in `downloads/` and updates `Network Data Attach Users.xlsx`. |
| **`Run_BC_VLR_HLR_Dump.bat`** | Queries ENIQ Sybase IQ + Huawei UDM (`ERB2UDMFE01`) and updates `BC_VLR_HLR_Dump.xlsx`. |
