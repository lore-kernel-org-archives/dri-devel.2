Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20629C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B0BD10F617;
	Fri,  3 Jul 2026 03:02:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="E3c1MEXS";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68C9910F610
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:42 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493b27c7451so11549985e9.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047761; x=1783652561;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NdX3Cn5RlzHa2YKrbPiFLyyMC4tpWz0socWbAnGJY54=;
 b=E3c1MEXSyNCFZaEk4SH3RnasgudR9xachCUoy+Y9UtiFB/yGIVcNDR7vOccBpCmI2/
 Tnae9nIiZtYXKm8hd+eKliSu73DlvfIs34YTcBGUOdDRipWvG523yYTeUZTDxzDrR+C+
 QhaIJKnYSrpal9QBtEqkKoouUdsBd5Os7gGWLbfYHrzu7UWCZzKFI2wKTlGHv06hRrp+
 t8oSpVYzb5BnuIb+r7hy0xt/Kl0F1S2a3oQDnLEKxUUXJQwQbYWKJoTO8bl+h7pnRBHl
 UWaG+hK7aG4PqBzrDwsM1jzgnUic3pOYbHzm6ILRMHjKQcxJWj4piILGSAefdGQrisEt
 WOXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047761; x=1783652561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NdX3Cn5RlzHa2YKrbPiFLyyMC4tpWz0socWbAnGJY54=;
 b=TwyI8/zyUpeamp2HJ1OrZirSilOZogpyuhiVtdOqZyJ+7qvrh9GFieSv5M5eGPz+cd
 HbwQ+Gy8gc3H87mXLuKeEWXyAUabVq0L80BUN94bVd9Uwcr6Q1GWjy5xbzCfRHPnfAIq
 X5QLqIOhTytFGiqTrKafruxj9jePgpYtKzTeeKxnkt5mkiUnaji0f008tMrjUaB7L446
 HhuQ8qsMuk9eFpl2o97P/RSccCUPcMNT7HyFVEFMKk8LAIehin3TSLqiRVQzDUy7vMGD
 pAime1Q3rdE8Pla9Ffjic+eq6gKb4m1UY114uEu++/1PSbiwow4sORcwWLiu0FWRCXxn
 VaEw==
X-Gm-Message-State: AOJu0Yz7tk9gTSdWT5skqTJYMe4hufAARyOk82kjQ7PLfzn3InmrNLEm
 CDjXD9UOcb5R55EPRwu6nSTJ/ZlR/sXLyGOB4mZ9LguyhodgNnGNi69i0/zkMhIYEw==
X-Gm-Gg: AfdE7cniuBnG7PqlXGDC53wPrK5Z1f1cir1kSQ/cMKR+1NziBvZP+PgNYYIKkjVN9M8
 L9LSAnwHMiFf/eK5Ta3qQemvoAVYCEF/TVRWKvx7kxFIcEclpyUkjePY2xm5r8joWkd4wx3GY5V
 IMohxjWiNC2McknARlyUSByrdCliyJC2dwYT6uGE4spsuqGE3JmH+tFnQdLPukdG3Nh7f70kmYV
 JJgHUSBi8vOCQFB6tr8VOEWB58J9z/WgBgrBwOjNelMH8DJvAxFJxdYI12OVpwqFeXJIGeknw+t
 YFg7So+FnSGRPbzi4YRo26tzByigX0/IzsoVXmb5wE+ZqWmjC23B7grpObZBDxxxtd5F7wI77Sz
 LESGvgL9py4lWWsyyh++ZdHn/2CxFtKBvuxi5+gag/PyDRmuzaiGe29gKN3fjF9A1bdnQNuJVrf
 pVuWaljh/XOApeQhpvw2/r29vvTIN1UEjbMmtsrwZ5OqJfq9EPY8TE/OkT
X-Received: by 2002:a05:600c:8217:b0:490:af63:2cb1 with SMTP id
 5b1f17b1804b1-493c9b4da0dmr28578515e9.7.1783047757915; 
 Thu, 02 Jul 2026 20:02:37 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:35 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: rust-for-linux@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, Mike Lothian <mike@fireburn.co.uk>
Subject: [RFC PATCH v2 06/10] drm/vino: add the DisplayLink DL3 dock driver
Date: Fri,  3 Jul 2026 04:02:11 +0100
Message-ID: <20260703030217.2886-7-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030217.2886-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Ties the rest of the series together: the USB bind (usb::Driver for
the D6000's control interface), the plaintext session-init handshake,
driving the HDCP 2.2 AKE and control-plane bring-up from a deferred
work item, publishing the engaged CP session and dock EDID to the DRM
device once bring-up completes, and the on-device crypto known-answer
self-tests plus the KUnit coverage for the protocol builders/parsers
(gated on CONFIG_KUNIT, zero effect on a production build).

Everything up to the encrypted control-plane engagement works on real
hardware (USB bring-up, HDCP 2.2 AKE/LC/SKE verified, the AES-CTR +
Dl3Cmac seal byte-exact, the stream-open arm marker, a registered
DRM/KMS card), but the dock never acks the first encrypted CP frame
(wsub=0x45 stays 0), so no pixels flow yet -- see docs/BLOCKER.md for
what's been tried and ruled out.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 drivers/gpu/drm/vino/vino.rs | 2617 ++++++++++++++++++++++++++++++++++
 1 file changed, 2617 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/vino.rs

diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
new file mode 100644
index 000000000000..eb4378a747c3
--- /dev/null
+++ b/drivers/gpu/drm/vino/vino.rs
@@ -0,0 +1,2617 @@
+// SPDX-License-Identifier: GPL-2.0
+// SPDX-FileCopyrightText: Copyright (C) 2026 Mike Lothian
+
+//! Vino -- open in-kernel Rust driver for DisplayLink DL3 docks (Dell D6000, ...).
+//!
+//! This is an `[RFC]` work-in-progress, posted to ask for help. It is a clean-room
+//! reverse-engineered replacement for the proprietary DisplayLinkManager userspace
+//! daemon + the EVDI kernel module, written natively in Rust against the in-tree USB,
+//! crypto and DRM/KMS bindings (the prerequisite binding patches are posted as their
+//! own series).
+//!
+//! # What works
+//!
+//! On probe the driver runs, all on real hardware (Dell Universal Dock D6000):
+//! - the plaintext connect handshake over the Rust USB bulk + control transfer API;
+//! - the clean-room HDCP 2.2 AKE / LC / SKE -- H', L' and V' all verify against the
+//!   dock, so the session key `ks` is established and shared;
+//! - the AES-CTR + AES-CMAC ("Dl3Cmac") control-plane seal, byte-exact against the
+//!   reference daemon's captured wire;
+//! - the plaintext `type=2 sub=0x24` stream-open arm marker; and
+//! - registration of a real `struct drm_device` (see [`drm_sink`]) via the simple
+//!   display pipe, so the dock appears to userspace as a mode-settable GEM/dumb DRM
+//!   card, with a live EP08 framebuffer-scanout hook on every page-flip.
+//!
+//! # What does NOT work -- the wall (help wanted)
+//!
+//! After the arm marker the driver sends the first encrypted control-plane frame
+//! (msg0) and the dock **never acknowledges it** (`wsub=0x45` ack count stays 0), so
+//! the CP cipher never engages and no pixels ever flow. Every host-observable channel
+//! has been matched to the reference daemon -- the bulk wire is byte-identical through
+//! the arm + msg0, the AKE verifies, the seal/MAC/IV are byte-exact, the full EP0
+//! control-transfer set matches, the endpoint set matches, the arm timing is tighter
+//! than the daemon's -- and the dock still silently drops our encrypted CP while it
+//! engages the daemon's. The gate appears to be something not visible on the host wire
+//! (dock-internal session state, or a whole-bus timing/ordering property a per-channel
+//! diff cannot see). **If you know the DL3 / DisplayLink control-plane engagement
+//! sequence, or have ideas for the remaining paired full-bus diff, please help.**
+//!
+//! Note: `send_cp_setup` builds msg0's body field-by-field except for a small captured
+//! cap-announce skeleton ([`golden`]); a fully field-derived cap-announce is open work.
+//!
+//! Device: VID 0x17e9 (DisplayLink) / PID 0x6006 (Dell Universal Dock D6000).
+
+use kernel::{
+    alloc::flags::GFP_KERNEL,
+    bindings,
+    drm,
+    device::{self, Core},
+    error::code::{ENODEV, EINVAL},
+    prelude::*,
+    sync::{aref::ARef, Arc},
+    time::{
+        delay::{fsleep, udelay},
+        Delta, Instant, Monotonic,
+    },
+    usb,
+    workqueue::{self, impl_has_work, new_work, Work, WorkItem},
+};
+
+/// DisplayLink vendor id.
+const VID_DISPLAYLINK: u16 = 0x17e9;
+/// Dell Universal Dock D6000 (DL3 family) product id.
+const PID_D6000: u16 = 0x6006;
+
+/// Control + per-head bulk endpoints (guide sec 2).
+const EP_CTRL_OUT: u8 = 0x02;
+const EP_CTRL_IN: u8 = 0x84;
+/// EP84 (dock->host) drain buffer size. The dock's capability block can reach ~5.8 KiB, so a
+/// single bulk read needs a generously sized buffer to avoid truncating and misframing it.
+const EP84_BUF: usize = 16384;
+/// Number of IN URBs kept perpetually posted on EP84 by the async reader
+/// ([`usb::Interface::bulk_in_queue`]); `depth - 1` stay outstanding while one is serviced.
+///
+/// MEASURED 2026-06-27 (`WinCap` IRP pairing + usbmon S/C pairing): **both** reference drivers run
+/// EP84 at an outstanding depth of exactly **1** -- Windows DLM (USBPcap `max_outstanding_depth=1`)
+/// and Linux DLM (usbmon `max_depth=1`) post one IN read, wait for the dock's reply, then re-post.
+/// It is an "always one posted" reader, not a deep queue. vino was the only implementation running
+/// depth=4, so its EP84 IN-token/NAK cadence differed from every engaging driver. Match them
+/// exactly (1) -- still always-posted (re-armed on completion) but with no extra concurrent reads.
+const EP84_QUEUE_DEPTH: usize = 1;
+
+/// USB transfer timeout used during bring-up.
+fn timeout() -> Delta {
+    Delta::from_millis(1000)
+}
+
+/// Impersonate DLM's **fixed-timer** bring-up fingerprint instead of vino's reactive pacing.
+///
+/// The 2026-06-25 step-timing survey (`captures/step-timing-survey-20260625.md`) across 9 DLM
+/// and 29 vino plugs showed DLM does NOT react to the wire -- it uses hardcoded sleeps, so its
+/// pre-arm milestones are tight constants: `cp_first->cert` ~1.3 ms, `cert->arm` ~59.1 ms,
+/// `arm->msg0` ~0.17 ms. vino's reactive settle scatters those (cert->arm 57-292 ms) and, at
+/// the one step we can measure precisely, fires msg0 ~0.07 ms after the arm -- ~2x FASTER than
+/// DLM, the only consistent timing *inversion* in the whole corpus and a never-tested variable.
+///
+/// With this on, vino reproduces DLM's fingerprint as closely as the host allows:
+///   - the pre-AKE stale-EP84 flush probes at 1 ms (front gap ~1 ms, like DLM) -- see `run_ake`;
+///   - it holds the arm marker to a *fixed* [`CERT_TO_ARM_US`] after the cert (59.1 ms, like
+///     DLM) instead of arming reactively the instant the AKE settles -- see `send_cp_setup`;
+///   - it holds [`ARM_TO_MSG0`] between the arm marker and msg0 (~0.17 ms, like DLM);
+///   - it logs the realised `cp_start->arm`, `cert->arm` and the hold so the next cold plug's
+///     dmesg reports the actual fingerprint for an A/B against DLM.
+///
+/// The cert->arm hold is the key one: the 2026-06-26 corpus re-measure showed DLM's `cert->arm`
+/// is 59.11 ms +-0.5 ms across 11 plugs (a hard sleep) while vino arms reactively at ~57.9 ms --
+/// *below DLM's observed minimum* every time. So vino was consistently arming a hair ahead of the
+/// window DLM ever uses; the fixed hold closes that and makes the step deterministic.
+///
+/// Default ON: this is the one timing combination we have never put on the wire simultaneously.
+/// Flip to `false` to restore the reactive pacing for a clean paired diff.
+const DLM_FIXED_TIMERS: bool = true;
+
+/// Mimic the Windows DisplayLink driver's pre-arm control choreography instead of the Linux/libusb
+/// DLM one (2026-06-27, `WinCap/WINCAP-ANALYSIS.md`). The USBPcap traces of three engaging Windows
+/// sessions on this exact dock (`bcdDevice=0x3159`) showed a *leaner* device-open than DLM's libusb
+/// stack, on three concrete, observable axes:
+///   1. ONE device-open vendor-IN read -- only `0xc1 0xfe wIdx=1` (the 16 B "RidgeDock" blob).
+///      Windows never issues the `0xfc`/`0xfd`/`0xfb` DFU reads vino picked up from the DLM oracle.
+///   2. NO libusb descriptor-burst at open (the CONFIG 618x3/40x3 + STRING 255x22 replay): Windows
+///      runs over the already-enumerated device and uses cached descriptors, exactly like a native
+///      kernel driver -- so [`CP_LIBUSB_OPEN_ENUM`] is forced OFF.
+///   3. The `0x40 bReq=0x24` vendor-OUT uses **wValue=0** (Windows), not wValue=3 (Linux DLM/vino).
+/// The analysis already proved none of these is the CP gate (Linux DLM engages WITH the libusb burst
+/// and wValue=3; Windows engages WITHOUT them) -- so this is a "just in case" A/B, not a fix. It is
+/// the smallest set of changes that makes vino's EP0 pre-arm stream resemble Windows'. The cap-
+/// announce / cert-req framing is left alone (changing it risks the byte-exact seal, and both DLM's
+/// 7-descriptor form -- which vino matches -- and Windows' 6-descriptor form engage). Flip to `false`
+/// to restore the DLM/libusb behaviour for a clean paired-vs-DLM diff.
+const WINDOWS_MIMIC: bool = true;
+
+/// DLM's `cert->arm` hold: 59.11 ms median, [58.74..59.84] over 11 DLM cold plugs (2026-06-26
+/// corpus re-measure) -- a hardcoded sleep, not a reaction. Under [`DLM_FIXED_TIMERS`],
+/// `send_cp_setup` holds the arm marker until this long after `Session::cert_at` so vino arms on
+/// DLM's fixed schedule instead of the moment its AKE happens to finish (~57.9 ms, always early).
+const CERT_TO_ARM_US: i64 = 59_100;
+
+/// DLM's `ctr2->ctr3` gap (AKE_Transmitter_Info -> AKE_No_Stored_km): consistently **~1.65 ms**
+/// over 6 cold plugs [1.55..1.89], vs vino's **~0.30 ms** (5x faster, and rock-steady across both
+/// corpora -- 2026-06-26 per-message latency analysis vs the same-day engaging DLM baseline). This
+/// is the window where a real HDCP transmitter **verifies the receiver's DCP-signed certificate**
+/// (RSA-1024 signature check + revocation) before wrapping `km`; vino skips it -- it only
+/// RSA-OAEP-encrypts `km`, which is why it is so much faster. It is the first consistent,
+/// host-reachable behavioural divergence from DLM found since the host was declared "exhausted",
+/// and it fits the wall's evidence box (invisible to a passive byte diff; DLM satisfies it for
+/// free; a repeater could time it as a locality-style "did you actually validate me?" check).
+/// Under [`DLM_FIXED_TIMERS`], hold `ctr2->ctr3` to this so vino spends a realistic cert-verify
+/// time instead of answering impossibly fast.
+const CERT_VERIFY_HOLD_US: i64 = 1650;
+
+/// DLM's median `arm->msg0` gap (the survey: 0.152 / 0.188 ms on the two clean DLM cold plugs).
+/// vino naturally fires msg0 ~0.07 ms after the arm; hold to match DLM when [`DLM_FIXED_TIMERS`].
+const ARM_TO_MSG0: Delta = Delta::from_micros(170);
+
+/// Per-frame send pads that reproduce DLM's `cp_first->cert` cadence (2026-06-26 frame-by-frame
+/// diff of the plaintext session-init + AKE_Init burst). With the cold-plug flush removed, vino's
+/// sync `bulk_send`s fire back-to-back ~0.37 ms QUICKER than DLM's pipelined libusb URBs, so
+/// `cp_first->cert` was 0.64 ms vs DLM's 1.07 ms. Each pad is the measured per-gap deficit
+/// (vino gap -> DLM gap): init_0->init_25 0.065->0.144, init_25->init_4 0.194->0.372,
+/// session-init-ACK->AKE_Init 0.043->0.159. Applied as `udelay` (calibrated busy-wait, us-precise,
+/// unlike `fsleep`'s slack) only under [`DLM_FIXED_TIMERS`]. Sum 0.373 ms lands `cp_first->cert`
+/// on DLM's ~1.07 ms.
+const PAD_INIT0_TO_INIT25_US: i64 = 79;
+const PAD_INIT25_TO_INIT4_US: i64 = 120;
+const PAD_ACK_TO_AKEINIT_US: i64 = 90;
+
+/// Post-enumeration idle hold (2026-06-26). From `SET_CONFIGURATION` to the first CP frame, vino
+/// (an in-kernel driver that probes the instant the device is configured) responds in ~4.8 ms,
+/// whereas DLM -- a userspace daemon behind evdi that the OS must notify, schedule and have open
+/// the device -- takes ~15.5 ms (14.6/16.3 ms over two cold plugs). That ~10.7 ms is pure
+/// userspace-startup latency, the one place vino is *dramatically* faster than DLM rather than
+/// within sub-ms noise. Under [`DLM_FIXED_TIMERS`], idle this long at the very top of `bring_up`
+/// (before any USB transaction) so vino's enumeration-to-first-CP response matches DLM's ~15 ms
+/// instead of beating it 3x -- closing the last large timing divergence from DLM's fingerprint.
+const ENUM_RESPONSE_HOLD_US: i64 = 9_800;
+
+/// Hold until `anchor` is at least `target_us` old, to microsecond precision. A plain `fsleep`
+/// overshoots a wall-clock target by its timer slack (the cert->arm hold targeted 59.1 ms but
+/// `fsleep` alone landed it at 59.4 ms); so `fsleep` the bulk of the wait (cheap -- it must not
+/// busy-burn ~1 ms of CPU) leaving a margin, then re-measure and `udelay` the exact residual to
+/// hit `target_us` on the nose. Never returns before `target_us` of `anchor` has elapsed; returns
+/// immediately if it already has. Used to realise DLM's fixed pre-arm timer (`DLM_FIXED_TIMERS`).
+fn hold_until(anchor: Instant<Monotonic>, target_us: i64) {
+    /// Leave this much for the precise `udelay` tail; `fsleep`'s slack stays under it.
+    const SPIN_MARGIN_US: i64 = 400;
+    let now = anchor.elapsed().as_micros_ceil();
+    if now >= target_us {
+        return;
+    }
+    if target_us - now > SPIN_MARGIN_US {
+        fsleep(Delta::from_micros(target_us - now - SPIN_MARGIN_US));
+    }
+    let now = anchor.elapsed().as_micros_ceil();
+    if now < target_us {
+        udelay(Delta::from_micros(target_us - now));
+    }
+}
+
+/// Set once the dock has actually engaged the CP cipher (`wsub=0x45` acks > 0). EP08 video is
+/// gated on it: pushing frames at a dock whose CP channel is dead makes it fault and USB-reset.
+/// NOTE: with the current CP-engagement wall (see the file header) this is never set on real
+/// hardware -- the dock runs the whole plaintext handshake but never engages the encrypted CP.
+static CP_ENGAGED: core::sync::atomic::AtomicBool = core::sync::atomic::AtomicBool::new(false);
+
+/// One-shot: clear-halt + prime the video endpoints before the first live-scanout EP08 write.
+static EP08_SCANOUT_PRIMED: core::sync::atomic::AtomicBool =
+    core::sync::atomic::AtomicBool::new(false);
+
+/// Select the live scanout codec. `false` (default) = the RLE/mode-2 path (`video::Encoder`),
+/// which is what the dock currently runs and which the dock NAKs pre-CP anyway. `true` = the
+/// byte-exact Vino WHT **colour** codec (`video::wht::colour_frame_ep08`), the bandwidth-efficient
+/// DLM-quality path. Kept a compile-time flag (default off) so the RLE path stays the live default
+/// and the switch is testable independently the moment the CP wall falls; the WHT path needs a
+/// 64x16-aligned mode and falls back to RLE otherwise (see `docs/VIDEO-TODO.md`).
+const EP08_WHT_CODEC: bool = false;
+
+/// Consecutive failed live-scanout frames, for log rate-limiting. Until CP engages, the dock
+/// NAKs every EP08 write (EPROTO), so without this every compositor pageflip would spam dmesg.
+static SCANOUT_FAILS: core::sync::atomic::AtomicU64 = core::sync::atomic::AtomicU64::new(0);
+
+/// Pageflip throttle: number of upcoming pageflips to skip before the next scanout attempt
+/// (a backoff while the dock NAKs). A single successful frame clears it.
+static SCANOUT_SKIP: core::sync::atomic::AtomicU64 = core::sync::atomic::AtomicU64::new(0);
+
+/// Set once the bring-up work item finishes (AKE/CP attempt done). `detect` only connects the
+/// live-scanout connector AFTER this, so a compositor enabling the output cannot start EP08
+/// scanout on top of the still-running AKE on the same USB device.
+static BRINGUP_COMPLETE: core::sync::atomic::AtomicBool =
+    core::sync::atomic::AtomicBool::new(false);
+
+mod proto;
+mod crypto;
+mod rng;
+mod hdcp;
+mod ake;
+mod golden;
+mod cp;
+mod video;
+
+/// The shared secrets a completed HDCP 2.2 AKE leaves behind: the SKE session key
+/// `ks` and content IV `riv` key the AES-CTR control plane (sec 6), and `kd` is kept
+/// for any further repeater verification. Consumed by the Phase 2b/2c CP + video.
+#[allow(dead_code)] // ks/riv/kd are consumed by the post-engagement CP stream (open blocker)
+struct Session {
+    ks: [u8; 16],
+    riv: [u8; 8],
+    kd: [u8; 32],
+    /// The 7-frame **plaintext capability-announce** to send between the init markers and
+    /// the arm marker (see `VinoDriver::build_cap_announce`). Built LIVE
+    /// from this session's AKE values (rtx/ekpub/rn/edkey+riv/V) -- NOT a stale replay. Empty
+    /// for a non-repeater dock (the announce path is only exercised on the D6000, repeater=1).
+    cap_announce: KVec<u8>,
+    /// Monotonic timestamp of the first CP frame (~`cp_first` in the timing survey), taken at
+    /// the top of [`run_ake`]. Used by [`send_cp_setup`] to realise DLM's fixed pre-arm timer
+    /// and to log the achieved `cp_start->arm` fingerprint. See [`DLM_FIXED_TIMERS`].
+    cp_start: Instant<Monotonic>,
+    /// Monotonic timestamp of the dock's `AKE_Send_Cert` push (`cert` in the timing survey),
+    /// taken the instant [`run_ake`] receives it. DLM arms a *fixed* [`CERT_TO_ARM_US`] after
+    /// this point (59.1 ms, +-0.5 ms over 11 cold plugs -- a hardcoded sleep), whereas vino's
+    /// reactive settle arms the moment the AKE completes (~57.9 ms -- consistently *earlier*
+    /// than DLM's tightest run). [`send_cp_setup`] holds the arm to this offset under
+    /// [`DLM_FIXED_TIMERS`] so vino never arms ahead of DLM's window. See [`DLM_FIXED_TIMERS`].
+    cert_at: Instant<Monotonic>,
+}
+
+mod drm_sink;
+
+/// Per-bound-interface driver state.
+struct VinoDriver {
+    _intf: ARef<usb::Interface>,
+    /// The registered `drm::Device` (only on the control interface, iface 0).
+    _ddev: Option<ARef<drm_sink::VinoDrmDevice>>,
+    /// A handle to the deferred bring-up work (control interface only), retained so
+    /// [`disconnect`](VinoDriver::disconnect) can `cancel_work_sync()` it: the work
+    /// does blocking USB I/O on the bound interface, so it must be flushed before the
+    /// interface is unbound (otherwise `Interface::as_bound` in `BringUp::run` would
+    /// touch an unbound interface). `None` on the idle sibling interface.
+    bringup: Option<Arc<BringUp>>,
+}
+
+/// Deferred bring-up work item: the bring-up sequence run on the system workqueue instead
+/// of inline in `probe()` (which would pin the driver-model probe thread on blocking USB
+/// I/O while the card node is live). Holds a refcounted handle to the bound interface (and,
+/// once the DRM sink exists, the DRM device), so they outlive `probe()`.
+#[pin_data]
+struct BringUp {
+    intf: ARef<usb::Interface>,
+    ddev: Option<ARef<drm_sink::VinoDrmDevice>>,
+    #[pin]
+    work: Work<BringUp>,
+}
+
+impl_has_work! {
+    impl HasWork<Self> for BringUp { self.work }
+}
+
+impl BringUp {
+    fn new(
+        intf: ARef<usb::Interface>,
+        ddev: Option<ARef<drm_sink::VinoDrmDevice>>,
+    ) -> Result<Arc<Self>> {
+        Arc::pin_init(
+            pin_init!(BringUp {
+                intf,
+                ddev,
+                work <- new_work!("vino::bring_up"),
+            }),
+            GFP_KERNEL,
+        )
+    }
+}
+
+impl WorkItem for BringUp {
+    type Pointer = Arc<BringUp>;
+
+    fn run(this: Arc<BringUp>) {
+        let cdev: &device::Device = this.intf.as_ref();
+        // SAFETY: `BringUp` holds an `ARef<usb::Interface>` taken in `probe()`; the
+        // work item is cancelled and flushed in `disconnect()` before the interface
+        // is unbound (see `VinoDriver::disconnect`), so it stays bound for this run.
+        let dev: &usb::Interface<device::Bound> = unsafe { this.intf.as_bound() };
+        let ddev = &this.ddev;
+        // WIP scaffold: attempt the plaintext bring-up, then the clean-room HDCP 2.2
+        // AKE/LC/SKE, then the post-SKE CP setup. Bind regardless of the outcome -- there
+        // is no display path until the dock engages the encrypted control plane, which it
+        // currently never does (see the "help wanted" note at the top of the file).
+        match VinoDriver::bring_up(dev) {
+            Ok(()) => {
+                dev_info!(cdev, "vino: plaintext session init OK\n");
+                match VinoDriver::run_ake(dev) {
+                    Ok(session) => {
+                        dev_info!(cdev, "vino: HDCP AKE + LC + SKE complete (session keyed)\n");
+                        // Dev diagnostic: the live session key/riv, so the dock's encrypted
+                        // EP84 replies can be decoded offline from a usbmon capture. Behind
+                        // pr_debug, so compiled out unless dynamic debug is enabled.
+                        pr_debug!("vino: SESSION ks={:02x?} riv={:02x?}\n", &session.ks, &session.riv);
+
+                        // Phase 2c: drive the post-SKE CP setup. send_cp_setup re-seals
+                        // DLM's captured setup template under THIS session's live ks/riv and
+                        // sends it; `acks` counts the dock's encrypted wsub=0x45 replies.
+                        // THIS IS THE WALL: on a cold dock `acks` stays 0 -- the dock runs the
+                        // entire plaintext handshake but never engages the encrypted CP.
+                        let mut edid_out: Option<KVec<u8>> = None;
+                        match VinoDriver::send_cp_setup(dev, &session, &mut edid_out) {
+                            Ok((n, acks, wseq_end, ctr_end)) => {
+                                dev_info!(cdev,
+                                    "vino: CP setup sent -- {n} messages, {acks} dock CP acks (wsub=0x45)\n");
+                                // CP engagement gates EP08 video: until the dock acks, pushing
+                                // pixels at it wedges the hub.
+                                CP_ENGAGED.store(acks > 0, core::sync::atomic::Ordering::SeqCst);
+                                // Publish the engaged session to the DRM device so the KMS
+                                // callbacks
+                                // can send runtime CP (mode-set on a modeset, cursor on motion),
+                                // continuing this keystream. Only when the dock actually engaged.
+                                if acks > 0 {
+                                    if let Some(d) = ddev.as_ref() {
+                                        let data: &drm_sink::VinoDrmData = d;
+                                        data.publish_session(
+                                            &session.ks, &session.riv, wseq_end, ctr_end,
+                                        );
+                                    }
+                                }
+                            }
+                            Err(e) => dev_info!(cdev, "vino: CP setup incomplete ({e:?}) -- WIP\n"),
+                        }
+                        // Cache the dock's EDID on the DRM device (when the CP channel
+                        // delivered it) so the connector's get_modes installs the real
+                        // monitor descriptor via the standard DRM EDID helpers.
+                        if let (Some(blob), Some(d)) = (edid_out, ddev.as_ref()) {
+                            let n = blob.len();
+                            let dev: &drm_sink::VinoDrmDevice = d;
+                            let data: &drm_sink::VinoDrmData = dev;
+                            data.set_edid(dev, blob);
+                            dev_info!(cdev, "vino: cached dock EDID for connector ({n} bytes)\n");
+                        }
+                    }
+                    Err(e) => dev_info!(cdev, "vino: HDCP AKE incomplete ({e:?}) -- WIP\n"),
+                }
+            }
+            Err(e) => dev_info!(cdev, "vino: session init incomplete ({e:?}) -- WIP\n"),
+        }
+        // Bring-up attempt finished: allow the live-scanout connector to report connected
+        // and let a compositor drive EP08 frames, without racing the handshake.
+        BRINGUP_COMPLETE.store(true, core::sync::atomic::Ordering::SeqCst);
+        if let Some(d) = ddev.as_ref() {
+            let dev: &drm_sink::VinoDrmDevice = d;
+            dev.hotplug_event();
+            dev_info!(cdev, "vino: bring-up complete -- live-scanout connector now connected\n");
+        }
+    }
+}
+
+/// On-device crypto known-answer self-test. Confirms the IN-KERNEL crypto path (which the CP seal
+/// depends on) is byte-correct -- something only ever checked offline (Python `verify-kdf.py`)
+/// before.
+/// Runs three checks and logs PASS/FAIL:
+///   1. AES-128-ECB vs the FIPS-197 test vector.
+///   2. AES-CMAC vs the RFC 4493 test vector (subkey + full-block path).
+///   3. The full `cp::seal_livemac` vs cold-ref's REAL msg0: known plaintext + known `ks`/`riv`
+///      must reproduce the captured wire ciphertext+tag byte-for-byte. A FAIL here (with 1+2
+///      passing) would localize a bug in our seal framing; a FAIL in 1/2 means the kernel
+///      primitive itself is wrong. If all PASS, the crypto we send is correct and the
+///      CP-engagement wall is NOT our crypto.
+fn crypto_selftest() {
+    use core::sync::atomic::{AtomicBool, Ordering};
+    static RAN: AtomicBool = AtomicBool::new(false);
+    if RAN.swap(true, Ordering::Relaxed) {
+        return;
+    }
+
+    // 1. AES-128-ECB KAT (FIPS-197 Appendix B / C.1).
+    let ecb_key = [
+        0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07, 0x08, 0x09, 0x0a, 0x0b, 0x0c, 0x0d, 0x0e,
+        0x0f,
+    ];
+    let ecb_pt = [
+        0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd, 0xee,
+        0xff,
+    ];
+    let ecb_expect = [
+        0x69, 0xc4, 0xe0, 0xd8, 0x6a, 0x7b, 0x04, 0x30, 0xd8, 0xcd, 0xb7, 0x80, 0x70, 0xb4, 0xc5,
+        0x5a,
+    ];
+    match crypto::aes128_ecb(&ecb_key, &ecb_pt) {
+        Ok(out) if out == ecb_expect => pr_info!("vino: selftest AES-128-ECB PASS\n"),
+        Ok(out) => pr_err!("vino: selftest AES-128-ECB FAIL got={out:02x?}\n"),
+        Err(e) => pr_err!("vino: selftest AES-128-ECB ERR ({e:?})\n"),
+    }
+
+    // 2. AES-CMAC KAT (RFC 4493 sec 4 example 2: a single 16-byte block).
+    let cmac_key = [
+        0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf, 0x4f,
+        0x3c,
+    ];
+    let cmac_msg = [
+        0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93, 0x17,
+        0x2a,
+    ];
+    let cmac_expect = [
+        0x07, 0x0a, 0x16, 0xb4, 0x6b, 0x4d, 0x41, 0x44, 0xf7, 0x9b, 0xdd, 0x9d, 0xd0, 0x4a, 0x28,
+        0x7c,
+    ];
+    match crypto::aes_cmac(&cmac_key, &cmac_msg) {
+        out if out == cmac_expect => pr_info!("vino: selftest AES-CMAC PASS\n"),
+        out => pr_err!("vino: selftest AES-CMAC FAIL got={out:02x?}\n"),
+    }
+
+    // 3. Full seal_livemac vs cold-ref's REAL msg0 (capture t=36.813765). ks/riv are the cold-ref
+    // session's; content is msg0's 32-byte plaintext; the expected frame is the captured wire.
+    let ks = [
+        0xd8, 0xb2, 0x48, 0x12, 0x44, 0x1d, 0x50, 0x82, 0x0d, 0xa3, 0xc2, 0x71, 0xc7, 0xa3, 0x6e,
+        0xc2,
+    ];
+    let riv = [0xfb, 0xa7, 0xc3, 0x5f, 0xe6, 0xce, 0x40, 0xec];
+    let header = [
+        0x00, 0x00, 0x3c, 0x00, 0x04, 0x00, 0x00, 0x00, 0x24, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x00,
+        0x00,
+    ];
+    let content = [
+        0x14, 0x00, 0x00, 0x00, 0x08, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x56, 0x48, 0xec, 0x9c, 0xec, 0xc3, 0x89, 0x23,
+        0x5d, 0x69,
+    ];
+    let expect = [
+        0x00, 0x00, 0x3c, 0x00, 0x04, 0x00, 0x00, 0x00, 0x24, 0x00, 0x0a, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0xcb, 0x4c, 0x80, 0xde, 0xf0, 0xd0, 0xfd, 0x56, 0x22, 0x5f, 0x43, 0xbd, 0x55, 0x0d,
+        0x8e, 0xc5, 0x7a, 0x1c, 0x35, 0x12, 0x81, 0x35, 0x31, 0x1a, 0x45, 0x13, 0x91, 0x41, 0x25,
+        0x87, 0xe9, 0xf7, 0xe5, 0x5b, 0xb5, 0xbc, 0x76, 0x5b, 0x2f, 0x1e, 0x79, 0xf2, 0x8b, 0xd5,
+        0x5b, 0x2c, 0x3c, 0xe7,
+    ];
+    match cp::seal_livemac(&ks, &riv, &header, &content) {
+        Ok(frame) if frame.as_slice() == expect.as_slice() => {
+            pr_info!("vino: selftest seal_livemac(msg0) PASS -- CP crypto reproduces cold-ref wire\n")
+        }
+        Ok(frame) => {
+            // Show where it first diverges so a framing/order bug is localizable.
+            let mut at = frame.len().min(expect.len());
+            for i in 0..at {
+                if frame[i] != expect[i] {
+                    at = i;
+                    break;
+                }
+            }
+            pr_err!(
+                "vino: selftest seal_livemac(msg0) FAIL at byte {at} (len {} vs {})\n",
+                frame.len(),
+                expect.len()
+            );
+            let s = at.saturating_sub(0);
+            let e = (at + 16).min(frame.len());
+            pr_err!("vino:   got[{s}..]={:02x?}\n", &frame[s..e]);
+            let e2 = (at + 16).min(expect.len());
+            pr_err!("vino:   exp[{s}..]={:02x?}\n", &expect[s..e2]);
+        }
+        Err(e) => pr_err!("vino: selftest seal_livemac(msg0) ERR ({e:?})\n"),
+    }
+}
+
+impl VinoDriver {
+    /// Plaintext session bring-up (sec 4): control-request preamble then the three
+    /// bulk init messages, reading the single ACK. Best-effort during scaffold
+    /// bring-up -- errors are logged, not fatal.
+    fn bring_up(dev: &usb::Interface<device::Bound>) -> Result {
+        // Post-enumeration idle hold: match DLM's ~15 ms userspace-daemon startup latency from
+        // SET_CONFIGURATION to the first CP frame (vino, in-kernel, otherwise responds in ~4.8 ms).
+        // Placed before ANY USB transaction so vino sits idle like DLM's daemon waiting to be
+        // scheduled, then bursts. fsleep is fine here -- DLM's own latency spans 14.6..16.3 ms, far
+        // wider than fsleep's slack. See [`ENUM_RESPONSE_HOLD_US`].
+        if DLM_FIXED_TIMERS {
+            fsleep(Delta::from_micros(ENUM_RESPONSE_HOLD_US));
+        }
+
+        // Verify the KERNEL crypto path is byte-correct before we rely on it for CP. The KDF was
+        // only ever checked offline (Python); this confirms the in-kernel AES-ECB, AES-CMAC and the
+        // full `seal_livemac` reproduce ground-truth vectors on THIS device. Logs PASS/FAIL once.
+        crypto_selftest();
+
+        // Control-request preamble (sec 4): dock-id read, interface selection, then the
+        // vendor_out 0x24 / vendor_in 0x22 pairs that kick off the HDCP path. (The
+        // GET_DESCRIPTOR string reads DLM also issues look cosmetic and are omitted.)
+        const VENDOR_OUT: u8 = 0x40; // host->dev, vendor, device
+        const VENDOR_IN_IFACE: u8 = 0xc1; // dev->host, vendor, INTERFACE recipient (DLM's choice)
+
+        // The DLM-style vendor preamble (sec 4). Per the userspace oracle, every
+        // control request here is **best-effort**: the dock legitimately STALLs
+        // some of them (e.g. the cosmetic dock-id read) yet still advances its
+        // host-identification state. The oracle tolerates each error and relies
+        // on DLM's inter-request timing gaps -- without those gaps the dock may
+        // not advance. So we log-and-continue on every control step and insert
+        // the same delays; only the bulk init + ACK is treated as load-bearing.
+        // GROUND-TRUTH 2026-06-13: at device-open DLM issues two vendor-IN reads on interface 1,
+        // recipient 0xc1, BEFORE the SET_INTERFACE / 0x24 / 0x22 sequence (dlm-cold-20260611-123347
+        // f708 `0xc1 0xfe wIdx=1` -> 16 B "RidgeDock" blob; f710 `0xc1 0xfc wIdx=1` -> 0 B). vino
+        // skipped them; the earlier attempt used recipient 0xc0 (device) and STALLed, which was
+        // misread as "the dock rejects 0xfe / DLM never sends it". Issue them here with the correct
+        // 0xc1 recipient. Best-effort: log and continue (the dock may still short/stall 0xfc).
+        let mut dock_id = [0u8; 16];
+        match dev.control_recv(0xfe, VENDOR_IN_IFACE, 0, 1, &mut dock_id, timeout(), GFP_KERNEL) {
+            Ok(()) => pr_info!("vino: step device-open 0xfe(iface1) OK = {:02x?}\n", dock_id),
+            Err(e) => pr_info!("vino: step device-open 0xfe(iface1) non-fatal ({e:?})\n"),
+        }
+        // Windows issues ONLY the single `0xfe` device-open read above; the `0xfc`/`0xfd`/`0xfb`
+        // DFU reads are a DLM-oracle addition vino picked up. Skip them under [`WINDOWS_MIMIC`] to
+        // match the Windows EP0 stream (they are diagnostic-only and CP-irrelevant either way).
+        if !WINDOWS_MIMIC {
+            let mut probe3 = [0u8; 3];
+            match dev.control_recv(0xfc, VENDOR_IN_IFACE, 0, 1, &mut probe3, timeout(), GFP_KERNEL) {
+                Ok(()) => pr_info!("vino: step device-open 0xfc(iface1) OK = {:02x?}\n", probe3),
+                Err(e) => pr_info!("vino: step device-open 0xfc(iface1) non-fatal ({e:?})\n"),
+            }
+            // DFU firmware-version query, matching DLM / the macOS+Windows drivers'
+            // DfuGetVmmDeviceFirmwareVersion: vendor IN bmRequestType=0xc1 bRequest=0xfd wIndex=1,
+            // a 6-byte version blob (the reference driver's request-size table: 0xfb=4
+            // customer/board, 0xfc=3 device-type, 0xfd=6 firmware-version, 0xfe=16 descriptor). This
+            // is a device-level DFU read, independent of the CP channel, so it works regardless of
+            // CP engagement -- handy for diagnostics and confirming the dock firmware revision.
+            let mut fw_ver = [0u8; 6];
+            match dev.control_recv(0xfd, VENDOR_IN_IFACE, 0, 1, &mut fw_ver, timeout(), GFP_KERNEL) {
+                Ok(()) => pr_info!("vino: dock DFU firmware version = {:02x?}\n", fw_ver),
+                Err(e) => pr_info!("vino: device-open 0xfd(firmware-version) non-fatal ({e:?})\n"),
+            }
+            // DFU customer/board id (DfuGetVmmDeviceCustomerAndBoardId): bRequest=0xfb, 4-byte blob.
+            let mut cust_board = [0u8; 4];
+            match dev.control_recv(0xfb, VENDOR_IN_IFACE, 0, 1, &mut cust_board, timeout(), GFP_KERNEL) {
+                Ok(()) => pr_info!("vino: dock DFU customer/board id = {:02x?}\n", cust_board),
+                Err(e) => pr_info!("vino: device-open 0xfb(customer/board) non-fatal ({e:?})\n"),
+            }
+        }
+
+        // EXPERIMENT (2026-06-16): replay DLM's repeated STRING-descriptor reads at device-open.
+        // Timing analysis of the paired cold capture (captures/paired-coldbus-20260615-220311)
+        // shows DLM, beyond the distinct descriptor SET vino already issues, re-reads STRING idx0
+        // (language-ID list) and idx3 (en-US product, langid 0x0409), 255 B each, at ~2/sec for the
+        // ENTIRE 175 s session -- a 1 Hz host string-poll heartbeat. Engagement happens in the
+        // first
+        // second, so this is almost certainly NOT a pre-AKE gate (the distinct set already
+        // matches),
+        // but the repetition was never A/B-tested by replay the way the 0xfe/0xfc reads were. Issue
+        // a
+        // small burst here, BEFORE the AKE, to test whether the dock conditions CP engagement on
+        // seeing the host poll its strings. Best-effort: the kernel reports EREMOTEIO on the
+        // expected
+        // short reply, but the GET_DESCRIPTOR still reaches the wire, which is all the experiment
+        // needs.
+        // RESULT 2026-06-16 (paired-coldbus-20260616-162650): the pre-arm GET_DESCRIPTOR delta is
+        // USB ENUMERATION, not application protocol. Both captures contain an identical 3x 8-byte +
+        // 7x 18-byte DEVICE-descriptor read sequence -- which no kernel driver issues (it is the
+        // enumeration handshake the USB core runs each time the dock re-enumerates on the cold
+        // plug, plus DisplayLink's leftover /opt/displaylink/udev.sh hook firing per uevent).
+        // Proven to be enumeration, not the DLM daemon: the vino capture reproduces the SAME reads
+        // with displaylink-driver.service masked and no DisplayLinkManager process running. It is
+        // symmetric across both runs, so it is neither a DLM-vs-vino difference nor the engagement
+        // gate. This speculative burst only ADDED vino-issued reads on top, so disable it.
+        // -- LIBUSB-STYLE DEVICE-OPEN ENUMERATION (2026-06-17)
+        // ----------------------------------
+        // The clean paired capture (paired-coldbus-20260616-180401) isolated the LAST pre-AKE
+        // divergence from DLM to ONE thing: DLM (libusb) re-reads the dock's full descriptor set
+        // when it opens the device -- DEVICE(18), CONFIG(9 then full ~618), STRING langid(idx0),
+        // then every STRING index the descriptors reference (~22x 255B) -- right before the AKE.
+        // A
+        // kernel driver normally skips this (the USB core cached it at enumeration), which is why
+        // vino's pre-arm control stream was missing it (the "DLM-ONLY 255x22 / 618 / 40"
+        // residual).
+        // These reads are CP-irrelevant descriptor boilerplate. The cold-plug A/B proved the dock
+        // does NOT gate CP on them (replaying them byte-for-byte still gave 0x wsub=0x45 -- see
+        // project_get_descriptor_burst_experiment / the firmware-wall verdict), and the in-kernel
+        // Windows (WDF) and macOS (IOUSBLib) drivers DON'T issue this burst either -- like vino
+        // they run over an already-enumerated device and use the USB core's cached descriptors.
+        // The burst is therefore a libusb-userspace artifact, not something the dock expects.
+        // Default OFF so vino behaves like a native kernel driver; flip to `true` only to reproduce
+        // DLM's libusb wire for a paired A/B diff. Best-effort throughout: a STALL/EREMOTEIO on an
+        // absent index is fine -- EP0 auto-recovers and the SETUP still reaches the wire (all the
+        // A/B diff needs). Reproduces (histogram diff DLM vs vino, paired-coldbus-20260616-180401):
+        // DLM's libusb open adds CONFIG-full(618)x3, CONFIG-partial(40)x3, STRING(255)x22, with
+        // no
+        // extra DEVICE(18)/CONFIG(9).
+        // Windows (like a native kernel driver) does NOT replay this libusb descriptor burst, so
+        // [`WINDOWS_MIMIC`] forces it off; otherwise default ON to reproduce DLM's libusb open.
+        const CP_LIBUSB_OPEN_ENUM: bool = !WINDOWS_MIMIC;
+        if CP_LIBUSB_OPEN_ENUM {
+            let mut tmp = [0u8; 255];
+            let mut cfg = KVec::from_elem(0u8, 618, GFP_KERNEL)?;
+            // CONFIG full (618) x3 -- parse the first to find real string indices so the STRING
+            // reads
+            // below return data (matching DLM's byte counts), not just the SETUP counts.
+            for _ in 0..3 {
+                let _ = dev.control_recv(0x06, 0x80, 0x0200, 0, &mut cfg, timeout(), GFP_KERNEL);
+            }
+            // CONFIG partial (40) x3.
+            for _ in 0..3 {
+                let _ = dev.control_recv(0x06, 0x80, 0x0200, 0, &mut tmp[..40], timeout(), GFP_KERNEL);
+            }
+            // STRING idx0 = language-ID list (1st of the 22x 255 reads); adopt the dock's REAL
+            // langid.
+            let mut langid = 0x0409u16;
+            if dev.control_recv(0x06, 0x80, 0x0300, 0, &mut tmp, timeout(), GFP_KERNEL).is_ok() && tmp[0] >= 4 {
+                langid = (tmp[2] as u16) | ((tmp[3] as u16) << 8);
+            }
+            // String indices referenced by the config (iConfiguration @off6, iInterface @off8).
+            let mut idxs = [0u8; 64];
+            let mut ni = 0usize;
+            let mut p = 0usize;
+            while p + 2 <= cfg.len() {
+                let blen = cfg[p] as usize;
+                if blen == 0 {
+                    break;
+                }
+                let btype = cfg[p + 1];
+                if btype == 0x02 && p + 7 <= cfg.len() && cfg[p + 6] != 0 && ni < idxs.len() {
+                    idxs[ni] = cfg[p + 6];
+                    ni += 1;
+                }
+                if btype == 0x04 && p + 9 <= cfg.len() && cfg[p + 8] != 0 && ni < idxs.len() {
+                    idxs[ni] = cfg[p + 8];
+                    ni += 1;
+                }
+                p += blen;
+            }
+            // 21 more STRING(255) reads (idx0 above makes 22 total = DLM's count). Cycle the real
+            // referenced indices so each returns data; DLM likewise re-reads indices.
+            let mut nok = 0usize;
+            for k in 0..21usize {
+                let i = if ni > 0 { idxs[k % ni] as u16 } else { 1 + k as u16 };
+                if dev
+                    .control_recv(0x06, 0x80, 0x0300 | i, langid, &mut tmp, timeout(), GFP_KERNEL)
+                    .is_ok()
+                {
+                    nok += 1;
+                }
+            }
+            pr_info!(
+                "vino: libusb-open enum: config 618x3 + 40x3, langid={langid:#06x}, strings 22 ({nok} ok of {ni} refs)\n"
+            );
+        }
+
+        // SET_INTERFACE: DLM's two handshake SET_INTERFACEs target iface 1 (alt 0,
+        // app-specific/DFU) then iface 0 (alt 0, vendor) -- confirmed by a clean cold
+        // DLM usbmon capture (captures/dlm-cold-20260611-123347, t=52.079/52.085).
+        // The old code set iface 4 (the microphone) which DLM NEVER touches in the
+        // handshake (the 58 audio SET_INTERFACEs in a session are snd-usb-audio's, not
+        // DLM's -- see project_cp_setinterface_is_audio_binding_fix).
+        match dev.set_interface(1, 0) {
+            Ok(()) => pr_info!("vino: step set_interface(1,0) OK\n"),
+            Err(e) => pr_info!("vino: step set_interface(1,0) non-fatal ({e:?})\n"),
+        }
+        match dev.set_interface(0, 0) {
+            Ok(()) => pr_info!("vino: step set_interface(0,0) OK\n"),
+            Err(e) => pr_info!("vino: step set_interface(0,0) non-fatal ({e:?})\n"),
+        }
+        // vendor_out 0x24 (initial ack) then vendor_in 0x22 (state read, wValue=1 -- DLM's exact
+        // value; wValue=0 STALLs). Both best-effort: the dock advances state regardless and the
+        // oracle tolerates failure here. The OUT's wValue is the one observable divergence: Linux
+        // DLM (and vino) use wValue=3, the Windows driver uses wValue=0 -- both engage, so
+        // [`WINDOWS_MIMIC`] just picks Windows' value for the A/B.
+        let w24: u16 = if WINDOWS_MIMIC { 0 } else { 3 };
+        match dev.control_send(0x24, VENDOR_OUT, w24, 0, &[], timeout(), GFP_KERNEL) {
+            Ok(()) => pr_info!("vino: step 0x24(wValue={w24}) OK\n"),
+            Err(e) => pr_info!("vino: step 0x24(wValue={w24}) non-fatal ({e:?})\n"),
+        }
+        // 0xc1 = IN|vendor|INTERFACE recipient (NOT 0xc0, device recipient): DLM's cold capture
+        // uses
+        // bmRequestType=0xc1, wIndex=0 (interface 0). wValue=1 (DLM's value; 0 stalls). Uses the
+        // function-scope `VENDOR_IN_IFACE` declared in the device-open preamble above.
+        let mut state = [0u8; 28];
+        match dev.control_recv(0x22, VENDOR_IN_IFACE, 1, 0, &mut state, timeout(), GFP_KERNEL) {
+            Ok(()) => pr_info!("vino: step 0x22(wValue=1) OK = {:02x?}\n", state),
+            Err(e) => pr_info!("vino: step 0x22(wValue=1) non-fatal ({e:?})\n"),
+        }
+
+        // Plaintext session init (sec 4) in DLM's exact wire order. The dock only
+        // ACKs once init_4+probe arrives, and it gates on DLM's fingerprint -- the
+        // interleaved GET_DESCRIPTOR reads (CONFIGURATION before init_0, two STRING
+        // reads between init_25 and init_4). Those reads are best-effort: the
+        // kernel reports EREMOTEIO on the short reply but the request still hits the
+        // wire (all we need). init_0/init_25/init_4+probe are separate transfers.
+        const STD_IN: u8 = 0x80; // dev->host, standard, device
+        let mut desc = KVec::from_elem(0u8, 618, GFP_KERNEL)?;
+        let _ = dev.control_recv(0x06, STD_IN, 0x0200, 0, &mut desc[..40], timeout(), GFP_KERNEL); // CONFIG, 40
+        let _ = dev.control_recv(0x06, STD_IN, 0x0200, 0, &mut desc, timeout(), GFP_KERNEL); // CONFIG, 618
+
+        // Log EP02's bulk wMaxPacketSize from the config descriptor. If it is 64 then a 64-byte
+        // msg0/arm is an exact multiple and the in-kernel `usb_bulk_msg` path (unlike libusb's
+        // LIBUSB_TRANSFER_ADD_ZERO_PACKET) won't auto-append the terminating ZLP -- the dock's SIE
+        // would then wait for more data and never hand the frame to firmware. Rules the ZLP-trap
+        // hypothesis in or out from data we already capture. Walk the standard descriptor chain
+        // (bLength/bDescriptorType), find the ENDPOINT (0x05) descriptor for bEndpointAddress 0x02.
+        {
+            let total = ((desc[2] as usize) | ((desc[3] as usize) << 8)).min(desc.len());
+            let mut i = 0usize;
+            while i + 2 <= total {
+                let blen = desc[i] as usize;
+                if blen == 0 {
+                    break;
+                }
+                if desc[i + 1] == 0x05 && i + 7 <= total && desc[i + 2] == EP_CTRL_OUT {
+                    let wmax = (desc[i + 4] as u16) | ((desc[i + 5] as u16) << 8);
+                    pr_info!("vino: EP02 bulk wMaxPacketSize = {wmax} (ZLP needed if msg0 is a multiple)\n");
+                }
+                i += blen;
+            }
+        }
+
+        let load_bearing = |label: &str, msg: &[u8]| -> Result {
+            match dev.bulk_send(EP_CTRL_OUT, msg, timeout(), GFP_KERNEL) {
+                Ok(_) => Ok(pr_info!("vino: step {label} OK ({} B)\n", msg.len())),
+                Err(e) => {
+                    pr_err!("vino: step {label} FAILED ({e:?})\n");
+                    Err(e)
+                }
+            }
+        };
+        load_bearing("init_0", &proto::init_0()?)?;
+        // Pad init_0->init_25 to DLM's cadence (sync bulk_send fires ~0.08 ms quicker than DLM's
+        // libusb URB). See PAD_* docs. udelay = us-precise busy-wait.
+        if DLM_FIXED_TIMERS {
+            udelay(Delta::from_micros(PAD_INIT0_TO_INIT25_US));
+        }
+        load_bearing("init_25", &proto::init_25()?)?;
+        // DLM's two interleaved STRING reads between init_25 and init_4+probe.
+        let _ = dev.control_recv(0x06, STD_IN, 0x0300, 0x0000, &mut desc[..255], timeout(), GFP_KERNEL); // STRING #0
+        let _ = dev.control_recv(0x06, STD_IN, 0x0303, 0x0409, &mut desc[..255], timeout(), GFP_KERNEL); // STRING #3 en-US
+        // Pad init_25->init_4 to DLM's cadence (~0.18 ms; vino's STRING reads return quicker too).
+        if DLM_FIXED_TIMERS {
+            udelay(Delta::from_micros(PAD_INIT25_TO_INIT4_US));
+        }
+        load_bearing("init_4+probe", &proto::init_4_probe()?)?;
+
+        // Read the single ACK that follows init_4+probe.
+        let mut ack = KVec::from_elem(0u8, 1024, GFP_KERNEL)?;
+        match dev.bulk_recv(EP_CTRL_IN, &mut ack, timeout(), GFP_KERNEL) {
+            Ok(n) => Ok(pr_info!("vino: session-init ACK = {n} bytes: {:02x?}\n",
+                &ack[..n.min(40)])),
+            Err(e) => {
+                pr_err!("vino: session-init ACK read FAILED ({e:?})\n");
+                Err(e)
+            }
+        }
+    }
+
+
+    /// Whether to service EP83 (interrupt-IN status) during bring-up. Measured 2026-06-16
+    /// (paired-coldbus-20260616-162650): DLM polls EP83 0x in the pre-arm window (14x total, all
+    /// post-engagement) while vino polled it 5x pre-arm -- injecting interrupt-IN traffic into the
+    /// critical arm/msg0 window that DLM never generates. Disabled so the pre-arm wire matches DLM;
+    /// re-enable if a post-engagement status channel is ever needed (DLM only services it once the
+    /// dock has already acked).
+    const POLL_EP83_DURING_BRINGUP: bool = false;
+
+    /// CP_STREAM_TYPE0 experiment (2026-06-23, check.md panel Gemini #4 / Grok #3): send a single
+    /// Type-0 (unrestricted) stream in `RepeaterAuth_Stream_Manage` instead of the DLM-replicated
+    /// 0x04/0x05 stream-type bytes, to test whether the dock engages CP as a terminal Type-0 sink
+    /// (vs an HDCP-2.2 repeater). Speculative: vino's Stream_Manage already matches DLM byte-exact
+    /// and DLM engages, so this DIVERGES from the proven-good default -- keep `false` for normal
+    /// runs and the paired diff; flip only for the A/B cold plug. M (`wait_cap_complete`) is
+    /// host-verify-only so its value never gates, but its `m_data` tracks this flag for a clean log.
+    const CP_STREAM_TYPE0: bool = false;
+
+    /// Reads the next HDCP response (type=4 sub=0x25, sec 5.2) from EP `0x84`,
+    /// skipping any non-HDCP frames (e.g. plain ACKs) in between, and returns the
+    /// parsed `(msg_id, payload)`. Bounded retry so a chatty dock can't wedge us.
+    fn recv_hdcp(dev: &usb::Interface<device::Bound>) -> Result<(u8, KVec<u8>)> {
+        const SUB_HDCP_RESP: u16 = 0x25;
+        // The dock interleaves capability blocks up to ~5.8 KiB into the AKE reply
+        // stream; size the buffer like the rest of the EP84 reads ([`EP84_BUF`]) so a
+        // large frame is read whole rather than truncated/`-EOVERFLOW`'d.
+        let mut buf = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL)?;
+        for _ in 0..24 {
+            // Read EP84 FIRST. The dock replies to AKE messages sub-millisecond (DLM cold capture:
+            // ~0.1-0.7 ms between EP84 IN frames), but it interleaves status/cap pushes that we
+            // skip. Polling EP83 (a ~2 ms idle wait) BEFORE every read added ~2 ms x
+            // N-skipped-frames
+            // of latency per reply -- making vino's AKE ~400 ms vs DLM's ~62 ms, slow enough that
+            // the
+            // dock starts downstream HDCP and NAKs our arm/Stream_Manage. So only service EP83 when
+            // EP84 came back empty (same reorder as `drain_ep84`). See the cold wire diff.
+            let n = dev.bulk_recv(EP_CTRL_IN, &mut buf, timeout(), GFP_KERNEL)?;
+            if n < 16 {
+                if Self::POLL_EP83_DURING_BRINGUP {
+                    Self::poll_ep83(dev);
+                }
+                continue;
+            }
+            // DIAGNOSTIC (2026-06-11): log EVERY frame the dock returns during the AKE --
+            // including
+            // wsub!=0x25 and cap-block (sub=0x84) pushes we'd otherwise skip -- so we can see
+            // whether
+            // the dock interleaves its capability blocks with the HDCP replies (the suspected
+            // reason
+            // its cap phase never completes / it won't engage CP). Inner id/sub at off 16/18.
+            {
+                let wsub = u16::from_le_bytes([buf[8], buf[9]]);
+                let iid = if n >= 18 { u16::from_le_bytes([buf[16], buf[17]]) } else { 0 };
+                let isub = if n >= 20 { u16::from_le_bytes([buf[18], buf[19]]) } else { 0 };
+                pr_debug!("vino: AKE-EP84 {n}B wsub={wsub:#x} inner_id={iid:#x} inner_sub={isub:#x}\n");
+            }
+            if u16::from_le_bytes([buf[8], buf[9]]) != SUB_HDCP_RESP {
+                continue; // non-HDCP frame -- skip
+            }
+            if let Some((id, payload)) = ake::parse_in(&buf[16..n]) {
+                // Inner msg_id 0 is a status/ACK frame (the dock emits one as a
+                // sub=0x25 frame after each OUT message, e.g. the `14 00 76 00...`
+                // frame after AKE_Init) -- skip it and keep reading for the real
+                // HDCP response, mirroring the oracle's recv_hdcp_msg.
+                if id == 0 {
+                    continue;
+                }
+                let mut pl = KVec::with_capacity(payload.len(), GFP_KERNEL)?;
+                pl.extend_from_slice(payload, GFP_KERNEL)?;
+                return Ok((id, pl));
+            }
+        }
+        Err(EINVAL)
+    }
+
+
+    /// Pace like DLM after a RepeaterAuth OUT (ctr6 Send_Ack / ctr7 Stream_Manage):
+    /// read the dock's per-frame `id=0x14 sub=0x10` ack off EP84 BEFORE the next OUT,
+    /// so vino never transmits while the dock is mid-NAK.
+    ///
+    /// Ground truth (cold wire diff, captures/dlm-cold-20260611-123347 vs vino-cold):
+    /// DLM reads that ack after EVERY cap/AKE OUT --
+    /// ctr4->ack->ctr5->ack->ctr6->ack->ctr7->
+    /// ack->arm, ~0.2 ms apart, whole ctr7->arm gap 0.46 ms. Commit d74a4d7 dropped the
+    /// drain for ctr6/ctr7, so `run_ake` sent ctr6->ctr7 back-to-back with no read; the
+    /// dock (busy with downstream HDCP after SKE) then NAK'd each OUT ~100 ms (vino's
+    /// V'->arm gap measured ~200 ms), and the arm landed after the dock had left its
+    /// freshly-keyed CP window -> CP never engaged (0 `wsub=0x45`). Restoring the read
+    /// re-paces vino to DLM and lets the arm land tight. Best-effort: returns as soon as
+    /// the matching ack arrives, or immediately if nothing is queued (dock idle).
+    fn pace_cap_ack(dev: &usb::Interface<device::Bound>, want_ctr: u16) {
+        // EP84 frames here can carry an interleaved capability block up to ~5.8 KiB;
+        // size to [`EP84_BUF`] so a large frame isn't truncated mid-pacing.
+        let Ok(mut buf) = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL) else {
+            return;
+        };
+        for _ in 0..8 {
+            match dev.bulk_recv(EP_CTRL_IN, &mut buf, Delta::from_millis(30), GFP_KERNEL) {
+                Ok(len) if len >= 22 => {
+                    let wsub = u16::from_le_bytes([buf[8], buf[9]]);
+                    let iid = u16::from_le_bytes([buf[16], buf[17]]);
+                    let ictr = u16::from_le_bytes([buf[20], buf[21]]);
+                    // The per-frame cap-ack: wsub=0x25, inner id=0x14 sub=0x10 ctr=want.
+                    // An interleaved cap push (sub=0x84) or earlier ack -- keep reading.
+                    if wsub == 0x25 && iid == 0x14 && ictr == want_ctr {
+                        return;
+                    }
+                }
+                // A short frame (header-only ack/keepalive): not our cap-ack, but the
+                // dock is still talking -- keep pacing rather than bailing out.
+                Ok(_) => continue,
+                // Nothing queued within the short window -- the dock is idle, don't block.
+                Err(_) => return,
+            }
+        }
+    }
+
+
+    /// After ctr7 (Stream_Manage) and its ack, WAIT for the dock's terminal capability block
+    /// `id=0x0b sub=0x84` before letting the caller arm. This is the dock's "cap-complete"
+    /// signal: DLM receives it and only then arms (cold-ref: `id=0x21` @52.1465 -> `id=0x0b`
+    /// @52.1469 -> arm @52.1474). vino's lockstep ([`pace_cap_ack`]) only consumed the `id=0x14`
+    /// ctr acks, so it armed right after ctr7's ack -- BEFORE the dock had emitted `id=0x0b`
+    /// (vino received every other cap block id=0x213/0x0d/0x10/0x28/0x18/0x21 but armed one push
+    /// early). The dock then NAK'd msg0 ~100 ms and dumped a 16 KB error block
+    /// (`type=0x1003 wsub=0x37`) that DLM never produces, instead of engaging CP -- the true
+    /// gate, found on cold plug `vino-cold-20260612-080549`. The dock emits `id=0x0b` a few ms
+    /// after `id=0x21` once it settles downstream HDCP, so draining EP84 until it arrives keeps
+    /// the arm tight (DLM ~ 0.5 ms after ctr7) yet correctly ordered. Best-effort, bounded.
+    fn wait_cap_complete(dev: &usb::Interface<device::Bound>, kd: &[u8; 32]) {
+        let Ok(mut buf) = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL) else {
+            return;
+        };
+        // Drain EP84 until the dock goes QUIET, not merely until id=0x0b. Cold plug #2
+        // (vino-cold-20260612-082707) showed DLM's LAST pre-arm push is the id=0x28 that
+        // follows id=0x0b (cold-ref: id=0x0b@52.1469 -> ack ctr7 -> id=0x28@52.1472 ->
+        // arm@52.1474),
+        // whereas vino stopped at id=0x0b and armed -- leaving id=0x28 (and the rest of the dock's
+        // terminal cap burst) un-drained in the dock's EP84 queue. With its IN queue backed up the
+        // dock NAK'd vino's msg0 ~100 ms (it can't accept the OUT while it still owes IN data) and
+        // then dumped the 16 KB error block. So after id=0x0b, keep reading until a read times out
+        // (the dock has sent everything), then return so the caller arms into a clean dock -- like
+        // DLM. Bounded: id=0x0b is the marker; QUIET_GAP short reads of silence end the drain.
+        //
+        // * 2026-06-12 (HDCP 2.3 Adaptation sec RepeaterAuth, pdfs/): one of the frames drained
+        // here is
+        // the dock's `RepeaterAuth_Stream_Ready` (HDCP msg 0x11) -- the 3rd `id=0x28` DLM receives
+        // and
+        // vino historically did not. The spec requires the transmitter to RECEIVE it within 100 ms
+        // of
+        // `Stream_Manage` and verify `M == M'` before transmitting content; the dock's exactly-100
+        // ms
+        // msg0 NAK on a cold plug is that window. We now RECOGNISE it in this same drain (no added
+        // latency vs the old broken 10x1 s poll) and log `M'` plus candidate `M`s so the next
+        // capture
+        // pins the exact `STREAMID_TYPE || seq_num_M` the dock hashes. The HDCP msg_id rides at
+        // `body[9]` = `buf[25]` in an EP84 reply (`ake::parse_in`); `M'[32]` follows at
+        // `buf[26..58]`.
+        // Verification is logged-only for now (the DisplayLink field offsets in `Stream_Manage` are
+        // not yet confirmed, so a wrong guess must not block the arm); the arm is gated on
+        // receiving
+        // Stream_Ready when it arrives, else on the existing id=0x0b + quiet fallback. `M` key is
+        // `SHA256(kd)`; `M = HMAC-SHA256(STREAMID_TYPE || seq_num_M, SHA256(kd))`, seq_num_M = 0.
+        let sha_kd = crypto::sha256(kd);
+        let mut saw_0b = false;
+        let mut saw_ready = false;
+        let mut quiet = 0usize;
+        const QUIET_GAP: usize = 3; // ~3 consecutive empty short reads => dock done pushing
+        const MAX_ROUNDS: usize = 48;
+        for _ in 0..MAX_ROUNDS {
+            match dev.bulk_recv(EP_CTRL_IN, &mut buf, Delta::from_millis(5), GFP_KERNEL) {
+                Ok(len) if len >= 20 => {
+                    quiet = 0;
+                    let iid = u16::from_le_bytes([buf[16], buf[17]]);
+                    let isub = u16::from_le_bytes([buf[18], buf[19]]);
+                    let mid = if len >= 26 { buf[25] } else { 0 }; // HDCP msg_id (body[9])
+                    if isub == 0x84 && iid == 0x0b {
+                        saw_0b = true;
+                    }
+                    if mid == ake::id::REPEATERAUTH_STREAM_READY && len >= 58 {
+                        saw_ready = true;
+                        let mprime = &buf[26..58];
+                        pr_info!("vino: AKE: Stream_Ready (0x11) M'={mprime:02x?}\n");
+                        // M = HMAC-SHA256(SHA256(kd), data) where data is the Content Stream
+                        // Management input the dock hashes: `k` 7-byte stream entries followed by
+                        // the 3-byte `seq_num_M` (=0 on the first Stream_Manage). Cracked from the
+                        // DLM aarch64 decompile (`FUN_0057be04`: data = memcpy(streams, k*7) ||
+                        // BE16(field) || field, keyed by the 32-byte SHA256(kd) at session+0x37);
+                        // reproduces DLM's captured M' byte-exact (captures/.../FINDINGS.md).
+                        // vino's
+                        // two streams carry the same StreamID_Type bytes its Stream_Manage sends
+                        // (`repeater_auth_stream_manage`: type 0x04 and 0x05), so the dock computes
+                        // the same M. (Earlier code guessed a 5-byte STREAMID_TYPE||seq layout and
+                        // so
+                        // always mismatched -- host-side only, never gated the dock.)
+                        // Stream-type bytes track CP_STREAM_TYPE0 so the logged M matches what
+                        // Stream_Manage actually sent (M is host-verify-only; never gates the dock).
+                        let (s0, s1) = if Self::CP_STREAM_TYPE0 { (0x00, 0x00) } else { (0x04, 0x05) };
+                        let m_data: [u8; 17] = [
+                            0, 0, 0, s0, 0, 0, 0, // stream 0: StreamID_Type[0]
+                            0, 0, 0, s1, 0, 0, 0, // stream 1: StreamID_Type[1]
+                            0, 0, 0, // seq_num_M = 0 (first Stream_Manage, big-endian)
+                        ];
+                        let m = crypto::hmac_sha256(&sha_kd, &m_data);
+                        let eq = if &m[..] == mprime { "==" } else { "!=" };
+                        pr_info!("vino: AKE:   M {} M' (CSM stream-entry layout)\n", eq);
+                    } else if mid == ake::id::RECEIVER_AUTH_STATUS && len >= 27 {
+                        pr_info!("vino: AKE: RECEIVER_AUTH_STATUS=0x{:02x}\n", buf[26]);
+                    }
+                    // * 2026-06-12: arm the INSTANT both terminal markers have arrived -- the
+                    // cap-complete
+                    // id=0x0b AND the Stream_Ready (the trailing id=0x28 / HDCP 0x11). DLM arms
+                    // 0.46 ms
+                    // after its last cap block; a cold-plug cadence diff
+                    // (vino-cold-20260612-113706) showed
+                    // vino was instead waiting QUIET_GAP x 5 ms of EMPTY reads AFTER already
+                    // seeing both
+                    // markers, landing the arm ~68 ms late -- outside the dock's freshly-keyed CP
+                    // window, so
+                    // the dock errored on the arm (27 KB type=0x1001 dump) instead of engaging.
+                    // Once both
+                    // markers are in, the terminal burst is complete; arm now, like DLM. (The
+                    // empty-read
+                    // quiet path below remains the fallback when Stream_Ready never arrives.)
+                    if saw_0b && saw_ready {
+                        pr_info!("vino: cap-complete (id=0x0b + Stream_Ready 0x11) -- arming now\n");
+                        return;
+                    }
+                }
+                // Empty/short read = a quiet window. Fallback when Stream_Ready (0x11) never
+                // arrives:
+                // once id=0x0b has arrived AND the dock has been quiet for QUIET_GAP rounds, the
+                // terminal burst is drained -- arm now.
+                _ => {
+                    if saw_0b {
+                        quiet += 1;
+                        if quiet >= QUIET_GAP {
+                            pr_info!(
+                                "vino: cap-complete drained (id=0x0b{}+ quiet) -- arming now\n",
+                                if saw_ready { ", Stream_Ready 0x11, " } else { " (no 0x11) " }
+                            );
+                            return;
+                        }
+                    }
+                }
+            }
+        }
+        pr_info!(
+            "vino: cap-complete drain budget hit (saw_0b={saw_0b} saw_ready={saw_ready}) -- arming anyway\n"
+        );
+    }
+
+
+    /// Drives a full clean-room HDCP 2.2 AKE + LC + SKE (and RepeaterAuth for a
+    /// repeater sink) over EP `0x02`/`0x84`, verifying `H'`, `L'` and `V'` against
+    /// our own KDF (sec 5). On success returns the [`Session`] keys.
+    ///
+    /// All HDCP transfers use transport `seq=0`; the `hdcp_seq` counter increments
+    /// 1..7 across the OUT messages (sec 5.1). Best-effort: any mismatch/short read
+    /// aborts with an error the caller logs.
+    fn run_ake(dev: &usb::Interface<device::Bound>) -> Result<Session> {
+        use ake::id;
+
+        // Anchor the CP-start instant (~`cp_first` in the timing survey) before the first frame,
+        // so `send_cp_setup` can realise DLM's fixed pre-arm timer and log the fingerprint.
+        let cp_start = Instant::<Monotonic>::now();
+
+        // Flush any STALE EP84 frames the dock still has queued from a PRIOR session before
+        // starting a fresh AKE. On a warm rmmod/insmod re-probe the dock is not power-cycled, so
+        // its previous CP/cap replies (including a multi-KB residual block) sit in its EP84 queue;
+        // if we don't drain them, the first `recv_hdcp` picks up a stale frame and the whole AKE
+        // reply stream is shifted.
+        //
+        // TIMING (2026-06-23 paired cold-plug diff): a stale frame is ALREADY queued in the dock,
+        // so it returns sub-millisecond; only the trailing empty read pays the timeout. A 20 ms
+        // probe therefore cost a dead 20 ms before AKE_Init on a *cold* plug (queue empty) -- the
+        // sole pre-arm gap where vino diverged from DLM (DLM emits ctr1 ~0.3 ms after session-init,
+        // vino was ~21.8 ms). Drop the probe to 3 ms: still ample to drain a warm-reprobe backlog
+        // (each present frame returns immediately; the loop only stops on the empty read), but the
+        // cold-plug cost collapses 20 ms -> 3 ms, matching DLM's cadence into the AKE.
+        //
+        // FIXED-TIMER (2026-06-26, `DLM_FIXED_TIMERS`): DLM does NOT flush here at all -- the
+        // cp_first->cert frame dump shows it emits AKE_Init ~0.14 ms after the session-init ACK,
+        // whereas vino blocked ~1.9 ms in this probe. The cause: on a COLD plug the EP84 queue is
+        // empty (the session-init ACK was already consumed), so the first `bulk_recv` waits out its
+        // full timeout -- and because a sub-ms `Delta` truncates via `as_millis()` to 0 = "wait
+        // forever", the practical floor is ~1.9 ms wall even at a nominal 1 ms. That dead wait was
+        // the ENTIRE residual `cp_first->cert` gap vs DLM (vino 2.6 ms, DLM 1.07 ms). The flush only
+        // matters on a WARM rmmod/insmod re-probe, where the un-power-cycled dock still has a stale
+        // CP/cap backlog queued that would shift the first `recv_hdcp`. So under DLM_FIXED_TIMERS
+        // (the cold-plug DLM-impersonation mode) skip it entirely and let AKE_Init follow the ACK as
+        // tightly as DLM; keep the drain on the reactive/warm path where stale frames are possible.
+        if !DLM_FIXED_TIMERS {
+            let flush_probe = Delta::from_millis(3);
+            if let Ok(mut flush) = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL) {
+                let mut flushed = 0usize;
+                for _ in 0..32 {
+                    match dev.bulk_recv(EP_CTRL_IN, &mut flush, flush_probe, GFP_KERNEL) {
+                        Ok(n) if n > 0 => flushed += 1,
+                        _ => break,
+                    }
+                }
+                if flushed > 0 {
+                    pr_info!("vino: flushed {flushed} stale EP84 frame(s) before AKE\n");
+                }
+            }
+        }
+
+        // Pad session-init-ACK->AKE_Init to DLM's 0.159 ms cadence. With the cold-plug flush gone,
+        // vino fires AKE_Init only ~0.043 ms after the ACK; DLM spaces it 0.159 ms. See PAD_* docs.
+        if DLM_FIXED_TIMERS {
+            udelay(Delta::from_micros(PAD_ACK_TO_AKEINIT_US));
+        }
+
+        // (1) AKE_Init -- fresh rtx, TxCaps = 00 00 00 (DLM-exact).
+        let mut rtx = [0u8; 8];
+        rng::fill(&mut rtx);
+        dev.bulk_send(EP_CTRL_OUT, &ake::ake_init(1, 0, &rtx, &[0; 3])?, timeout(), GFP_KERNEL)?;
+
+        // (2) AKE_Send_Cert: payload = REPEATER(1) || cert_rx(522). Extract the
+        // RSA-1024 public key (modulus[5..133], exponent[133..136]).
+        let (cid, cert_msg) = Self::recv_hdcp(dev)?;
+        // Anchor the `cert` milestone the instant the dock's cert lands: DLM arms a fixed
+        // CERT_TO_ARM_US after this point (see `Session::cert_at` / `DLM_FIXED_TIMERS`).
+        let cert_at = Instant::<Monotonic>::now();
+        if cid != id::AKE_SEND_CERT || cert_msg.len() < 1 + 136 {
+            pr_err!("vino: AKE: bad AKE_Send_Cert (id={cid:#x}, {} B)\n", cert_msg.len());
+            return Err(EINVAL);
+        }
+        let repeater = cert_msg[0] != 0;
+        let cert = &cert_msg[1..];
+        let mut modulus = [0u8; 128];
+        modulus.copy_from_slice(&cert[5..133]);
+        let mut exponent = [0u8; 3];
+        exponent.copy_from_slice(&cert[133..136]);
+
+        // (3) AKE_Transmitter_Info, then (4) read AKE_Receiver_Info (RxCaps unused).
+        dev.bulk_send(EP_CTRL_OUT, &ake::ake_transmitter_info(2, 0)?, timeout(), GFP_KERNEL)?;
+        let xmit_info_at = Instant::<Monotonic>::now();
+        let _ = Self::recv_hdcp(dev)?;
+
+        // (5) AKE_No_Stored_km -- fresh km, RSA-OAEP-SHA256 to Ekpub(km).
+        let mut km = [0u8; 16];
+        rng::fill(&mut km);
+        let ekpub = hdcp::oaep_encrypt_km(&modulus, &exponent, &km)?;
+        // Spend a REALISTIC cert-verification time before No_Stored_km. vino reaches this point
+        // ~0.3 ms after AKE_Transmitter_Info; DLM takes ~1.65 ms (it verifies the receiver's
+        // DCP-signed cert). Hold to DLM's cadence so vino doesn't answer impossibly fast -- the one
+        // consistent host-reachable divergence found vs the same-day engaging DLM. See
+        // [`CERT_VERIFY_HOLD_US`].
+        if DLM_FIXED_TIMERS {
+            hold_until(xmit_info_at, CERT_VERIFY_HOLD_US);
+        }
+        dev.bulk_send(EP_CTRL_OUT, &ake::ake_no_stored_km(3, 0, &ekpub)?, timeout(), GFP_KERNEL)?;
+
+        // (6) AKE_Send_Rrx.
+        let (rid, rrx_pl) = Self::recv_hdcp(dev)?;
+        if rid != id::AKE_SEND_RRX || rrx_pl.len() < 8 {
+            pr_err!("vino: AKE: bad AKE_Send_Rrx (id={rid:#x})\n");
+            return Err(EINVAL);
+        }
+        let mut rrx = [0u8; 8];
+        rrx.copy_from_slice(&rrx_pl[..8]);
+
+        // (7)/(8) AKE_Send_H_prime -- verify H' = HMAC(kd, rtx^REPEATER).
+        let (hid, hp) = Self::recv_hdcp(dev)?;
+        if hid != id::AKE_SEND_H_PRIME || hp.len() < 32 {
+            pr_err!("vino: AKE: bad H' (id={hid:#x})\n");
+            return Err(EINVAL);
+        }
+        let kd = hdcp::derive_kd(&km, &rtx, &rrx)?;
+        if hdcp::compute_h(&kd, &rtx, repeater)[..] != hp[..32] {
+            pr_err!("vino: AKE: H' mismatch -- authentication failed\n");
+            return Err(EINVAL);
+        }
+        pr_info!("vino: AKE: H' verified\n");
+
+        // (9) AKE_Send_Pairing_Info (Ekh_km) -- read and discard (no-stored path).
+        let _ = Self::recv_hdcp(dev)?;
+
+        // (10) Locality Check -- LC_Init(rn) then verify L'.
+        let mut rn = [0u8; 8];
+        rng::fill(&mut rn);
+        dev.bulk_send(EP_CTRL_OUT, &ake::lc_init(4, 0, &rn)?, timeout(), GFP_KERNEL)?;
+        let (lid, lp) = Self::recv_hdcp(dev)?;
+        if lid != id::LC_SEND_L_PRIME || lp.len() < 32 {
+            pr_err!("vino: AKE: bad L' (id={lid:#x})\n");
+            return Err(EINVAL);
+        }
+        if hdcp::compute_l(&kd, &rrx, &rn)[..] != lp[..32] {
+            pr_err!("vino: AKE: L' mismatch -- locality check failed\n");
+            return Err(EINVAL);
+        }
+        pr_info!("vino: AKE: L' verified\n");
+
+        // (11) Session Key Exchange -- send Edkey(ks) || riv. The session key and IV are
+        // fresh-random per session.
+        let mut ks = [0u8; 16];
+        let mut riv = [0u8; 8];
+        rng::fill(&mut ks);
+        rng::fill(&mut riv);
+        let edkey = hdcp::compute_eks(&km, &rtx, &rrx, &rn, &ks)?;
+        // Dev diagnostic: the full SKE secrets, so the SKE delivery can be verified OFFLINE
+        // (edkey == ks XOR derive_dkey(km,rtx,rrx,rn,2), and the dock unwrapping to the same ks).
+        // Behind pr_debug, so compiled out unless dynamic debug is enabled.
+        pr_debug!("vino: SKE-SECRETS km={km:02x?} rtx={rtx:02x?} rrx={rrx:02x?} rn={rn:02x?}\n");
+        pr_debug!("vino: SKE-SECRETS ks={ks:02x?} edkey={edkey:02x?}\n");
+        // * riv DERIVATION -- THE CP-ENGAGEMENT BUG, FIXED 2026-06-11.
+        // The SKE delivers the BASE riv (byte7 low-3 head/direction-selector bits cleared); the
+        // dock
+        // derives the per-direction CP riv from that base. GROUND TRUTH from cold-ref AND the live
+        // vino cold-plug diff (captures/dlm-cold-20260611-123347 + vino-cold-20260611-130522):
+        // delivered base byte7 = e8 -> host OUT-CP riv = ec (base | 0x04) -> dock IN-CP riv = ed
+        // (^1).
+        // vino had been sealing OUT-CP with the RAW random `riv` (byte7 e.g. f9 = base f8 | 0x01)
+        // while delivering base f8 -- so the dock, deriving its keystream from f8 (expecting
+        // host-OUT
+        // = fc), could NOT decrypt vino's CP and SILENTLY DROPPED every post-arm frame (0 sub=0x45,
+        // EP84 dead after the arm) even though ks/seal/MAC/frame-format were all byte-correct. The
+        // off-by-one-bit IV was the whole wall. Fix: deliver base, seal OUT with base | 0x04.
+        // The SKE delivers the FULL random riv as-is (DLM does NOT mask the low bits -- verified
+        // on
+        // two decrypted DLM sessions: cold-ref delivers ...e8, dl3cmac delivers ...e7). The host CP
+        // OUT riv = delivered XOR 0x04 (flip byte7 bit 2): cold-ref e8->ec, dl3cmac e7->e3.
+        // cp::in_riv
+        // then ^1 for the dock->host IN stream (ec->ed). vino had been masking the delivered riv
+        // and
+        // sealing with the raw random LSBs, so the dock (deriving its keystream as delivered^0x04)
+        // got a different keystream and silently dropped every CP frame. See the vino cold-plug
+        // diff.
+        let riv_ske = riv; // deliver the full random riv, unmasked, exactly like DLM
+        riv[7] ^= 0x04; // host OUT-CP riv = delivered ^ 0x04
+        dev.bulk_send(EP_CTRL_OUT, &ake::ske_send_eks(5, 0, &edkey, &riv_ske)?, timeout(), GFP_KERNEL)?;
+        // Dev diagnostic: the live session key/out-riv the dock must hold to decrypt our CP.
+        pr_debug!("vino: SESSION ks={ks:02x?} out_riv={riv:02x?}\n");
+
+        // The LIVE plaintext capability-announce (`build_cap_announce`),
+        // built once V is known below. Empty unless the dock is a repeater (D6000 always is).
+        let mut cap_announce = KVec::new();
+
+        // (12) RepeaterAuth -- verify V' over the ReceiverID_List, ACK, then SM2.
+        if repeater {
+            let (vid, list) = Self::recv_hdcp(dev)?;
+            if vid != id::REPEATERAUTH_SEND_RECEIVERID_LIST || list.len() < 16 {
+                pr_err!("vino: AKE: bad ReceiverID_List (id={vid:#x})\n");
+                return Err(EINVAL);
+            }
+            let split = list.len() - 16;
+            // V = HMAC(kd, list_header): MSB-128 = V' (verify vs the list trailer);
+            // LSB-128 = the RepeaterAuth_Send_Ack value (NOT the MSB -- that was THE bug).
+            let v_full = hdcp::compute_v_full(&kd, &list[..split]);
+            let mut v_ack = [0u8; 16];
+            v_ack.copy_from_slice(&v_full[16..]);
+            if v_full[..16] != list[split..] {
+                pr_err!("vino: AKE: V' mismatch -- repeater verification failed\n");
+                return Err(EINVAL);
+            }
+            pr_info!("vino: AKE: V' verified\n");
+            dev.bulk_send(EP_CTRL_OUT, &ake::repeater_auth_send_ack(6, 0, &v_ack)?, timeout(), GFP_KERNEL)?;
+            // Read the dock's ctr6 ack before sending ctr7 -- DLM's lockstep pacing, without
+            // which the dock NAKs the back-to-back OUTs ~100 ms each (see `pace_cap_ack`).
+            Self::pace_cap_ack(dev, 6);
+            dev.bulk_send(
+                EP_CTRL_OUT,
+                &ake::repeater_auth_stream_manage(7, 0, Self::CP_STREAM_TYPE0)?,
+                timeout(),
+                GFP_KERNEL,
+            )?;
+            // Read the dock's ctr7 ack before returning, so the caller's arm marker lands
+            // tight after ctr7 (DLM: 0.46 ms) instead of while the dock is still NAKing.
+            Self::pace_cap_ack(dev, 7);
+            // Then drain the dock's terminal cap burst -- id=0x0b (cap-complete) AND the dock's
+            // `RepeaterAuth_Stream_Ready` (HDCP 0x11, the 3rd id=0x28) -- before the caller arms.
+            // DLM arms only after this burst (cold-ref: id=0x21 -> id=0x0b -> id=0x28/0x11 ->
+            // arm);
+            // arming early makes the dock NAK msg0 ~100 ms and dump a 16 KB error block instead of
+            // engaging. `wait_cap_complete` recognises + verifies the Stream_Ready in place (HDCP
+            // 2.3 Adaptation sec RepeaterAuth). `kd` is needed to check `M == M'`.
+            Self::wait_cap_complete(dev, &kd);
+
+            // Build the LIVE capability-announce now that every field is known. This is the
+            // plaintext re-statement of the 7 AKE OUT messages the dock requires between the
+            // init markers and the arm marker (`CP_CAP_PHASE`). See `build_cap_announce`.
+            // Pass `riv_ske` (the value SKE_Send_Eks actually delivered), NOT `riv` (= session
+            // OUT-CP seal riv = riv_ske ^ 0x04). The cap-announce ctr5 frame is a byte-faithful
+            // re-statement of SKE_Send_Eks, so it must carry the IDENTICAL riv.
+            cap_announce = Self::build_cap_announce(&rtx, &ekpub, &rn, &edkey, &riv_ske, &v_ack)?;
+        }
+
+        Ok(Session { ks, riv, kd, cap_announce, cp_start, cert_at })
+    }
+
+
+    /// Build the LIVE plaintext **capability-announce** the dock requires before the arm
+    /// marker. Ground truth: the cold-ref raw wire
+    /// (`captures/cold-ref-20260608-200850/`, t~36.754-36.813) shows DLM, *after* the HDCP
+    /// AKE, sends 7 plaintext `type=4 wsub=0x04` frames that are a re-statement of the 7 AKE
+    /// OUT messages -- `id=0x22/0x1f/0x9a/0x22/0x32/0x2a/0x2d`, `sub=0x10`, ctr 1-7 -- each
+    /// carrying THIS session's real value: f1=rtx, f2=const TxCaps, f3=Ekpub(km)[128],
+    /// f4=rn, f5=Edkey(ks)[16]||riv_base[8], f6=V[16], f7=const Stream_Manage config. The dock
+    /// ACKs each (`id=0x14 sub=0x10 ctr=N`) and only then engages its CP cipher; skipping the
+    /// announce leaves it cipher-off (the long-standing "0 `sub=0x45` acks" symptom).
+    ///
+    /// [`golden::CAP_PLAIN_1080P`] is a byte-correct *skeleton* (headers/aux/lead bytes and the
+    /// two constant frames are session-invariant -- verified across the cold-ref and matched
+    /// sessions) but its 5 variable payloads are a STALE foreign session's values. Replaying it
+    /// verbatim delivers the dock a stale Ekpub/Edkey/riv that re-key it to a foreign `ks`
+    /// (the `cap_phase`-clobbers-`ks` bug). So we clone the skeleton and overwrite ONLY the 5
+    /// session-specific payloads. Each payload sits at frame offset 44 (16-byte wire header +
+    /// 22 inner-prefix bytes + the `30 00 00 00 00` marker + 1 lead byte = 28 inner bytes), and
+    /// frames are stored `[u16 len][frame]`. `riv` here is the SKE-*delivered* riv (`riv_ske`),
+    /// written verbatim -- frame 5 is a byte-faithful re-statement of `SKE_Send_Eks`, so it must
+    /// carry the EXACT delivered riv. (It earlier wrote `riv & 0xF8`, which equals the delivered
+    /// value only when the random riv's low 3 bits are zero -- true for cold-ref's `e8` but wrong
+    /// for 7 of 8 live sessions, so the dock saw a different riv in the announce than in SKE.
+    /// Ground truth: cold-ref ctr5 capture t=36.812413 delivers riv `...40e8` == its SKE riv.)
+    fn build_cap_announce(
+        rtx: &[u8; 8],
+        ekpub: &[u8; 128],
+        rn: &[u8; 8],
+        edkey: &[u8; 16],
+        riv: &[u8; 8],
+        v: &[u8; 16],
+    ) -> Result<KVec<u8>> {
+        let mut blob = KVec::with_capacity(golden::CAP_PLAIN_1080P.len(), GFP_KERNEL)?;
+        blob.extend_from_slice(golden::CAP_PLAIN_1080P, GFP_KERNEL)?;
+
+        // Walk the skeleton; for each frame, overwrite the payload (at frame+44) keyed by ctr.
+        let mut off = 0usize;
+        while off + 2 <= blob.len() {
+            let len = u16::from_le_bytes([blob[off], blob[off + 1]]) as usize;
+            let frame = off + 2;
+            if frame + len > blob.len() {
+                break;
+            }
+            // ctr (inner offset 4) identifies which AKE message this announce frame restates.
+            let ctr = u16::from_le_bytes([blob[frame + 16 + 4], blob[frame + 16 + 5]]);
+            let pay = frame + 44; // 16 hdr + 22 inner-prefix + 5 marker + 1 lead
+            match ctr {
+                1 => blob[pay..pay + 8].copy_from_slice(rtx), // AKE_Init
+                3 => blob[pay..pay + 128].copy_from_slice(ekpub), // AKE_No_Stored_km Ekpub
+                4 => blob[pay..pay + 8].copy_from_slice(rn), // LC_Init
+                5 => {
+                    // SKE_Send_Eks: Edkey(ks)[16] || riv[8] (the delivered riv, verbatim)
+                    blob[pay..pay + 16].copy_from_slice(edkey);
+                    blob[pay + 16..pay + 24].copy_from_slice(riv);
+                }
+                6 => blob[pay..pay + 16].copy_from_slice(v), // RepeaterAuth_Send_Ack V
+                _ => {} // ctr 2 (TxCaps) and 7 (Stream_Manage) are session-invariant
+            }
+            off = frame + len;
+        }
+        Ok(blob)
+    }
+
+
+    /// Poll EP 0x83 (interrupt-IN status endpoint). DLM submits URBs here CONTINUOUSLY and the dock
+    /// pushes 6-byte status events; the dock may gate CP/downstream-HDCP engagement on the host
+    /// servicing this endpoint (flagged in `vino-driver/src/bin/bringup.rs`). vino never polled it
+    /// --
+    /// invisible in the EP02/EP84 bulk-wire comparison. Reads up to a few events (short timeout so
+    /// a
+    /// URB is pending when the dock pushes). `usb_bulk_msg` auto-routes the interrupt endpoint.
+    fn poll_ep83(dev: &usb::Interface<device::Bound>) -> usize {
+        // EP83 (interrupt-IN) transfers need DMA-capable memory -- allocate on the HEAP.
+        // A stack array trips usb_hcd_map_urb_for_dma's "transfer buffer is on stack"
+        // WARNING (VMAP_STACK can't be DMA-mapped) and the broken submit also stalls the
+        // bring-up (poll_ep83 runs inside every drain round). Best-effort: bail on OOM.
+        let mut buf = match KVec::from_elem(0u8, 64, GFP_KERNEL) {
+            Ok(b) => b,
+            Err(_) => return 0,
+        };
+        let mut n = 0usize;
+        // Short timeout: a pending URB gives the dock a window to push, but a 30 ms block on the
+        // (normally idle) EP83 stalls the bring-up loop (see drain_ep84). 2 ms is enough to catch a
+        // ready event without serializing the handshake.
+        for _ in 0..4 {
+            match dev.interrupt_recv(0x83, &mut buf, Delta::from_millis(2), GFP_KERNEL) {
+                Ok(len) if len > 0 => {
+                    n += 1;
+                    let s = &buf[..len.min(8)];
+                    pr_info!("vino: EP83 status event {len}B {s:02x?}\n");
+                }
+                _ => break,
+            }
+        }
+        n
+    }
+
+    /// Reap any completed transfers from the persistent EP83 interrupt-IN queue (opened in
+    /// [`send_cp_setup`]) without blocking, re-posting each as it is read so a URB always stays
+    /// pending. Returns the number of status events drained (logged for the cold-plug A/B vs DLM).
+    ///
+    /// [`send_cp_setup`]: Self::send_cp_setup
+    fn drain_ep83_queue(q: Option<&mut usb::BulkInQueue>) -> usize {
+        let Some(q) = q else { return 0 };
+        let mut buf = [0u8; 64];
+        let mut n = 0usize;
+        // Non-blocking sweep: a 0 ms wait returns Ok(None) immediately if nothing has completed,
+        // so this never serialises the arm/msg0 burst -- it only harvests what the dock pushed.
+        for _ in 0..4 {
+            match q.recv(&mut buf, Delta::from_millis(0)) {
+                Ok(Some(len)) if len > 0 => {
+                    n += 1;
+                    let s = &buf[..len.min(8)];
+                    pr_info!("vino: EP83 (async) status event {len}B {s:02x?}\n");
+                }
+                _ => break,
+            }
+        }
+        n
+    }
+
+
+    /// Drives the post-SKE CP setup: opens the async EP84 reader, sends the plaintext
+    /// stream-open arm marker, then the first live encrypted CP frame (msg0), and counts the
+    /// dock's encrypted `wsub=0x45` acks. THE WALL: on a cold dock `acks` stays 0 -- the dock
+    /// runs the entire plaintext handshake but never engages the encrypted CP. See the "help
+    /// wanted" note at the top of the file.
+    fn send_cp_setup(
+        dev: &usb::Interface<device::Bound>,
+        session: &Session,
+        edid_out: &mut Option<KVec<u8>>,
+    ) -> Result<(usize, usize, u32, u16)> {
+        // 16 KiB so the dock's ~5787 B capability block is read whole (see [`EP84_BUF`]).
+        let mut resp = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL)?;
+        let mut drained = 0usize;
+        let mut acks = 0usize;
+        let mut sent = 0usize;
+        let mut ep83_events = 0usize;
+
+        // Plaintext `type=2 sub=0x24`+`0x45` stream-open arm marker -- the mandatory gate
+        // before the first encrypted frame.
+        const STREAM_OPEN: [u8; 64] = [
+            0x00, 0x00, 0x1c, 0x00, 0x02, 0x00, 0x00, 0x00, //
+            0x24, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
+            0x04, 0x00, 0x06, 0x00, 0x00, 0x00, 0x00, 0x00, //
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
+            0x00, 0x00, 0x1c, 0x00, 0x02, 0x00, 0x00, 0x00, //
+            0x45, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
+            0x05, 0x00, 0x0e, 0x00, 0x00, 0x00, 0x00, 0x00, //
+            0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, //
+        ];
+
+        // Open the persistent async EP84 IN reader BEFORE the arm marker and msg0, so
+        // `EP84_QUEUE_DEPTH` IN transfers are already posted when the dock pushes its post-arm
+        // reply (DLM's libusb always-pending-IN behaviour). Draining EP84 concurrently stops the
+        // dock's IN FIFO filling and NAKing our OUT (the sync-bulk deadlock that produced a 100 ms
+        // msg0 NAK). RAII: dropping the queue at function exit kills+frees the URBs.
+        let mut ep84_q = match dev.bulk_in_queue(0x04, EP84_QUEUE_DEPTH, EP84_BUF) {
+            Ok(q) => {
+                pr_info!("vino: EP84 async IN queue opened (depth={EP84_QUEUE_DEPTH})\n");
+                Some(q)
+            }
+            Err(e) => {
+                pr_info!("vino: EP84 async queue open failed ({e:?}) -- falling back to sync bulk_recv\n");
+                None
+            }
+        };
+
+        // A persistent async interrupt-IN queue on EP83 (mirroring `BulkInQueue` but for an
+        // interrupt endpoint) was tried here to see whether FIFO backpressure on the dock's
+        // status endpoint was blocking CP engagement. It wasn't: a HW cold plug measured
+        // `EP83_events=0` and the dock still never acked (`wsub=0x45`). Dropped rather than
+        // carried forward on an ad hoc binding outside the usb series -- `poll_ep83` (sync,
+        // called elsewhere in bring-up) is sufficient and already matches DLM's own cadence.
+        let mut ep83_q: Option<usb::BulkInQueue> = None;
+
+        // A/B (2026-06-16): route the engagement-critical arm marker + msg0 through an async,
+        // pipelined OUT queue (`usb::Interface::bulk_out_queue`) instead of the synchronous
+        // `bulk_send`. This mirrors DLM's libusb execution model exactly: each OUT URB is
+        // submitted and returns immediately (the HCD auto-retries NAKs until the URB's
+        // teardown), so the arm and msg0 are queued back-to-back and reaped afterwards rather
+        // than each blocking for its device-ACK round-trip before the next is submitted. The
+        // 2026-06-15 measurement showed the *wire* (lengths + submit->complete latency) is
+        // already identical, so this is not expected to change what the dock receives -- it is
+        // the last structural host difference (sync `usb_bulk_msg` vs async submit/reap) made
+        // identical so a cold plug can rule it in or out. Default OFF so vino keeps the proven
+        // sync path and paired diffs are not polluted; flip to test.
+        const CP_ASYNC_OUT: bool = true;
+        let mut out_q = if CP_ASYNC_OUT {
+            match dev.bulk_out_queue(0x02, 4, 1024) {
+                Ok(q) => {
+                    pr_info!("vino: EP02 async OUT queue opened (depth=4) -- libusb-style submit/reap\n");
+                    Some(q)
+                }
+                Err(e) => {
+                    pr_info!("vino: EP02 async OUT queue open failed ({e:?}) -- using sync bulk_send\n");
+                    None
+                }
+            }
+        } else {
+            None
+        };
+
+        // Pin the EP02 DATA0/DATA1 toggle to DATA0 immediately before the arm. This is the one
+        // host lever invisible to every "host exhausted" test: usbmon logs payloads, not the
+        // toggle bit, and the crypto/timing work never touches it. DLM (libusb async URBs) and
+        // vino (in-kernel blocking bulk_send) can reach the arm with EP02 at *different* parity
+        // after the ~9 preceding OUT transfers (7 cap-announce + arm) -- a mismatch makes the
+        // dock's SIE ACK the packet at the link layer (byte-identical on the wire) yet discard
+        // the payload as a duplicate, i.e. "arms clean, silently drops msg0". clear_halt issues
+        // CLEAR_FEATURE(ENDPOINT_HALT), which resets both sides' toggle to DATA0. Every earlier
+        // reset (reset_configuration at the top of bring_up, HARD_RESET, VBUS cycle) reset the
+        // toggle *before* those preceding transfers, so msg0's parity was never pinned. A/B:
+        // flip to `reset_configuration()` to test the heavier reset at the same call site.
+        // RESULT 2026-06-16 (cold plug vino-cold-20260616-000552): TESTED NEGATIVE.
+        // clear_halt(EP02)
+        // fired (wire shows CLEAR_FEATURE on EP2, dmesg "toggle -> DATA0") yet the dock still gave
+        // sub=0x45_acks=0. The toggle was NOT the gate. Left default-OFF so vino doesn't carry an
+        // EP02 CLEAR_FEATURE that DLM never sends (would pollute future paired diffs); flip to
+        // test.
+        // Sibling result: EP02 wMaxPacketSize logged = 1024, so a 64-byte msg0/arm always
+        // terminates
+        // as a natural short packet -- the ZLP-trap hypothesis is moot too.
+        const CLEAR_HALT_BEFORE_ARM: bool = false;
+        if CLEAR_HALT_BEFORE_ARM {
+            match dev.clear_halt(EP_CTRL_OUT) {
+                Ok(()) => pr_info!("vino: EP02 clear_halt before arm OK (toggle -> DATA0)\n"),
+                Err(e) => pr_info!("vino: EP02 clear_halt before arm non-fatal ({e:?})\n"),
+            }
+        }
+
+        // cert->arm fixed hold (the key `DLM_FIXED_TIMERS` lever). DLM arms a hardcoded
+        // CERT_TO_ARM_US (59.1 ms) after the dock's cert; vino's reactive settle arms the instant
+        // the AKE completes (~57.9 ms -- below DLM's observed minimum, i.e. always a hair EARLY).
+        // `hold_until` pads to exactly CERT_TO_ARM_US after the cert with udelay-grade precision (a
+        // plain fsleep overshot 59.1 -> 59.4 ms). If wait_cap_complete already ran past the target
+        // (dock slow), it returns at once -- we never arm *before* the window, only pad up to it.
+        if DLM_FIXED_TIMERS {
+            hold_until(session.cert_at, CERT_TO_ARM_US);
+        }
+
+        // Submit the arm marker. Async path: queue it and DO NOT flush -- leave it in flight so
+        // msg0 can be submitted right behind it (the pipelined arm->msg0 burst DLM does). Sync
+        // path: the original blocking send.
+        let arm_res = match out_q.as_mut() {
+            Some(q) => q.send(&STREAM_OPEN, timeout()),
+            None => dev.bulk_send(EP_CTRL_OUT, &STREAM_OPEN, timeout(), GFP_KERNEL).map(|_| ()),
+        };
+        if let Err(e) = arm_res {
+            pr_err!("vino: CP stream-open marker FAILED ({e:?})\n");
+            return Err(e);
+        }
+        // Report the realised `cp_start->arm` AND `cert->arm` so the cold-plug dmesg carries vino's
+        // pre-arm fingerprint for an A/B against DLM (cp_start->arm ~60 ms; cert->arm fixed 59.1 ms
+        // under DLM_FIXED_TIMERS). Microsecond precision. See the 2026-06-26 timing survey.
+        let arm_at = session.cp_start.elapsed();
+        let cert_to_arm = session.cert_at.elapsed().as_micros_ceil();
+        pr_info!(
+            "vino: CP stream-open arm marker sent (cp_start->arm = {} us, cert->arm = {} us, target {} us)\n",
+            arm_at.as_micros_ceil(), cert_to_arm, CERT_TO_ARM_US
+        );
+
+        // arm->msg0 hold. The 2026-06-25 timing survey found this is the ONE step where vino is
+        // consistently faster than DLM: vino fires msg0 ~0.07 ms after the arm, DLM ~0.17 ms -- the
+        // only timing inversion in the corpus, and never tested as a variable. Earlier this gap was
+        // left unpadded on the "engine is event-driven, sub-ms lead is immaterial" reasoning; the
+        // survey shows DLM's gap is a *fixed* ~0.17 ms (0.152/0.188 ms, 0.036 ms spread = a hard
+        // sleep, not a reaction), so under `DLM_FIXED_TIMERS` we hold [`ARM_TO_MSG0`] to match it
+        // exactly. If the dock keys engagement on msg0 not arriving before the arm has settled, this
+        // is the lever; if it engages, "msg0 too soon" was the gate. Cheap to A/B on one cold plug.
+        if DLM_FIXED_TIMERS {
+            fsleep(ARM_TO_MSG0);
+        }
+
+        // LIVE CP msg0: protocol-fixed header `id=0x14 sub=0x00 ctr=0x08`, 14 zero bytes, then a
+        // fresh host-random 10-byte token (the dock does not validate or echo it), sealed under
+        // THIS session's ks/riv with a live Dl3Cmac. This is the decisive engagement probe: a
+        // `wsub=0x45` reply would mean the cipher engaged on a live session.
+        let mut content = [0u8; 32];
+        content[0..2].copy_from_slice(&0x0014u16.to_le_bytes()); // id=0x14
+        content[4..8].copy_from_slice(&8u32.to_le_bytes()); // ctr=0x08 (sub=0x00 stays zero)
+        rng::fill(&mut content[22..32]); // host-random token
+        let body_len = content.len() + 16; // AES-CTR ciphertext + 16-byte Dl3Cmac
+        let size = ((16 + body_len) - 4) as u16;
+        let aux = cp::aux_for_id(0x14, body_len);
+        let mut hdr = [0u8; 16];
+        hdr[2..4].copy_from_slice(&size.to_le_bytes());
+        hdr[4..8].copy_from_slice(&4u32.to_le_bytes()); // type=4
+        hdr[8..10].copy_from_slice(&0x24u16.to_le_bytes()); // sub=0x24 (interactive CP)
+        hdr[10..12].copy_from_slice(&aux.to_le_bytes());
+        // hdr[12..16] = wire_seq = 0 (first CP block)
+        let frame = cp::seal_livemac(&session.ks, &session.riv, &hdr, &content)?;
+
+        let mut ok = false;
+        if let Some(q) = out_q.as_mut() {
+            // Async path: submit msg0 right behind the still-in-flight arm (pipelined burst),
+            // then drain EP84 while the HCD auto-retries any NAK against the live URB. Reap both
+            // OUT transfers; a flush timeout just means the dock NAK'd msg0 (URB killed at drop).
+            match q.send(&frame, timeout()) {
+                Ok(()) => {
+                    ok = true;
+                    pr_info!("vino: live CP msg0 submitted async (pipelined behind arm)\n");
+                }
+                Err(e) => pr_info!("vino: live CP msg0 async submit failed ({e:?})\n"),
+            }
+            for _ in 0..8 {
+                let (d, a) = Self::drain_ep84(dev, ep84_q.as_mut(), &mut resp, session, edid_out);
+                drained += d;
+                acks += a;
+                ep83_events += Self::drain_ep83_queue(ep83_q.as_mut());
+            }
+            match q.flush(Delta::from_millis(200)) {
+                Ok(()) => pr_info!("vino: async arm+msg0 reaped OK (both transfers completed)\n"),
+                Err(e) => pr_info!("vino: async arm+msg0 reap incomplete ({e:?}) -- dock NAK'd\n"),
+            }
+        } else {
+            // Sync path: single-packet msg0 => a NAK transfers nothing, so cancel+retry is safe.
+            // Between attempts drain EP84 so the dock can push/drain its IN queue. Bounded.
+            const TRIES: usize = 40;
+            for t in 0..TRIES {
+                match dev.bulk_send(EP_CTRL_OUT, &frame, Delta::from_millis(5), GFP_KERNEL) {
+                    Ok(_) => {
+                        ok = true;
+                        pr_info!("vino: live CP msg0 ACCEPTED after {t} interleaved tries\n");
+                        break;
+                    }
+                    // OUT NAK'd (nothing transferred) -- let the dock push on EP84, then retry.
+                    Err(_) => {
+                        let (d, a) =
+                            Self::drain_ep84(dev, ep84_q.as_mut(), &mut resp, session, edid_out);
+                        drained += d;
+                        acks += a;
+                        ep83_events += Self::drain_ep83_queue(ep83_q.as_mut());
+                    }
+                }
+            }
+        }
+        if ok {
+            sent += 1;
+            pr_info!("vino: live CP msg0 sent (id=0x14 ctr=8, random token, live seal)\n");
+        } else {
+            pr_info!("vino: live CP msg0 still NAK'd (no transfer accepted)\n");
+        }
+
+        // DLM sends the `0x24 wValue=0` render/commit vendor request right after msg0.
+        match dev.control_send(0x24, 0x40 /* VENDOR_OUT */, 0, 0, &[], timeout(), GFP_KERNEL) {
+            Ok(()) => pr_info!("vino: post-msg0 0x24(wValue=0) OK\n"),
+            Err(e) => pr_info!("vino: post-msg0 0x24(wValue=0) non-fatal ({e:?})\n"),
+        }
+        // DLM then re-reads the 0x22 vendor state (0xc1, wValue=1, wIndex=0, 28 B) -- its SECOND
+        // 0x22 of the session, immediately after the post-msg0 0x24. vino issued the first 0x22
+        // pre-arm but stopped here, leaving "DLM-ONLY 0x22" in the paired diff. Issue it
+        // unconditionally so the wire matches DLM regardless of whether the dock acks; it is a
+        // harmless vendor IN read. (0xc1 = IN|vendor|INTERFACE recipient, matching the first 0x22.)
+        let mut state2 = [0u8; 28];
+        match dev.control_recv(0x22, 0xc1, 1, 0, &mut state2, timeout(), GFP_KERNEL) {
+            Ok(()) => pr_info!("vino: post-msg0 0x22(wValue=1) OK = {:02x?}\n", state2),
+            Err(e) => pr_info!("vino: post-msg0 0x22(wValue=1) non-fatal ({e:?})\n"),
+        }
+
+        // Read the dock's reply: a `wsub=0x45` ack means the cipher engaged on our live frame.
+        let (d, a, _m) = Self::lockstep_reply(dev, ep84_q.as_mut(), &mut resp, session, 0x08, edid_out);
+        drained += d;
+        acks += a;
+
+        const MAX_ROUNDS: usize = 16;
+        for _ in 0..MAX_ROUNDS {
+            let (d, a) = Self::drain_ep84(dev, ep84_q.as_mut(), &mut resp, session, edid_out);
+            drained += d;
+            acks += a;
+            if d == 0 {
+                break;
+            }
+        }
+
+        // ---- Post-engagement live setup (CP-HANDSHAKE.md sec 4f/sec 4e) ------------------------
+        // Only meaningful once the dock has acked msg0: ask the dock for the downstream EDID,
+        // then build the mode-set from its preferred timing and send that -- the live path that
+        // replaces the static 1080p modeset and the opportunistic-only EDID capture. On a cold
+        // dock `acks` stays 0 (the wall), so this does not run on current hardware; it completes
+        // the standalone live-generation flow for when the engagement gate is solved.
+        // The next free AES-CTR block index past this setup, handed to the DRM device so runtime
+        // KMS sends (mode-set/cursor) continue the same keystream. Defaults to msg0's end (2) when
+        // the live block below doesn't run (no acks) -- irrelevant then, since we only publish the
+        // session when `acks > 0`.
+        let mut wire_seq_end = 2u32;
+        if acks > 0 {
+            // `wseq` continues the AES-CTR block counter past msg0 (32 B content = 2 blocks);
+            // the inner `counter` continues past msg0's ctr=8. The dock echoes both, so the
+            // exact values only need to stay monotonic / non-overlapping for the keystream.
+            let mut wseq = 2u32;
+
+            // (1) Live get-EDID request -> the dock replies id=0x194; `drain_ep84` (called inside
+            // `send_live_cp`) decodes it and fills `edid_out` via `parse_edid_from_reply`.
+            if let Ok(req) = cp::get_edid_req(9) {
+                match Self::send_live_cp(
+                    dev, session, ep84_q.as_mut(), &mut resp, edid_out, 0x15, wseq, &req,
+                ) {
+                    Ok((ok, d, a)) => {
+                        drained += d;
+                        acks += a;
+                        wseq = wseq.wrapping_add(((req.len() + 15) / 16) as u32);
+                        pr_info!("vino: live get-EDID request {}\n",
+                            if ok { "sent (id=0x15 sub=0x21)" } else { "NAK'd" });
+                    }
+                    Err(e) => pr_info!("vino: live get-EDID request failed ({e:?})\n"),
+                }
+            }
+
+            // (2) Dynamic mode-set from the dock's EDID preferred detailed timing, falling back to
+            // the known-good UHD_60 timing when no EDID/DTD is available.
+            let from_edid = edid_out.is_some();
+            let timing = edid_out
+                .as_deref()
+                .and_then(cp::timing_from_edid)
+                .unwrap_or(cp::Timing::UHD_60);
+            match cp::set_mode(10, &timing) {
+                Ok(smode) => {
+                    // `set_mode` reserves a trailing 16-byte tag region; `seal_livemac` appends a
+                    // fresh live Dl3Cmac, so hand it the inner content without that region.
+                    let content = &smode[..smode.len().saturating_sub(16)];
+                    match Self::send_live_cp(
+                        dev, session, ep84_q.as_mut(), &mut resp, edid_out, 0x48, wseq, content,
+                    ) {
+                        Ok((ok, d, a)) => {
+                            drained += d;
+                            acks += a;
+                            pr_info!("vino: live mode-set {} ({}x{}@{} from {})\n",
+                                if ok { "sent" } else { "NAK'd" },
+                                timing.hactive, timing.vactive, timing.refresh_hz,
+                                if from_edid { "EDID" } else { "fallback" });
+                        }
+                        Err(e) => pr_info!("vino: live mode-set failed ({e:?})\n"),
+                    }
+                    // Advance the keystream past this mode-set so runtime KMS sends continue it.
+                    wseq = wseq.wrapping_add(((content.len() + 15) / 16) as u32);
+                }
+                Err(e) => pr_info!("vino: mode-set build failed ({e:?})\n"),
+            }
+            wire_seq_end = wseq;
+        }
+
+        // Final sweep of the EP83 interrupt queue so a status byte the dock pushed late (after the
+        // arm/msg0 burst settled) is still counted before the queue is dropped.
+        for _ in 0..4 {
+            let e = Self::drain_ep83_queue(ep83_q.as_mut());
+            ep83_events += e;
+            if e == 0 {
+                break;
+            }
+        }
+        let engaged = if acks > 0 { "dock engaged" } else { "dock ignoring our CP (the wall)" };
+        pr_info!("vino: CP setup sent={sent} EP84_resp={drained} sub=0x45_acks={acks} EP83_events={ep83_events} ({engaged})\n");
+        // Inner counter past the bring-up CP messages (msg0=8, get-EDID=9, mode-set=10).
+        Ok((sent, acks, wire_seq_end, 11))
+    }
+
+
+    /// Seal `content` (inner CP plaintext, WITHOUT the 16-byte tag region) into a live
+    /// `type=4 sub=0x24` frame at `wire_seq`, send it on EP02 with EP84 drained between NAK
+    /// retries (the single-packet interleave discipline msg0 uses), then drain once more to
+    /// collect the dock's reply. `id` selects the DLM-exact `aux` header field
+    /// ([`cp::aux_for_id`]). Returns `(sent_ok, ep84_reads, sub=0x45_acks)`. Used for the
+    /// post-engagement live messages (get-EDID, mode-set) once the dock has acked msg0.
+    fn send_live_cp(
+        dev: &usb::Interface<device::Bound>,
+        session: &Session,
+        mut q: Option<&mut usb::BulkInQueue>,
+        resp: &mut [u8],
+        edid_out: &mut Option<KVec<u8>>,
+        id: u16,
+        wire_seq: u32,
+        content: &[u8],
+    ) -> Result<(bool, usize, usize)> {
+        let frame = cp::seal_interactive(&session.ks, &session.riv, id, wire_seq, content)?;
+
+        // Single-packet OUT: a NAK transfers nothing, so cancel+retry is safe. Between attempts
+        // drain EP84 so the dock can push/drain its IN queue (matches msg0's behaviour).
+        const TRIES: usize = 40;
+        let mut ok = false;
+        let mut drained = 0usize;
+        let mut acks = 0usize;
+        for _ in 0..TRIES {
+            match dev.bulk_send(EP_CTRL_OUT, &frame, Delta::from_millis(5), GFP_KERNEL) {
+                Ok(_) => {
+                    ok = true;
+                    break;
+                }
+                Err(_) => {
+                    let (d, a) = Self::drain_ep84(dev, q.as_deref_mut(), resp, session, edid_out);
+                    drained += d;
+                    acks += a;
+                }
+            }
+        }
+        // Collect the dock's reply (the get-EDID id=0x194 frame is captured here via drain_ep84).
+        let (d, a) = Self::drain_ep84(dev, q.as_deref_mut(), resp, session, edid_out);
+        drained += d;
+        acks += a;
+        Ok((ok, drained, acks))
+    }
+
+
+    /// sec 5 read-only diagnostic: log one dock->host EP84 frame's wire header
+    /// (`type`@4, `sub`@8, `aux`@10, `seq`@12) and, when the body decrypts under the IN
+    /// keystream, its inner `(id, sub, ictr)`. Surfaces EVERY frame the dock returns --
+    /// not just `sub=0x45` -- so a hardware run reveals whether the dock is mute, NAKing,
+    /// or replying with an unexpected sub. Pure logging; no state change.
+    fn log_ep84(session: &Session, frame: &[u8]) {
+        let len = frame.len();
+        let wtype = if len >= 8 {
+            u32::from_le_bytes([frame[4], frame[5], frame[6], frame[7]])
+        } else {
+            0
+        };
+        let wsub = if len >= 10 { u16::from_le_bytes([frame[8], frame[9]]) } else { 0 };
+        let aux = if len >= 12 { u16::from_le_bytes([frame[10], frame[11]]) } else { 0 };
+        let wseq = if len >= 16 {
+            u32::from_le_bytes([frame[12], frame[13], frame[14], frame[15]])
+        } else {
+            0
+        };
+        {
+            // Dev diagnostic (pr_debug, compiled out unless dynamic debug is enabled): the raw
+            // wire, so the dock's pushes can be offline-decoded. The dock's large capability block
+            // (~5787 B) must be dumped in 128-byte CHUNKS, because a single hex print of a
+            // >~250-byte
+            // array exceeds printk's per-line limit. Capped at 768 B (6 lines) to avoid flooding.
+            let cap = len.min(768);
+            if cap <= 64 {
+                let raw = &frame[..cap];
+                pr_debug!("vino: dock EP84 RAW {len}B {raw:02x?}\n");
+            } else {
+                pr_debug!("vino: dock EP84 RAW {len}B (first {cap} B in 128-B chunks):\n");
+                let mut o = 0usize;
+                while o < cap {
+                    let e = (o + 128).min(cap);
+                    let chunk = &frame[o..e];
+                    pr_debug!("vino:   ep84[{o:#06x}] {chunk:02x?}\n");
+                    o = e;
+                }
+            }
+        }
+        match cp::decode_any(&session.ks, &session.riv, frame) {
+            Some((rivtag, rid, rsub, rictr, sample)) => {
+                pr_info!(
+                    "vino: dock EP84 type={wtype} wsub={wsub:#x} aux={aux:#x} seq={wseq:#x} {len}B -> [{rivtag}] id={rid:#x} sub={rsub:#x} ictr={rictr:#x} pt={sample:02x?}\n"
+                );
+            }
+            None => {
+                pr_info!(
+                    "vino: dock EP84 type={wtype} wsub={wsub:#x} aux={aux:#x} seq={wseq:#x} {len}B (no inner decode)\n"
+                );
+            }
+        }
+    }
+
+    /// Read one EP84 frame: from the persistent async queue `q` when [`CP_ASYNC_EP84`] has opened
+    /// one, else a synchronous `bulk_recv`. The queue's timeout (`Ok(None)`) is mapped to
+    /// `Err(ETIMEDOUT)` so the callers' existing match arms (which treat any `Err`/empty as
+    /// "no more data right now") work unchanged across both paths.
+    fn read_ep84(
+        dev: &usb::Interface<device::Bound>,
+        q: Option<&mut usb::BulkInQueue>,
+        buf: &mut [u8],
+        to: Delta,
+    ) -> Result<usize> {
+        match q {
+            Some(queue) => match queue.recv(buf, to) {
+                Ok(Some(n)) => Ok(n),
+                Ok(None) => Err(ETIMEDOUT),
+                Err(e) => Err(e),
+            },
+            None => dev.bulk_recv(EP_CTRL_IN, buf, to, GFP_KERNEL),
+        }
+    }
+
+
+    fn drain_ep84(
+        dev: &usb::Interface<device::Bound>,
+        mut q: Option<&mut usb::BulkInQueue>,
+        buf: &mut [u8],
+        session: &Session,
+        edid_out: &mut Option<KVec<u8>>,
+    ) -> (usize, usize) {
+        const MAX_READS: usize = 16;
+        let mut n = 0usize;
+        let mut acks = 0usize;
+        // Read EP84 FIRST (the dock answers in ~0.14 ms, same as it does for DLM). The EP83 status
+        // poll is serviced AFTER -- polling it before the EP84 read blocked the critical path for
+        // up
+        // to 30 ms PER cap frame (timeline diff 2026-06-11: vino's cap phase was 446 ms / ~32 ms
+        // per
+        // frame vs DLM's 60 ms / 0.14 ms, purely from this ordering), arming the dock ~1 s late.
+        for _ in 0..MAX_READS {
+            match Self::read_ep84(dev, q.as_deref_mut(), buf, Delta::from_millis(10)) {
+                Ok(len) if len > 0 => {
+                    n += 1;
+                    // sec 5 diagnostic: surface EVERY dock->host frame, not just `sub=0x45`,
+                    // so a hardware run shows what the dock actually returns (a different
+                    // sub, a NAK, or plaintext) instead of a bare `EP84_resp=N` count.
+                    Self::log_ep84(session, &buf[..len]);
+                    if len >= 10 && u16::from_le_bytes([buf[8], buf[9]]) == 0x45 {
+                        acks += 1;
+                        // Capture the dock's EDID the first time it appears (id=0x94
+                        // sub=0x21 reply to the replayed get-EDID request). Reuses the
+                        // standard DRM EDID infra in get_modes. See CONTROL-PLANE.md.
+                        if edid_out.is_none() {
+                            if let Ok(Some(e)) =
+                                cp::parse_edid_from_reply(&session.ks, &session.riv, &buf[..len])
+                            {
+                                pr_info!("vino: EDID read from dock ({} bytes)\n", e.len());
+                                *edid_out = Some(e);
+                            }
+                        }
+                    }
+                }
+                _ => break,
+            }
+        }
+        // Service EP83 AFTER draining EP84, so it never delays reading the dock's CP reply.
+        if Self::POLL_EP83_DURING_BRINGUP {
+            Self::poll_ep83(dev);
+        }
+        (n, acks)
+    }
+
+
+    /// Lockstep counterpart to [`drain_ep84`]: after one CP OUT, drain EP84 until the
+    /// `sub=0x45` reply whose **inner counter echoes** `ictr` arrives (DLM's 1:1
+    /// handshake) or the short read budget elapses. Any async
+    /// pushes seen meanwhile are still counted and scanned for the EDID. Returns
+    /// `(reads, acks, matched)`.
+    fn lockstep_reply(
+        dev: &usb::Interface<device::Bound>,
+        mut q: Option<&mut usb::BulkInQueue>,
+        buf: &mut [u8],
+        session: &Session,
+        ictr: u16,
+        edid_out: &mut Option<KVec<u8>>,
+    ) -> (usize, usize, bool) {
+        const MAX_READS: usize = 8;
+        let in_riv = cp::in_riv(&session.riv);
+        let mut reads = 0usize;
+        let mut acks = 0usize;
+        let mut matched = false;
+        for _ in 0..MAX_READS {
+            match Self::read_ep84(dev, q.as_deref_mut(), buf, Delta::from_millis(30)) {
+                Ok(len) if len > 16 => {
+                    reads += 1;
+                    // sec 5 diagnostic: log every frame the dock returns in the lockstep
+                    // window -- including the non-`0x45` frames we otherwise skip -- so the
+                    // divergence point is paired with the dock's actual reply on the wire.
+                    Self::log_ep84(session, &buf[..len]);
+                    if u16::from_le_bytes([buf[8], buf[9]]) != 0x45 {
+                        continue;
+                    }
+                    acks += 1;
+                    let seq = u32::from_le_bytes([buf[12], buf[13], buf[14], buf[15]]);
+                    // Decrypt just the first block to read the inner counter (off 4).
+                    let head = &buf[16..len.min(32)];
+                    if let Ok(inner) = cp::open_in(&session.ks, &in_riv, seq, head) {
+                        if inner.len() >= 6
+                            && u16::from_le_bytes([inner[4], inner[5]]) == ictr
+                        {
+                            matched = true;
+                        }
+                    }
+                    // Opportunistically capture the EDID (id=0x94 reply, off 22).
+                    if edid_out.is_none() {
+                        if let Ok(Some(e)) =
+                            cp::parse_edid_from_reply(&session.ks, &session.riv, &buf[..len])
+                        {
+                            pr_info!("vino: EDID read from dock ({} bytes)\n", e.len());
+                            *edid_out = Some(e);
+                        }
+                    }
+                    if matched {
+                        break;
+                    }
+                }
+                // A short, header-only frame (bare ack/keepalive, len <= 16): not a CP
+                // reply, but the dock is still talking -- keep reading for the 0x45 rather
+                // than dropping the rest of the lockstep window.
+                Ok(_) => continue,
+                // Read error / nothing queued within the window: the dock is idle, stop.
+                Err(_) => break,
+            }
+        }
+        (reads, acks, matched)
+    }
+}
+
+kernel::usb_device_table!(
+    USB_TABLE,
+    MODULE_USB_TABLE,
+    <VinoDriver as usb::Driver>::IdInfo,
+    [(usb::DeviceId::from_id(VID_DISPLAYLINK, PID_D6000), ())]
+);
+
+impl usb::Driver for VinoDriver {
+    type IdInfo = ();
+    // The driver instance is itself the per-bound device-private data.
+    type Data<'bound> = Self;
+    const ID_TABLE: usb::IdTable<Self::IdInfo> = &USB_TABLE;
+
+    fn probe<'bound>(
+        intf: &'bound usb::Interface<Core<'_>>,
+        _id: &usb::DeviceId,
+        _info: &'bound Self::IdInfo,
+    ) -> impl PinInit<Self, Error> + 'bound {
+        let cdev: &device::Device<Core<'_>> = intf.as_ref();
+        // The D6000 exposes several interfaces (0/1/5/6 match us; 2-4 are audio).
+        // The control endpoints (0x02/0x84) and the whole HDCP session live on
+        // interface 0 -- drive bring-up only there so we don't run the preamble and
+        // AKE four times and pollute the dock's state machine. Other interfaces
+        // bind (so usbcore doesn't hand them to another driver) but stay idle.
+        let ifnum = intf.number();
+        if ifnum != 0 {
+            // Interface 1 (app-specific/DFU) is the only other one DLM claims; let everything else
+            // (audio 2-4, Ethernet 5-6) fall through to its proper kernel driver. Returning ENODEV
+            // tells usbcore this driver doesn't handle the interface, so it tries the next match.
+            if ifnum != 1 {
+                dev_info!(cdev, "vino: declining D6000 interface {ifnum} (left to its class driver)\n");
+                return Err(ENODEV);
+            }
+            dev_info!(cdev, "vino: bound D6000 interface {ifnum} (idle -- control is iface 0)\n");
+            return Ok(Self { _intf: intf.into(), _ddev: None, bringup: None });
+        }
+        dev_info!(cdev, "vino: bound DisplayLink D6000 -- plaintext session bring-up\n");
+
+        // Phase 3: register a real DRM/KMS device on the control interface so the dock
+        // shows up as a mode-settable `card`/`renderD` node (atomic KMS via the simple
+        // display pipe, one 1080p virtual connector, GEM-shmem dumb buffers). Non-fatal:
+        // bring-up still proceeds (and the interface still binds) if any step fails, so
+        // a DRM-core hiccup can't regress the USB session work.
+        // Hold a refcounted handle to the bound interface; one copy goes into the DRM
+        // device-private (for the EP08 scanout path), one stays in `VinoDriver`.
+        let intf_ref: ARef<usb::Interface> = intf.into();
+        // DRM device lifecycle (drm-rust API): allocate an `UnregisteredDevice`, wire up
+        // the KMS pipeline on it while still unregistered, then hand it to
+        // `Registration::new_foreign_owned` (which registers it and ties its lifetime to
+        // the bound USB device via devres, returning a borrowed `&Device`).
+        let ddev: Option<ARef<drm_sink::VinoDrmDevice>> =
+            match drm::UnregisteredDevice::<drm_sink::VinoDrmDriver>::new(
+                intf,
+                drm_sink::VinoDrmData::new(intf_ref.clone()),
+            ) {
+                // `probe_kms()` (which calls our `KmsDriver::probe()` to build the CRTC/
+                // plane/connector/encoder) runs automatically inside `UnregisteredDevice::new`
+                // above -- there is no separate KMS init step to call.
+                Ok(unreg) => match drm::driver::Registration::new_foreign_owned(unreg, cdev, (), 0) {
+                    Ok(reg_dev) => {
+                        dev_info!(cdev, "vino: DRM+KMS device registered (card node live, 1080p)\n");
+                        Some(reg_dev.into())
+                    }
+                    Err(e) => {
+                        dev_info!(cdev, "vino: DRM registration failed ({e:?}) -- continuing without card node\n");
+                        None
+                    }
+                },
+                Err(e) => {
+                    dev_info!(cdev, "vino: drm::UnregisteredDevice::new failed ({e:?}) -- continuing\n");
+                    None
+                }
+            };
+
+        // Bring-up (preamble + HDCP AKE + ~6 s of lockstep CP replay) is all blocking
+        // synchronous USB I/O. Running it inline here pins the USB driver-model probe
+        // thread while the DRM card node is already registered and live, which stalled
+        // the compositor (KWin) on first plug until the dock was physically yanked. Hand
+        // it to the system workqueue so `probe()` returns immediately and userspace KMS
+        // stays responsive. The work item holds refcounted handles to the interface (for
+        // the bulk endpoints) and the DRM device (for EDID caching), so they outlive
+        // `probe()`; USB I/O after an intervening disconnect simply errors and is logged,
+        // exactly like any other failed bring-up step.
+        // Retain the bring-up handle so `disconnect()` can flush it; enqueue a clone.
+        let bringup = match BringUp::new(intf_ref.clone(), ddev.clone()) {
+            Ok(work) => {
+                let _ = workqueue::system().enqueue(work.clone());
+                dev_info!(cdev, "vino: bring-up queued on system workqueue\n");
+                Some(work)
+            }
+            Err(e) => {
+                dev_info!(cdev, "vino: failed to queue bring-up ({e:?}) -- WIP\n");
+                None
+            }
+        };
+
+        Ok(Self { _intf: intf_ref, _ddev: ddev, bringup })
+    }
+
+    fn disconnect<'bound>(intf: &'bound usb::Interface<Core<'_>>, data: Pin<&Self>) {
+        let dev: &device::Device<Core<'_>> = intf.as_ref();
+        // Flush the deferred bring-up before the interface is unbound: `cancel_work_sync`
+        // dequeues it if pending and blocks until it returns if already running, so no
+        // USB I/O races the unbind (see the `Interface::as_bound` contract in
+        // `BringUp::run`). Safe to call when the work already finished or never ran.
+        if let Some(work) = data.bringup.as_ref() {
+            // SAFETY: `work.work` is a live `Work` field of a pinned, refcounted `BringUp`;
+            // `raw_get` yields its valid `work_struct`, which `cancel_work_sync` only reads
+            // and synchronises against. The `Arc` keeps the allocation alive across the call.
+            unsafe {
+                let wptr = Work::raw_get(core::ptr::addr_of!(work.work));
+                bindings::cancel_work_sync(wptr);
+            }
+        }
+        dev_info!(dev, "vino: D6000 disconnected\n");
+    }
+}
+
+kernel::module_usb_driver! {
+    type: VinoDriver,
+    name: "vino",
+    authors: ["Mike Lothian"],
+    description: "DisplayLink DL3 (Vino) open driver",
+    license: "GPL v2",
+}
+
+/// Build a minimal valid 128-byte EDID with a 1920x1080@60 detailed timing at base-block
+/// offset `dtd_at` (54 = preferred slot), a correct checksum, and the standard magic.
+#[cfg(CONFIG_KUNIT)]
+fn mk_test_edid(dtd_at: usize) -> [u8; 128] {
+    let mut e = [0u8; 128];
+    e[..8].copy_from_slice(&[0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00]);
+    // 1920x1080@60: pclk 14850 (148.5 MHz, 10 kHz units); hblank 280, vblank 45;
+    // hsync_front 88, hsync_width 44, vsync_front 4, vsync_width 5.
+    let dtd: [u8; 18] = [
+        0x02, 0x3a, // pixel clock 0x3a02 LE
+        0x80, 0x18, 0x71, // hactive 1920 / hblank 280 (high nibbles in byte 4)
+        0x38, 0x2d, 0x40, // vactive 1080 / vblank 45 (high nibbles in byte 7)
+        0x58, 0x2c, 0x45, 0x00, // hsync/vsync front+width
+        0, 0, 0, 0, 0, 0, // trailing flags (DTD is 18 bytes total)
+    ];
+    e[dtd_at..dtd_at + 18].copy_from_slice(&dtd);
+    let s = e[..127].iter().fold(0u8, |a, &b| a.wrapping_add(b));
+    e[127] = 0u8.wrapping_sub(s); // base-block checksum: all 128 bytes sum to 0
+    e
+}
+
+/// Offline self-tests for the pure protocol builders/parsers and the crypto bindings the
+/// control plane relies on. Gated behind `CONFIG_KUNIT` (the macro adds the cfg), so they
+/// have zero effect on a production build; run with a KUnit-enabled kernel. The crypto cases
+/// are published known-answer vectors (FIPS-197 AES-128, RFC 4493 AES-CMAC); the seal case is
+/// a live round-trip; the rest pin wire layout and EDID parsing that have no hardware oracle.
+#[kunit_tests(vino_protocol)]
+mod tests {
+    use super::*;
+    use kernel::error::code::EINVAL;
+
+    #[test]
+    fn aes128_ecb_fips197_kat() -> Result {
+        // FIPS-197 / NIST SP800-38A F.1.1 AES-128 ECB known-answer vector.
+        let key = [
+            0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf,
+            0x4f, 0x3c,
+        ];
+        let pt = [
+            0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93,
+            0x17, 0x2a,
+        ];
+        assert_eq!(
+            crypto::aes128_ecb(&key, &pt)?,
+            [
+                0x3a, 0xd7, 0x7b, 0xb4, 0x0d, 0x7a, 0x36, 0x60, 0xa8, 0x9e, 0xca, 0xf3, 0x24, 0x66,
+                0xef, 0x97,
+            ]
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn aes_cmac_rfc4493_kat() -> Result {
+        // RFC 4493 sec 4 AES-CMAC test vectors (same key as above).
+        let key = [
+            0x2b, 0x7e, 0x15, 0x16, 0x28, 0xae, 0xd2, 0xa6, 0xab, 0xf7, 0x15, 0x88, 0x09, 0xcf,
+            0x4f, 0x3c,
+        ];
+        assert_eq!(
+            crypto::aes_cmac(&key, &[]),
+            [
+                0xbb, 0x1d, 0x69, 0x29, 0xe9, 0x59, 0x37, 0x28, 0x7f, 0xa3, 0x7d, 0x12, 0x9b, 0x75,
+                0x67, 0x46,
+            ]
+        );
+        let msg = [
+            0x6b, 0xc1, 0xbe, 0xe2, 0x2e, 0x40, 0x9f, 0x96, 0xe9, 0x3d, 0x7e, 0x11, 0x73, 0x93,
+            0x17, 0x2a,
+        ];
+        assert_eq!(
+            crypto::aes_cmac(&key, &msg),
+            [
+                0x07, 0x0a, 0x16, 0xb4, 0x6b, 0x4d, 0x41, 0x44, 0xf7, 0x9b, 0xdd, 0x9d, 0xd0, 0x4a,
+                0x28, 0x7c,
+            ]
+        );
+        Ok(())
+    }
+
+    #[test]
+    fn seal_livemac_roundtrip() -> Result {
+        // A sealed CP frame must decrypt back to its content under the IN riv, and its
+        // appended tag must equal a fresh Dl3Cmac over the ciphertext (encrypt-then-MAC).
+        let ks = [
+            0x00, 0x11, 0x22, 0x33, 0x44, 0x55, 0x66, 0x77, 0x88, 0x99, 0xaa, 0xbb, 0xcc, 0xdd,
+            0xee, 0xff,
+        ];
+        let riv = [0x10, 0x11, 0x12, 0x13, 0x14, 0x15, 0x16, 0x17];
+        let content = [0xa5u8; 32];
+        let mut hdr = [0u8; 16];
+        hdr[12..16].copy_from_slice(&4u32.to_le_bytes()); // wire_seq = 4
+        let frame = cp::seal_livemac(&ks, &riv, &hdr, &content)?;
+        assert_eq!(frame.len(), 16 + 32 + 16);
+        let ct = &frame[16..16 + 32];
+        assert_eq!(&cp::open_in(&ks, &cp::in_riv(&riv), 4, ct)?[..], &content[..]);
+        assert_eq!(&frame[16 + 32..], &cp::dl3cmac_tag(&ks, &riv, 4, ct)?[..]);
+        Ok(())
+    }
+
+    #[test]
+    fn aux_for_id_constants() {
+        // The CP header `aux` field is a per-inner-id constant, not body_len/4.
+        assert_eq!(cp::aux_for_id(0x14, 48), 0x0a);
+        assert_eq!(cp::aux_for_id(0x15, 32), 0x09);
+        assert_eq!(cp::aux_for_id(0x48, 96), 0x06);
+        // Cursor ids recovered from the cold-ref differential (scripts/verify-cp-seal.py):
+        // body_len/4 (here 0x0c) would be wrong for all three.
+        assert_eq!(cp::aux_for_id(0x1a, 48), 0x04); // cursor move
+        assert_eq!(cp::aux_for_id(0x1b, 48), 0x03); // cursor create
+        assert_eq!(cp::aux_for_id(0x1c, 48), 0x02); // cursor image
+        assert_eq!(cp::aux_for_id(0x99, 40), 10); // unknown id falls back to body_len/4
+    }
+
+    #[test]
+    fn edid_timing_parse_and_validate() {
+        // A well-formed EDID yields the DTD timing; a bad checksum is rejected; a leading
+        // monitor descriptor (pclk 0) does not hide the preferred timing in a later slot.
+        let edid = mk_test_edid(54);
+        let t = cp::timing_from_edid(&edid).expect("valid EDID parses");
+        assert_eq!(t.hactive, 1920);
+        assert_eq!(t.vactive, 1080);
+        assert_eq!(t.refresh_hz, 60);
+        assert_eq!(t.pixel_clock_10khz, 14850);
+
+        let mut bad = edid;
+        bad[127] ^= 0xff;
+        // bad checksum must be rejected
+        assert!(cp::timing_from_edid(&bad).is_none());
+
+        let scanned = mk_test_edid(72); // off54 left as a zero (monitor) descriptor
+        assert_eq!(
+            cp::timing_from_edid(&scanned).expect("scans past off54").hactive,
+            1920
+        );
+    }
+
+    #[test]
+    fn edid_reply_guards() -> Result {
+        // The pre-decrypt guards reject non-EDID frames without touching the cipher.
+        let ks = [0u8; 16];
+        let riv = [0u8; 8];
+        assert!(cp::parse_edid_from_reply(&ks, &riv, &[0u8; 10])?.is_none());
+        let mut wrong_sub = [0u8; 20];
+        wrong_sub[8] = 0x44; // wire sub != 0x45
+        assert!(cp::parse_edid_from_reply(&ks, &riv, &wrong_sub)?.is_none());
+        Ok(())
+    }
+
+    #[test]
+    fn rgb565_packing() {
+        assert_eq!(video::rgb565(0xff, 0x00, 0x00), 0xf800);
+        assert_eq!(video::rgb565(0x00, 0xff, 0x00), 0x07e0);
+        assert_eq!(video::rgb565(0x00, 0x00, 0xff), 0x001f);
+        let _ = EINVAL; // silence unused import on configs without the assert paths
+    }
+
+    #[test]
+    fn cursor_messages_structure() -> Result {
+        // The shared 32-byte cursor layout (recovered byte-exact from the cold-ref session by
+        // scripts/verify-cp-seal.py): marker 0x02 @22, head_id @23, two LE u16 fields @24/@26.
+        // Create (head 0): id=0x1b sub=0x42, fields = w,h.
+        let c = cp::cursor_create(7, 0, 64, 64)?;
+        assert_eq!(c.len(), 32);
+        assert_eq!(&c[0..6], &[0x1b, 0x00, 0x42, 0x00, 0x07, 0x00]); // id, sub, counter (LE)
+        assert_eq!(c[22], 0x02); // marker
+        assert_eq!(c[23], 0); // head id
+        assert_eq!(u16::from_le_bytes([c[24], c[25]]), 64); // width
+        assert_eq!(u16::from_le_bytes([c[26], c[27]]), 64); // height
+
+        // Move (head 1): id=0x1a sub=0x43, marker@22, head@23, X@24, Y@26 (LE).
+        let m = cp::cursor_move(9, 1, 0x0140, 0x00f0)?;
+        assert_eq!(m.len(), 32);
+        assert_eq!(&m[0..4], &[0x1a, 0x00, 0x43, 0x00]); // id, sub
+        assert_eq!(m[22], 0x02); // marker
+        assert_eq!(m[23], 1); // head id
+        assert_eq!(u16::from_le_bytes([m[24], m[25]]), 0x0140); // X
+        assert_eq!(u16::from_le_bytes([m[26], m[27]]), 0x00f0); // Y
+
+        // Image: 32-byte header (inner id 0x401c, the 0x40 bitmap flag) + w*h*4 BGRA at off32;
+        // wrong-size input rejected.
+        let bitmap = KVec::from_elem(0xabu8, 64 * 64 * 4, GFP_KERNEL)?;
+        let img = cp::cursor_image(3, 0, 64, 64, &bitmap)?;
+        assert_eq!(img.len(), 32 + 64 * 64 * 4);
+        assert_eq!(&img[0..4], &[0x1c, 0x40, 0x41, 0x00]); // inner id 0x401c, sub 0x41
+        assert_eq!(img[22], 0x02); // marker
+        assert_eq!(img[32], 0xab); // bitmap begins at off32
+        assert!(cp::cursor_image(3, 0, 64, 64, &[0u8; 16]).is_err()); // wrong bitmap length
+        Ok(())
+    }
+
+    #[test]
+    fn timing_from_drm_mode_1080p60() {
+        // CEA 1920x1080@60: clock 148.5 MHz, h 2008/2052/2200, v 1084/1089/1125.
+        let mut m = bindings::drm_display_mode::default();
+        m.clock = 148_500; // kHz
+        m.hdisplay = 1920;
+        m.hsync_start = 2008;
+        m.hsync_end = 2052;
+        m.htotal = 2200;
+        m.vdisplay = 1080;
+        m.vsync_start = 1084;
+        m.vsync_end = 1089;
+        m.vtotal = 1125;
+        // SAFETY: `m` is a fully-initialised local drm_display_mode.
+        let t = unsafe { cp::timing_from_drm_mode(&m) };
+        assert_eq!(t.hactive, 1920);
+        assert_eq!(t.hblank, 280); // htotal - hdisplay
+        assert_eq!(t.hsync_front, 88); // hsync_start - hdisplay
+        assert_eq!(t.hsync_width, 44); // hsync_end - hsync_start
+        assert_eq!(t.vactive, 1080);
+        assert_eq!(t.vblank, 45); // vtotal - vdisplay
+        assert_eq!(t.vsync_front, 4);
+        assert_eq!(t.vsync_width, 5);
+        assert_eq!(t.pixel_clock_10khz, 14_850); // clock(kHz) / 10
+        assert_eq!(t.refresh_hz, 60); // via drm_mode_vrefresh
+    }
+
+    #[test]
+    fn rotation_pixel_mapping() {
+        use bindings::{
+            DRM_MODE_REFLECT_X, DRM_MODE_ROTATE_0, DRM_MODE_ROTATE_180, DRM_MODE_ROTATE_270,
+            DRM_MODE_ROTATE_90,
+        };
+        // Source 2x3 (sw=2, sh=3). 0deg is identity; 180deg mirrors both axes.
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_0, 0, 0, 2, 3), (0, 0));
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_0, 1, 2, 2, 3), (1, 2));
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_180, 0, 0, 2, 3), (1, 2));
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_180, 1, 2, 2, 3), (0, 0));
+        // 90deg: output dims are (sh,sw)=(3,2); (dx,dy) -> (dy, sh-1-dx).
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_90, 0, 0, 2, 3), (0, 2));
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_90, 2, 1, 2, 3), (1, 0));
+        // 270deg: (dx,dy) -> (sw-1-dy, dx).
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_270, 0, 0, 2, 3), (1, 0));
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_270, 2, 1, 2, 3), (0, 2));
+        // Reflect-X composes on top of the rotation (here identity): sx -> sw-1-sx.
+        assert_eq!(drm_sink::rot_src(DRM_MODE_ROTATE_0 | DRM_MODE_REFLECT_X, 0, 0, 2, 3), (1, 0));
+    }
+
+    #[test]
+    fn wht_colour_and_quantize() {
+        use video::wht;
+        // Colour transform vs DLM's transform-DC ground truth (validate-transform-encoderio):
+        // white -> Y=16320, achromatic -> Cb=Cr=0, and the reversible luma Y = 64G +
+        // 64*((Cb+Cr)>>2) reproduces every measured colour. Red's Y is 4032 (= 64*((255)>>2)
+        // = 64*63), NOT the old un-floored 16*255 = 4080 (which ran 48 high; see `colour`).
+        assert_eq!(wht::colour(255, 255, 255), (16320, 0, 0));
+        assert_eq!(wht::colour(128, 128, 128), (128 * 64, 0, 0)); // gray: chroma zero
+        assert_eq!(wht::colour(255, 0, 0), (4032, 64 * 255, 0)); // red: Y floored, Cb>0, Cr=0
+        assert_eq!(wht::colour(0, 255, 0), (8128, -64 * 255, -64 * 255)); // green (signed chroma)
+        assert_eq!(wht::colour(0, 0, 255), (4032, 0, 64 * 255)); // blue
+        // The documented ground-truth vector: white Y_DC=16320 quantizes (DC, position 0) to 1020.
+        assert_eq!(wht::quantize(16320, 0), 1020);
+        // AC clamps to the 12-bit signed long-token range.
+        assert_eq!(wht::quantize(1_000_000, 16), 2047);
+        assert_eq!(wht::quantize(-1_000_000, 16), -2048);
+    }
+
+    #[test]
+    fn wht_transform_uniform() {
+        use video::wht;
+        // A uniform block: DC = the per-pixel value, every AC coefficient = 0 (VIDEO.md invariant).
+        let block = [16320i32; wht::BLOCK];
+        let c = wht::transform(&block);
+        assert_eq!(c[0], 16320); // DC = mean = the uniform value
+        assert!(c[1..].iter().all(|&x| x == 0)); // AC all zero
+        // End-to-end: white pixel -> Y plane -> WHT DC -> quantize -> 1020.
+        let (y, _, _) = wht::colour(255, 255, 255);
+        assert_eq!(wht::quantize(wht::transform(&[y; wht::BLOCK])[0], 0), 1020);
+    }
+
+    #[test]
+    fn wht_transform_haar_vectors() {
+        // The 8x8 2-D Haar (Mallat) wavelet, byte-exact-verified against DLM (2026-06-23):
+        // `scripts/wht-transform.py` reproduces these on 320/320 real gradient blocks. Each vector
+        // here is computed by that reference; `Y = 64*gray`. (See the breakthrough writeup.)
+        use video::wht::{transform, DIM, PIXELS};
+        // Build an 8x8 Y block by evaluating a gray-per-(row,col) selector.
+        fn build(gray: impl Fn(usize, usize) -> i32) -> [i32; PIXELS] {
+            let mut b = [0i32; PIXELS];
+            for r in 0..DIM {
+                for c in 0..DIM {
+                    b[r * DIM + c] = 64 * gray(r, c);
+                }
+            }
+            b
+        }
+        // vstripe2 (period-2 vertical, full contrast 0/255) -> level-2 HL band c[4..8] = -2040.
+        let c = transform(&build(|_, c| if (c / 2) & 1 != 0 { 255 } else { 0 }));
+        assert_eq!(&c[4..8], &[-2040, -2040, -2040, -2040]);
+        assert!(c[1..4].iter().all(|&x| x == 0) && c[8..].iter().all(|&x| x == 0));
+        // vstripe4 (period-4 vertical) -> coarse HL c[1] = -8160 (4x the fine band, energy-conserving).
+        let c = transform(&build(|_, c| if (c / 4) & 1 != 0 { 255 } else { 0 }));
+        assert_eq!(c[1], -8160);
+        // hstripe2 (period-2 horizontal) -> level-2 LH band c[8..12] = -2040 (H/V swap of vstripe2).
+        let c = transform(&build(|r, _| if (r / 2) & 1 != 0 { 255 } else { 0 }));
+        assert_eq!(&c[8..12], &[-2040, -2040, -2040, -2040]);
+        // A per-column gradient (gray = 36*col) exercises the DC, coarse-HL and finest band at once.
+        let c = transform(&build(|_, col| 36 * col as i32));
+        assert_eq!(c[0], 8064); // DC = mean(36*0..36*7)*64/64 = 8064
+        assert_eq!(&c[4..8], &[-576, -576, -576, -576]);
+        assert!(c[16..].iter().all(|&x| x == -72)); // finest HL band, uniform per-column ramp
+    }
+
+    #[test]
+    fn wht_vlc_codebook_byte_exact() -> Result {
+        // ★ The recovered LSB-first entropy VLC (dumped from DLM 0x5e68b0), verified byte-exact
+        // against DLM's own captured output (scripts/wht-block-codec.py). Symbol 7 is the AC code
+        // 0b1110000 (LSB-first); four of them pack to the wire's per-block AC unit bytes, and the
+        // final byte is padded with 1-bits (a truncated all-ones code), exactly as the dock emits.
+        use video::wht::Vlc;
+        let mut w = Vlc::new();
+        for _ in 0..4 {
+            w.symbol(7)?;
+        }
+        assert_eq!(&w.finish()?[..], &[0x87, 0xc3, 0xe1, 0xf0]);
+        // The full per-block AC unit `0 0 0 7 7 7 7` (idx1-3 zero, idx4-7 AC) -- matches the live
+        // wire bytes `38 1c 0e ...` captured for vstripe2.
+        let mut w = Vlc::new();
+        for s in [0usize, 0, 0, 7, 7, 7, 7] {
+            w.symbol(s)?;
+        }
+        assert_eq!(&w.finish()?[..4], &[0x38, 0x1c, 0x0e, 0x87]);
+        // Symbol 0 (the 1-bit `0` code) alone -> one byte padded with seven 1-bits.
+        let mut w = Vlc::new();
+        w.symbol(0)?;
+        assert_eq!(&w.finish()?[..], &[0xfe]);
+        Ok(())
+    }
+
+    #[test]
+    fn wht_coeff_magnitude_code() -> Result {
+        // The AC magnitude-code emitter, verified byte-exact vs DLM's per-coefficient wire bits
+        // (q-4/q-8/q-16; scripts/wht-strip-encoder.py reproduces the full q-4 vstripe2 strip).
+        use video::wht::Vlc;
+        // Four q-4 coefficients (category 3, zero offset) == four sym7 -- the per-block AC unit.
+        let mut w = Vlc::new();
+        for _ in 0..4 {
+            w.coeff(-4)?;
+        }
+        assert_eq!(&w.finish()?[..], &[0x87, 0xc3, 0xe1, 0xf0]);
+        // A zero coefficient is the 1-bit symbol 0 -> one byte padded with seven 1-bits.
+        let mut w = Vlc::new();
+        w.coeff(0)?;
+        assert_eq!(&w.finish()?[..], &[0xfe]);
+        // Within-category offset (q-6 = category 3, offset 2) and sign polarity (negative vs +).
+        let mut w = Vlc::new();
+        w.coeff(-6)?;
+        assert_eq!(&w.finish()?[..], &[0x97]);
+        let mut w = Vlc::new();
+        w.coeff(6)?;
+        assert_eq!(&w.finish()?[..], &[0xd7]); // same magnitude, sign bit flipped
+        // Category 5 with offset (q-16) spans two bytes.
+        let mut w = Vlc::new();
+        w.coeff(-16)?;
+        assert_eq!(&w.finish()?[..], &[0x1f, 0xf8]);
+        // Category >= 9 (|q| >= 256) is the unrecovered escape long form -> rejected, not mis-coded.
+        let mut w = Vlc::new();
+        assert!(w.coeff(-256).is_err());
+        Ok(())
+    }
+
+    #[test]
+    fn wht_solid_strip_byte_exact() {
+        // The general solid-colour 64x16 strip encoder, byte-exact vs DLM's wire (14/14 strips of
+        // the codec-grammar-20260623 capture: the full grey sweep c=8/9/10, white, and the 6 solid
+        // primaries/secondaries; scripts/wht-strip-encoder.py). The three per-plane DCs (Cr, Cb, Y)
+        // are escape-coded from bit 368; the strip is zero-padded to its even length with
+        // w18=w1c=tail=L-2. grey128 (Y=8192) and white (Y=16320) differ only in the Y escape bits.
+        use video::wht::solid_strip;
+        let grey128 = [
+            0x01, 0x28, 0, 0, 0, 0, 0, 0, 0, 0, 0x3a, 0, 0x3a, 0, 0, 0, 0xfc, 0x00, 0x7e, 0x00,
+            0x3f, 0x80, 0x1f, 0xc0, 0x0f, 0xe0, 0x07, 0xf0, 0x03, 0xf8, 0x01, 0xfc, 0x00, 0x7e,
+            0x00, 0x3f, 0x80, 0x1f, 0xc0, 0x0f, 0xe0, 0x07, 0xf0, 0x03, 0xf8, 0x01, 0xfc, 0x0f,
+            0x20, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0x3a, 0,
+        ];
+        assert_eq!(&*solid_strip(0, 0, 8192, 0, 0).unwrap(), &grey128);
+        // White (Y=16320) -- identical but the Y escape bytes [47:49] are 0xff,0x27 not 0x0f,0x20.
+        let mut white = grey128;
+        white[47] = 0xff;
+        white[48] = 0x27;
+        assert_eq!(&*solid_strip(0, 0, 16320, 0, 0).unwrap(), &white);
+        // X/Y are patched into the header (little-endian) without disturbing the body.
+        let s = solid_strip(0x40, 0x10, 8192, 0, 0).unwrap();
+        assert_eq!(&s[2..6], &[0x40, 0x00, 0x10, 0x00]);
+        assert_eq!(&s[16..47], &grey128[16..47]); // main frame + Y escape unchanged by position
+        // Chroma: red (Y=4032, Cb=64*(255-0)=16320, Cr=0) -- 60-byte strip, plane order (Cr,Cb,Y).
+        let red = [
+            0x01, 0x28, 0, 0, 0, 0, 0, 0, 0, 0, 0x3a, 0, 0x3a, 0, 0, 0, 0xfc, 0x00, 0x7e, 0x00,
+            0x3f, 0x80, 0x1f, 0xc0, 0x0f, 0xe0, 0x07, 0xf0, 0x03, 0xf8, 0x01, 0xfc, 0x00, 0x7e,
+            0x00, 0x3f, 0x80, 0x1f, 0xc0, 0x0f, 0xe0, 0x07, 0xf0, 0x03, 0xf8, 0x01, 0xef, 0xfd,
+            0xff, 0xfb, 0x04, 0, 0, 0, 0, 0, 0, 0x3a, 0,
+        ];
+        assert_eq!(&*solid_strip(0, 0, 4032, 16320, 0).unwrap(), &red);
+        // green (Y=8128, Cb=Cr=-16320) is the longest -- a 64-byte strip (w18=w1c=tail=0x3e=62).
+        let g = solid_strip(0, 0, 8128, -16320, -16320).unwrap();
+        assert_eq!(g.len(), 64);
+        assert_eq!(&g[10..14], &[0x3e, 0, 0x3e, 0]);
+        assert_eq!(&g[62..64], &[0x3e, 0]);
+    }
+
+    #[test]
+    fn wht_ac_strip_byte_exact() {
+        // The uniform AC-strip encoder, byte-exact vs DLM (sig-library-20260623, 25/25 strips). The
+        // significance coder is a LAST-significant-position code (00111110 ++ 5-bit(32-last)); the AC
+        // stream run/magnitude-codes coeffs 1..last with the DLM-matched quantizer (pos3 deadzone).
+        use video::wht::ac_strip;
+        // s_L3HL: c3 = [128, -64, 0..]; last=1 (qAC[1]=-4). 70-byte strip.
+        let mut c = [0i32; 32];
+        c[0] = 128;
+        c[1] = -64;
+        let l3hl = ac_strip(&c, 0x40, 0x10).unwrap();
+        let want = [
+            0x01, 0x28, 0x40, 0x00, 0x10, 0x00, 0, 0, 0, 0, 0x34, 0x00, 0x3c, 0x00, 0, 0, 0x7c, 0x9f,
+            0xef, 0xf3, 0x7d, 0xbe, 0xcf, 0xf7, 0xf9, 0x3e, 0xdf, 0xe7, 0xfb, 0x7c, 0x9f, 0xef, 0xf3,
+            0x7d, 0xbe, 0xcf, 0xf7, 0xf9, 0x3e, 0xdf, 0xe7, 0xfb, 0x3c, 0x04, 0, 0, 0, 0, 0, 0, 0, 0,
+            0x87, 0xc3, 0xe1, 0x70, 0x38, 0x1c, 0x0e, 0x00, 0x87, 0xc3, 0xe1, 0x70, 0x38, 0x1c, 0x0e,
+            0x00, 0x44, 0x00,
+        ];
+        assert_eq!(&*l3hl, &want);
+        // s_L2HL: c3 = [128, 0,0,0, -16,-16,-16,-16, 0..]; last=7 (deadzone pos3 untouched -> last
+        // stays in the L2-HL band). 118-byte strip; spot-check length + w18/w1c framing.
+        let mut c2 = [0i32; 32];
+        c2[0] = 128;
+        for i in 4..8 {
+            c2[i] = -16;
+        }
+        let l2hl = ac_strip(&c2, 0x40, 0x10).unwrap();
+        assert_eq!(l2hl.len(), 118);
+        assert_eq!(&l2hl[10..14], &[0x34, 0x00, 0x54, 0x00]); // w18=52, w1c=84
+        assert_eq!(&l2hl[116..118], &[0x74, 0x00]); // tail = L-2 = 116
+    }
+
+    #[test]
+    fn wht_general_strip_and_frame_forward_hint() -> Result {
+        // The general 16-block strip encoder subsumes the two verified primitives, and the frame
+        // composer writes the forward length-hint tail (tail[k] = L[k+1] - 2).
+        use video::wht::{ac_strip, encode_frame, solid_strip, strip};
+
+        // (a) 16 identical flat grey128 blocks (Y_DC = 64*128 = 8192) -> the SOLID layout, byte-exact
+        // equal to solid_strip (which is itself verified 14/14 vs DLM).
+        let mut flat = [0i32; 32];
+        flat[0] = 8192;
+        let from_general = strip(&[flat; 16], 0x40, 0x10)?;
+        let from_solid = solid_strip(0x40, 0x10, 8192, 0, 0)?;
+        assert_eq!(&*from_general, &*from_solid);
+
+        // (b) 16 identical s_L3HL blocks -> the AC layout, byte-exact equal to ac_strip (verified
+        // 25/25 vs DLM). c3 = [128, -64, 0..]; last = 1.
+        let mut acblk = [0i32; 32];
+        acblk[0] = 128;
+        acblk[1] = -64;
+        assert_eq!(&*strip(&[acblk; 16], 0x40, 0x10)?, &*ac_strip(&acblk, 0x40, 0x10)?);
+
+        // (c) Forward length hint across two differently-sized strips in one 128x16 row: the left
+        // 64-px column is flat grey (small SOLID strip), the right column carries a per-block vertical
+        // edge (larger AC strip). The composer must set strip0's tail to strip1's L-2, and strip1
+        // (the last strip) keeps its own L-2.
+        let mut luma: KVec<u8> = KVec::new();
+        for _y in 0..16 {
+            for x in 0..128usize {
+                let v: u8 = if x < 64 {
+                    128
+                } else if x % 8 < 4 {
+                    120
+                } else {
+                    136
+                };
+                luma.push(v, GFP_KERNEL)?;
+            }
+        }
+        let out = encode_frame(&luma, 128, 16)?;
+        assert_eq!(&out[0..2], &[0x01, 0x28]); // strip0 magic
+        let l0 = (2..out.len() - 1)
+            .find(|&i| out[i] == 0x01 && out[i + 1] == 0x28)
+            .unwrap(); // strip1 start == strip0 length
+        let l1 = out.len() - l0;
+        assert_ne!(l0, l1); // the two strips genuinely differ in size (non-trivial hint)
+        // strip0's tail is the forward hint = strip1's L - 2.
+        assert_eq!(&out[l0 - 2..l0], &((l1 - 2) as u16).to_le_bytes());
+        // strip1 is last -> tail = its own L - 2.
+        assert_eq!(&out[out.len() - 2..], &((l1 - 2) as u16).to_le_bytes());
+        Ok(())
+    }
+
+    #[test]
+    fn wht_magnitude_category() {
+        // Magnitude category = bit_length(|coeff|), verified across the 2026-06-23 value sweep
+        // (q-4 -> cat 3 -> sym7, q-8 -> 4, ... q-128 -> 8).
+        use video::wht::mag_category;
+        assert_eq!(mag_category(0), 0);
+        assert_eq!(mag_category(1), 1);
+        assert_eq!(mag_category(-4), 3);
+        assert_eq!(mag_category(7), 3);
+        assert_eq!(mag_category(-8), 4);
+        assert_eq!(mag_category(16), 5);
+        assert_eq!(mag_category(-128), 8);
+        assert_eq!(mag_category(255), 8);
+    }
+
+    #[test]
+    fn ddc_ci_set_vcp_checksum() {
+        // VESA DDC/CI 1.1 sec 4.4 worked example: Set brightness (VCP 0x10) to 50 (0x0032).
+        // Bytes after the 0x6e write address: 51 84 03 10 00 32, checksum = XOR incl. 0x6e.
+        let p = cp::ddc_ci_set_vcp(cp::VCP_BRIGHTNESS, 50);
+        assert_eq!(&p[..6], &[0x51, 0x84, 0x03, 0x10, 0x00, 0x32]);
+        let want = 0x6e ^ 0x51 ^ 0x84 ^ 0x03 ^ 0x10 ^ 0x00 ^ 0x32;
+        assert_eq!(p[6], want);
+        // The checksum makes the XOR of {dest, source, len, opcode, vcp, hi, lo, chk} zero.
+        assert_eq!(0x6eu8 ^ p.iter().fold(0u8, |a, &b| a ^ b), 0);
+        // Contrast (0x12) and the power VCP (0xd6 = off) carry their codes/values verbatim.
+        assert_eq!(cp::ddc_ci_set_vcp(cp::VCP_CONTRAST, 0x0140)[3..6], [0x12, 0x01, 0x40]);
+        assert_eq!(cp::ddc_ci_set_vcp(cp::VCP_POWER_MODE, cp::POWER_OFF)[3..6], [0xd6, 0x00, 0x04]);
+    }
+
+    #[test]
+    fn ddc_set_vcp_message_structure() -> Result {
+        // CP wrapper: id=0x15 sub=0x22, counter (LE) at off4, I2C slave 0x37 + len 7 at off20,
+        // the 7-byte DDC/CI Set-VCP payload at off22, padded to a 32-byte block.
+        let m = cp::ddc_set_vcp(0x11, cp::VCP_BRIGHTNESS, 75)?;
+        assert_eq!(m.len(), 32);
+        assert_eq!(&m[0..6], &[0x15, 0x00, 0x22, 0x00, 0x11, 0x00]); // id, sub, counter (LE)
+        assert_eq!(&m[20..22], &[0x37, 7]); // monitor DDC/CI I2C slave + payload length
+        assert_eq!(&m[22..29], &cp::ddc_ci_set_vcp(cp::VCP_BRIGHTNESS, 75)); // DDC/CI payload
+        assert_eq!(&m[29..32], &[0, 0, 0]); // block padding
+        Ok(())
+    }
+}
-- 
2.55.0

