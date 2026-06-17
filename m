Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA889CD98F6
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 15:13:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 80FE810F029;
	Wed, 17 Jun 2026 15:13:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="s0o8NMBj";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 252BC10F025
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 15:13:05 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso56320675e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1781709184; x=1782313984;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=emAnSLd1CtwUBhugSbwTjxlvgKObX3UsKgYud8sNwlk=;
 b=s0o8NMBjkd148YG/rTZQYt3xe2YOzm68v0wh9ggWqmMLR4cobioX5l7CJD8Ls4XRUA
 eN+j+fBm58jzKmvpDwl9tOT4vXiC+1PZnKaNuWFT1w7PVlTR6BLZfzs5bg0OOjAOqkVN
 Krw3tnHfpYIBuJCGhr2Ot3Wp6lVYpq1UbuYgpQkh7vwpj+naEV3NdlIU/QF9Zv1+9zq3
 zMep6Z9QRVDUsge9/PHdZbxwnIegY3iXxCwfwBX+GTuYa2M/6SZj7BIQJs/erdBc5Mk2
 470UZnWZW+U9/EcOxd6tjdDpHUK0Jubsqd5xI6IdaGRQUrVWYw0+MOTDUddiABEt3uTA
 h6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781709184; x=1782313984;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=emAnSLd1CtwUBhugSbwTjxlvgKObX3UsKgYud8sNwlk=;
 b=DFF8OLuaB5MGsnQXm/lnZ2bd33DUJC5ucVNGoL9Tl/2nb6fX+o4DNXLKvTULP53jat
 rRZEXPh36+bHqS35v79wBONRsB5VHIK9bf8WZtGvWDDapF35bg7F92cB7ojzVR4VJCIf
 oS8SfskZ8wSjuEDz8bvyWhFIXSXc9DCdfVFnwkMZPrLs3jrGA2UV1hjZbOvz2+CmgXQ9
 hF0qZglqSm7yiWgKYoRPe2KUBGv31itPND1KQlWPaiwVNWV0qGXKw7r+3966NjAk6Kee
 zQOUwZv+4X8yb6aNiWrRhxTTicGy//1YRg1jQRwoiD1VmuVeXHWdAQ4btl9XlkkhsF/w
 SbtQ==
X-Gm-Message-State: AOJu0YwyuhAZlJWQGE+4O59HJoKUQvXXIMhdAQZLz5nbXxgILg8NIaxC
 X5rgQcKalOHq8G0UbJ2ncR+b/m8T7rnDZ8Ep/UVHi+xmW6CRFKj0CKWIsJ6Slx90M/NZcrsKY6m
 iG2hxj8Ad
X-Gm-Gg: Acq92OHqCpmMuAmsgME8d3X5bh90gpahsTZsNfsGQ9R0EPySM0VyJmIT9ufFFIIf/A/
 aPPxj5mJmHw5byZ8MUNwgjdh01R2TsK6lbn6ttBe6+zIBfS6yaBrVoEpHd0zs021hw8IUphzaW4
 aU2AcKF8fSQRXB4ACdcTazPcKMPTtOOrOJ1cMiqGSNjNEjblOqtVK9pS1kdIcokCxK1ii24X0pd
 EE6tVI/EO2+kZzbprl2reWiJ/AptEnBBuRrmKzNE5EKbeWwTymKXRrySx1+9/uT7MEwhhQfppcz
 EmO5Kcuaxbo/uY9nLkbuc0D2kfgeim5we+fg/CGMnX0NS3HzyWdZCMTwOUUWTNYGQ+x9RjQ5biU
 yqaCFTS2tumt2kbfisd6/H4e/Y415edZiaCYeaEBBsvGC+BllLLEwiqg0F/3v4q0wB498p93RjD
 uUwKnbPgTDo9rMqRSIUBh+G8oFGdMTTl842FIrjWgNI+e9xKMTKsSHbcd5
X-Received: by 2002:a05:600c:c0c4:b0:490:50c5:8153 with SMTP id
 5b1f17b1804b1-492333a16ecmr65318985e9.2.1781709181587; 
 Wed, 17 Jun 2026 08:13:01 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49230a9a399sm151019305e9.14.2026.06.17.08.13.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 08:13:00 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, rust-for-linux@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 3/7] drm/vino: add the AES-CTR/AES-CMAC control-plane seal
 and arm
Date: Wed, 17 Jun 2026 16:12:40 +0100
Message-ID: <20260617151249.2937-4-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617151249.2937-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
MIME-Version: 1.0
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

With the HDCP session keyed, the dock's control plane (CP) is an
AES-CTR-encrypted, AES-CMAC-authenticated ("Dl3Cmac") message channel.
Add the cp module: the control-plane message builders (mode-set, EDID
read/parse, cursor, the interactive seal) plus seal_livemac(), which
encrypts and frames a CP message under the live ks/riv -- byte-exact
against the reference daemon's captured wire (the on-device self-test
gains a third known-answer check that reproduces the daemon's real msg0).

send_cp_setup() drives the post-SKE sequence: it opens the async EP84
bulk-IN reader, sends the plaintext type=2 sub=0x24 stream-open arm
marker, then the first live encrypted CP frame, and counts the dock's
encrypted wsub=0x45 acks. The EP84 drain/parse helpers and the
lockstep-reply decoder land here too.

This is THE WALL: on a cold dock the ack count stays 0 -- the dock runs
the entire plaintext handshake but never engages the encrypted CP (see
the final patch's "help wanted" note). CP_ENGAGED is left clear, which
gates the EP08 video added in a later patch.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 drivers/gpu/drm/vino/cp.rs   | 635 +++++++++++++++++++++++++++++++++++
 drivers/gpu/drm/vino/vino.rs | 607 ++++++++++++++++++++++++++++++++-
 2 files changed, 1237 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/vino/cp.rs

diff --git a/drivers/gpu/drm/vino/cp.rs b/drivers/gpu/drm/vino/cp.rs
new file mode 100644
index 000000000000..2668931d8500
--- /dev/null
+++ b/drivers/gpu/drm/vino/cp.rs
@@ -0,0 +1,635 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Encrypted-control-plane message builders (the inner plaintext of the type=4
+//! sub=0x24 AES-CTR frames) plus the AES-CTR `seal` that encrypts and frames them.
+//! Layouts are from the reverse-engineered protocol; offsets cite the guide and
+//! should be re-checked against a capture before they drive real hardware.
+#![allow(dead_code)] // some seal/handler paths run only after the dock engages CP (open blocker)
+
+use super::*;
+
+/// Common CP inner header: `[id u16][sub u16][counter u16][00 00]` (sec 6.1/sec 8.6.4).
+fn header(out: &mut KVec<u8>, id: u16, sub: u16, counter: u16) -> Result {
+    out.extend_from_slice(&id.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&sub.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&counter.to_le_bytes(), GFP_KERNEL)?;
+    out.extend_from_slice(&[0, 0], GFP_KERNEL)?;
+    Ok(())
+}
+
+fn pad_to(out: &mut KVec<u8>, len: usize) -> Result {
+    while out.len() < len {
+        out.push(0, GFP_KERNEL)?;
+    }
+    Ok(())
+}
+
+/// OUT heartbeat (sec 6.1): `id=0x16 sub=0x75`, two AES blocks (`10 27` at block1+6).
+pub(super) fn heartbeat(counter: u16) -> Result<KVec<u8>> {
+    let mut b = KVec::with_capacity(32, GFP_KERNEL)?;
+    header(&mut b, 0x16, 0x75, counter)?;
+    pad_to(&mut b, 22)?; // block0 tail + block1[0..6]
+    b.extend_from_slice(&[0x10, 0x27], GFP_KERNEL)?; // block1[6..8]
+    pad_to(&mut b, 32)?;
+    Ok(b)
+}
+
+/// OUT get-EDID request (CP-HANDSHAKE.md sec 4f): `id=0x15 sub=0x21`, the message that asks
+/// the dock to return the downstream monitor's EDID in an `id=0x194 sub=0x21` reply (parsed
+/// by [`parse_edid_from_reply`]). The request carries no payload beyond the inner header, so
+/// it is a single 16-byte AES block; [`seal_livemac`] appends the 16-byte Dl3Cmac. The dock
+/// echoes the `counter`, so any monotonic value works. The exact request body was never
+/// captured (only the reply), so this is the minimal well-formed form -- re-check against a
+/// capture if the dock ever NAKs it once CP engages.
+pub(super) fn get_edid_req(counter: u16) -> Result<KVec<u8>> {
+    let mut b = KVec::with_capacity(16, GFP_KERNEL)?;
+    header(&mut b, 0x15, 0x21, counter)?;
+    pad_to(&mut b, 16)?;
+    Ok(b)
+}
+
+/// A video timing in DisplayID-Type-I terms (sec 8.6.4), as carried by the
+/// `0x48/0x22` set-mode message. Field meanings and offsets are verified
+/// byte-exact against the golden 3840x2160@60 capture (see [`set_mode`]).
+#[derive(Clone, Copy)]
+pub(super) struct Timing {
+    pub hactive: u16,
+    pub hblank: u16,
+    pub hsync_front: u16,
+    pub hsync_width: u16,
+    pub vactive: u16,
+    pub vblank: u16,
+    pub vsync_front: u16,
+    pub vsync_width: u16,
+    pub refresh_hz: u16,
+    /// Pixel clock in 10 kHz units (e.g. 0xd040 = 533.12 MHz for 4K@60).
+    pub pixel_clock_10khz: u16,
+    /// DisplayID field at off42 -- partly decoded (0x0604 for 4K, 0x0600 for the
+    /// 2560x1440 sample in sec 8.6.4); high byte 0x06 constant, low byte mode-varying.
+    pub field42: u16,
+}
+
+impl Timing {
+    /// 3840x2160@60 (CVT-RB) -- the mode the non-HDCP dongle advertises, kept as a
+    /// known-good reference whose `set_mode` output is byte-exact vs the golden capture.
+    pub(super) const UHD_60: Timing = Timing {
+        hactive: 3840, hblank: 160, hsync_front: 48, hsync_width: 32,
+        vactive: 2160, vblank: 62, vsync_front: 3, vsync_width: 5,
+        refresh_hz: 60, pixel_clock_10khz: 0xd040, field42: 0x0604,
+    };
+}
+
+/// set-mode (sec 8.6.4): `id=0x48 sub=0x22`, a 96-byte inner message carrying a
+/// DisplayID-Type-I u16 timing record. **Verified byte-exact** against the golden
+/// `[59]` 3840x2160@60 capture for every byte except the trailing 22-byte session
+/// MAC (off74..95), which [`seal`]'s caller / the HDCP session layer appends.
+///
+/// Layout (inner offsets): off20 BE u32 generation=2; off26 begins the LE u16
+/// record `hactive,hblank,hsync_front,hsync_width,vactive,vblank,vsync_front,
+/// vsync_width,field42,refresh,flags(0x4000)`; off48/off58/off60/off66 carry
+/// constants observed in the 4K capture; off70 the pixel clock (10 kHz units).
+pub(super) fn set_mode(counter: u16, t: &Timing) -> Result<KVec<u8>> {
+    let mut b = KVec::with_capacity(96, GFP_KERNEL)?;
+    header(&mut b, 0x48, 0x22, counter)?;
+    pad_to(&mut b, 20)?;
+    b.extend_from_slice(&2u32.to_be_bytes(), GFP_KERNEL)?; // off20: BE generation=2
+    pad_to(&mut b, 26)?; // off24..25 zero; timing begins at off26
+    for v in [
+        t.hactive, t.hblank, t.hsync_front, t.hsync_width,
+        t.vactive, t.vblank, t.vsync_front, t.vsync_width,
+        t.field42, t.refresh_hz, 0x4000, /* off46 flags */ 0x6000, /* off48 */
+    ] {
+        b.extend_from_slice(&v.to_le_bytes(), GFP_KERNEL)?;
+    }
+    pad_to(&mut b, 58)?;
+    b.extend_from_slice(&0x0080u16.to_le_bytes(), GFP_KERNEL)?; // off58 (observed const)
+    b.extend_from_slice(&0x00ffu16.to_le_bytes(), GFP_KERNEL)?; // off60 (observed const)
+    pad_to(&mut b, 66)?;
+    b.extend_from_slice(&0x0800u16.to_le_bytes(), GFP_KERNEL)?; // off66 (observed const)
+    pad_to(&mut b, 70)?;
+    b.extend_from_slice(&t.pixel_clock_10khz.to_le_bytes(), GFP_KERNEL)?; // off70
+    pad_to(&mut b, 96)?;
+    Ok(b)
+}
+
+/// EDID base-block sanity check: length, the `00 FF..FF 00` magic, and the 1-byte
+/// checksum (all 128 base bytes sum to 0 mod 256). A corrupt blob must never drive a
+/// mode-set, so [`timing_from_edid`] rejects anything that fails this.
+fn edid_valid(edid: &[u8]) -> bool {
+    const MAGIC: [u8; 8] = [0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00];
+    edid.len() >= 128
+        && edid[..8] == MAGIC
+        && edid[..128].iter().fold(0u8, |a, &b| a.wrapping_add(b)) == 0
+}
+
+/// Parse one 18-byte EDID detailed timing descriptor into a [`Timing`], or `None` if it
+/// is too short or not a timing (pixel clock 0 marks a monitor descriptor). `field42`
+/// is left at the sec 8.6.4 default (`0x0600`) -- its low byte is mode-varying and not fully
+/// decoded, so the live mode-set substitution leaves the captured value in place.
+fn parse_dtd(d: &[u8]) -> Option<Timing> {
+    if d.len() < 18 {
+        return None;
+    }
+    let pclk = u16::from_le_bytes([d[0], d[1]]);
+    if pclk == 0 {
+        return None; // monitor descriptor, not a detailed timing
+    }
+    let hi = |v: u8, lo: u8| -> u16 { ((v as u16) << 8) | lo as u16 };
+    let hactive = hi((d[4] >> 4) & 0xf, d[2]);
+    let hblank = hi(d[4] & 0xf, d[3]);
+    let vactive = hi((d[7] >> 4) & 0xf, d[5]);
+    let vblank = hi(d[7] & 0xf, d[6]);
+    let hsync_front = (((d[11] >> 6) & 0x3) as u16) << 8 | d[8] as u16;
+    let hsync_width = (((d[11] >> 4) & 0x3) as u16) << 8 | d[9] as u16;
+    let vsync_front = (((d[11] >> 2) & 0x3) as u16) << 4 | ((d[10] >> 4) & 0xf) as u16;
+    let vsync_width = ((d[11] & 0x3) as u16) << 4 | (d[10] & 0xf) as u16;
+    let htotal = hactive.wrapping_add(hblank) as u32;
+    let vtotal = vactive.wrapping_add(vblank) as u32;
+    let refresh_hz = if htotal != 0 && vtotal != 0 {
+        ((pclk as u32 * 10_000 + (htotal * vtotal) / 2) / (htotal * vtotal)) as u16
+    } else {
+        0
+    };
+    Some(Timing {
+        hactive,
+        hblank,
+        hsync_front,
+        hsync_width,
+        vactive,
+        vblank,
+        vsync_front,
+        vsync_width,
+        refresh_hz,
+        pixel_clock_10khz: pclk,
+        field42: 0x0600,
+    })
+}
+
+/// Extract the monitor's **preferred** detailed timing from an EDID for the live mode-set
+/// (CP-HANDSHAKE.md sec 4e). The first DTD in the base block is the preferred timing per the
+/// EDID spec; scan all four base descriptor slots (off 54/72/90/108) so a leading monitor
+/// descriptor (name/range/serial) doesn't hide it, and if the base block carries no DTD at
+/// all, fall back to the first DTD in the CTA-861 extension block. The blob is validated
+/// first; an invalid or timing-less EDID returns `None` so the caller keeps its known-good
+/// fallback timing rather than driving the dock with garbage.
+pub(super) fn timing_from_edid(edid: &[u8]) -> Option<Timing> {
+    if !edid_valid(edid) {
+        return None;
+    }
+    // Base-block descriptors: the first valid DTD is the preferred timing.
+    for off in [54usize, 72, 90, 108] {
+        if off + 18 <= edid.len() {
+            if let Some(t) = parse_dtd(&edid[off..off + 18]) {
+                return Some(t);
+            }
+        }
+    }
+    // No DTD in the base block: try the first CTA-861 extension's DTD area. CTA-861 blocks
+    // have tag 0x02 at byte 0 and a DTD-area byte offset at byte 2 (>= 4 when DTDs follow);
+    // descriptors run in 18-byte records up to the extension's checksum byte (127).
+    if edid[126] as usize >= 1 && edid.len() >= 256 {
+        let ext = &edid[128..256];
+        if ext[0] == 0x02 {
+            let start = ext[2] as usize;
+            if start >= 4 {
+                let mut off = start;
+                while off + 18 <= 127 {
+                    if let Some(t) = parse_dtd(&ext[off..off + 18]) {
+                        return Some(t);
+                    }
+                    off += 18;
+                }
+            }
+        }
+    }
+    None
+}
+
+/// Overwrite the geometry + clock fields of an in-place set-mode inner message
+/// (`id=0x48 sub=0x22`) with `t` (CP-HANDSHAKE.md sec 4e). Offsets mirror [`set_mode`]:
+/// the LE u16 timing record at off26 and the pixel clock at off70. `field42` (off42),
+/// the off66 token and the encrypted trailer are intentionally **left as captured**;
+/// only the EDID-derived values change, so the wire length (hence `wire_seq`) is
+/// unchanged. No-op if `plain` is too short.
+pub(super) fn apply_edid_timing(plain: &mut [u8], t: &Timing) {
+    if plain.len() < 72 {
+        return;
+    }
+    let put = |b: &mut [u8], off: usize, v: u16| {
+        b[off] = v as u8;
+        b[off + 1] = (v >> 8) as u8;
+    };
+    put(plain, 26, t.hactive);
+    put(plain, 28, t.hblank);
+    put(plain, 30, t.hsync_front);
+    put(plain, 32, t.hsync_width);
+    put(plain, 34, t.vactive);
+    put(plain, 36, t.vblank);
+    put(plain, 38, t.vsync_front);
+    put(plain, 40, t.vsync_width);
+    put(plain, 44, t.refresh_hz);
+    put(plain, 70, t.pixel_clock_10khz);
+}
+
+/// Convert a DRM display mode (the timing the *compositor* selected from the connector's
+/// EDID-derived mode list) into a set-mode [`Timing`]. This is what makes the dock
+/// multi-mode: `drm_edid_connector_add_modes` already advertises every base+extension mode
+/// from the dock's EDID, and when userspace sets any one of them the resulting
+/// `drm_display_mode` lands here verbatim -- no re-parsing of EDID offsets. The blanking
+/// fields map straight across (CVT/DMT/DisplayID all use the same front-porch/sync model),
+/// and the refresh rate comes from DRM's own `drm_mode_vrefresh` helper rather than a
+/// hand-rolled divide. `field42` keeps the sec 8.6.4 default (its low byte is mode-varying and
+/// not fully decoded); the dock tolerates the high byte `0x06`.
+///
+/// SAFETY: `mode` must point to a valid `drm_display_mode` for the duration of the call.
+pub(super) unsafe fn timing_from_drm_mode(mode: *const bindings::drm_display_mode) -> Timing {
+    // SAFETY: caller guarantees `mode` is a live drm_display_mode.
+    let m = unsafe { &*mode };
+    // SAFETY: `drm_mode_vrefresh` only reads the mode; `mode` is valid per the contract.
+    let refresh = unsafe { bindings::drm_mode_vrefresh(mode) } as u16;
+    let sub = |a: u16, b: u16| a.saturating_sub(b);
+    Timing {
+        hactive: m.hdisplay,
+        hblank: sub(m.htotal, m.hdisplay),
+        hsync_front: sub(m.hsync_start, m.hdisplay),
+        hsync_width: sub(m.hsync_end, m.hsync_start),
+        vactive: m.vdisplay,
+        vblank: sub(m.vtotal, m.vdisplay),
+        vsync_front: sub(m.vsync_start, m.vdisplay),
+        vsync_width: sub(m.vsync_end, m.vsync_start),
+        refresh_hz: refresh,
+        // `clock` is in kHz; the set-mode field is in 10 kHz units.
+        pixel_clock_10khz: (m.clock / 10).clamp(0, u16::MAX as i32) as u16,
+        field42: 0x0600,
+    }
+}
+
+/// Decode the inner header of a dock->host CP frame: returns `(id, sub, ictr)` from
+/// the first decrypted block (CP-HANDSHAKE.md sec 3), or `None` if `wire` is not a
+/// decryptable CP frame. Used by the live loop to log what the dock is replying.
+pub(super) fn reply_info(
+    ks: &[u8; 16],
+    out_riv: &[u8; 8],
+    wire: &[u8],
+) -> Option<(u16, u16, u16)> {
+    if wire.len() <= 16 {
+        return None;
+    }
+    let seq = u32::from_le_bytes([wire[12], wire[13], wire[14], wire[15]]);
+    let head = &wire[16..wire.len().min(32)];
+    let inner = open_in(ks, &in_riv(out_riv), seq, head).ok()?;
+    if inner.len() < 6 {
+        return None;
+    }
+    Some((
+        u16::from_le_bytes([inner[0], inner[1]]),
+        u16::from_le_bytes([inner[2], inner[3]]),
+        u16::from_le_bytes([inner[4], inner[5]]),
+    ))
+}
+
+/// CP `sub` ids seen on the wire (CP-HANDSHAKE.md). Used to score a candidate
+/// decrypt: a plaintext whose `sub` is one of these (and whose post-counter pad is
+/// zero) is almost certainly the correct key/riv.
+fn is_known_sub(sub: u16) -> bool {
+    matches!(
+        sub,
+        0x00 | 0x04 | 0x0c | 0x10 | 0x20 | 0x21 | 0x22 | 0x24 | 0x25 | 0x30 | 0x41
+            | 0x42 | 0x43 | 0x45 | 0x75 | 0x84
+    )
+}
+
+/// Diagnostic decode: try a dock->host frame under every plausible riv variant and
+/// return the best-scoring inner `(riv_tag, id, sub, ictr)`. The interactive
+/// `wsub=0x45` replies decrypt under `in_riv` (byte7^1), but the **cap-phase**
+/// `wsub=0x25` frames decrypt under the session ks with **byte7 unchanged** (the OUT
+/// value) -- see the cold-ref transcript. `byte0^0x80` selects the head. This mirrors
+/// `decode-handshake.py`'s scoring so a live trace shows what the dock is actually
+/// asking for during the capability exchange we currently skip.
+pub(super) fn decode_any(
+    ks: &[u8; 16],
+    out_riv: &[u8; 8],
+    wire: &[u8],
+) -> Option<(&'static str, u16, u16, u16, [u8; 24])> {
+    if wire.len() <= 16 {
+        return None;
+    }
+    let seq = u32::from_le_bytes([wire[12], wire[13], wire[14], wire[15]]);
+    let head = &wire[16..wire.len().min(48)];
+    let out0 = *out_riv;
+    let in0 = in_riv(out_riv);
+    let mut out1 = out0;
+    out1[0] ^= 0x80;
+    let mut in1 = in0;
+    in1[0] ^= 0x80;
+    let variants: [(&'static str, [u8; 8]); 4] =
+        [("out/h0", out0), ("in/h0", in0), ("out/h1", out1), ("in/h1", in1)];
+    let mut best: Option<(i32, &'static str, u16, u16, u16, [u8; 24])> = None;
+    for (tag, riv) in variants.iter() {
+        let Ok(pt) = open_in(ks, riv, seq, head) else { continue };
+        if pt.len() < 8 {
+            continue;
+        }
+        let id = u16::from_le_bytes([pt[0], pt[1]]);
+        let sub = u16::from_le_bytes([pt[2], pt[3]]);
+        let ctr = u16::from_le_bytes([pt[4], pt[5]]);
+        let pad = u16::from_le_bytes([pt[6], pt[7]]);
+        let mut sc = 0i32;
+        if is_known_sub(sub) {
+            sc += 50;
+        }
+        if pad == 0 {
+            sc += 10;
+        }
+        if ctr < 0x400 {
+            sc += 5;
+        }
+        if best.map_or(true, |b| sc > b.0) {
+            // Keep the first 24 plaintext bytes so the live trace shows the decoded
+            // structure (e.g. the `..4c..de..` cap-descriptor template that, in the
+            // capture, is session-independent -- its absence flags a ks/riv mismatch).
+            let mut sample = [0u8; 24];
+            let n = pt.len().min(24);
+            sample[..n].copy_from_slice(&pt[..n]);
+            best = Some((sc, tag, id, sub, ctr, sample));
+        }
+    }
+    best.map(|(_, tag, id, sub, ctr, sample)| (tag, id, sub, ctr, sample))
+}
+
+/// cursor create (sec 8.6.1): `id=0x1b sub=0x42`, advertises `w x h`.
+pub(super) fn cursor_create(counter: u16, w: u16, h: u16) -> Result<KVec<u8>> {
+    let mut b = KVec::with_capacity(32, GFP_KERNEL)?;
+    header(&mut b, 0x1b, 0x42, counter)?;
+    pad_to(&mut b, 20)?;
+    b.extend_from_slice(&[0x00, 0x02, 0x00], GFP_KERNEL)?; // marker seen in captures
+    b.extend_from_slice(&w.to_le_bytes(), GFP_KERNEL)?;
+    b.extend_from_slice(&h.to_le_bytes(), GFP_KERNEL)?;
+    Ok(b)
+}
+
+/// cursor move (sec 8.6.1): `id=0x1a sub=0x43`, head id @22, X @24, Y @26 (LE).
+pub(super) fn cursor_move(counter: u16, head: u8, x: u16, y: u16) -> Result<KVec<u8>> {
+    let mut b = KVec::with_capacity(28, GFP_KERNEL)?;
+    header(&mut b, 0x1a, 0x43, counter)?;
+    pad_to(&mut b, 22)?;
+    b.push(head, GFP_KERNEL)?; // off22 head/monitor id
+    b.push(1, GFP_KERNEL)?; // off23 flag
+    b.extend_from_slice(&x.to_le_bytes(), GFP_KERNEL)?; // off24
+    b.extend_from_slice(&y.to_le_bytes(), GFP_KERNEL)?; // off26
+    Ok(b)
+}
+
+/// cursor image (sec 8.6.1): `id=0x1c sub=0x41`. Mirrors [`cursor_create`]'s header (the
+/// `00 02 00` marker + `w`,`h` at off20) and appends the `w*h` BGRA bitmap. `bgra` must be
+/// `w*h*4` bytes -- DRM hands the driver a 64x64 ARGB8888 cursor buffer and the caller swaps
+/// it
+/// to BGRA. The image sub-layout past the create-style header is capture-unconfirmed (only the
+/// id and the shared header are decoded); re-check against a capture once CP engages.
+pub(super) fn cursor_image(counter: u16, w: u16, h: u16, bgra: &[u8]) -> Result<KVec<u8>> {
+    if bgra.len() != w as usize * h as usize * 4 {
+        return Err(EINVAL);
+    }
+    let mut b = KVec::with_capacity(32 + bgra.len(), GFP_KERNEL)?;
+    header(&mut b, 0x1c, 0x41, counter)?;
+    pad_to(&mut b, 20)?;
+    b.extend_from_slice(&[0x00, 0x02, 0x00], GFP_KERNEL)?; // marker (mirrors cursor_create)
+    b.extend_from_slice(&w.to_le_bytes(), GFP_KERNEL)?;
+    b.extend_from_slice(&h.to_le_bytes(), GFP_KERNEL)?;
+    b.extend_from_slice(bgra, GFP_KERNEL)?;
+    Ok(b)
+}
+
+/// DisplayLink "Dl3Cmac" CP-message integrity tag (16 bytes) -- **FULLY SOLVED + CROSS-SESSION
+/// VERIFIED 2026-06-11** (`captures/DL3CMAC-FULLY-SOLVED-20260611.md`):
+/// `tag = AES-CMAC(ks, mac_nonce(8) || BE64(wire_seq) || ciphertext)` where
+/// - `mac_nonce` = the CTR stream `riv` **with `byte0 ^= 0x80`** (this byte0 flip is the bit
+///   prior writeups missed -- they tried `riv` / `riv^1@byte7` and OUT never verified),
+/// - `wire_seq` = the AES-CTR block counter (frame header off-12), zero-extended to BE64,
+/// - `ciphertext` = the AES-CTR ciphertext content (encrypt-then-MAC), tag appended IN CLEAR.
+/// `K_dl3 = ks`. Proven: 110/115 OUT + 128/135 IN corpus frames AND cold-ref msg0 (a different
+/// session) reproduce byte-exact. Pass the CTR `riv` directly; the byte0 flip is applied here.
+pub(super) fn dl3cmac_tag(
+    ks: &[u8; 16],
+    riv: &[u8; 8],
+    wire_seq: u64,
+    ciphertext: &[u8],
+) -> Result<[u8; 16]> {
+    let mut mac_nonce = *riv;
+    mac_nonce[0] ^= 0x80;
+    let mut buf = KVec::with_capacity(16 + ciphertext.len(), GFP_KERNEL)?;
+    buf.extend_from_slice(&mac_nonce, GFP_KERNEL)?;
+    buf.extend_from_slice(&wire_seq.to_be_bytes(), GFP_KERNEL)?;
+    buf.extend_from_slice(ciphertext, GFP_KERNEL)?;
+    crypto::aes_cmac(ks, &buf)
+}
+
+/// Seal a CP message with a **freshly computed live Dl3Cmac**, reusing DLM's captured wire
+/// `header` (so `seq`/`aux` are byte-identical) but recomputing the tail tag for THIS session.
+/// `content_pt` is the real inner plaintext WITHOUT the 16-byte tag region. Wire body =
+/// `AES-CTR(ks, riv, content_pt)` || `dl3cmac_tag(...)`. This is the live-generation path. See
+/// `captures/DL3CMAC-FULLY-SOLVED-20260611.md`.
+pub(super) fn seal_livemac(
+    ks: &[u8; 16],
+    riv: &[u8; 8],
+    header: &[u8],
+    content_pt: &[u8],
+) -> Result<KVec<u8>> {
+    let seq = u32::from_le_bytes([header[12], header[13], header[14], header[15]]);
+    let mut ct = KVec::with_capacity(content_pt.len(), GFP_KERNEL)?;
+    for (i, chunk) in content_pt.chunks(16).enumerate() {
+        let mut iv = [0u8; 16];
+        iv[..8].copy_from_slice(riv);
+        iv[12..].copy_from_slice(&seq.wrapping_add(i as u32).to_be_bytes());
+        let ksb = crypto::aes128_ecb(ks, &iv)?;
+        for (j, &p) in chunk.iter().enumerate() {
+            ct.push(p ^ ksb[j], GFP_KERNEL)?;
+        }
+    }
+    let tag = dl3cmac_tag(ks, riv, seq as u64, &ct)?;
+    let mut frame = KVec::with_capacity(16 + ct.len() + 16, GFP_KERNEL)?;
+    frame.extend_from_slice(&header[..16], GFP_KERNEL)?;
+    frame.extend_from_slice(&ct, GFP_KERNEL)?;
+    frame.extend_from_slice(&tag, GFP_KERNEL)?;
+    Ok(frame)
+}
+
+/// Seal an inner CP message into a wire frame (type=4 sub=0x24, `seq`). DisplayLink
+/// CP is **encrypt-then-MAC**: the message content is AES-CTR-encrypted, then a
+/// 16-byte Dl3Cmac tag (`AES-CMAC(ks, riv || BE64(seq) || ciphertext)`) is appended.
+/// The keystream is `AES_ECB(ks, riv(8) || u32(0) || u32_be(seq + block))` (sec 6.1).
+///
+/// `inner` is the captured golden plaintext `[content || stale-tag-region(16)]`; we
+/// encrypt only `content = inner[..len-16]` and append a **fresh** tag keyed by our
+/// live session, so the dock's Dl3Cmac verification passes (the stale replayed tag is
+/// why the dock previously dropped our CP). VERIFIED construction (sec 8.6.7).
+pub(super) fn seal(
+    ks: &[u8; 16],
+    riv: &[u8; 8],
+    seq: u32,
+    inner: &[u8],
+) -> Result<KVec<u8>> {
+    // The interactive CP stream: session ks, wire sub `0x24`.
+    seal_stream(ks, riv, 0x24, seq, inner)
+}
+
+/// Build a fully sealed interactive CP frame (`type=4 sub=0x24`) at `wire_seq` over `content`
+/// (the inner plaintext, WITHOUT any trailing 16-byte tag placeholder): the 16-byte wire
+/// header -- size, `type=4`, `sub=0x24`, the per-`id` [`aux_for_id`] field, and `wire_seq` --
+/// followed by [`seal_livemac`] (AES-CTR ciphertext + appended live Dl3Cmac). Shared by the
+/// bring-up live loop ([`VinoDriver::send_live_cp`]) and the runtime KMS senders
+/// ([`drm_sink::VinoDrmData::send_cp`]) so both produce a byte-identical wire frame.
+pub(super) fn seal_interactive(
+    ks: &[u8; 16],
+    riv: &[u8; 8],
+    id: u16,
+    wire_seq: u32,
+    content: &[u8],
+) -> Result<KVec<u8>> {
+    let body_len = content.len() + 16; // AES-CTR ciphertext + 16-byte Dl3Cmac
+    let size = ((16 + body_len) - 4) as u16;
+    let aux = aux_for_id(id, body_len);
+    let mut hdr = [0u8; 16];
+    hdr[2..4].copy_from_slice(&size.to_le_bytes());
+    hdr[4..8].copy_from_slice(&4u32.to_le_bytes()); // type=4
+    hdr[8..10].copy_from_slice(&0x24u16.to_le_bytes()); // sub=0x24 (interactive CP)
+    hdr[10..12].copy_from_slice(&aux.to_le_bytes());
+    hdr[12..16].copy_from_slice(&wire_seq.to_le_bytes());
+    seal_livemac(ks, riv, &hdr, content)
+}
+
+/// The CP wire-header `aux`@10 (`sub_len_dw`) field is a **strict per-inner-message-id
+/// constant** in DLM's CP stream -- verified byte-exact across all 94 captured 1080p CP
+/// frames (`cp-hdrwire-1080p.bin`) -- **not** `body.len()/4`, which is what `push_frame`
+/// derives. Reproducing it makes a generated CP frame's header byte-identical to DLM, the
+/// leading hypothesis for the dock engaging its CP cipher (the dock acks our plaintext cap
+/// but emits 0 encrypted replies with the wrong `aux`). See docs/BLOCKER.md and memory
+/// `project_cp_aux_field_per_id_constant`. Unknown ids fall back to the dword count so an
+/// unrecognised message is still well-formed. This makes the generated `seal`/`seal_stream`
+/// path match DLM without a captured-header blob -- the basis for **live** CP generation.
+pub(super) fn aux_for_id(id: u16, body_len: usize) -> u16 {
+    match id {
+        0x14 => 0x0a,
+        0x15 => 0x09,
+        0x16 => 0x08,
+        0x19 => 0x05,
+        0x1f => 0x0f,
+        0x22 => 0x0c,
+        0x26 => 0x08,
+        0x2a => 0x04,
+        0x32 => 0x0c,
+        0x48 => 0x06,
+        0x9a => 0x04,
+        _ => (body_len / 4) as u16,
+    }
+}
+
+/// General AES-CTR seal under an arbitrary stream `key`/`riv` and wire sub. `seal`
+/// is the session-CP case (`wsub=0x24`); the **cap phase** (CP-HANDSHAKE.md sec 4b)
+/// needs `wsub=0x04` sealed under the dock's `id=0x32`-delivered per-head stream key,
+/// not the session ks -- which `seal` cannot express. Body construction is identical:
+/// AES-CTR(key, riv || 0x00000000 || BE32(seq+block)) over the **whole** inner message
+/// (no appended MAC; the inner carries its own encrypted trailer -- verified byte-exact
+/// vs DLM, 30/30 wire frames).
+pub(super) fn seal_stream(
+    key: &[u8; 16],
+    riv: &[u8; 8],
+    wsub: u16,
+    seq: u32,
+    inner: &[u8],
+) -> Result<KVec<u8>> {
+    let mut ct = KVec::with_capacity(inner.len(), GFP_KERNEL)?;
+    for (i, chunk) in inner.chunks(16).enumerate() {
+        let mut iv = [0u8; 16];
+        iv[..8].copy_from_slice(riv);
+        iv[12..].copy_from_slice(&seq.wrapping_add(i as u32).to_be_bytes());
+        let ksb = crypto::aes128_ecb(key, &iv)?;
+        for (j, &p) in chunk.iter().enumerate() {
+            ct.push(p ^ ksb[j], GFP_KERNEL)?;
+        }
+    }
+    let mut frame = KVec::with_capacity(16 + ct.len(), GFP_KERNEL)?;
+    // DLM-exact `aux`@10: a per-inner-id constant (see `aux_for_id`), not `body/4`. The
+    // id is read from the *plaintext* inner (off 0); `push_frame` would derive the wrong
+    // value and is the suspected reason the dock won't engage its CP cipher.
+    let id = if inner.len() >= 2 { u16::from_le_bytes([inner[0], inner[1]]) } else { 0 };
+    super::proto::push_frame_with(&mut frame, 0x04, wsub, aux_for_id(id, ct.len()), seq, &ct)?;
+    Ok(frame)
+}
+
+/// Derive the dock->host (IN) CP riv from the host->dock (OUT) `riv`. **It is the
+/// SAME riv -- no transform.** Proven 2026-06-12 by decrypting a frida-keyed DLM cold
+/// session's engaged `sub=0x45` replies (`captures/dlm-coldkeys-20260611-135237`, logged
+/// `ks`/`out_riv`): the dock's replies decrypt cleanly ONLY under the raw `out_riv`
+/// (`id=0x4c sub=0 ctr=8` to msg0, `id=0x14 sub=0x10` ACKs, `id=0x213` cert, ...); the old
+/// `byte7 ^= 1` gives garbage. The earlier "byte7^1 for IN" note was never validated against
+/// a real engaged reply (vino never engaged) and was wrong -- it would have made vino
+/// misdecode
+/// every dock reply (and partly explains old "dock replies garbage under our ks" findings).
+pub(super) fn in_riv(out_riv: &[u8; 8]) -> [u8; 8] {
+    *out_riv
+}
+
+/// Decrypt a dock->host CP frame body (AES-CTR, the same keystream as [`seal`] but
+/// keyed with the IN `riv`). `ct` is the ciphertext (wire bytes after the 16-byte
+/// cleartext header); `seq` is the wire counter at wire offset 12.
+pub(super) fn open_in(
+    ks: &[u8; 16],
+    in_riv: &[u8; 8],
+    seq: u32,
+    ct: &[u8],
+) -> Result<KVec<u8>> {
+    let mut pt = KVec::with_capacity(ct.len(), GFP_KERNEL)?;
+    for (i, chunk) in ct.chunks(16).enumerate() {
+        let mut iv = [0u8; 16];
+        iv[..8].copy_from_slice(in_riv);
+        iv[12..].copy_from_slice(&seq.wrapping_add(i as u32).to_be_bytes());
+        let ksb = crypto::aes128_ecb(ks, &iv)?;
+        for (j, &c) in chunk.iter().enumerate() {
+            pt.push(c ^ ksb[j], GFP_KERNEL)?;
+        }
+    }
+    Ok(pt)
+}
+
+/// If `wire` is an EDID reply (dock->host EP84, `type=4 sub=0x45`, inner
+/// `id=0x194 sub=0x21`), decrypt it with the IN riv and return the embedded EDID
+/// blob (base block + extensions). The EDID begins at inner offset 22; its total
+/// length is `128 * (1 + extension_count)`, where the extension count is base-block
+/// byte 126. Returns `None` for any other frame. See docs/CONTROL-PLANE.md.
+pub(super) fn parse_edid_from_reply(
+    ks: &[u8; 16],
+    out_riv: &[u8; 8],
+    wire: &[u8],
+) -> Result<Option<KVec<u8>>> {
+    // Wire header: [.. type@4 u32 .. sub@8 u16 .. seq@12 u32]; body at off16.
+    if wire.len() <= 16 || u16::from_le_bytes([wire[8], wire[9]]) != 0x45 {
+        return Ok(None);
+    }
+    let seq = u32::from_le_bytes([wire[12], wire[13], wire[14], wire[15]]);
+    let inner = open_in(ks, &in_riv(out_riv), seq, &wire[16..])?;
+    // Inner header: [id u16][sub u16][counter u16][00 00]; EDID payload at off22.
+    const EDID_OFF: usize = 22;
+    if inner.len() < EDID_OFF + 128 {
+        return Ok(None);
+    }
+    let id = u16::from_le_bytes([inner[0], inner[1]]);
+    let sub = u16::from_le_bytes([inner[2], inner[3]]);
+    // The get-EDID reply id is `0x194` on the wire (CP-HANDSHAKE.md sec 4f, ground-truthed
+    // against the cold-ref capture); older notes wrote the low byte `0x94` alone. Accept
+    // both so a real `0x194` reply is not silently dropped (the EDID would never reach the
+    // connector even after CP engages).
+    if (id != 0x94 && id != 0x194) || sub != 0x21 {
+        return Ok(None);
+    }
+    let edid = &inner[EDID_OFF..];
+    // Validate the EDID base-block magic `00 FF FF FF FF FF FF 00`.
+    const MAGIC: [u8; 8] = [0x00, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0x00];
+    if edid[..8] != MAGIC {
+        return Ok(None);
+    }
+    let total = ((1 + edid[126] as usize) * 128).min(edid.len());
+    let mut out = KVec::with_capacity(total, GFP_KERNEL)?;
+    out.extend_from_slice(&edid[..total], GFP_KERNEL)?;
+    Ok(Some(out))
+}
diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
index db4c38b6dc92..ef44a625cb70 100644
--- a/drivers/gpu/drm/vino/vino.rs
+++ b/drivers/gpu/drm/vino/vino.rs
@@ -43,6 +43,7 @@
 
 use kernel::{
     alloc::flags::GFP_KERNEL,
+    bindings,
     device::{self, Core},
     error::code::{ENODEV, EINVAL},
     prelude::*,
@@ -63,18 +64,28 @@
 /// EP84 (dock->host) drain buffer size. The dock's capability block can reach ~5.8 KiB, so a
 /// single bulk read needs a generously sized buffer to avoid truncating and misframing it.
 const EP84_BUF: usize = 16384;
+/// Number of IN URBs kept perpetually posted on EP84 by the async reader
+/// ([`usb::Device::bulk_in_queue`]); `depth - 1` stay outstanding while one is serviced.
+const EP84_QUEUE_DEPTH: usize = 4;
 
 /// USB transfer timeout used during bring-up.
 fn timeout() -> Delta {
     Delta::from_millis(1000)
 }
 
+/// Set once the dock has actually engaged the CP cipher (`wsub=0x45` acks > 0). EP08 video is
+/// gated on it: pushing frames at a dock whose CP channel is dead makes it fault and USB-reset.
+/// NOTE: with the current CP-engagement wall (see the file header) this is never set on real
+/// hardware -- the dock runs the whole plaintext handshake but never engages the encrypted CP.
+static CP_ENGAGED: core::sync::atomic::AtomicBool = core::sync::atomic::AtomicBool::new(false);
+
 mod proto;
 mod crypto;
 mod rng;
 mod hdcp;
 mod ake;
 mod golden;
+mod cp;
 
 /// The shared secrets a completed HDCP 2.2 AKE leaves behind: the SKE session key
 /// `ks` and content IV `riv` key the AES-CTR control plane (sec 6), and `kd` is kept
@@ -129,18 +140,33 @@ impl WorkItem for BringUp {
     fn run(this: Arc<BringUp>) {
         let cdev: &device::Device = this.intf.as_ref();
         let dev: &usb::Device = this.intf.as_ref();
-        // WIP scaffold: plaintext bring-up then the clean-room HDCP 2.2 AKE/LC/SKE. Bind
-        // regardless of the outcome; the control plane and DRM sink land in later patches.
+        // WIP scaffold: plaintext bring-up, the clean-room HDCP 2.2 AKE/LC/SKE, then the
+        // post-SKE CP setup. Bind regardless of the outcome -- there is no display path until
+        // the dock engages the encrypted control plane, which it currently never does (see the
+        // "help wanted" note at the top of the file). The DRM sink lands in a later patch.
         match VinoDriver::bring_up(dev) {
             Ok(()) => {
                 dev_info!(cdev, "vino: plaintext session init OK\n");
                 match VinoDriver::run_ake(dev) {
                     Ok(session) => {
                         dev_info!(cdev, "vino: HDCP AKE + LC + SKE complete (session keyed)\n");
-                        // Dev diagnostic: the live session key/riv, so the dock's encrypted
-                        // EP84 replies can be decoded offline from a usbmon capture. Behind
-                        // pr_debug, so compiled out unless dynamic debug is enabled.
                         pr_debug!("vino: SESSION ks={:02x?} riv={:02x?}\n", &session.ks, &session.riv);
+                        // Phase 2c: drive the post-SKE CP setup. send_cp_setup re-seals DLM's
+                        // captured setup template under THIS session's live ks/riv and sends it;
+                        // `acks` counts the dock's encrypted wsub=0x45 replies. THIS IS THE WALL:
+                        // on a cold dock `acks` stays 0 -- the dock runs the entire plaintext
+                        // handshake but never engages the encrypted CP.
+                        let mut edid_out: Option<KVec<u8>> = None;
+                        match VinoDriver::send_cp_setup(dev, &session, &mut edid_out) {
+                            Ok((n, acks, _wseq_end, _ctr_end)) => {
+                                dev_info!(cdev,
+                                    "vino: CP setup sent -- {n} messages, {acks} dock CP acks (wsub=0x45)\n");
+                                // CP engagement gates EP08 video (added in a later patch): until
+                                // the dock acks, pushing pixels at it wedges the hub.
+                                CP_ENGAGED.store(acks > 0, core::sync::atomic::Ordering::SeqCst);
+                            }
+                            Err(e) => dev_info!(cdev, "vino: CP setup incomplete ({e:?}) -- WIP\n"),
+                        }
                     }
                     Err(e) => dev_info!(cdev, "vino: HDCP AKE incomplete ({e:?}) -- WIP\n"),
                 }
@@ -205,6 +231,56 @@ fn crypto_selftest() {
         Ok(out) => pr_err!("vino: selftest AES-CMAC FAIL got={out:02x?}\n"),
         Err(e) => pr_err!("vino: selftest AES-CMAC ERR ({e:?})\n"),
     }
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
 }
 
 impl VinoDriver {
@@ -962,6 +1038,527 @@ fn poll_ep83(dev: &usb::Device) -> usize {
         n
     }
 
+
+    /// Drives the post-SKE CP setup: opens the async EP84 reader, sends the plaintext
+    /// stream-open arm marker, then the first live encrypted CP frame (msg0), and counts the
+    /// dock's encrypted `wsub=0x45` acks. THE WALL: on a cold dock `acks` stays 0 -- the dock
+    /// runs the entire plaintext handshake but never engages the encrypted CP. See the "help
+    /// wanted" note at the top of the file.
+    fn send_cp_setup(
+        dev: &usb::Device,
+        session: &Session,
+        edid_out: &mut Option<KVec<u8>>,
+    ) -> Result<(usize, usize, u32, u16)> {
+        // 16 KiB so the dock's ~5787 B capability block is read whole (see [`EP84_BUF`]).
+        let mut resp = KVec::from_elem(0u8, EP84_BUF, GFP_KERNEL)?;
+        let mut drained = 0usize;
+        let mut acks = 0usize;
+        let mut sent = 0usize;
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
+        // A/B (2026-06-16): route the engagement-critical arm marker + msg0 through an async,
+        // pipelined OUT queue (`usb::Device::bulk_out_queue`) instead of the synchronous
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
+        // Submit the arm marker. Async path: queue it and DO NOT flush -- leave it in flight so
+        // msg0 can be submitted right behind it (the pipelined arm->msg0 burst DLM does). Sync
+        // path: the original blocking send.
+        let arm_res = match out_q.as_mut() {
+            Some(q) => q.send(&STREAM_OPEN, timeout()),
+            None => dev.bulk_send(EP_CTRL_OUT, &STREAM_OPEN, timeout()).map(|_| ()),
+        };
+        if let Err(e) = arm_res {
+            pr_err!("vino: CP stream-open marker FAILED ({e:?})\n");
+            return Err(e);
+        }
+        pr_info!("vino: CP stream-open arm marker sent\n");
+
+        // No artificial arm->msg0 pad. The shared engine (decompiled mac/Windows drivers) is
+        // event-driven and never wall-clock-paces this gap; vino sends msg0 ~0.06 ms after the arm
+        // (vs DLM's ~0.18 ms libusb gap) and the dock's acceptance window is ms-scale, so the
+        // sub-ms lead is immaterial -- confirmed not a gate by the firmware-wall verdict. (Was a
+        // 150 us fsleep copied from DLM's usbmon spacing.)
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
+                match dev.bulk_send(EP_CTRL_OUT, &frame, Delta::from_millis(5)) {
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
+        match dev.control_send(0x24, 0x40 /* VENDOR_OUT */, 0, 0, &[], timeout()) {
+            Ok(()) => pr_info!("vino: post-msg0 0x24(wValue=0) OK\n"),
+            Err(e) => pr_info!("vino: post-msg0 0x24(wValue=0) non-fatal ({e:?})\n"),
+        }
+        // DLM then re-reads the 0x22 vendor state (0xc1, wValue=1, wIndex=0, 28 B) -- its SECOND
+        // 0x22 of the session, immediately after the post-msg0 0x24. vino issued the first 0x22
+        // pre-arm but stopped here, leaving "DLM-ONLY 0x22" in the paired diff. Issue it
+        // unconditionally so the wire matches DLM regardless of whether the dock acks; it is a
+        // harmless vendor IN read. (0xc1 = IN|vendor|INTERFACE recipient, matching the first 0x22.)
+        let mut state2 = [0u8; 28];
+        match dev.control_recv(0x22, 0xc1, 1, 0, &mut state2, timeout()) {
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
+        let engaged = if acks > 0 { "dock engaged" } else { "dock ignoring our CP (the wall)" };
+        pr_info!("vino: CP setup sent={sent} EP84_resp={drained} sub=0x45_acks={acks} ({engaged})\n");
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
+        dev: &usb::Device,
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
+            match dev.bulk_send(EP_CTRL_OUT, &frame, Delta::from_millis(5)) {
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
+        dev: &usb::Device,
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
+            None => dev.bulk_recv(EP_CTRL_IN, buf, to),
+        }
+    }
+
+
+    fn drain_ep84(
+        dev: &usb::Device,
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
+        dev: &usb::Device,
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
+                _ => break,
+            }
+        }
+        (reads, acks, matched)
+    }
 }
 
 kernel::usb_device_table!(
-- 
2.54.0

