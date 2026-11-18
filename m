Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7031606A7CB
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JA+xHdLt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE98610EC57;
	Wed, 18 Nov 2026 16:32:50 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9307E10E5B2
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:32:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EE32062987;
 Wed, 18 Nov 2026 16:32:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C01C51F000CA;
 Wed, 18 Nov 2026 16:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795019557;
 bh=FU9I4h5VPSFm2UUsPs50K/BUB1ZDNdMz2E1Ufcl88ww=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JA+xHdLt98qFeU2PPmetVpefyTy/a4X6I5Ug0ffOPgzjWZwbDV9SQ+W6HrCdzmneu
 i/dU4br1GFUI37ZlN5xV96rdHRrowZnd4AiLLtI5UEv0KfPR/0B3ptdjALdKH+fQhH
 PPFmQLUABz65BxmzwdkDcfS6U5usmZC8sAlpakQwwWWYQ23OrI3s/c1iPB264LmwNB
 LDu5DrxTTJX2dCA5hUoL83NG2zV2BKrHY9OL7g92Lp+TQYCWPu212MdrT+qi50ZWFl
 mciBzcNzNuonioZmekWVJVq6EDfD3n/CbzlBMotSVgV2/xibTsXIGSrof4Xke3aZ4c
 EfVayYrDWJLgQ==
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
Subject: [PATCH v3 5/7] rust: drm: wrap fops open with RegistrationGuard
Date: Wed, 18 Nov 2026 17:29:46 +0100
Message-ID: <20261118163203.2483856-6-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261118163203.2483856-1-dakr@kernel.org>
References: <20261118163203.2483856-1-dakr@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a Minor abstraction with RAII release and a fops_open() wrapper that
holds a RegistrationGuard (drm_dev_enter / drm_dev_exit) across the
entire drm_open() call.

This guarantees that drm_dev_unplug() in Registration::drop() waits for
the full open sequence to complete, so all files are visible in the
filelist when iterating for cleanup.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Reviewed-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 63 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 3340fa0dc46b..b8444499b39c 100644
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
 
         fops.owner = crate::module::this_module::<T::OwnerModule>().as_ptr();
-        fops.open = Some(bindings::drm_open);
+        fops.open = Some(Self::fops_open);
         fops.release = Some(bindings::drm_release);
         fops.unlocked_ioctl = Some(bindings::drm_ioctl);
         #[cfg(CONFIG_COMPAT)]
-- 
2.56.1

