Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC5AAC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1AA5110F615;
	Fri,  3 Jul 2026 03:02:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="HGCx8RWd";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D030D10F60D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493c486f012so205255e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047765; x=1783652565;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vBERefzbgATLELd1YFB2eeu96z/oqUgArZaJpq716CA=;
 b=HGCx8RWdqR2kCtCy/b0fayGdPhjTdF3NTP0TlTICzKfKL3FAa9YFumZoUCwsYK/eM5
 1v/qFUGLxZbvZon4GzStfPq8nPpglahFWyocQ4C9GBSZhtaEZXrhY94QP4Q1Df0P+uvU
 BketaR27qUyAgDM1+pNfXLYmVAxFYusqy7+PKtN9MlyBEzSIsKac9Wi3pIyzMJjIdNxB
 wKsXUID+HmHfenu/qhh2O9pQx7swZeIFzOawUK40FcKHaQCBoSJW6X7O9QcMhbt1W/Je
 gIy9EuFa6gVzPz/1dOjPkPhBC8qoQPL2kfDDeWWL3uqQxIQTnCPVJWMFFMw6Wythh1wK
 6dgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047765; x=1783652565;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=vBERefzbgATLELd1YFB2eeu96z/oqUgArZaJpq716CA=;
 b=mcJH0woMEGi1q/1RpizMiQOJUfLqNNhYi+OZuKH7oXvA9g9tk9vqoaY5gqSDZpBiqv
 OPlCZTXvcwje15M5A6Ddi5UnUlwJC/iqcMX88hJzW2Wx1c5IA3Mv0L6719IlWNq5V9aZ
 fA16ff6XKu1c37Ai5oDEdP4O7zxijvVREYxXLZKAC/gAl2hBHTpEAl5x1EE81rd3RX8a
 /AsNz3mLRtDyaEifvY2NX6Mj0a9Ccm6itDu1e8qJ3/UHOzHeME1rGcHarbsSaa5QEuM+
 NGFSdeFSfgAivwxtDDOBVg6vvMJjmXu7ahR5w6EfFpSvDn4lRVScd4cPjbjUjtD4j099
 LUXQ==
X-Gm-Message-State: AOJu0Yxf6qvfTGDTfofjDLu/ErHl0sQi0zNgPiaKh4wLx8emaMm0M9ko
 o8wL6WXDv1FuitRn2eWMytyo3dsZBE+PDODc7GHGx9dCLm9YUtbs7T50r1K1j4SIoQ==
X-Gm-Gg: AfdE7cn6JQRMXNJo9KeNebLWPVu1ndK8+Q1wNpTqzrBkz7Ma4epp8K36KoaPibWimz4
 weqbxZ2fZn6gEllv6IKVCh8MMYOFfgVdHXAEiNKE3dx6AvDB7A5xWziW1rljpg/sJ8SRLT/FQSX
 ro8BUQ7arFwKYiAEO6YRTdObYpKkeP+jaYTW65lf2wm1VQPy75Lh6S/CQHzqN1JREbd/JL8rL/R
 GHsOHrvLCBWEixZZ86PN6BRIxHPi3rm257YX85lTYQ641jG0sleEb1wscAzMNE6t9ONYUTCjsc7
 ZV/dItpIMoZm+iTODrt23cn5yVq/YBBmSbT9irjLje57ECtEFogw7EQaxDZYSRfOSyYgFrDgURI
 e0uZ7ijf5vqcHGflE/T0hIntnk72GFVzGvjLSVddEMdnezOBC2/mPNGn0kHB1fFbSebCx9LXYo4
 2boV1RRKRXsYGf8qNGQR4lE5ejaFdoSjJoY072kYMkJDnACqQ/rd9ryzHz
X-Received: by 2002:a05:600c:6c95:b0:493:bc4a:fb56 with SMTP id
 5b1f17b1804b1-493c2bbcb21mr91851205e9.39.1783047764627; 
 Thu, 02 Jul 2026 20:02:44 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:43 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/10] drm/vino: two heads, 90/270 rotation,
 damage clips and connector probe
Date: Fri,  3 Jul 2026 04:02:14 +0100
Message-ID: <20260703030217.2886-10-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260703030217.2886-1-mike@fireburn.co.uk>
References: <20260617151249.2937-1-mike@fireburn.co.uk>
 <20260703030217.2886-1-mike@fireburn.co.uk>
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

Consume the new connector detect()/mode_valid() and plane damage-clip
bindings, and finish the KMS feature set the driver previously stubbed:

  - Two display heads. probe() builds an independent CRTC + primary/cursor
    plane + encoder + connector per head (see HEADS), each pinned to its
    own video endpoint (VIDEO_EPS: head 0 -> EP08, head 1 -> EP0b) via a
    head index carried in VinoPlane. The scanout and cursor CP messages
    route by that head; per-head EDID uses a per-head connector pointer
    array. The CP mode-set has no decoded head field, so a head is
    conveyed on the wire only by which endpoint its frames go to.

  - 90/270 plane rotation. The rotation property now advertises all four
    90-degree rotations plus reflection; the scanout maps each output
    pixel back to its source pixel with rot_src(), and src_dims() swaps
    the source/output dimensions for 90/270 (rot_src itself was already
    correct given source dimensions -- only its callers were feeding it
    output dims).

  - Damage clips. The RLE scanout takes the old+new plane state, merges
    the client's damage clips (RawPlaneState::damage_merged) into one
    rectangle, and re-converts only that region into the shadow the
    encoder diffs against (identity rotation only; the WHT keyframe path
    is unaffected).

  - Connector detect()/mode_valid(). A head reports connected once its
    downstream EDID arrives (no phantom output for an unpopulated head),
    and modes above MAX_HEAD_CLOCK_KHZ (~4K@60) are pruned.

Still inert until the dock engages CP (see docs/BLOCKER.md).

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-opus-4-8 [Claude-Code]
---
 drivers/gpu/drm/vino/drm_sink.rs | 426 +++++++++++++++++++++----------
 drivers/gpu/drm/vino/vino.rs     |   8 +-
 2 files changed, 292 insertions(+), 142 deletions(-)

diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_sink.rs
index 898cfae8fd4f..ee04a5af9f7d 100644
--- a/drivers/gpu/drm/vino/drm_sink.rs
+++ b/drivers/gpu/drm/vino/drm_sink.rs
@@ -2,31 +2,38 @@
 
 //! DRM/KMS sink: register a real `struct drm_device` with an atomic mode-setting
 //! pipeline so the dock appears to userspace as a `card`/`renderD` node that can be
-//! `drmModeSetCrtc`'d. One CRTC driven by a single primary plane
-//! ([`VinoPlane::atomic_update`] -> EP08 scanout), a virtual encoder, and a virtual
-//! connector whose mode list comes from the dock's real EDID (falling back to 1080p),
-//! with GEM-shmem dumb buffers and `drm_gem_fb_create` framebuffers.
+//! `drmModeSetCrtc`'d. Two independent display heads (see [`HEADS`]), each a CRTC driven by a
+//! primary plane ([`VinoPlane::atomic_update`] -> per-head video endpoint scanout), a cursor plane,
+//! a virtual encoder, and a virtual connector whose mode list comes from the dock's real EDID
+//! (falling back to 1080p), with GEM-shmem dumb buffers and `drm_gem_fb_create` framebuffers.
 //!
 //! Built on the safe KMS mode-object layer (`kernel::drm::kms`), not the raw
 //! `bindings::drm_*` C API: `VinoDrmDriver` implements `drm::kms::KmsDriver`, and each
 //! mode object (`VinoCrtc`/`VinoPlane`/`VinoConnector`/`VinoEncoder`) implements the
 //! matching `Driver*` trait rather than hand-assembling a C vtable.
 //!
-//! Wired onto the safe KMS layer: primary plane (EP08 scanout), a `Type::Cursor` plane (bitmap +
-//! position forwarded via `cp::cursor_{create,image,move}`), a 256-entry CRTC `GAMMA_LUT` (applied
-//! in the scanout), a primary-plane rotation property (0/180 + reflect, applied per source pixel
-//! via `rot_src`), and a DDC/CI virtual I2C adapter ([`VinoI2c`], tunnelling monitor-control writes
-//! to the dock over CP -- brightness/contrast/etc. via `ddcutil`), alongside the DPMS-power VCP the
-//! CRTC hooks already send.
+//! Wired onto the safe KMS layer:
+//! - Per-head primary plane scanout to that head's video endpoint ([`VIDEO_EPS`]) and a
+//!   `Type::Cursor` plane (bitmap + position forwarded via `cp::cursor_{create,image,move}` with
+//!   the head as the CP `head` field).
+//! - A 256-entry CRTC `GAMMA_LUT` (applied in the scanout) and a full plane rotation property
+//!   (all four 90-degree rotations plus X/Y reflection), applied per source pixel via `rot_src`
+//!   (90/270 swap the source/output dimensions -- see [`src_dims`]).
+//! - Frame-damage clips: the RLE scanout re-converts only the client's changed rectangles
+//!   (`RawPlaneState::for_each_damage_clip`) for identity rotation.
+//! - Connector `detect()` (connected once the head's EDID arrives) and `mode_valid()` (prune modes
+//!   above [`MAX_HEAD_CLOCK_KHZ`]).
+//! - A DDC/CI virtual I2C adapter ([`VinoI2c`], tunnelling monitor-control writes to the dock over
+//!   CP -- brightness/contrast/etc. via `ddcutil`), alongside the DPMS-power VCP the CRTC hooks
+//!   send.
 //!
-//! Not yet ported (needs `kernel::drm::kms` extension points that don't exist yet; not fabricated):
-//! - A second display head (the DL3 protocol supports up to 4; one is wired here).
-//!   `VinoPlane`/`VinoCrtc` hold their state inline, so a head is a second `probe()` call away.
-//! - 90/270 rotation (swaps width/height, unlike the dimension-preserving rotations above).
+//! Not yet done (needs hardware capture past the CP wall; not fabricated):
+//! - Per-head EDID reads (the bring-up reads head 0's EDID only) and per-head mode-set / DDC
+//!   differentiation on the wire -- the CP mode-set (`id=0x48`) has no decoded head/stream field,
+//!   so the head is conveyed only by which video endpoint its frames go to.
+//! - The WHT keyframe codec ignores damage clips (strip-based); damage applies to the RLE path.
 //! - DDC/CI *reads* (Get-VCP) -- need the dock's CP reply path; and brightness/contrast as
-//!   *connector properties* (the I2C adapter above is the interface for now).
-//! - The `.detect`/`mode_valid` connector hooks -- `DriverConnector` only exposes `get_modes`.
-//! - Damage-clip bounded conversion (always converts the full frame).
+//!   *connector properties* (the I2C adapter is the interface for now).
 //!
 //! None of this is reachable on real hardware yet regardless: the dock never engages
 //! its content-protection channel for vino (see `docs/BLOCKER.md`), so `atomic_update`
@@ -36,9 +43,10 @@
     bindings, drm,
     drm::kms::{
         self,
-        connector::{self, ConnectorGuard},
+        connector::{self, Connector, ConnectorGuard, ModeStatus, Status},
         crtc::{self, CrtcAtomicCommit, RawCrtc as _, RawCrtcState as _},
         encoder,
+        modes::DisplayMode,
         plane::{self, PlaneAtomicCommit, RawPlaneState as _},
         KmsDriver, ModeConfigGuard, ModeConfigInfo, ModeObject as _, NewKmsDevice, Probing,
     },
@@ -65,16 +73,24 @@
 /// Cursor-plane format list.
 static CURSOR_FORMATS: [u32; 1] = [DRM_FORMAT_ARGB8888];
 
-/// Per-mode pixel-clock ceiling (kHz) -- about 4K@60 (CEA 594 MHz). With only one head wired
-/// there is no combined-heads budget to enforce (see the module doc); a real ceiling still
-/// needs the connector `mode_valid` hook this port doesn't expose yet, so this constant is
-/// currently unused wiring for when it does.
-#[allow(dead_code)]
+/// Per-mode pixel-clock ceiling (kHz) -- about 4K@60 (CEA 594 MHz). Modes above this are pruned
+/// by the connector `mode_valid` hook ([`VinoConnector::mode_valid`]).
 const MAX_HEAD_CLOCK_KHZ: i32 = 600_000;
 
-/// The one wired display head's video bulk-OUT endpoint (see the module doc -- only
-/// head 0 is wired for now).
-const VIDEO_EP: u8 = 0x08;
+/// Number of display heads wired. The DL3 protocol supports up to 4; two are wired here (the
+/// common dual-monitor dock), each scanned out to its own video endpoint ([`VIDEO_EPS`]).
+const HEADS: usize = 2;
+
+/// Per-head video bulk-OUT endpoint: head 0 -> EP08, head 1 -> EP0b (captured from DLM driving a
+/// two-monitor dock). The endpoint is the head selector for scanout; the cursor uses the CP `head`
+/// field (see [`VinoPlane::atomic_update`]).
+const VIDEO_EPS: [u8; HEADS] = [0x08, 0x0b];
+
+/// Maximum number of individual frame-damage rectangles re-converted per flip before they are
+/// collapsed into a single bounding box. Bounds the stack array used on the atomic-commit path
+/// (no per-flip allocation); a compositor that reports more clips than this just gets a coarser
+/// (still correct) repaint.
+const MAX_DAMAGE_CLIPS: usize = 16;
 
 /// The DRM driver marker type.
 pub(super) struct VinoDrmDriver;
@@ -123,10 +139,11 @@ pub(super) struct VinoDrmData {
     intf: ARef<super::usb::Interface>,
     #[pin]
     cp_link: Mutex<Option<CpLink>>,
-    /// The device's one connector, stashed by [`KmsDriver::probe`] so [`VinoDrmData::set_edid`]
-    /// can reach its cached-EDID slot without needing DRM's mode-object list. Written once,
+    /// The device's per-head connectors, stashed by [`KmsDriver::probe`] so
+    /// [`VinoDrmData::set_edid`] can reach a head's cached-EDID slot without needing DRM's
+    /// mode-object list. Written once,
     /// during single-threaded probe, before the device is registered; read-only thereafter.
-    connector: core::sync::atomic::AtomicPtr<VinoConnector>,
+    connectors: [core::sync::atomic::AtomicPtr<VinoConnector>; HEADS],
     /// The CRTC's gamma ramp cached from the atomic hook as three 256-entry 8-bit LUTs
     /// (`[r; 256] ++ [g; 256] ++ [b; 256]`), or `None` for identity. Cached here (not read from
     /// the CRTC state) because scanout runs in the plane path; it is `Copy`, so the scanout
@@ -140,7 +157,9 @@ pub(super) fn new(intf: ARef<super::usb::Interface>) -> impl PinInit<Self, Error
         try_pin_init!(Self {
             intf,
             cp_link <- new_mutex!(Option::<CpLink>::None),
-            connector: core::sync::atomic::AtomicPtr::new(core::ptr::null_mut()),
+            connectors: core::array::from_fn(|_| {
+                core::sync::atomic::AtomicPtr::new(core::ptr::null_mut())
+            }),
             gamma <- new_mutex!(None),
         })
     }
@@ -210,12 +229,14 @@ pub(super) fn set_vcp(&self, vcp: u8, value: u16) -> Result {
         self.send_cp(0x15, 0, |ctr| super::cp::ddc_set_vcp(ctr, vcp, value))
     }
 
-    /// Cache the dock's EDID (read during probe) for the connector's `get_modes` to install,
-    /// then fire a hotplug so the compositor re-probes the connector. Only the connector
-    /// itself holds the cached blob (see [`VinoConnector::cached_edid`]); this just forwards
-    /// it there via the pointer [`KmsDriver::probe`] stashed in `self.connector`.
-    pub(super) fn set_edid(&self, dev: &VinoDrmDevice, blob: KVec<u8>) {
-        let ptr = self.connector.load(core::sync::atomic::Ordering::Acquire);
+    /// Cache a head's downstream EDID (read during probe) for that connector's `get_modes` to
+    /// install, then fire a hotplug so the compositor re-probes it. Only the connector itself
+    /// holds the cached blob (see [`VinoConnector::cached_edid`]); this forwards it there via the
+    /// pointer [`KmsDriver::probe`] stashed in `self.connectors[head]`. Out-of-range `head` is a
+    /// no-op.
+    pub(super) fn set_edid(&self, dev: &VinoDrmDevice, head: usize, blob: KVec<u8>) {
+        let Some(slot) = self.connectors.get(head) else { return };
+        let ptr = slot.load(core::sync::atomic::Ordering::Acquire);
         let Some(connector) = (unsafe { ptr.as_ref() }) else { return };
         *connector.cached_edid.lock() = Some(blob);
         dev.hotplug_event();
@@ -319,69 +340,77 @@ fn mode_config_info(_dev: &drm::Device<Self, drm::Uninit>) -> Result<ModeConfigI
     }
 
     fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> Result {
-        // Order matters: `possible_crtcs` for the plane/encoder is a bitmask of CRTC
-        // *indices*, which only exist once `UnregisteredCrtc::new` runs -- but planes
-        // must exist before the CRTC that references them. With exactly one CRTC ever
-        // created here, its index is always 0, so `possible_crtcs = 1` is correct by
-        // construction rather than needing the CRTC up front.
-        let primary = plane::UnregisteredPlane::<VinoPlane>::new(
-            dev,
-            1,
-            &PRIMARY_FORMATS,
-            None,
-            plane::Type::Primary,
-            None,
-            false,
-        )?;
-        // Advertise the rotations vino's re-encode handles 1:1 (dimension-preserving): the
-        // scanout applies them per source pixel via `rot_src`. 90/270 (which swap width/height)
-        // are intentionally omitted.
-        primary.create_rotation_property(
-            bindings::DRM_MODE_ROTATE_0,
-            bindings::DRM_MODE_ROTATE_0
-                | bindings::DRM_MODE_ROTATE_180
-                | bindings::DRM_MODE_REFLECT_X
-                | bindings::DRM_MODE_REFLECT_Y,
-        )?;
-        let cursor = plane::UnregisteredPlane::<VinoPlane>::new(
-            dev,
-            1,
-            &CURSOR_FORMATS,
-            None,
-            plane::Type::Cursor,
-            None,
-            true,
-        )?;
-        let crtc_obj = crtc::UnregisteredCrtc::<VinoCrtc>::new(
-            dev,
-            primary,
-            Some(&cursor),
-            None,
-            (),
-        )?;
-        // Advertise a 256-entry GAMMA_LUT; the scanout applies it (cached via the CRTC hooks).
-        crtc_obj.enable_gamma(256);
-        let enc = encoder::UnregisteredEncoder::<VinoEncoder>::new(
-            dev,
-            encoder::Type::Virtual,
-            crtc_obj.mask(),
-            0,
-            None,
-            (),
-        )?;
-        let conn =
-            connector::UnregisteredConnector::<VinoConnector>::new(dev, connector::Type::Virtual, ())?;
-        conn.attach_encoder(&*enc)?;
-        // Stash a pointer to our own connector data (not the wrapping `Connector<T>`, which
-        // this crate has no public way to reconstruct from a reference) so
-        // `VinoDrmData::set_edid` can reach it later without walking DRM's mode-object list.
-        // `conn` outlives the device (destroyed only alongside it), so this is valid for as
-        // long as `dev.connector` is read.
         let data: &VinoDrmData = dev;
-        data.connector.store(
-            &**conn as *const VinoConnector as *mut VinoConnector,
-            core::sync::atomic::Ordering::Release,
-        );
+        // Build one independent head (CRTC + primary/cursor plane + encoder + connector) per
+        // wired display, each pinned to its own video endpoint via its head index.
+        for head in 0..HEADS {
+            // `possible_crtcs` for the plane/encoder is a bitmask of CRTC *indices*, which only
+            // exist once `UnregisteredCrtc::new` runs -- but planes must exist before the CRTC
+            // that references them. CRTCs are created here one per head in order, so this head's
+            // CRTC index is `head` and its mask is `1 << head`.
+            let crtc_mask = 1u32 << head;
+            let primary = plane::UnregisteredPlane::<VinoPlane>::new(
+                dev,
+                crtc_mask,
+                &PRIMARY_FORMATS,
+                None,
+                plane::Type::Primary,
+                None,
+                PlaneArgs { head: head as u8, is_cursor: false },
+            )?;
+            // Advertise every rotation vino's re-encode can produce by remapping source pixels
+            // (`rot_src`): the four 90-degree rotations plus the two reflections.
+            primary.create_rotation_property(
+                bindings::DRM_MODE_ROTATE_0,
+                bindings::DRM_MODE_ROTATE_0
+                    | bindings::DRM_MODE_ROTATE_90
+                    | bindings::DRM_MODE_ROTATE_180
+                    | bindings::DRM_MODE_ROTATE_270
+                    | bindings::DRM_MODE_REFLECT_X
+                    | bindings::DRM_MODE_REFLECT_Y,
+            )?;
+            let cursor = plane::UnregisteredPlane::<VinoPlane>::new(
+                dev,
+                crtc_mask,
+                &CURSOR_FORMATS,
+                None,
+                plane::Type::Cursor,
+                None,
+                PlaneArgs { head: head as u8, is_cursor: true },
+            )?;
+            let crtc_obj = crtc::UnregisteredCrtc::<VinoCrtc>::new(
+                dev,
+                primary,
+                Some(&cursor),
+                None,
+                head as u8,
+            )?;
+            // Advertise a 256-entry GAMMA_LUT; the scanout applies it (cached via the CRTC hooks).
+            crtc_obj.enable_gamma(256);
+            let enc = encoder::UnregisteredEncoder::<VinoEncoder>::new(
+                dev,
+                encoder::Type::Virtual,
+                crtc_obj.mask(),
+                0,
+                None,
+                (),
+            )?;
+            let conn = connector::UnregisteredConnector::<VinoConnector>::new(
+                dev,
+                connector::Type::Virtual,
+                (),
+            )?;
+            conn.attach_encoder(&*enc)?;
+            // Stash a pointer to our own connector data (not the wrapping `Connector<T>`, which
+            // this crate has no public way to reconstruct from a reference) so
+            // `VinoDrmData::set_edid` can reach it later without walking DRM's mode-object list.
+            // `conn` outlives the device (destroyed only alongside it), so this is valid for as
+            // long as `dev.connectors[head]` is read.
+            data.connectors[head].store(
+                &**conn as *const VinoConnector as *mut VinoConnector,
+                core::sync::atomic::Ordering::Release,
+            );
+        }
         Ok(())
     }
 }
@@ -389,7 +418,11 @@ fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> Result {
 // ---- CRTC -----------------------------------------------------------------
 
 #[pin_data]
-pub(super) struct VinoCrtc;
+pub(super) struct VinoCrtc {
+    /// Which display head (0-based) this CRTC drives. Used for diagnostics; the mode-set/DDC CP
+    /// messages this CRTC sends are not yet head-differentiated on the wire (see the module doc).
+    head: u8,
+}
 
 #[derive(Clone, Default)]
 pub(super) struct VinoCrtcState;
@@ -400,26 +433,32 @@ impl crtc::DriverCrtcState for VinoCrtcState {
 
 #[vtable]
 impl crtc::DriverCrtc for VinoCrtc {
-    type Args = ();
+    type Args = u8;
     type Driver = VinoDrmDriver;
     type State = VinoCrtcState;
     type VblankImpl = core::marker::PhantomData<Self>;
 
-    fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, _args: &()) -> impl PinInit<Self, Error> {
-        try_pin_init!(VinoCrtc {})
+    fn new(
+        _device: &drm::Device<Self::Driver, drm::Uninit>,
+        head: &u8,
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(VinoCrtc { head: *head })
     }
 
     /// The display is turning on (scanout begins). Pushes a live mode-set CP message for the
     /// negotiated mode and brings the monitor out of DPMS standby -- both no-ops until CP
     /// engages (the wall).
     fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
-        let data: &VinoDrmData = commit.crtc().drm_dev();
+        let crtc = commit.crtc();
+        let head = crtc.head;
+        let data: &VinoDrmData = crtc.drm_dev();
         let new = commit.take_new_state();
         // Cache the gamma ramp for the scanout to apply.
         data.update_gamma(new.gamma_lut());
         let timing = super::cp::timing_from_drm_mode(new.mode());
         pr_info!(
-            "vino: KMS CRTC enable -- display ON, mode {}x{}@{} (scanout begins)\n",
+            "vino: KMS CRTC enable -- head {} display ON, mode {}x{}@{} (scanout begins)\n",
+            head,
             timing.hactive,
             timing.vactive,
             timing.refresh_hz
@@ -435,10 +474,12 @@ fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
     /// against a shadow the dock may have dropped, and blanks the monitor via DDC/CI -- a
     /// no-op until CP engages.
     fn atomic_disable(commit: CrtcAtomicCommit<'_, Self>) {
-        let data: &VinoDrmData = commit.crtc().drm_dev();
+        let crtc = commit.crtc();
+        let head = crtc.head;
+        let data: &VinoDrmData = crtc.drm_dev();
         data.update_gamma(None);
         let _ = data.set_vcp(super::cp::VCP_POWER_MODE, super::cp::POWER_OFF);
-        pr_info!("vino: KMS CRTC disable -- display OFF (scanout stopped)\n");
+        pr_info!("vino: KMS CRTC disable -- head {head} display OFF (scanout stopped)\n");
     }
 }
 
@@ -447,10 +488,21 @@ fn atomic_disable(commit: CrtcAtomicCommit<'_, Self>) {
 // The safe KMS layer allows one `DriverPlane` type per driver, so `VinoPlane` serves both the
 // primary and cursor planes, told apart by `is_cursor` (from the plane's `Args`).
 
+/// Constructor arguments for a [`VinoPlane`]: which head it belongs to and whether it is that
+/// head's cursor plane (vs. its primary scanout plane).
+#[derive(Clone, Copy)]
+pub(super) struct PlaneArgs {
+    head: u8,
+    is_cursor: bool,
+}
+
 #[pin_data]
 pub(super) struct VinoPlane {
     #[pin]
     scanout: Mutex<ScanoutState>,
+    /// Which display head (0-based) this plane belongs to. Selects the scanout video endpoint
+    /// ([`VIDEO_EPS`]) and the cursor CP `head` field.
+    head: u8,
     /// Whether this is the cursor plane (vs. the primary scanout plane).
     is_cursor: bool,
     /// The framebuffer last uploaded to the dock as the cursor bitmap (raw address, `0` = none),
@@ -467,11 +519,14 @@ impl plane::DriverPlaneState for VinoPlaneState {
 
 #[vtable]
 impl plane::DriverPlane for VinoPlane {
-    type Args = bool;
+    type Args = PlaneArgs;
     type Driver = VinoDrmDriver;
     type State = VinoPlaneState;
 
-    fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, is_cursor: bool) -> impl PinInit<Self, Error> {
+    fn new(
+        _device: &drm::Device<Self::Driver, drm::Uninit>,
+        args: PlaneArgs,
+    ) -> impl PinInit<Self, Error> {
         try_pin_init!(VinoPlane {
             scanout <- new_mutex!(ScanoutState {
                 enc: None,
@@ -480,7 +535,8 @@ fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, is_cursor: bool) -> imp
                 dims: (0, 0),
                 hint: 0,
             }),
-            is_cursor,
+            head: args.head,
+            is_cursor: args.is_cursor,
             cursor_last: core::sync::atomic::AtomicUsize::new(0),
         })
     }
@@ -498,14 +554,14 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
             return;
         }
         let plane = commit.plane();
+        let head = plane.head;
         let data: &VinoDrmData = plane.drm_dev();
-        let new = commit.take_new_state();
 
         // Cursor plane: forward the cursor bitmap/position to the dock over CP (id=0x1b create,
         // 0x401c image, 0x1a move -- see `cp::cursor_*`). A no-op until CP engages, like scanout.
         if plane.is_cursor {
             use core::sync::atomic::Ordering::Relaxed;
-            const HEAD: u8 = 0;
+            let new = commit.take_new_state();
             match new.framebuffer::<VinoDrmDriver>() {
                 Some(fb) => {
                     let w = fb.width() as u16;
@@ -514,15 +570,17 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
                     // position (a bare cursor move must not re-send the whole image).
                     let key = fb as *const _ as usize;
                     if plane.cursor_last.swap(key, Relaxed) != key {
-                        let _ = data.send_cp(0x1b, 0, |ctr| super::cp::cursor_create(ctr, HEAD, w, h));
+                        let _ =
+                            data.send_cp(0x1b, 0, |ctr| super::cp::cursor_create(ctr, head, w, h));
                         if let Ok(bgra) = read_cursor_bgra(fb, w as usize, h as usize) {
-                            let _ = data
-                                .send_cp(0x401c, 0, |ctr| super::cp::cursor_image(ctr, HEAD, w, h, &bgra));
+                            let _ = data.send_cp(0x401c, 0, |ctr| {
+                                super::cp::cursor_image(ctr, head, w, h, &bgra)
+                            });
                         }
                     }
                     let x = new.crtc_x().max(0) as u16;
                     let y = new.crtc_y().max(0) as u16;
-                    let _ = data.send_cp(0x1a, 0, |ctr| super::cp::cursor_move(ctr, HEAD, x, y));
+                    let _ = data.send_cp(0x1a, 0, |ctr| super::cp::cursor_move(ctr, head, x, y));
                 }
                 // Cursor disabled: forget the last bitmap so it re-uploads if it comes back.
                 None => plane.cursor_last.store(0, Relaxed),
@@ -530,6 +588,8 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
             return;
         }
 
+        // Primary plane: take both old and new state so the frame-damage clips can be merged.
+        let (old, new) = commit.take_old_new_state();
         let Some(fb) = new.framebuffer::<VinoDrmDriver>() else { return };
         // The plane's destination geometry mirrors the negotiated mode (the compositor sizes the
         // primary plane 1:1 with the virtual output), so this drives the dynamic scanout
@@ -537,6 +597,37 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
         let (w, h) = (new.crtc_w() as usize, new.crtc_h() as usize);
         // Plane rotation/reflection (identity unless the compositor set the rotation property).
         let rotation = new.rotation();
+        // Collect the client's individual frame-damage clips (the rectangles that
+        // `damage_merged()` would collapse into one bounding box), each clamped to the output, so
+        // only the genuinely changed rectangles are re-converted from the source rather than their
+        // whole enclosing box. Only for identity rotation (the clips are in un-rotated source
+        // space; mapping them through 90/270 is not worth it for the throttled fallback path), and
+        // never on the WHT keyframe path -- see `encode_and_send`. A fixed stack array keeps the
+        // atomic-commit path allocation-free; on overflow the clips collapse into one bounding box.
+        // An empty list means "convert the whole output" (used for the rotated/reflected case).
+        let mut clips = [(0usize, 0usize, 0usize, 0usize); MAX_DAMAGE_CLIPS];
+        let mut nclips = 0usize;
+        if rotation & bindings::DRM_MODE_ROTATE_MASK == bindings::DRM_MODE_ROTATE_0
+            && rotation & (bindings::DRM_MODE_REFLECT_X | bindings::DRM_MODE_REFLECT_Y) == 0
+        {
+            new.for_each_damage_clip(old, |r| {
+                let c = (
+                    (r.x1.max(0) as usize).min(w),
+                    (r.y1.max(0) as usize).min(h),
+                    (r.x2.max(0) as usize).min(w),
+                    (r.y2.max(0) as usize).min(h),
+                );
+                if nclips < MAX_DAMAGE_CLIPS {
+                    clips[nclips] = c;
+                    nclips += 1;
+                } else {
+                    // Overflow: collapse everything so far (and `c`) into clips[0]'s bounding box.
+                    let b = clips[0];
+                    clips[0] = (b.0.min(c.0), b.1.min(c.1), b.2.max(c.2), b.3.max(c.3));
+                    nclips = 1;
+                }
+            });
+        }
 
         use core::sync::atomic::Ordering::Relaxed;
         // Throttle: while scanout is failing (dock NAKing because CP isn't engaged), skip the
@@ -547,7 +638,7 @@ fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
             super::SCANOUT_SKIP.store(skip - 1, Relaxed);
             return;
         }
-        match scanout_one(data, plane, fb, rotation, w, h) {
+        match scanout_one(data, plane, fb, rotation, &clips[..nclips], w, h) {
             Ok(()) => {
                 let n = super::SCANOUT_FAILS.swap(0, Relaxed);
                 super::SCANOUT_SKIP.store(0, Relaxed);
@@ -608,12 +699,27 @@ fn read_cursor_bgra(
     Ok(out)
 }
 
-/// vmap `fb`, encode it, and push one EP08 frame. Split out so `?` can be used.
+/// Source (framebuffer) dimensions for an output of `ow`x`oh` pixels under plane `rotation`.
+/// The 90/270 rotations swap width and height between the framebuffer and the displayed output;
+/// the others preserve them.
+fn src_dims(rotation: u32, ow: usize, oh: usize) -> (usize, usize) {
+    let rot = rotation & bindings::DRM_MODE_ROTATE_MASK;
+    if rot == bindings::DRM_MODE_ROTATE_90 || rot == bindings::DRM_MODE_ROTATE_270 {
+        (oh, ow)
+    } else {
+        (ow, oh)
+    }
+}
+
+/// vmap `fb`, encode it, and push one video frame to the head's endpoint. Split out so `?` can be
+/// used. `w`/`h` are the OUTPUT (displayed) dimensions; `clips` are the client's changed
+/// rectangles in output space (empty = repaint the whole output).
 fn scanout_one(
     data: &VinoDrmData,
     plane: &plane::Plane<VinoPlane>,
     fb: &kms::framebuffer::Framebuffer<VinoDrmDriver>,
     rotation: u32,
+    clips: &[(usize, usize, usize, usize)],
     w: usize,
     h: usize,
 ) -> Result {
@@ -626,7 +732,7 @@ fn scanout_one(
     // The real source stride: GEM dumb buffers pad the pitch (alignment), so it is not necessarily
     // `w * 4` -- read it from the framebuffer rather than assuming.
     let pitch = fb.pitch(0) as usize;
-    encode_and_send(data, plane, vmap.as_ptr(), pitch, rotation, w, h)
+    encode_and_send(data, plane, vmap.as_ptr(), pitch, rotation, clips, w, h)
 }
 
 /// Encode the mapped frame with the byte-exact Vino WHT **colour** codec and bulk-write the
@@ -646,11 +752,13 @@ fn encode_and_send_wht(
 ) -> Result {
     let seq0 = plane.scanout.lock().seq;
     let gamma = data.gamma_snapshot();
+    // Source dimensions (swapped from the output for 90/270 rotation).
+    let (sw, sh) = src_dims(rotation, w, h);
     let (frames, next_seq) = super::video::wht::colour_frame_ep08(w, h, seq0, |dx, dy| {
         // Map the output pixel back to its source pixel under the plane rotation/reflection.
-        let (sx, sy) = rot_src(rotation, dx, dy, w, h);
-        // SAFETY: `sy*pitch + sx*4 + 3` is within the mapped source framebuffer (`pitch*h` bytes);
-        // `rot_src` returns `sx < w <= pitch/4`, `sy < h`.
+        let (sx, sy) = rot_src(rotation, dx, dy, sw, sh);
+        // SAFETY: `sy*pitch + sx*4 + 3` is within the mapped source framebuffer (`pitch*sh`
+        // bytes); `rot_src` returns `sx < sw <= pitch/4`, `sy < sh`.
         let px = unsafe { (vaddr.add(sy * pitch + sx * 4) as *const u32).read_unaligned() };
         apply_gamma(
             &gamma,
@@ -665,8 +773,9 @@ fn encode_and_send_wht(
     // in `disconnect()`, which first unplugs the DRM device, so it is bound for this push.
     let dev = unsafe { data.intf.as_bound() };
     prime_video_eps(dev);
+    let ep = VIDEO_EPS[plane.head as usize];
     for frame in frames.iter() {
-        dev.bulk_send(VIDEO_EP, frame, super::timeout(), GFP_KERNEL)?;
+        dev.bulk_send(ep, frame, super::timeout(), GFP_KERNEL)?;
     }
     Ok(())
 }
@@ -679,13 +788,14 @@ fn encode_and_send(
     vaddr: *const u8,
     pitch: usize,
     rotation: u32,
+    clips: &[(usize, usize, usize, usize)],
     w: usize,
     h: usize,
 ) -> Result {
     // WHT colour codec path (default off): the byte-exact, bandwidth-efficient DLM-quality
     // codec. Requires a 64x16-aligned mode; for non-aligned geometry (e.g. 1080p, height
     // 1080 % 16 = 8) fall through to the RLE path until partial-strip edge handling is
-    // captured.
+    // captured. The keyframe codec ignores damage clips.
     if super::EP08_WHT_CODEC
         && w % super::video::wht::STRIP_W == 0
         && h % super::video::wht::STRIP_H == 0
@@ -693,6 +803,8 @@ fn encode_and_send(
         return encode_and_send_wht(data, plane, vaddr, pitch, rotation, w, h);
     }
     let gamma = data.gamma_snapshot();
+    // Source dimensions (swapped from the output for 90/270 rotation).
+    let (sw, sh) = src_dims(rotation, w, h);
     let frame = {
         let mut st = plane.scanout.lock();
         // On the first frame `cur` is freshly zeroed, so the whole buffer must be filled.
@@ -708,21 +820,31 @@ fn encode_and_send(
             st.hint = 0;
         }
         let ScanoutState { enc, cur, seq, hint, dims: _ } = &mut *st;
-        for dy in 0..h {
-            for dx in 0..w {
-                // Map the output pixel back to its source pixel under the plane rotation.
-                let (sx, sy) = rot_src(rotation, dx, dy, w, h);
-                // SAFETY: `sy*pitch + sx*4 + 3` is within the mapped source framebuffer
-                // (`pitch*h` bytes); `rot_src` returns `sx < w <= pitch/4`, `sy < h`.
-                let px = unsafe { (vaddr.add(sy * pitch + sx * 4) as *const u32).read_unaligned() };
-                let (r, g, b) = apply_gamma(
-                    &gamma,
-                    ((px >> 16) & 0xff) as u8,
-                    ((px >> 8) & 0xff) as u8,
-                    (px & 0xff) as u8,
-                );
-                let (r, g, b) = (r as u32, g as u32, b as u32);
-                cur[dy * w + dx] = (((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3)) as u16;
+        // Re-convert only the client's changed rectangles into `cur`; the rest already holds the
+        // previous frame, which the encoder diffs against. On the first frame there is no valid
+        // previous frame (and on a rotated output there are no usable clips), so convert the whole
+        // output. `clips` are already clamped to the output in `atomic_update`.
+        let full = [(0usize, 0usize, w, h)];
+        let regions: &[(usize, usize, usize, usize)] =
+            if first || clips.is_empty() { &full } else { clips };
+        for &(x0, y0, x1, y1) in regions {
+            for dy in y0..y1 {
+                for dx in x0..x1 {
+                    // Map the output pixel back to its source pixel under the plane rotation.
+                    let (sx, sy) = rot_src(rotation, dx, dy, sw, sh);
+                    // SAFETY: `sy*pitch + sx*4 + 3` is within the mapped source framebuffer
+                    // (`pitch*sh` bytes); `rot_src` returns `sx < sw <= pitch/4`, `sy < sh`.
+                    let px =
+                        unsafe { (vaddr.add(sy * pitch + sx * 4) as *const u32).read_unaligned() };
+                    let (r, g, b) = apply_gamma(
+                        &gamma,
+                        ((px >> 16) & 0xff) as u8,
+                        ((px >> 8) & 0xff) as u8,
+                        (px & 0xff) as u8,
+                    );
+                    let (r, g, b) = (r as u32, g as u32, b as u32);
+                    cur[dy * w + dx] = (((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3)) as u16;
+                }
             }
         }
         let s = *seq;
@@ -746,7 +868,7 @@ fn encode_and_send(
     // DRM device, so it is bound for the duration of this push.
     let dev = unsafe { data.intf.as_bound() };
     prime_video_eps(dev);
-    dev.bulk_send(VIDEO_EP, &frame, super::timeout(), GFP_KERNEL)?;
+    dev.bulk_send(VIDEO_EPS[plane.head as usize], &frame, super::timeout(), GFP_KERNEL)?;
     Ok(())
 }
 
@@ -769,7 +891,9 @@ fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, _args: ()) -> impl PinI
 
 #[pin_data]
 pub(super) struct VinoConnector {
-    /// This connector's downstream-monitor EDID (`None` until the CP channel delivers it).
+    /// This connector's downstream-monitor EDID (`None` until the CP channel delivers it). Which
+    /// head a connector belongs to is tracked by its slot in [`VinoDrmData::connectors`], so the
+    /// connector itself needs no head field.
     #[pin]
     cached_edid: Mutex<Option<KVec<u8>>>,
 }
@@ -814,6 +938,28 @@ fn get_modes<'a>(
         connector.set_preferred_mode((FALLBACK_W as u32, FALLBACK_H as u32));
         n
     }
+
+    /// Report the head connected once the dock has delivered this head's downstream EDID (a real
+    /// monitor is attached and described), disconnected until then. A head with no monitor (e.g.
+    /// the second head of a single-monitor dock) stays disconnected rather than advertising a
+    /// phantom output.
+    fn detect(connector: &Connector<Self>, _force: bool) -> Status {
+        if connector.cached_edid.lock().is_some() {
+            Status::Connected
+        } else {
+            Status::Disconnected
+        }
+    }
+
+    /// Prune modes whose pixel clock exceeds a single head's bandwidth ceiling
+    /// ([`MAX_HEAD_CLOCK_KHZ`], ~4K@60).
+    fn mode_valid(_connector: &Connector<Self>, mode: &DisplayMode) -> ModeStatus {
+        if mode.clock() > MAX_HEAD_CLOCK_KHZ {
+            ModeStatus::ClockHigh
+        } else {
+            ModeStatus::Ok
+        }
+    }
 }
 
 // ---- DDC/CI I2C adapter -----------------------------------------------------
diff --git a/drivers/gpu/drm/vino/vino.rs b/drivers/gpu/drm/vino/vino.rs
index fd8d351dd1d9..049e8c4cb0f7 100644
--- a/drivers/gpu/drm/vino/vino.rs
+++ b/drivers/gpu/drm/vino/vino.rs
@@ -372,8 +372,12 @@ fn run(this: Arc<BringUp>) {
                             let n = blob.len();
                             let dev: &drm_sink::VinoDrmDevice = d;
                             let data: &drm_sink::VinoDrmData = dev;
-                            data.set_edid(dev, blob);
-                            dev_info!(cdev, "vino: cached dock EDID for connector ({n} bytes)\n");
+                            // The bring-up reads the dock's primary downstream EDID; head 0.
+                            data.set_edid(dev, 0, blob);
+                            dev_info!(
+                                cdev,
+                                "vino: cached dock EDID for head 0 connector ({n} bytes)\n"
+                            );
                         }
                     }
                     Err(e) => dev_info!(cdev, "vino: HDCP AKE incomplete ({e:?}) -- WIP\n"),
-- 
2.55.0

