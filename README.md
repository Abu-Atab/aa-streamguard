# aa-streamguard


Made By: **Abu Atab DEV Team**

Join us here: https://discord.gg/ZVrTWVvf5f
---

## Overview
**aa-streamguard** is a lightweight client-side script designed to reduce and prevent vehicles
from falling under the GTA V default map while driving at high speeds.

This issue occurs when map visuals are rendered but **collision data is not yet fully streamed**.
The script proactively handles collision streaming ahead of the vehicle and applies a safe recovery
mechanism if a fall happens.

---

## How It Works
The script operates entirely on the client and applies two protection layers:

1. **Collision Preloading**
   - Requests collision and scene data ahead of the vehicle based on its current speed.
   - Reduces the chance of reaching unloaded ground while driving fast.

2. **Safety Rescue System**
   - Stores the last confirmed valid ground position.
   - If the vehicle starts falling below the map, it is automatically returned to a safe location.

---

## Features
- Works on the **default GTA V map**
- No framework dependencies (QBCore / ox not required)
- Client-side only
- Lightweight and performance-friendly
- Adaptive look-ahead collision streaming
- Automatic recovery from collision failure
- Suitable for RP, Freeroam, and Racing servers

---

## File Structure

aa-streamguard/
│
├─ fxmanifest.lua
├─ README.md
└─ client.lua

---

## Configuration
All settings can be adjusted in `client/main.lua`, including:
- Activation speed threshold
- Look-ahead distance based on vehicle speed
- Scene loading radius
- Rescue system sensitivity
- Enable or disable rescue logic

Each option is documented directly inside the configuration section.

---

## Installation
1. Copy the resource into your `resources` folder
2. Add the following line to your `server.cfg`:

ensure aa-streamguard

3. Restart the server

---

## Important Notes
- This script greatly **reduces** the issue but cannot guarantee full prevention on extremely low-end systems.
- Collision streaming is handled by the client, not the server.
- Best results are achieved with stable FPS and reasonable vehicle speeds.

---

## Recommended For
- Roleplay servers
- High-speed driving environments
- Servers with modified vehicle handling
- Any server experiencing collision streaming issues on the default map

---

## Support & Community
Join our Discord for support, updates, and development discussions:  
**[Abu Atab DEV](https://discord.gg/ZVrTWVvf5f)**

---

## Accounts
- **Discord:** `@ab.atb`
- **GitHub:** [@Abu-Atab](https://github.com/abu-atab)

---

## Author
**Abu Atab DEV Team**

---

## License

### Abu Atab DEV Team – Proprietary License

© 2025 Abu Atab DEV Team. All rights reserved.

This software is licensed, not sold.  
This script is the exclusive intellectual property of **Abu Atab DEV Team**.

### You are NOT allowed to:
- Sell, resell, rent, or monetize this script in any form
- Re-upload, redistribute, or mirror this resource
- Share this script publicly or privately outside your own server
- Include this script in any public or private pack or bundle
- Remove or modify any copyright, license, or author information
- Claim this script as your own work

### You ARE allowed to:
- Use this script on **one server only**
- Modify the script **for personal server use only**
- Create private edits that are not shared, sold, or redistributed

### Restrictions
- Commercial use, resale, or redistribution is strictly prohibited
  unless explicit written permission is granted by Abu Atab DEV Team.
- This license does not grant ownership of the source code.

### Enforcement
Any violation of this license may result in:
- Immediate revocation of usage rights
- DMCA takedown requests
- Legal action if necessary

By using this script, you acknowledge that you have read, understood,
and agreed to the terms of this license.

