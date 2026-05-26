# Packet Loss Simulator for QA

Two scripts that use the macOS built-in packet filter (`pf`) and dummynet
(`dnctl`) to simulate packet loss on a Mac. Combined with macOS Internet
Sharing, you can route an iPhone (or any device) through the Mac and test
how apps behave under lossy network conditions.

## What's in here

| File                  | What it does                                                  |
| --------------------- | ------------------------------------------------------------- |
| `packetloss-on.sh N`  | Turns on packet loss at N percent (e.g. `10` for 10% loss).   |
| `packetloss-off.sh`   | Turns packet loss back off and restores normal networking.    |

You will be prompted for your Mac admin password — both scripts use `sudo`.

---

## Part 1 — Set up the Mac to share its internet with the iPhone

Do this once. The goal: the Mac becomes a Wi-Fi hotspot that the iPhone
joins, so all of the iPhone's traffic flows through the Mac.

### What you need

- A Mac with admin rights.
- The Mac connected to the internet via **Ethernet** (or a USB-C/Thunderbolt
  Ethernet adapter). You can't share Wi-Fi over Wi-Fi — the source and
  destination must be different interfaces.
- The iPhone you want to test.

### Steps

1. On the Mac, open **System Settings** > **General** > **Sharing**.
2. Click the small **(i)** button next to **Internet Sharing** (do not
   toggle it on yet).
3. Set **Share your connection from:** `Ethernet` (or whichever interface
   has the live internet connection).
4. Under **To devices using:**, tick **Wi-Fi**.
5. Click **Wi-Fi Options...** and set:
   - **Network Name:** something obvious, e.g. `QA-Test-Net`
   - **Channel:** leave default
   - **Security:** `WPA2 Personal`
   - **Password:** pick one, write it down
6. Click **Done**, then toggle **Internet Sharing** to **On**. macOS will
   warn you it may disrupt the network — click **Start**.
7. The Wi-Fi icon in the menu bar should now show an upward arrow,
   indicating sharing is active.

### Join from the iPhone

1. On the iPhone: **Settings** > **Wi-Fi**.
2. Pick the network name you set above (e.g. `QA-Test-Net`).
3. Enter the password.
4. Once connected, open Safari and load any site to confirm internet works.

At this point the iPhone is online **through the Mac**. Any packet loss
you simulate on the Mac will hit the iPhone's traffic.

---

## Part 2 — Turn packet loss on

Open Terminal on the Mac and run:

```bash
cd ~/Projects/bash/packetloss
./packetloss-on.sh 10
```

The `10` means **10% packet loss**. Use any number from `0` to `100`:

- `./packetloss-on.sh 5`  — light degradation
- `./packetloss-on.sh 20` — noticeable lag and stalls
- `./packetloss-on.sh 50` — brutal; many things will fail

> Tip: if you have the shell aliases set up (see "Aliases" below), you can
> just run `plon 10` from anywhere instead.

You'll be asked for your Mac password the first time. Output should look
roughly like:

```
Enabling 10% packet loss (plr=0.1000)...
Password:
pfctl: Use of -f option, could result in flushing of rules ...
pf enabled
Packet loss enabled. Run packetloss-off.sh to disable.
```

The warning about flushing rules is normal.

---

## Part 3 — Test on the iPhone

With the iPhone connected to the Mac's shared Wi-Fi and packet loss enabled,
exercise the app under test. Good things to try:

- Load a webpage in Safari (should be slow or fail partially).
- Stream a video — expect buffering.
- Run a speed test (e.g. fast.com) to see degraded throughput.
- Run the actual QA scenarios you care about.

To sanity-check from the Mac itself, you can run a TCP test:

```bash
for i in {1..20}; do
  curl -o /dev/null -s -w "%{http_code} in %{time_total}s\n" \
    --max-time 3 https://www.google.com
done
```

Some requests will be slow or time out — that's the loss working.

> Note: `ping` (ICMP) **will not** show packet loss with these scripts. The
> rule only affects TCP and UDP, which is what real apps use. Don't rely on
> ping to verify.

---

## Part 4 — Turn packet loss off

When you're done testing, **always** run:

```bash
./packetloss-off.sh    # or: ploff
```

This disables the packet filter and flushes the dummynet rules, returning
the Mac to normal networking.

If you forget and your Mac feels sluggish later, just run it — it's safe to
run any time, even if loss wasn't on.

You can also turn off **Internet Sharing** (System Settings > Sharing)
when QA is finished.

---

## Troubleshooting

**The iPhone says "No Internet" after joining the network.**
- Confirm the Mac's source interface (Ethernet) actually has internet.
  Open a browser on the Mac and load any page.
- Toggle Internet Sharing off and back on.
- Forget the network on the iPhone and rejoin.

**`./packetloss-on.sh` says "permission denied".**
- Run `chmod +x packetloss-on.sh packetloss-off.sh` once.

**Things still feel slow after running `packetloss-off.sh`.**
- Run it a second time. If the issue persists, also run:
  ```bash
  sudo pfctl -d
  sudo dnctl -q flush
  ```
  Or just restart the Mac — all `pf`/`dnctl` rules are cleared on reboot.

**The script asks for a password every time.**
- That's normal `sudo` behaviour. To skip it, you'd need to configure a
  passwordless `sudo` rule, which is out of scope here.

**I want to change the loss percentage without turning it off first.**
- You can — just run `./packetloss-on.sh <new-number>` again. It will
  reconfigure pipe 1 with the new rate.

---

## Aliases (optional, but handy)

Add these to your `~/.zshrc` so you can call the scripts from anywhere
without `cd`-ing into the project folder:

```sh
alias plon='~/Projects/bash/packetloss/packetloss-on.sh'
alias ploff='~/Projects/bash/packetloss/packetloss-off.sh'
```

Then `source ~/.zshrc` (or open a new terminal) and you can run:

```sh
plon 10
ploff
```

---

## How it works (the short version)

1. `dnctl pipe 1 config plr 0.10` creates a virtual pipe that randomly
   drops 10% of packets sent through it.
2. A `pf` rule tells the packet filter to send all TCP and UDP traffic
   through that pipe.
3. `pfctl -e` enables the packet filter.
4. Since the iPhone's traffic is being NAT'd through the Mac via Internet
   Sharing, it all flows through pipe 1 and gets the same 10% loss.
