Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30DE3C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:35:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6953A10E620;
	Wed, 26 Aug 2026 16:35:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="aGckRORG";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B9B10E620
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:35:43 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so9732545e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762141; x=1788366941;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wYl7l/etGs1HUCwJvrp7fmSei6XB3oybHpPXkhZ1Ci8=;
 b=aGckRORGGbimyXnGGrGFduGj/potEqFIY+xT/dzxNajr4Q0GJ84zdUAsr488LwOwiZ
 f5WTduqvM/RFuqoyKpRO2PixyiTQZljLh+Xc1jZNWrUn3yHe6cBUrHGPh4Nx+4vQqYrL
 thhnzabReN+eNP3qxgLZnuh7e1o1yaxFeSj5W4N0arcl13Yt0XJ8Nb9R/3IMv2k1qHlq
 zgn7G6SjdyxxJPrCKNRVykaSUgmi3FI8Yu+pqyUYc5xpNM0mlrT+s4lxmLSQyJ4plg/k
 z5+zAVGr+aOIo6dQwepqjw2Q2F1LXXmTWGY+ehi1Qyr0fp87josAjMIQojosf+ZOAHFB
 jiog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762141; x=1788366941;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wYl7l/etGs1HUCwJvrp7fmSei6XB3oybHpPXkhZ1Ci8=;
 b=qfMzWHw5NP91IlOMwPOZrZW5I/ph6eNOpwaYHwAbkZwJeaC3L463Pdbk4k/0TqSS/n
 Vs3ja2er/riZEOoS/HlfLHnGiLjpzec8FB5TkQ9L9GLBWFZ9MvJXbiaL+4z7yOJvdpyL
 aO1CNf74+3A9otLwZ6eZVh0vT1wzRvcH14/LOEPTPeMrKKp7L/vXG46mjI4vtmM7U7/l
 48eeIUl8GNLeN7sIQ90FIRPqemtp/0cW63DPrKCGDGQasNezKQ5fk/eicvsdvrNnY2qQ
 GMyA4Y4quJ0NG3A3vvzo00QZS3FO+tzMdLCMPNF3YL6VDi6Ai/WHj7Hg0dRyhiCZbfYR
 FTIA==
X-Gm-Message-State: AFuF++nzOLUA34je4zHRJnQTZTMpvuhA5Zju/QGCUVQNJVtxIm1ZntlE
 oD/5RbPE+bvLveHecjppEQZLgdwTPvow7JZAhlrU7EPzJtDBq/aI4cJzHR23sixbkQqbf1OCYMX
 MINBtCqo6
X-Gm-Gg: AR+sD12IeN8v7KZqp0RGsm8II1IKIjkU8/u/kfMZYMEuYScJfhDN7YOwqHInpLbtFM7
 cDT8w4oV8vGfKQPOqYHLJr3dZNpuxY6sBbewq87qVfGAYbq8rG+fn40+Q23/UW7DmmHpEWtlP9y
 sYqvbjoF1SBwybhAwg0/IrOZ4m6TOLAjtslLkUGP6rf74qVPmaqVHN6xCwOvYFT6OAdqq8OOEH/
 uI9L0erPr/TuPobXDr/02ZiKOtzUx2Qdy/nUHNMKQrp7hm3p+pq2etn8UXQ8RmGLx8trMGVOhZV
 D0hrMJktvnELte67X08Iqf/mjO3jM1V2Xpu9m8lutYDcLmPvIUM/wsPU1LytmWrogfc4YZJ+jVQ
 RPZs5MM3/GpvfovqRb/Ikpv1U3y5Q0cIbEseN9q//n5a4YP9674gINHAzdNThp1IdV0PUJv7eOZ
 3gEGGAmZH7+iJt/VVEcDFU2etKYihhvyDHRLeVvNf1on4L1bT40X5fK8nyOZcuQDfXJp0Nfu/Iy
 8NI2Ah4xdeTo46A7Ew7aD2Dt7AlJGeImNrM
X-Received: by 2002:a05:600c:3b03:b0:499:8704:242c with SMTP id
 5b1f17b1804b1-499dc6a37famr76052765e9.0.1787762140258; 
 Wed, 26 Aug 2026 09:35:40 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.35.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:35:37 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Lyude Paul <lyude@redhat.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3 10/23] rust: drm: framebuffer: add validated shmem scanout
 views
Date: Wed, 26 Aug 2026 17:31:41 +0100
Message-ID: <20260826163359.4998-11-mike@fireburn.co.uk>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260826163359.4998-1-mike@fireburn.co.uk>
References: <20260826163359.4998-1-mike@fireburn.co.uk>
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

Add framebuffer geometry and reference-counting operations for drivers
that retain and inspect scanout buffers outside an atomic callback.

Build borrowed and owned adapters on the existing shmem VMap
implementation. The owned form retains the GEM object so a driver
can prepare and reuse a bounded scanout pool.

Constrain both adapters to the exact Rust shmem object type. Reject
foreign-device, imported, multiplane, non-linear, block-layout,
undersized, and invalid-pitch framebuffers. Apply the framebuffer
offset to the returned SysMem view with checked size arithmetic,
and add KUnit coverage for the validation rules.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/helpers/drm/drm.c             |   1 +
 rust/helpers/drm/framebuffer.c     |  13 ++
 rust/kernel/drm/fourcc.rs          |  28 ++-
 rust/kernel/drm/kms/framebuffer.rs | 345 ++++++++++++++++++++++++++++-
 4 files changed, 382 insertions(+), 5 deletions(-)
 create mode 100644 rust/helpers/drm/framebuffer.c

diff --git a/rust/helpers/drm/drm.c b/rust/helpers/drm/drm.c
index 45890e9c3290..2144a67623bd 100644
--- a/rust/helpers/drm/drm.c
+++ b/rust/helpers/drm/drm.c
@@ -3,6 +3,7 @@
 #ifdef CONFIG_DRM
 #ifdef CONFIG_DRM_KMS_HELPER
 #include "atomic.c"
+#include "framebuffer.c"
 #include "vblank.c"
 #endif
 
diff --git a/rust/helpers/drm/framebuffer.c b/rust/helpers/drm/framebuffer.c
new file mode 100644
index 000000000000..672cee03463a
--- /dev/null
+++ b/rust/helpers/drm/framebuffer.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <drm/drm_framebuffer.h>
+
+__rust_helper void rust_helper_drm_framebuffer_get(struct drm_framebuffer *fb)
+{
+	drm_framebuffer_get(fb);
+}
+
+__rust_helper void rust_helper_drm_framebuffer_put(struct drm_framebuffer *fb)
+{
+	drm_framebuffer_put(fb);
+}
diff --git a/rust/kernel/drm/fourcc.rs b/rust/kernel/drm/fourcc.rs
index a30e40dbc037..010823c4c86c 100644
--- a/rust/kernel/drm/fourcc.rs
+++ b/rust/kernel/drm/fourcc.rs
@@ -12,9 +12,29 @@ const fn fourcc_code(a: u8, b: u8, c: u8, d: u8) -> u32 {
 // TODO: We manually import this because we don't have a reasonable way of getting constants from
 // function-like macros in bindgen yet.
 pub(crate) const FORMAT_MOD_INVALID: u64 = 0xffffffffffffff;
+/// Linear framebuffer layout (`DRM_FORMAT_MOD_LINEAR`).
+pub(crate) const FORMAT_MOD_LINEAR: u64 = 0;
 
-// TODO: We need to automate importing all of these. For the time being, just add the single one
-// that we need
+/// 32 bpp RGB with unused alpha.
+pub const XRGB8888: u32 = fourcc_code(b'X', b'R', b'2', b'4');
 
-/// 32 bpp RGB
-pub const XRGB888: u32 = fourcc_code(b'X', b'R', b'2', b'4');
+/// 32 bpp RGB with alpha.
+pub const ARGB8888: u32 = fourcc_code(b'A', b'R', b'2', b'4');
+
+/// 32 bpp BGR with unused alpha.
+pub const XBGR8888: u32 = fourcc_code(b'X', b'B', b'2', b'4');
+
+/// 32 bpp BGR with alpha.
+pub const ABGR8888: u32 = fourcc_code(b'A', b'B', b'2', b'4');
+
+/// 30 bpp 10:10:10 RGB with unused alpha.
+pub const XRGB2101010: u32 = fourcc_code(b'X', b'R', b'3', b'0');
+
+/// 30 bpp 10:10:10 RGB with alpha.
+pub const ARGB2101010: u32 = fourcc_code(b'A', b'R', b'3', b'0');
+
+/// 30 bpp 10:10:10 BGR with unused alpha.
+pub const XBGR2101010: u32 = fourcc_code(b'X', b'B', b'3', b'0');
+
+/// 30 bpp 10:10:10 BGR with alpha.
+pub const ABGR2101010: u32 = fourcc_code(b'A', b'B', b'3', b'0');
diff --git a/rust/kernel/drm/kms/framebuffer.rs b/rust/kernel/drm/kms/framebuffer.rs
index 54d0391388a9..02e9e63cff30 100644
--- a/rust/kernel/drm/kms/framebuffer.rs
+++ b/rust/kernel/drm/kms/framebuffer.rs
@@ -5,8 +5,20 @@
 //! C header: [`include/drm/drm_framebuffer.h`](srctree/include/drm/drm_framebuffer.h)
 
 use super::{KmsDriver, ModeObject, Sealed};
-use crate::{drm::device::Device, types::*};
+use crate::{
+    drm::device::Device,
+    prelude::*,
+    sync::aref::{ARef, AlwaysRefCounted},
+    types::*,
+};
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+use crate::{
+    drm::gem::{self, shmem, BaseObject},
+    io::{IoBase, SysMem},
+};
 use bindings;
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+use core::ops::Deref;
 use core::{marker::*, ptr};
 
 /// The main interface for [`struct drm_framebuffer`].
@@ -55,6 +67,145 @@ fn eq(&self, other: &Self) -> bool {
 }
 impl<T: KmsDriver> Eq for Framebuffer<T> {}
 
+// SAFETY: DRM framebuffers use the refcount in their embedded mode object. The C get/put helpers
+// operate on that refcount and release the object only after the last reference is dropped.
+unsafe impl<T: KmsDriver> AlwaysRefCounted for Framebuffer<T> {
+    fn inc_ref(&self) {
+        // SAFETY: A shared reference proves the framebuffer and its refcount are live.
+        unsafe { bindings::drm_framebuffer_get(self.0.get()) };
+    }
+
+    unsafe fn dec_ref(obj: core::ptr::NonNull<Self>) {
+        // SAFETY: The caller transfers one live framebuffer reference to this method.
+        unsafe { bindings::drm_framebuffer_put(obj.as_ref().0.get()) };
+    }
+}
+
+/// A validated packed, linear framebuffer mapping backed by Lyude's shmem [`shmem::VMap`].
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+pub struct FramebufferMapping<O, R>
+where
+    O: gem::DriverObject,
+    R: Deref<Target = shmem::Object<O>>,
+{
+    map: shmem::VMap<O, R>,
+    offset: usize,
+    len: usize,
+    pitch: usize,
+    width: u32,
+    height: u32,
+    format: u32,
+}
+
+/// A framebuffer mapping borrowed from its backing object.
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+pub type FramebufferVMap<'a, O> = FramebufferMapping<O, &'a shmem::Object<O>>;
+
+/// A framebuffer mapping which owns a reference to its backing object.
+///
+/// This is suitable for a bounded scanout-registration cache: dropping it releases the mapping and
+/// object reference, while retaining it keeps the validated CPU view stable across atomic commits.
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+pub type FramebufferVMapOwned<O> = FramebufferMapping<O, ARef<shmem::Object<O>>>;
+
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+struct PackedLayout {
+    offset: usize,
+    len: usize,
+    pitch: usize,
+}
+
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+fn packed_layout(raw: &bindings::drm_framebuffer, object_size: usize) -> Result<PackedLayout> {
+    if raw.format.is_null() {
+        return Err(EINVAL);
+    }
+
+    // SAFETY: The caller supplies a live framebuffer, whose format descriptor remains valid.
+    let format = unsafe { &*raw.format };
+    if format.num_planes != 1 || raw.modifier != crate::drm::fourcc::FORMAT_MOD_LINEAR {
+        return Err(EINVAL);
+    }
+
+    // Restrict this convenience adapter to ordinary packed scanlines. More complex block or tiled
+    // layouts need a layout-specific API instead of pretending to be a byte raster.
+    let block_width = unsafe { bindings::drm_format_info_block_width(raw.format, 0) };
+    let block_height = unsafe { bindings::drm_format_info_block_height(raw.format, 0) };
+    if block_width != 1 || block_height != 1 {
+        return Err(EINVAL);
+    }
+
+    let min_pitch =
+        usize::try_from(unsafe { bindings::drm_format_info_min_pitch(raw.format, 0, raw.width) })
+            .map_err(|_| EOVERFLOW)?;
+    let pitch = raw.pitches[0] as usize;
+    if pitch < min_pitch {
+        return Err(EINVAL);
+    }
+
+    let offset = raw.offsets[0] as usize;
+    let len = pitch.checked_mul(raw.height as usize).ok_or(EOVERFLOW)?;
+    let end = offset.checked_add(len).ok_or(EOVERFLOW)?;
+    if end > object_size {
+        return Err(EINVAL);
+    }
+
+    Ok(PackedLayout { offset, len, pitch })
+}
+
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+fn validate_object(
+    raw: &bindings::drm_framebuffer,
+    object: *mut bindings::drm_gem_object,
+) -> Result {
+    if object.is_null() {
+        return Err(EINVAL);
+    }
+    // SAFETY: The object is non-null and live while its framebuffer owns it.
+    let object = unsafe { &*object };
+    if object.dev != raw.dev || !object.import_attach.is_null() {
+        return Err(EINVAL);
+    }
+    Ok(())
+}
+
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+impl<O, R> FramebufferMapping<O, R>
+where
+    O: gem::DriverObject,
+    R: Deref<Target = shmem::Object<O>>,
+{
+    /// Return the offset-adjusted pixel storage as a system-memory I/O view.
+    pub fn view(&self) -> SysMem<'_, [u8]> {
+        let base = (&self.map).as_view().as_ptr().cast::<u8>();
+        // SAFETY: the mapping constructor checked `offset + len` against the object's size, and
+        // borrowing `self` keeps the owning VMap alive for the returned view.
+        let ptr = unsafe { core::ptr::slice_from_raw_parts_mut(base.add(self.offset), self.len) };
+        // SAFETY: The range above is mapped, kernel-accessible system memory for this borrow.
+        unsafe { SysMem::new(ptr) }
+    }
+
+    /// Return the validated line pitch in bytes.
+    pub fn pitch(&self) -> usize {
+        self.pitch
+    }
+
+    /// Return the visible width in pixels.
+    pub fn width(&self) -> u32 {
+        self.width
+    }
+
+    /// Return the visible height in pixels.
+    pub fn height(&self) -> u32 {
+        self.height
+    }
+
+    /// Return the DRM fourcc pixel format.
+    pub fn format(&self) -> u32 {
+        self.format
+    }
+}
+
 impl<T: KmsDriver> Framebuffer<T> {
     /// Convert a raw pointer to a `struct drm_framebuffer` into a [`Framebuffer`]
     ///
@@ -67,4 +218,196 @@ pub(super) unsafe fn from_raw<'a>(ptr: *const bindings::drm_framebuffer) -> &'a
         // SAFETY: Our data layout is identical to drm_framebuffer
         unsafe { &*ptr.cast() }
     }
+
+    /// Return an owned reference to this framebuffer.
+    pub fn to_aref(&self) -> ARef<Self> {
+        self.into()
+    }
+
+    /// Return the framebuffer width in pixels.
+    pub fn width(&self) -> u32 {
+        // SAFETY: The framebuffer is initialized via its type invariant.
+        unsafe { (*self.0.get()).width }
+    }
+
+    /// Return the framebuffer height in pixels.
+    pub fn height(&self) -> u32 {
+        // SAFETY: The framebuffer is initialized via its type invariant.
+        unsafe { (*self.0.get()).height }
+    }
+
+    /// Return the framebuffer's DRM fourcc pixel format.
+    pub fn format(&self) -> u32 {
+        // SAFETY: An initialized framebuffer has a valid format descriptor.
+        unsafe { (*(*self.0.get()).format).format }
+    }
+
+    /// Return the pitch for `plane`, rejecting indices outside the format's actual plane count.
+    pub fn pitch(&self, plane: usize) -> Result<u32> {
+        // SAFETY: The framebuffer is initialized via its type invariant.
+        let raw = unsafe { &*self.0.get() };
+        if raw.format.is_null() {
+            return Err(EINVAL);
+        }
+        // SAFETY: `format` is non-null and remains valid for the framebuffer's lifetime.
+        if plane >= unsafe { (*raw.format).num_planes as usize } || plane >= raw.pitches.len() {
+            return Err(EINVAL);
+        }
+        Ok(raw.pitches[plane])
+    }
+
+    /// Map a packed, single-plane, linear Rust shmem framebuffer.
+    ///
+    /// The returned view starts at the framebuffer plane's declared offset rather than the start
+    /// of the GEM object. Multi-plane, imported, non-linear, block-compressed, undersized and
+    /// cross-device objects are rejected.
+    #[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+    pub fn vmap<O>(&self) -> Result<FramebufferVMap<'_, O>>
+    where
+        O: gem::DriverObject<Driver = T>,
+        T: crate::drm::Driver<Object = shmem::Object<O>>,
+    {
+        // SAFETY: The framebuffer is initialized via its type invariant.
+        let raw = unsafe { &*self.0.get() };
+        let object_raw = raw.obj[0];
+        validate_object(raw, object_raw)?;
+
+        // SAFETY:
+        // - `T::Object` is exactly `shmem::Object<O>` by the associated-type bound above.
+        // - `validate_object` checked that this is a local, non-imported object owned by this
+        //   framebuffer's instance of `T`.
+        // - The framebuffer keeps its backing object alive for this borrow.
+        let object = unsafe { <shmem::Object<O> as gem::IntoGEMObject>::from_raw(object_raw) };
+        let layout = packed_layout(raw, object.size())?;
+
+        Ok(FramebufferMapping {
+            map: object.vmap()?,
+            offset: layout.offset,
+            len: layout.len,
+            pitch: layout.pitch,
+            width: raw.width,
+            height: raw.height,
+            // SAFETY: `packed_layout` rejected a null format pointer above.
+            format: unsafe { (*raw.format).format },
+        })
+    }
+
+    /// Returns the GEM object backing plane 0 of this framebuffer.
+    ///
+    /// A driver needs this to hand the buffer to a client, which is done by minting a handle for it
+    /// in that client's file. The same type, ownership, import and device checks as [`Self::vmap`]
+    /// apply, so the returned reference is known to belong to this driver.
+    #[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+    pub fn object<O>(&self) -> Result<&shmem::Object<O>>
+    where
+        O: gem::DriverObject<Driver = T>,
+        T: crate::drm::Driver<Object = shmem::Object<O>>,
+    {
+        // SAFETY: The framebuffer is initialized via its type invariant.
+        let raw = unsafe { &*self.0.get() };
+        let object_raw = raw.obj[0];
+        validate_object(raw, object_raw)?;
+
+        // SAFETY: `validate_object` established that `object_raw` is a live object of this
+        // driver's type, and it is owned by the framebuffer for at least this borrow.
+        Ok(unsafe { <shmem::Object<O> as gem::IntoGEMObject>::from_raw(object_raw) })
+    }
+
+    /// Map a packed, single-plane, linear Rust shmem framebuffer and retain its backing object.
+    ///
+    /// The validation is identical to [`Framebuffer::vmap`], but the returned mapping is not tied
+    /// to this framebuffer borrow. It can therefore be retained in a bounded prepared-scanout
+    /// cache and reused by later commits. The mapping itself keeps the GEM object alive.
+    #[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+    pub fn owned_vmap<O>(&self) -> Result<FramebufferVMapOwned<O>>
+    where
+        O: gem::DriverObject<Driver = T>,
+        T: crate::drm::Driver<Object = shmem::Object<O>>,
+    {
+        // SAFETY: The framebuffer is initialized via its type invariant.
+        let raw = unsafe { &*self.0.get() };
+        let object_raw = raw.obj[0];
+        validate_object(raw, object_raw)?;
+
+        // SAFETY: The same type, ownership, import, and device checks as `vmap` hold here. The
+        // returned VMap takes its own object reference before this framebuffer borrow can end.
+        let object = unsafe { <shmem::Object<O> as gem::IntoGEMObject>::from_raw(object_raw) };
+        let layout = packed_layout(raw, object.size())?;
+
+        Ok(FramebufferMapping {
+            map: object.owned_vmap()?,
+            offset: layout.offset,
+            len: layout.len,
+            pitch: layout.pitch,
+            width: raw.width,
+            height: raw.height,
+            // SAFETY: `packed_layout` rejected a null format pointer above.
+            format: unsafe { (*raw.format).format },
+        })
+    }
+}
+
+#[cfg(CONFIG_RUST_DRM_GEM_SHMEM_HELPER)]
+#[kunit_tests(rust_drm_framebuffer)]
+mod tests {
+    use super::*;
+
+    fn linear_fb(width: u32, height: u32, pitch: u32, offset: u32) -> bindings::drm_framebuffer {
+        let mut fb = bindings::drm_framebuffer::default();
+        // SAFETY: `XRGB8888` is a valid DRM fourcc and the returned descriptor has static lifetime.
+        fb.format = unsafe { bindings::drm_format_info(crate::drm::fourcc::XRGB8888) };
+        fb.modifier = crate::drm::fourcc::FORMAT_MOD_LINEAR;
+        fb.width = width;
+        fb.height = height;
+        fb.pitches[0] = pitch;
+        fb.offsets[0] = offset;
+        fb
+    }
+
+    #[test]
+    fn packed_layout_honours_nonzero_offset() -> Result {
+        let fb = linear_fb(4, 2, 16, 128);
+        let layout = packed_layout(&fb, 160)?;
+        assert_eq!(layout.offset, 128);
+        assert_eq!(layout.len, 32);
+        Ok(())
+    }
+
+    #[test]
+    fn packed_layout_rejects_too_small_object() {
+        let fb = linear_fb(4, 2, 16, 128);
+        assert!(packed_layout(&fb, 159).is_err());
+    }
+
+    #[test]
+    fn packed_layout_rejects_multiple_planes() {
+        let mut fb = linear_fb(4, 2, 16, 0);
+        // SAFETY: `linear_fb` stored a non-null static format descriptor.
+        let mut format = unsafe { *fb.format };
+        format.num_planes = 2;
+        fb.format = &raw const format;
+        assert!(packed_layout(&fb, 32).is_err());
+    }
+
+    #[test]
+    fn imported_object_is_rejected() {
+        let mut fb = linear_fb(4, 2, 16, 0);
+        let dev = ptr::NonNull::<bindings::drm_device>::dangling().as_ptr();
+        fb.dev = dev;
+        let mut object = bindings::drm_gem_object::default();
+        object.dev = dev;
+        object.import_attach = ptr::NonNull::<bindings::dma_buf_attachment>::dangling().as_ptr();
+        assert!(validate_object(&fb, &raw mut object).is_err());
+    }
+
+    #[test]
+    fn cross_device_object_is_rejected() {
+        let mut first = core::mem::MaybeUninit::<bindings::drm_device>::uninit();
+        let mut second = core::mem::MaybeUninit::<bindings::drm_device>::uninit();
+        let mut fb = linear_fb(4, 2, 16, 0);
+        fb.dev = first.as_mut_ptr();
+        let mut object = bindings::drm_gem_object::default();
+        object.dev = second.as_mut_ptr();
+        assert!(validate_object(&fb, &raw mut object).is_err());
+    }
 }
