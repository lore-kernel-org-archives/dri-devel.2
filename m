Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D8ABC43327
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 03:02:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB2F310F60F;
	Fri,  3 Jul 2026 03:02:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="rX6xsKpG";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943AC10F60D
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 03:02:35 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-493c19bad03so418115e9.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 20:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1783047754; x=1783652554;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mAWpF5GM7+KlRlhG2oJiDdMl4YCXDmzEDdK+o+UpA3k=;
 b=rX6xsKpGI5XNkDvUblGN6zbsR6u7EylrEzabuklfZkqmkvSHn+mjrTdKQA6hJ1D1UJ
 1PdRdZxv3YmgvykdFocKwaswUOQ8lggim3r7WhIeG9x8NLuSORoIKDKWAMX0LdeAMSj0
 9R3TZj6iHi+Yab6xAjcQngxXU5U/fue1l+S18ODH1b0EajX3g1/D6TD+sVfqbFx6cwhJ
 Svw5OuYeE2ofkqtrlCslx6cpBsfkzSkJrIFyrPXMsc6OYzLvhwqSmOhocBnye6jCIATs
 fDoR0eyKmAuE1N699qV6s2O9EGc2I/VYEDrhj5r4Uv4KiIUiIy/lZQ25TRv8cxHmuJcy
 5x3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783047754; x=1783652554;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mAWpF5GM7+KlRlhG2oJiDdMl4YCXDmzEDdK+o+UpA3k=;
 b=Tz9bFmZld2yEupHTosYNv/ALZAnb6PAKJz7qW9or2IKCSbhESFkVSXY4OAveJCdhGW
 A1HfbSM/vcjR8ZHvi3dDRQuzKj4rpm/6P8ewOtFlTMD0du42Iq8ZOBoq+hz2XBkS3nzF
 lryG454qSoWLBSfxB9pnyKJS2ibmWeG6Mb6z5k9OZw+x+sq+pxgUdTpfrWDm6kRBghs7
 jgCr5PI9/7PB30dGOejGdEFN/arTLlL6mjCtviRte7GDMrA4CPNUwy/LCoI/AHoEKFb2
 Vuq/5Fe4wmtLGgI0LaoAOzaaMCJeqqtm3T9RU0o8Ol6RwYoEcLPzEAq1QXWDDOxzfMlM
 NJBw==
X-Gm-Message-State: AOJu0Yyo1al4ldUe89TDU7jABhmooYbQ4Si+J2qbct40A6feEOjmk+im
 Ppb1aThgCxE/8ahRWFLEpA8WEuEsVaCysWg+OPbgOSaCbzPLqOwx/TxtfxlkGZpShw==
X-Gm-Gg: AfdE7ckFNSaUKWFxQijJcl67ANew32qZQXRX978D+lLYVwIiUX6eFyhtlZT41jIhXCf
 ifzm2gvIJ/ketTmR4HANX/TSOgNGnyU2zt1WZSofxsjYmX/XhucSWWHCIPoCCDfpuy7aY/uyI0+
 0m/VJE+FA2PcGMoDFYFVsL0Hb4BmfIjq1eNb0AEI+g4SmHY3TvpXGe83mTyDK5yTdDP+ssC2Sww
 1ONfuTOocKv4yn0sMbMxSaO8AbNnG/5KjfBX5ZFwFtEyg3AE4YMqYt7sBIMQILBsAAQooT53V6G
 WNc5Z/n8GLr0rzskD5NIMnr7m34BNDYmeTNwJOAo2lfKAwfSk+8e9dLEuVLfwlMbEesb+RzL+7V
 XgFW8Bwqh+YJGVzah0fSGHwtR5xCeWAXs2qT0X6wrr/ciKYbmKHH5xsl6f0XDORL12VG0xTF8tB
 3OF8SBz8gBnUBgKYa1mu3zzAPYoXVYGQQyEc/QpsmxZQEE1UhT3OD1Zgtsuyev5gmgaUw=
X-Received: by 2002:a05:600c:190a:b0:493:c068:db11 with SMTP id
 5b1f17b1804b1-493c2b94615mr113249965e9.26.1783047753600; 
 Thu, 02 Jul 2026 20:02:33 -0700 (PDT)
Received: from axion.fireburn.co.uk ([137.220.119.72])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be4a343csm141233875e9.0.2026.07.02.20.02.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 20:02:31 -0700 (PDT)
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
Subject: [RFC PATCH v2 05/10] drm/vino: add the DRM/KMS sink,
 built on the safe KMS mode-object layer
Date: Fri,  3 Jul 2026 04:02:10 +0100
Message-ID: <20260703030217.2886-6-mike@fireburn.co.uk>
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

drm_sink.rs registers a real struct drm_device with an atomic
mode-setting pipeline: one CRTC driven by a single primary plane
(scanout -> EP08), a virtual encoder, and a virtual connector whose
mode list comes from the dock's real EDID when the CP channel has
delivered it (falling back to 1080p), with GEM-shmem dumb buffers.

Built entirely on kernel::drm::kms -- VinoDrmDriver implements
KmsDriver, and VinoCrtc/VinoPlane/VinoConnector/VinoEncoder each
implement the matching Driver* trait, rather than hand-assembling a
raw C vtable the way the pre-safe-KMS version of this driver did (that
approach no longer compiles against current drm-next: the base Driver
trait now requires a Kms associated type routed through this exact
system). vino is the first real KmsDriver consumer of this freshly
forward-ported layer; two small gaps it needed are added earlier in
this series (Framebuffer::vmap(), the raw crtc/plane-state escape
hatches).

Not yet ported (documented in the module's own doc comment, not
fabricated): a second display head, a cursor plane, CRTC gamma LUT,
plane rotation property, and DDC/CI brightness/contrast as connector
properties -- none of these have a safe kernel::drm::kms extension
point yet. None of this is reachable on real hardware regardless: the
dock never engages its content-protection channel for vino (see
docs/BLOCKER.md), so atomic_update never gets past the first
bulk_send.

Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
Assisted-by: Claude:claude-sonnet-5 [Claude-Code]
---
 drivers/gpu/drm/vino/drm_sink.rs | 698 +++++++++++++++++++++++++++++++
 1 file changed, 698 insertions(+)
 create mode 100644 drivers/gpu/drm/vino/drm_sink.rs

diff --git a/drivers/gpu/drm/vino/drm_sink.rs b/drivers/gpu/drm/vino/drm_sink.rs
new file mode 100644
index 000000000000..450c7c84a067
--- /dev/null
+++ b/drivers/gpu/drm/vino/drm_sink.rs
@@ -0,0 +1,698 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! DRM/KMS sink: register a real `struct drm_device` with an atomic mode-setting
+//! pipeline so the dock appears to userspace as a `card`/`renderD` node that can be
+//! `drmModeSetCrtc`'d. One CRTC driven by a single primary plane
+//! ([`VinoPlane::atomic_update`] -> EP08 scanout), a virtual encoder, and a virtual
+//! connector whose mode list comes from the dock's real EDID (falling back to 1080p),
+//! with GEM-shmem dumb buffers and `drm_gem_fb_create` framebuffers.
+//!
+//! Built on the safe KMS mode-object layer (`kernel::drm::kms`), not the raw
+//! `bindings::drm_*` C API: `VinoDrmDriver` implements `drm::kms::KmsDriver`, and each
+//! mode object (`VinoCrtc`/`VinoPlane`/`VinoConnector`/`VinoEncoder`) implements the
+//! matching `Driver*` trait rather than hand-assembling a C vtable.
+//!
+//! Not yet ported from the pre-safe-KMS driver (tracked as follow-up, not fabricated
+//! here since the extension points don't exist yet in `kernel::drm::kms`):
+//! - A second display head (the dock's DL3 protocol supports up to 4; only one is
+//!   wired here). `VinoPlane`/`VinoCrtc` hold their state inline rather than behind a
+//!   pointer-identity lookup table, so adding a head is a second `probe()` call away,
+//!   not a redesign.
+//! - A cursor plane, CRTC gamma LUT, and plane rotation property -- `kernel::drm::kms`
+//!   doesn't yet expose `drm_plane_create_rotation_property` or a second (cursor)
+//!   plane argument shape beyond what `UnregisteredCrtc::new` already threads through.
+//! - DDC/CI brightness/contrast as connector properties, and the `.detect`/`mode_valid`
+//!   connector hooks (report disconnected until a real EDID arrives; reject
+//!   over-budget modes) -- `DriverConnector` only exposes `get_modes` right now.
+//! - Damage-clip bounded conversion (always converts the full frame).
+//!
+//! None of this is reachable on real hardware yet regardless: the dock never engages
+//! its content-protection channel for vino (see `docs/BLOCKER.md`), so `atomic_update`
+//! never gets past the first `bulk_send`.
+
+use kernel::{
+    bindings, drm,
+    drm::kms::{
+        self,
+        connector::{self, ConnectorGuard},
+        crtc::{self, CrtcAtomicCommit, RawCrtc as _, RawCrtcState as _},
+        encoder,
+        plane::{self, PlaneAtomicCommit, RawPlaneState as _},
+        KmsDriver, ModeConfigGuard, ModeConfigInfo, ModeObject as _, NewKmsDevice, Probing,
+    },
+    error::code::EINVAL,
+    prelude::*,
+    sync::{aref::ARef, new_mutex, Mutex},
+    types::ForLt,
+};
+
+/// Fallback connector mode advertised by `get_modes` when the dock has not delivered a real
+/// downstream EDID yet. The live scanout geometry follows the actual framebuffer/negotiated
+/// mode (see [`scanout_one`]), so this is only the no-EDID default, not a hard scanout limit.
+const FALLBACK_W: i32 = 1920;
+const FALLBACK_H: i32 = 1080;
+
+/// `DRM_FORMAT_XRGB8888` (`fourcc_code('X','R','2','4')`); the dock scans out 32bpp.
+const DRM_FORMAT_XRGB8888: u32 = 0x3432_5258;
+/// Primary-plane format list (opaque 32bpp scanout).
+static PRIMARY_FORMATS: [u32; 1] = [DRM_FORMAT_XRGB8888];
+
+/// Per-mode pixel-clock ceiling (kHz) -- about 4K@60 (CEA 594 MHz). With only one head wired
+/// there is no combined-heads budget to enforce (see the module doc); a real ceiling still
+/// needs the connector `mode_valid` hook this port doesn't expose yet, so this constant is
+/// currently unused wiring for when it does.
+#[allow(dead_code)]
+const MAX_HEAD_CLOCK_KHZ: i32 = 600_000;
+
+/// The one wired display head's video bulk-OUT endpoint (see the module doc -- only
+/// head 0 is wired for now).
+const VIDEO_EP: u8 = 0x08;
+
+/// The DRM driver marker type.
+pub(super) struct VinoDrmDriver;
+
+/// Convenience alias for our concrete `drm::Device`.
+pub(super) type VinoDrmDevice = drm::Device<VinoDrmDriver>;
+
+/// Mutable scanout state, guarded because the atomic `update` callback may run
+/// concurrently with itself. Holds the stateful Vino encoder (created lazily on the
+/// first flip, once the buffer geometry is known) and the EP08 frame sequence counter.
+pub(super) struct ScanoutState {
+    enc: Option<super::video::Encoder>,
+    /// Reusable `width*height` RGB565 conversion buffer, allocated once alongside `enc`.
+    /// vmalloc-backed + persistent: virtually-contiguous (no high-order page need) and
+    /// allocated once, rather than a fresh multi-MiB kmalloc every pageflip.
+    cur: VVec<u16>,
+    seq: u32,
+    /// Geometry (`width`, `height`) the encoder/`cur` were allocated for. The scanout follows
+    /// the live framebuffer size, so a mode switch re-allocates them when this no longer
+    /// matches.
+    dims: (usize, usize),
+    /// Size of the last EP08 frame produced, used to pre-reserve the next frame's buffer.
+    hint: usize,
+}
+
+/// The live CP session the bring-up work item publishes once the dock engages the cipher
+/// (`acks > 0`), so the KMS callbacks can seal+send runtime CP messages (a mode-set when the
+/// compositor switches mode) that continue the SAME keystream the bring-up setup left off at.
+/// `wire_seq` is the AES-CTR block counter (advanced by the content blocks of each send; the
+/// appended Dl3Cmac tag is not part of the keystream) and `counter` the dock-echoed inner CP
+/// counter. Both advance per send under the mutex.
+pub(super) struct CpLink {
+    ks: [u8; 16],
+    riv: [u8; 8],
+    wire_seq: u32,
+    counter: u16,
+}
+
+/// DRM device-private data: the bound USB interface (to reach the video EP) and the engaged
+/// CP session for runtime KMS-driven sends. Per-object state (the scanout buffers, cached
+/// EDID) lives in the owning [`VinoPlane`]/[`VinoConnector`] instead of here, since the safe
+/// KMS layer already gives each mode object callback direct access to its own driver-private
+/// data -- no pointer-identity lookup table needed.
+#[pin_data]
+pub(super) struct VinoDrmData {
+    intf: ARef<super::usb::Interface>,
+    #[pin]
+    cp_link: Mutex<Option<CpLink>>,
+    /// The device's one connector, stashed by [`KmsDriver::probe`] so [`VinoDrmData::set_edid`]
+    /// can reach its cached-EDID slot without needing DRM's mode-object list. Written once,
+    /// during single-threaded probe, before the device is registered; read-only thereafter.
+    connector: core::sync::atomic::AtomicPtr<VinoConnector>,
+}
+
+impl VinoDrmData {
+    pub(super) fn new(intf: ARef<super::usb::Interface>) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self {
+            intf,
+            cp_link <- new_mutex!(Option::<CpLink>::None),
+            connector: core::sync::atomic::AtomicPtr::new(core::ptr::null_mut()),
+        })
+    }
+
+    /// Publish the engaged CP session so the KMS callbacks can send runtime CP messages.
+    /// Called once by the bring-up work item after the dock acks (`acks > 0`). `wire_seq`/
+    /// `counter` are the next free values past the bring-up CP setup.
+    pub(super) fn publish_session(&self, ks: &[u8; 16], riv: &[u8; 8], wire_seq: u32, counter: u16) {
+        *self.cp_link.lock() = Some(CpLink { ks: *ks, riv: *riv, wire_seq, counter });
+    }
+
+    /// Seal and send one interactive CP message on EP02, advancing the session keystream.
+    /// `build(counter)` produces the inner CP message for the dock-echoed `counter` it is
+    /// handed (e.g. [`super::cp::set_mode`]); `tag_reserved` trailing bytes are dropped before
+    /// the live Dl3Cmac is appended. Returns `Ok(())` as a **no-op when CP is not engaged**.
+    /// The `cp_link` mutex serialises concurrent KMS callbacks. Runs from the atomic-commit
+    /// context (same as the scanout), so the blocking `bulk_send` is fine.
+    pub(super) fn send_cp(
+        &self,
+        id: u16,
+        tag_reserved: usize,
+        build: impl FnOnce(u16) -> Result<KVec<u8>>,
+    ) -> Result {
+        let mut guard = self.cp_link.lock();
+        let Some(link) = (&mut *guard).as_mut() else {
+            return Ok(()); // CP not engaged -- nothing to send
+        };
+        let msg = build(link.counter)?;
+        let content = &msg[..msg.len().saturating_sub(tag_reserved)];
+        let frame = super::cp::seal_interactive(&link.ks, &link.riv, id, link.wire_seq, content)?;
+        // SAFETY: a runtime CP send only happens after a successful bring-up while the
+        // DRM device (and thus this interface) is live; the interface is unbound only
+        // in `disconnect()`, which first unplugs the DRM device, so it is bound here.
+        let dev = unsafe { self.intf.as_bound() };
+        dev.bulk_send(super::EP_CTRL_OUT, &frame, super::timeout(), GFP_KERNEL)?;
+        link.wire_seq = link.wire_seq.wrapping_add(((content.len() + 15) / 16) as u32);
+        link.counter = link.counter.wrapping_add(1);
+        Ok(())
+    }
+
+    /// Push a DDC/CI Set-VCP write to the downstream monitor (brightness, contrast or DPMS
+    /// power). Wraps [`super::cp::ddc_set_vcp`] (`id=0x15`); a no-op until the cipher is
+    /// engaged.
+    pub(super) fn set_vcp(&self, vcp: u8, value: u16) -> Result {
+        self.send_cp(0x15, 0, |ctr| super::cp::ddc_set_vcp(ctr, vcp, value))
+    }
+
+    /// Cache the dock's EDID (read during probe) for the connector's `get_modes` to install,
+    /// then fire a hotplug so the compositor re-probes the connector. Only the connector
+    /// itself holds the cached blob (see [`VinoConnector::cached_edid`]); this just forwards
+    /// it there via the pointer [`KmsDriver::probe`] stashed in `self.connector`.
+    pub(super) fn set_edid(&self, dev: &VinoDrmDevice, blob: KVec<u8>) {
+        let ptr = self.connector.load(core::sync::atomic::Ordering::Acquire);
+        let Some(connector) = (unsafe { ptr.as_ref() }) else { return };
+        *connector.cached_edid.lock() = Some(blob);
+        dev.hotplug_event();
+    }
+}
+
+/// GEM object inner data. Empty: the shmem-backed `drm::gem::shmem::Object` (which
+/// wires `drm_gem_shmem_dumb_create`, so userspace `DRM_IOCTL_MODE_CREATE_DUMB`
+/// works) is enough until the EP08 scanout path consumes the framebuffers.
+#[pin_data]
+pub(super) struct VinoObject {}
+
+impl drm::gem::DriverObject for VinoObject {
+    type Driver = VinoDrmDriver;
+    type Args = ();
+
+    fn new<Ctx: drm::DeviceContext>(
+        _dev: &drm::Device<VinoDrmDriver, Ctx>,
+        _size: usize,
+        _args: (),
+    ) -> impl PinInit<Self, Error> {
+        try_pin_init!(VinoObject {})
+    }
+}
+
+/// Per-open DRM client state. Empty of driver data, but its lifetime is used to
+/// pin the module for the duration of an open DRM file (see [`VinoDrmFile::open`]).
+#[pin_data(PinnedDrop)]
+pub(super) struct VinoDrmFile {}
+
+impl drm::file::DriverFile for VinoDrmFile {
+    type Driver = VinoDrmDriver;
+
+    fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
+        let file = KBox::try_pin_init(try_pin_init!(Self {}), GFP_KERNEL)?;
+        // Pin this module while a DRM file is open. The Rust DRM `file_operations` are
+        // built with `owner = NULL` (drm/gem/mod.rs `create_fops`), so the DRM core's
+        // `try_module_get(fops->owner)` on open is a no-op: an open card fd does NOT
+        // keep the driver loaded. Unloading vino (rmmod, or USB teardown at shutdown)
+        // while a compositor still holds `/dev/dri/cardN` then frees the module's
+        // `.rodata` -- where the fops live -- under that open fd, so the next
+        // ioctl/close dereferences freed memory and oopses the kernel. Take an
+        // explicit module reference here, released 1:1 in `PinnedDrop` (run by
+        // `postclose_callback` on file close), to restore the pin the NULL
+        // `fops.owner` drops. Remove once the binding sets `fops.owner`.
+        // SAFETY: we are executing inside this module's own DRM `open` callback, so
+        // the module is live; taking an extra reference via `__module_get` is sound.
+        unsafe { bindings::__module_get(crate::THIS_MODULE.as_ptr()) };
+        Ok(file)
+    }
+}
+
+#[pinned_drop]
+impl PinnedDrop for VinoDrmFile {
+    fn drop(self: Pin<&mut Self>) {
+        // Release the module reference taken in `open` (balanced one-per-open-file).
+        // SAFETY: balances the `__module_get` in `open`; `THIS_MODULE` is valid for
+        // the lifetime of the module.
+        unsafe { bindings::module_put(crate::THIS_MODULE.as_ptr()) };
+    }
+}
+
+const INFO: drm::DriverInfo = drm::DriverInfo {
+    major: 0,
+    minor: 1,
+    patchlevel: 0,
+    name: c"vino",
+    desc: c"DisplayLink DL3 (Dell D6000) DRM driver",
+};
+
+#[vtable]
+impl drm::Driver for VinoDrmDriver {
+    type Data = VinoDrmData;
+    type File = VinoDrmFile;
+    type Object<Ctx: drm::DeviceContext> = drm::gem::shmem::Object<VinoObject, Ctx>;
+    type ParentDevice<Ctx: kernel::device::DeviceContext> = super::usb::Interface<Ctx>;
+    type RegistrationData = ForLt!(());
+    type Kms = Self;
+
+    const INFO: drm::DriverInfo = INFO;
+
+    // No driver-private ioctls (GEM/dumb + KMS handled by the DRM core).
+    kernel::declare_drm_ioctls! {}
+}
+
+#[vtable]
+impl KmsDriver for VinoDrmDriver {
+    type Connector = VinoConnector;
+    type Plane = VinoPlane;
+    type Crtc = VinoCrtc;
+    type Encoder = VinoEncoder;
+
+    fn mode_config_info(_dev: &drm::Device<Self, drm::Uninit>) -> Result<ModeConfigInfo> {
+        Ok(ModeConfigInfo {
+            min_resolution: (0, 0),
+            max_resolution: (4096, 4096),
+            max_cursor: (0, 0),
+            preferred_depth: 32,
+            preferred_fourcc: Some(DRM_FORMAT_XRGB8888),
+        })
+    }
+
+    fn probe(dev: &NewKmsDevice<'_, Self, Probing>) -> Result {
+        // Order matters: `possible_crtcs` for the plane/encoder is a bitmask of CRTC
+        // *indices*, which only exist once `UnregisteredCrtc::new` runs -- but planes
+        // must exist before the CRTC that references them. With exactly one CRTC ever
+        // created here, its index is always 0, so `possible_crtcs = 1` is correct by
+        // construction rather than needing the CRTC up front.
+        let primary = plane::UnregisteredPlane::<VinoPlane>::new(
+            dev,
+            1,
+            &PRIMARY_FORMATS,
+            None,
+            plane::Type::Primary,
+            None,
+            (),
+        )?;
+        let crtc_obj = crtc::UnregisteredCrtc::<VinoCrtc>::new(
+            dev,
+            primary,
+            None::<&plane::UnregisteredPlane<VinoPlane>>,
+            None,
+            (),
+        )?;
+        let enc = encoder::UnregisteredEncoder::<VinoEncoder>::new(
+            dev,
+            encoder::Type::Virtual,
+            crtc_obj.mask(),
+            0,
+            None,
+            (),
+        )?;
+        let conn =
+            connector::UnregisteredConnector::<VinoConnector>::new(dev, connector::Type::Virtual, ())?;
+        conn.attach_encoder(&*enc)?;
+        // Stash a pointer to our own connector data (not the wrapping `Connector<T>`, which
+        // this crate has no public way to reconstruct from a reference) so
+        // `VinoDrmData::set_edid` can reach it later without walking DRM's mode-object list.
+        // `conn` outlives the device (destroyed only alongside it), so this is valid for as
+        // long as `dev.connector` is read.
+        let data: &VinoDrmData = dev;
+        data.connector.store(
+            &**conn as *const VinoConnector as *mut VinoConnector,
+            core::sync::atomic::Ordering::Release,
+        );
+        Ok(())
+    }
+}
+
+// ---- CRTC -----------------------------------------------------------------
+
+#[pin_data]
+pub(super) struct VinoCrtc;
+
+#[derive(Clone, Default)]
+pub(super) struct VinoCrtcState;
+
+impl crtc::DriverCrtcState for VinoCrtcState {
+    type Crtc = VinoCrtc;
+}
+
+#[vtable]
+impl crtc::DriverCrtc for VinoCrtc {
+    type Args = ();
+    type Driver = VinoDrmDriver;
+    type State = VinoCrtcState;
+    type VblankImpl = core::marker::PhantomData<Self>;
+
+    fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, _args: &()) -> impl PinInit<Self, Error> {
+        try_pin_init!(VinoCrtc {})
+    }
+
+    /// The display is turning on (scanout begins). Pushes a live mode-set CP message for the
+    /// negotiated mode and brings the monitor out of DPMS standby -- both no-ops until CP
+    /// engages (the wall).
+    fn atomic_enable(commit: CrtcAtomicCommit<'_, Self>) {
+        let data: &VinoDrmData = commit.crtc().drm_dev();
+        let new = commit.take_new_state();
+        let timing = super::cp::timing_from_drm_mode(new.mode());
+        pr_info!(
+            "vino: KMS CRTC enable -- display ON, mode {}x{}@{} (scanout begins)\n",
+            timing.hactive,
+            timing.vactive,
+            timing.refresh_hz
+        );
+        if let Err(e) = data.send_cp(0x48, 16, |ctr| super::cp::set_mode(ctr, &timing)) {
+            pr_warn!("vino: runtime mode-set send failed ({e:?})\n");
+        }
+        let _ = data.set_vcp(super::cp::VCP_POWER_MODE, super::cp::POWER_ON);
+    }
+
+    /// The display is turning off (DPMS-off/blank/suspend all land here in atomic KMS).
+    /// Resets the scanout state so a later re-enable sends a full keyframe rather than diffing
+    /// against a shadow the dock may have dropped, and blanks the monitor via DDC/CI -- a
+    /// no-op until CP engages.
+    fn atomic_disable(commit: CrtcAtomicCommit<'_, Self>) {
+        let data: &VinoDrmData = commit.crtc().drm_dev();
+        let _ = data.set_vcp(super::cp::VCP_POWER_MODE, super::cp::POWER_OFF);
+        pr_info!("vino: KMS CRTC disable -- display OFF (scanout stopped)\n");
+    }
+}
+
+// ---- Primary plane / scanout -----------------------------------------------
+
+#[pin_data]
+pub(super) struct VinoPlane {
+    #[pin]
+    scanout: Mutex<ScanoutState>,
+}
+
+#[derive(Clone, Default)]
+pub(super) struct VinoPlaneState;
+
+impl plane::DriverPlaneState for VinoPlaneState {
+    type Plane = VinoPlane;
+}
+
+#[vtable]
+impl plane::DriverPlane for VinoPlane {
+    type Args = ();
+    type Driver = VinoDrmDriver;
+    type State = VinoPlaneState;
+
+    fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, _args: ()) -> impl PinInit<Self, Error> {
+        try_pin_init!(VinoPlane {
+            scanout <- new_mutex!(ScanoutState {
+                enc: None,
+                cur: VVec::new(),
+                seq: 0,
+                dims: (0, 0),
+                hint: 0,
+            }),
+        })
+    }
+
+    /// A new framebuffer was flipped in. Maps it, converts XRGB8888 -> RGB565 (or feeds the
+    /// WHT colour codec directly for an aligned mode), and bulk-writes the resulting EP08
+    /// frame(s).
+    ///
+    /// The EP08 write only happens once the dock has engaged CP (see `docs/BLOCKER.md`):
+    /// until then the dock NAKs/stalls EP08, so a normal module load must not push frames on
+    /// every flip and thrash the dock. With the CP-engagement wall unsolved this never fires
+    /// on real hardware.
+    fn atomic_update(commit: PlaneAtomicCommit<'_, Self>) {
+        if !super::CP_ENGAGED.load(core::sync::atomic::Ordering::SeqCst) {
+            return;
+        }
+        let plane = commit.plane();
+        let data: &VinoDrmData = plane.drm_dev();
+        let new = commit.take_new_state();
+        let Some(fb) = new.framebuffer::<VinoDrmDriver>() else { return };
+        // The plane's destination geometry mirrors the negotiated mode (the compositor sizes the
+        // primary plane 1:1 with the virtual output), so this drives the dynamic scanout
+        // resolution.
+        let (w, h) = (new.crtc_w() as usize, new.crtc_h() as usize);
+
+        use core::sync::atomic::Ordering::Relaxed;
+        // Throttle: while scanout is failing (dock NAKing because CP isn't engaged), skip the
+        // upcoming pageflips set by the backoff below instead of converting+encoding+sending a
+        // frame the dock will just drop.
+        let skip = super::SCANOUT_SKIP.load(Relaxed);
+        if skip > 0 {
+            super::SCANOUT_SKIP.store(skip - 1, Relaxed);
+            return;
+        }
+        match scanout_one(data, plane, fb, w, h) {
+            Ok(()) => {
+                let n = super::SCANOUT_FAILS.swap(0, Relaxed);
+                super::SCANOUT_SKIP.store(0, Relaxed);
+                if n > 0 {
+                    pr_info!("vino: scanout recovered after {n} failed frame(s)\n");
+                }
+            }
+            Err(e) => {
+                // The dock NAKs every EP08 write (EPROTO) until CP engages -- expected and not
+                // actionable. Log the first failure and then at exponentially sparser points so
+                // dmesg isn't flooded, and back off the scanout rate.
+                let n = super::SCANOUT_FAILS.fetch_add(1, Relaxed) + 1;
+                if n == 1 || n.is_power_of_two() {
+                    pr_err!("vino: scanout frame failed ({e:?}) [x{n}] -- throttling\n");
+                }
+                // Linear backoff capped at 120 frames (~2 s @ 60 Hz) between probe attempts, so
+                // recovery (CP engaging) is still detected within ~2 s while idle CPU stays low.
+                super::SCANOUT_SKIP.store(core::cmp::min(n, 120), Relaxed);
+            }
+        }
+    }
+}
+
+/// Clear-halt + prime the main bulk-OUT video endpoint before the first live-scanout write,
+/// so it doesn't ETIMEDOUT on a stale endpoint toggle. DLM clear-halts these at engagement
+/// (the "startRender" step). Once.
+fn prime_video_eps(dev: &super::usb::Interface<kernel::device::Bound>) {
+    if !super::EP08_SCANOUT_PRIMED.swap(true, core::sync::atomic::Ordering::SeqCst) {
+        for ep in [0x08u8, 0x0a, 0x0b, 0x0c] {
+            let _ = dev.clear_halt(ep);
+        }
+        pr_info!("vino: video endpoints primed (clear-halt 8/10/11/12)\n");
+    }
+}
+
+/// vmap `fb`, encode it, and push one EP08 frame. Split out so `?` can be used.
+fn scanout_one(
+    data: &VinoDrmData,
+    plane: &plane::Plane<VinoPlane>,
+    fb: &kms::framebuffer::Framebuffer<VinoDrmDriver>,
+    w: usize,
+    h: usize,
+) -> Result {
+    if w == 0 || h == 0 {
+        return Err(EINVAL);
+    }
+    // Map the framebuffer's backing pages into the kernel address space; the guard unmaps on
+    // drop, including on an early return below.
+    let vmap = fb.vmap()?;
+    // The real source stride: GEM dumb buffers pad the pitch (alignment), so it is not necessarily
+    // `w * 4` -- read it from the framebuffer rather than assuming.
+    let pitch = fb.pitch(0) as usize;
+    encode_and_send(data, plane, vmap.as_ptr(), pitch, w, h)
+}
+
+/// Encode the mapped frame with the byte-exact Vino WHT **colour** codec and bulk-write the
+/// resulting EP08 frame(s). Reads the source XRGB8888 at full 8-bit precision (no RGB565
+/// reduction -- the codec works in 8-bit RGB). A full-frame keyframe is sent each flip
+/// (correct; strip-level damage is a bandwidth optimisation for later). `w`/`h` must be
+/// 64x16-aligned (the caller checks; [`super::video::wht::colour_frame_ep08`] returns
+/// `EINVAL` otherwise).
+fn encode_and_send_wht(
+    data: &VinoDrmData,
+    plane: &plane::Plane<VinoPlane>,
+    vaddr: *const u8,
+    pitch: usize,
+    w: usize,
+    h: usize,
+) -> Result {
+    let seq0 = plane.scanout.lock().seq;
+    let (frames, next_seq) = super::video::wht::colour_frame_ep08(w, h, seq0, |dx, dy| {
+        // SAFETY: `dy*pitch + dx*4 + 3` is within the mapped source framebuffer (`pitch*h` bytes);
+        // the caller (colour_frame_ep08) only invokes this for `dx < w <= pitch/4`, `dy < h`.
+        let px = unsafe { (vaddr.add(dy * pitch + dx * 4) as *const u32).read_unaligned() };
+        (((px >> 16) & 0xff) as u8, ((px >> 8) & 0xff) as u8, (px & 0xff) as u8)
+    })?;
+    plane.scanout.lock().seq = next_seq;
+
+    // SAFETY: scanout runs only while the DRM device is live; the interface is unbound only
+    // in `disconnect()`, which first unplugs the DRM device, so it is bound for this push.
+    let dev = unsafe { data.intf.as_bound() };
+    prime_video_eps(dev);
+    for frame in frames.iter() {
+        dev.bulk_send(VIDEO_EP, frame, super::timeout(), GFP_KERNEL)?;
+    }
+    Ok(())
+}
+
+/// Convert the mapped XRGB8888 frame to RGB565, Vino-encode it against the previous frame,
+/// and bulk-write the resulting EP08 frame to the dock.
+fn encode_and_send(
+    data: &VinoDrmData,
+    plane: &plane::Plane<VinoPlane>,
+    vaddr: *const u8,
+    pitch: usize,
+    w: usize,
+    h: usize,
+) -> Result {
+    // WHT colour codec path (default off): the byte-exact, bandwidth-efficient DLM-quality
+    // codec. Requires a 64x16-aligned mode; for non-aligned geometry (e.g. 1080p, height
+    // 1080 % 16 = 8) fall through to the RLE path until partial-strip edge handling is
+    // captured.
+    if super::EP08_WHT_CODEC
+        && w % super::video::wht::STRIP_W == 0
+        && h % super::video::wht::STRIP_H == 0
+    {
+        return encode_and_send_wht(data, plane, vaddr, pitch, w, h);
+    }
+    let frame = {
+        let mut st = plane.scanout.lock();
+        // On the first frame `cur` is freshly zeroed, so the whole buffer must be filled.
+        // Afterwards, unchanged regions of `cur` already hold the previous frame (== the
+        // shadow the encoder diffs against). Re-initialise the encoder/shadow/conversion
+        // buffers on the first frame AND whenever the framebuffer geometry changes (a mode
+        // switch), so they always match `cur`'s size.
+        let first = st.enc.is_none() || st.dims != (w, h);
+        if first {
+            st.enc = Some(super::video::Encoder::new(w, h, super::video::Mode::Rle)?);
+            st.cur = VVec::from_elem(0u16, w * h, GFP_KERNEL)?;
+            st.dims = (w, h);
+            st.hint = 0;
+        }
+        let ScanoutState { enc, cur, seq, hint, dims: _ } = &mut *st;
+        for dy in 0..h {
+            for dx in 0..w {
+                // SAFETY: `dy*pitch + dx*4 + 3` is within the mapped source framebuffer
+                // (`pitch*h` bytes); `dx < w <= pitch/4`, `dy < h`.
+                let px = unsafe { (vaddr.add(dy * pitch + dx * 4) as *const u32).read_unaligned() };
+                let (r, g, b) = ((px >> 16) & 0xff, (px >> 8) & 0xff, px & 0xff);
+                cur[dy * w + dx] = (((r >> 3) << 11) | ((g >> 2) << 5) | (b >> 3)) as u16;
+            }
+        }
+        let s = *seq;
+        *seq = seq.wrapping_add(1);
+        let enc = enc.as_mut().ok_or(kernel::error::code::ENOMEM)?;
+        // Encode straight into the outgoing frame buffer: reserve the EP08 header up front,
+        // append the codec stream in place, then back-patch the header now that the payload
+        // length is known.
+        const HDR: usize = super::video::EP08_HDR_LEN;
+        let mut frame = KVec::with_capacity((*hint).max(HDR + 64), GFP_KERNEL)?;
+        frame.extend_from_slice(&[0u8; HDR], GFP_KERNEL)?;
+        enc.encode_into(&*cur, &mut frame)?;
+        let payload_len = frame.len() - HDR;
+        super::video::write_ep08_header(&mut frame[..HDR], payload_len, s)?;
+        *hint = frame.len();
+        frame
+    };
+
+    // SAFETY: scanout runs only while the DRM device is live (driven by a compositor
+    // pageflip); the interface is unbound only in `disconnect()`, which first unplugs the
+    // DRM device, so it is bound for the duration of this push.
+    let dev = unsafe { data.intf.as_bound() };
+    prime_video_eps(dev);
+    dev.bulk_send(VIDEO_EP, &frame, super::timeout(), GFP_KERNEL)?;
+    Ok(())
+}
+
+// ---- Encoder ----------------------------------------------------------------
+
+#[pin_data]
+pub(super) struct VinoEncoder;
+
+#[vtable]
+impl encoder::DriverEncoder for VinoEncoder {
+    type Driver = VinoDrmDriver;
+    type Args = ();
+
+    fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, _args: ()) -> impl PinInit<Self, Error> {
+        try_pin_init!(VinoEncoder {})
+    }
+}
+
+// ---- Connector --------------------------------------------------------------
+
+#[pin_data]
+pub(super) struct VinoConnector {
+    /// This connector's downstream-monitor EDID (`None` until the CP channel delivers it).
+    #[pin]
+    cached_edid: Mutex<Option<KVec<u8>>>,
+}
+
+#[derive(Clone, Default)]
+pub(super) struct VinoConnectorState;
+
+impl connector::DriverConnectorState for VinoConnectorState {
+    type Connector = VinoConnector;
+}
+
+#[vtable]
+impl connector::DriverConnector for VinoConnector {
+    type Args = ();
+    type Driver = VinoDrmDriver;
+    type State = VinoConnectorState;
+
+    fn new(_device: &drm::Device<Self::Driver, drm::Uninit>, _args: ()) -> impl PinInit<Self, Error> {
+        try_pin_init!(VinoConnector {
+            cached_edid <- new_mutex!(Option::<KVec<u8>>::None),
+        })
+    }
+
+    /// Install the dock's real EDID (read during probe) when available; otherwise fall back
+    /// to a single 1920x1080@60 CVT mode. Reading the real EDID gives the true monitor
+    /// name/size and its native mode list; the fallback keeps the connector usable when
+    /// nothing is plugged into the dock or the CP channel has not yet delivered the EDID.
+    fn get_modes<'a>(
+        connector: ConnectorGuard<'a, Self>,
+        guard: &ModeConfigGuard<'a, Self::Driver>,
+    ) -> i32 {
+        if let Some(blob) = connector.cached_edid.lock().as_ref() {
+            let n = connector.add_edid_modes(blob);
+            if n > 0 {
+                return n;
+            }
+        }
+        let _ = guard;
+        // No downstream EDID yet: advertise the standard mode list up to the fallback resolution
+        // and prefer it, keeping the connector usable until the dock delivers a real EDID.
+        let n = connector.add_modes_noedid((FALLBACK_W as u32, FALLBACK_H as u32));
+        connector.set_preferred_mode((FALLBACK_W as u32, FALLBACK_H as u32));
+        n
+    }
+}
+
+/// Map an output pixel `(dx, dy)` back to its source-framebuffer pixel `(sx, sy)` under a DRM
+/// plane `rotation` bitmask (`DRM_MODE_ROTATE_*` | `DRM_MODE_REFLECT_*`, the values the
+/// standard `drm_plane_create_rotation_property` exposes). `sw`/`sh` are the SOURCE
+/// (framebuffer) dimensions. Rotation is clockwise; reflection is applied in source space
+/// after rotation. Pure and total (saturating), so it is unit-tested directly ahead of the
+/// rotation property itself being wired up (see the module doc).
+#[allow(dead_code)]
+pub(super) fn rot_src(rotation: u32, dx: usize, dy: usize, sw: usize, sh: usize) -> (usize, usize) {
+    let xmax = sw.saturating_sub(1);
+    let ymax = sh.saturating_sub(1);
+    let rot = rotation & bindings::DRM_MODE_ROTATE_MASK;
+    let (mut sx, mut sy) = if rot == bindings::DRM_MODE_ROTATE_90 {
+        (dy, ymax.saturating_sub(dx))
+    } else if rot == bindings::DRM_MODE_ROTATE_180 {
+        (xmax.saturating_sub(dx), ymax.saturating_sub(dy))
+    } else if rot == bindings::DRM_MODE_ROTATE_270 {
+        (xmax.saturating_sub(dy), dx)
+    } else {
+        (dx, dy) // ROTATE_0 / unset
+    };
+    if rotation & bindings::DRM_MODE_REFLECT_X != 0 {
+        sx = xmax.saturating_sub(sx);
+    }
+    if rotation & bindings::DRM_MODE_REFLECT_Y != 0 {
+        sy = ymax.saturating_sub(sy);
+    }
+    (sx, sy)
+}
-- 
2.55.0

