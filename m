Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E9C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 16:36:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59E8810ED4F;
	Wed, 26 Aug 2026 16:36:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fireburn-co-uk.20251104.gappssmtp.com header.i=@fireburn-co-uk.20251104.gappssmtp.com header.b="GB4eC0E7";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B691210ED4D
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 16:36:09 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4954a9e8490so394505e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 09:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fireburn-co-uk.20251104.gappssmtp.com; s=20251104; t=1787762168; x=1788366968;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=etS7dDlMuCWd3+VoKkG/reluEY3jsEXWbjkOvSEBEgk=;
 b=GB4eC0E7dwJwaJh3efv9W+qkLOlHRtjDkAFDh0RulKK1myoIndOpBldOFmwNU1NOni
 rxkLnUY0yHvxxosM3vbT9cTZJrZDQuH4+v2w3ZXf2kdJMz7vf+94ugckxDip1L8S759G
 jaGwRsIUCZJMwEuwsY7QoZy/FAnP/j98IYK8LUP874t3mIGFxDvrqybDnHq0/nsFXxDT
 ISKrHepMjPRWVrDcgPTNKLGMT8VNNI4FRi8m78kw0jpf14o+fKpmpIJ5Pcp9uEngtIAm
 BK8JeoB+6Hoeh1tCrYdY0a05tDGn7A3YnJvW8Gnbi1uHv1oMN/Ck58Zl2AieM2swpi+J
 FhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787762168; x=1788366968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=etS7dDlMuCWd3+VoKkG/reluEY3jsEXWbjkOvSEBEgk=;
 b=c6uMg1p8JknOjdAXJfo9hyypDuN685onqN2FALYhZ/iKs/X9FGZK0Ex35ij8tJ4i8X
 EQUi6AZamoLOGYMwDX02J8kmB0FsiViJstaHWByrJQGV/QafSFjLc3dwf86nXgQVRSjz
 9t0fzTQLaxKjHSTNCZJW/BnqDNLLLp7y0QGC2T+TaHnKwKtoJ0greII2y8amI2SX4NiI
 +Zj9QyXWTrd3jM6LCQKoxGvdXpy6oFTQDazaTOp19NcvWMrrCMmoiUWFoLL9KS4oWIAs
 bfzF33NYc29piJBMB8YUCK0Zu9PQc2wR5jSY0VXHez5LQHha8aBm4bIYzk1kFqXRoasi
 BdXA==
X-Gm-Message-State: AFuF++ldOu+grZB/TU7w12JDOy9hfzbtAWuDFO/+h/txpTZkqsZBrAhk
 Y26EO/tAUF+T3MQnl6qshsxESuLVlGw/6WLTBXUuc6yXEKc1wWxNA83xTszq1GpZigZ2ctpmNoW
 ZFrd4j3oO
X-Gm-Gg: AR+sD10tTxDCJyw/FuKiJpe/EpWi1oKhgFjguA/B/tyoJbWIOvZ22B9oJSOmz2pTAgs
 sTPm7F4mToFybISNaoH7i9tInxPEu8dHBLEOhCUEI/X0t7N45F+OBPQbQ178EgkiavD+uFetgDR
 GWyle50/ZMgigURVFEyJHcMfWlTUDe/rNEi0EEygb6Nd+/1NvARXxUmHySJ3ZwiJbn+ArxdEy5q
 KFIYuiLhBrF6aT9BDO10dwUnRrvaPu+bz5mBn/zbjuNiZP7stzUKeZBhcWuHlP1R+HcvEfvjQOl
 r/FcLtAY6soDybwE4NTqarv9FyBbT3ddhTUjbHgOCdMEeJZJuuoAu1nhm+g+dBpAL898YfXWSKQ
 bGwvz9VBgfBxlyryB//Q2XyimNnoNhVQzwZhfnpgvdSsRtSs4nSbjZ//kBNQLIvL/SmE2Ew5f/d
 02hY7fUlZ+P3tPNLRuQw4TcPRzIzGhk+nNdYR2sZl3o7OGYPSmGiWgex68vCaPdeZFz5oMEsXDx
 w89tOKfBBhAG/Wc9n9fzmxUTh+puBA6ExmOhSX3HY2WRAM=
X-Received: by 2002:a05:600c:3151:b0:499:a5cb:b7c0 with SMTP id
 5b1f17b1804b1-49b0deb14d0mr4919895e9.3.1787762168128; 
 Wed, 26 Aug 2026 09:36:08 -0700 (PDT)
Received: from axion.fireburn.co.uk ([2a01:4b00:d309:1c00:caf1:6b20:8531:818c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499dca8c75csm31227535e9.2.2026.08.26.09.36.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 09:36:06 -0700 (PDT)
From: Mike Lothian <mike@fireburn.co.uk>
To: dri-devel@lists.freedesktop.org
Cc: Mike Lothian <mike@fireburn.co.uk>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Lyude Paul <lyude@redhat.com>,
 "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 Asahi Lina <lina+kernel@asahilina.net>, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3 15/23] rust: drm: pin the owner while DRM files remain open
Date: Wed, 26 Aug 2026 17:31:46 +0100
Message-ID: <20260826163359.4998-16-mike@fireburn.co.uk>
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

Give each Rust DRM device its own driver and file-operations tables
so file_operations::owner can identify the module that owns the
implementation. Open DRM file descriptors then hold the same module
reference that C DRM drivers receive through DEFINE_DRM_GEM_*_FOPS().

Pass the owning module to UnregisteredDevice::new() and use the
built-in null module for the shmem KUnit device.

Assisted-by: Claude:claude-opus-5
Signed-off-by: Mike Lothian <mike@fireburn.co.uk>
---
 rust/kernel/drm/device.rs    | 46 ++++++++++++++++++++++++++++++++++--
 rust/kernel/drm/gem/shmem.rs |  8 ++++++-
 2 files changed, 51 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index bc2cdcd2b695..efbec3f42bda 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -208,9 +208,14 @@ const fn compute_features() -> u32 {
     /// Create a new `UnregisteredDevice` for a `drm::Driver`.
     ///
     /// This can be used to create a [`Registration`](kernel::drm::Registration).
+    ///
+    /// `module` must be the module that owns the driver implementation, i.e. `&THIS_MODULE`. It is
+    /// stamped into this device's `file_operations::owner` so that an open `/dev/dri/cardN` file
+    /// descriptor pins the module, exactly as `DEFINE_DRM_GEM_*_FOPS()` does in C.
     pub fn new(
         dev: &T::ParentDevice<device::Bound>,
         data: impl PinInit<T::Data, Error>,
+        module: &'static ThisModule,
     ) -> Result<Self> {
         // `__drm_dev_alloc` uses `kmalloc()` to allocate memory, hence ensure a `kmalloc()`
         // compatible `Layout`.
@@ -253,8 +258,37 @@ pub fn new(
             unsafe { bindings::drm_dev_put(drm_dev) };
         })?;
 
-        // SAFETY: `drm_dev` is still private to this function.
-        unsafe { (*drm_dev).driver = const { &Self::VTABLE } };
+        // Give this device its own `file_operations`/`drm_driver` pair so that the owning module
+        // can be stamped into the fops. `fops->owner` is what makes `fops_get()` in
+        // `drm_stub_open()` take a module reference for every open DRM file: without it nothing
+        // pins the module, and unloading the driver while a compositor still has
+        // `/dev/dri/cardN` in a poll set frees the `file_operations` out from under
+        // `do_sys_poll()`, which then faults on `f_op->poll`.
+        //
+        // SAFETY: `raw_drm` is a valid pointer to `Self`, still private to this function, and
+        // both fields are plain data that need no drop.
+        let raw_fops = unsafe { Opaque::cast_into(ptr::addr_of!((*raw_drm.as_ptr()).fops)) };
+        // SAFETY: `raw_fops` is valid, aligned and points at uninitialized memory we own.
+        unsafe {
+            raw_fops.write(bindings::file_operations {
+                owner: module.as_ptr(),
+                ..Self::GEM_FOPS
+            })
+        };
+
+        // SAFETY: as above, for the per-device `drm_driver` copy.
+        let raw_vtable = unsafe { Opaque::cast_into(ptr::addr_of!((*raw_drm.as_ptr()).vtable)) };
+        // SAFETY: `raw_vtable` is valid, aligned and points at uninitialized memory we own.
+        unsafe {
+            raw_vtable.write(bindings::drm_driver {
+                fops: raw_fops,
+                ..Self::VTABLE
+            })
+        };
+
+        // SAFETY: `drm_dev` is still private to this function; `raw_vtable` lives inside the DRM
+        // device allocation and so outlives every use of `drm_device::driver`.
+        unsafe { (*drm_dev).driver = raw_vtable };
 
         // SAFETY: `raw_drm` is valid; no concurrent access before registration.
         unsafe { (*raw_drm.as_ptr()).registration_data = UnsafeCell::new(NonNull::dangling()) };
@@ -277,12 +311,20 @@ pub fn new(
 ///
 /// * `self.dev` is a valid instance of a `struct device`.
 /// * The data layout of `Self` remains the same across all implementations of `C`.
+/// * `self.vtable` and `self.fops` are initialized before the device is registered and are never
+///   mutated afterwards; `self.dev.driver` points at `self.vtable`, whose `fops` points at
+///   `self.fops`.
 /// * Any invariants for `C` also apply.
 #[repr(C)]
 pub struct Device<T: drm::Driver, C: DeviceContext = Normal> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
     pub(super) registration_data: UnsafeCell<NonNull<T::RegistrationData<'static>>>,
+    /// Per-device copy of the driver vtable, so that `fops` below can be referenced from it.
+    vtable: Opaque<bindings::drm_driver>,
+    /// Per-device copy of the DRM file operations, carrying the owning module in `owner` so that
+    /// an open DRM file descriptor pins the module.
+    fops: Opaque<bindings::file_operations>,
     _ctx: PhantomData<C>,
 }
 
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 86797ab39ffd..8751000c92bb 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -642,12 +642,18 @@ impl drm::Driver for KunitDriver {
         const IOCTLS: &'static [drm::ioctl::DrmIoctlDescriptor] = &[];
     }
 
+    // These tests only ever build into the kernel image, so there is no module to pin. A null
+    // `file_operations::owner` is exactly what a built-in driver uses.
+    //
+    // SAFETY: `NULL` is the correct `THIS_MODULE` for built-in code.
+    static KUNIT_MODULE: ThisModule = unsafe { ThisModule::from_ptr(ptr::null_mut()) };
+
     fn create_drm_dev() -> Result<(faux::Registration, UnregisteredDevice<KunitDriver>)> {
         // Create a faux DRM device so we can test gem object creation.
         let data = try_pin_init!(KunitData {});
         let reg = faux::Registration::new(c"Kunit", None)?;
         let fdev = reg.as_ref();
-        let drm = UnregisteredDevice::new(fdev, data)?;
+        let drm = UnregisteredDevice::new(fdev, data, &KUNIT_MODULE)?;
 
         Ok((reg, drm))
     }
