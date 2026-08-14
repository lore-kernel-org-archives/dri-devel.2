Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8522DC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:09:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D11410E595;
	Fri, 14 Aug 2026 23:09:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cGR+vdgN";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E59A210E595
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:09:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 68B2A600E2;
 Fri, 14 Aug 2026 23:09:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9983C1F000E9;
 Fri, 14 Aug 2026 23:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786748995;
 bh=W8jExBi0QxHteBboXNh2hw2w9UoJVj//coupeb7xVIA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=cGR+vdgNS0EOwbb+Iwi9zyaK9ifG/cBh7PBJotdMZo0FFHft83iOCMM3w81N65ztG
 FqkzZqbdRmpaaAT9b8PaF9mt88lEuF0Zn/SSc+W9fq1m3WcFhUZQ2rTCD8Sxqk/Ibk
 rNXKlo8WaDtCMXJ9PlghCepkyMEinZJd5YpKMNVCZWJPJDKyWc4Qnnf4dCeNYXF5nn
 G65oPMQ9GQj8wGZ1nvOyBfQsN0kwf8Ros+9VGE8egK5lpXL9s3SfcVf0puLliYb1xm
 6hlfeCT/gnLX/9WfH9apGccQtu5UxyGoxXrEETAh687GtvAa3NCU7MOsq2FeMmw1fD
 /sDy0tr7ttqFQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, acourbot@nvidia.com,
 daniel.almeida@collabora.com, ojeda@kernel.org, boqun@kernel.org,
 gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
 a.hindborg@kernel.org, tmgross@umich.edu, tamird@kernel.org,
 work@onurozkan.dev, brauner@kernel.org, lyude@redhat.com, j@jananu.net,
 alvin.sun@linux.dev, deborah.brouwer@collabora.com,
 laura.nao@collabora.com, beata.michalska@arm.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] rust: drm: wrap fops open with RegistrationGuard
Date: Sat, 15 Aug 2026 01:09:03 +0200
Message-ID: <20260814230923.1292966-6-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260814230923.1292966-1-dakr@kernel.org>
References: <20260814230923.1292966-1-dakr@kernel.org>
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

Add a Minor abstraction with RAII release and a fops_open() wrapper that
holds a RegistrationGuard (drm_dev_enter / drm_dev_exit) across the
entire drm_open() call.

This guarantees that drm_dev_unplug() in Registration::drop() waits for
the full open sequence to complete, so all files are visible in the
filelist when iterating for cleanup.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 63 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index a2940e172073..09903ed783e1 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -42,6 +42,42 @@
     },
 };
 
+/// A reference to a `struct drm_minor` with RAII release.
+struct Minor(NonNull<bindings::drm_minor>);
+
+// Methods use `#[inline(never)]` to prevent the unexported `drm_minor_acquire()` /
+// `drm_minor_release()` symbols from being inlined into driver modules.
+impl Minor {
+    /// Acquire a minor by ID. Increments the underlying device's refcount.
+    #[inline(never)]
+    fn acquire(minor_id: u32) -> Result<Self> {
+        // SAFETY: `drm_minors_xa` is a valid global xarray; any `minor_id` is safe to
+        // look up (returns ERR_PTR on failure).
+        let ptr =
+            unsafe { bindings::drm_minor_acquire(&raw mut bindings::drm_minors_xa, minor_id) };
+        Ok(Self(NonNull::new(from_err_ptr(ptr)?).ok_or(ENODEV)?))
+    }
+
+    /// Returns a reference to the DRM device for this minor.
+    ///
+    /// # Safety
+    ///
+    /// The caller must ensure that the minor belongs to a `Device<T>`.
+    unsafe fn device<T: drm::Driver>(&self) -> &Device<T, Userspace> {
+        // SAFETY: The minor is valid (from `drm_minor_acquire()`) and `minor->dev`
+        // is a valid `drm_device`. The caller guarantees it is a `Device<T>`.
+        unsafe { Device::from_raw((*self.0.as_ptr()).dev) }
+    }
+}
+
+impl Drop for Minor {
+    #[inline(never)]
+    fn drop(&mut self) {
+        // SAFETY: `self.0` came from `drm_minor_acquire()` and has not been released yet.
+        unsafe { bindings::drm_minor_release(self.0.as_ptr()) }
+    }
+}
+
 #[cfg(CONFIG_DRM_LEGACY)]
 macro_rules! drm_legacy_fields {
     ( $($field:ident: $val:expr),* $(,)? ) => {
@@ -198,11 +234,36 @@ const fn compute_features() -> u32 {
         fops: &Self::FOPS,
     };
 
+    /// Wrapper for `fops.open` that holds a [`RegistrationGuard`] across the entire `drm_open()`
+    /// call. This guarantees that `drm_dev_unplug()` in `Registration::drop()` waits for the full
+    /// open sequence.
+    extern "C" fn fops_open(inode: *mut bindings::inode, filp: *mut bindings::file) -> c_int {
+        let f = || -> Result<c_int> {
+            // SAFETY: `inode` is valid.
+            let minor_id = unsafe { bindings::iminor(inode) };
+            let minor = Minor::acquire(minor_id)?;
+
+            // SAFETY: `fops_open` is only installed for devices of type `T` (via `FOPS`).
+            let _guard = (unsafe { minor.device::<T>() })
+                .registration_guard()
+                .ok_or(ENODEV)?;
+
+            // SAFETY: `inode` and `filp` are valid. The RegistrationGuard ensures the entire
+            // `drm_open()` runs within the SRCU critical section.
+            Ok(unsafe { bindings::drm_open(inode, filp) })
+        };
+
+        match f() {
+            Ok(ret) => ret,
+            Err(e) => e.to_errno(),
+        }
+    }
+
     const FOPS: bindings::file_operations = {
         let mut fops: bindings::file_operations = pin_init::zeroed();
 
         fops.owner = core::ptr::null_mut();
-        fops.open = Some(bindings::drm_open);
+        fops.open = Some(Self::fops_open);
         fops.release = Some(bindings::drm_release);
         fops.unlocked_ioctl = Some(bindings::drm_ioctl);
         #[cfg(CONFIG_COMPAT)]
-- 
2.55.0

