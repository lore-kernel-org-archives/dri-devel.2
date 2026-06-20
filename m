Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB21CD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E186610E247;
	Sat, 20 Jun 2026 18:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gCypBl2r";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B483510E258
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:49:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D5843601F3;
 Sat, 20 Jun 2026 18:49:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2383D1F00A3A;
 Sat, 20 Jun 2026 18:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981380;
 bh=CaM1+SVTD+InAXDdfA+jIamxSOfh/RY/jyvis0pChEQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gCypBl2rDgXQNtLQAes0M4Huor84MXlc4eSOa6gSNd9U3aGzWqo8putoNaSTYYSyx
 E1cOxWnEEZOjU3f9BzN40i9RqfT+brdaPYDw4EnUHF+O2nZAC3QjEcKQNXuxCbB4Vu
 QliPybpkIpNiGK0Lt2amamhCrnk8ZBeAShYcvh8zyu33HLNLb3SSUR7hqlzXfuM2rA
 nG6XlOfhEFT59CguvXvc4FLlAd0Pv5YAD2+ztGkOm5lKTmpf+9SgdGUfZqNc9c1nSS
 DB0DGsQGyJv49xR5QxeVi8JEfPvctw8xJtmhWyOuzy+jcuK4pxitJpoUSryn2iD9Jx
 f8nH0z7oWAieA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org
Subject: [PATCH v4 01/16] rust: drm: ioctl: fix unbounded lifetimes in ioctl
 handler arguments
Date: Sat, 20 Jun 2026 20:47:54 +0200
Message-ID: <20260620184924.2247517-2-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620184924.2247517-1-dakr@kernel.org>
References: <20260620184924.2247517-1-dakr@kernel.org>
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

References to dev, data, and file in the declare_drm_ioctls! macro are
created via unsafe pointer dereferences, producing unbounded lifetimes.
If an ioctl handler explicitly annotates its parameters with 'static,
the compiler accepts this, allowing the handler to stash references that
outlive the ioctl call.

Fix this by routing all references through a helper function whose
lifetime parameter 'a is tied to a local anchor variable. Since 'a is
bounded by the anchor's stack lifetime, handlers can no longer demand
'static on any parameter.

Cc: stable@vger.kernel.org
Fixes: 9a69570682b1 ("rust: drm: ioctl: Add DRM ioctl abstraction")
Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/all/20260620011346.A47D01F000E9@smtp.kernel.org/
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/ioctl.rs | 59 +++++++++++++++++++++++++++++++---------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index cf328101dde4..023e6da5c1e4 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -70,6 +70,39 @@ pub mod internal {
     pub use bindings::drm_device;
     pub use bindings::drm_file;
     pub use bindings::drm_ioctl_desc;
+
+    /// Call an ioctl handler with lifetime-bounded references.
+    ///
+    /// The lifetime `'a` is tied to the `_anchor` parameter. This prevents handlers from
+    /// declaring `'static` on `dev`, `data`, or `file`.
+    ///
+    /// # Safety
+    ///
+    /// - `raw_data` must point to a valid, exclusively-owned instance of `Data` for the duration
+    ///   of the call.
+    /// - `raw_file` must be a valid pointer to a `struct drm_file`.
+    #[doc(hidden)]
+    #[inline(always)]
+    pub unsafe fn __call_ioctl<
+        'a,
+        Dev: 'a,
+        Data: 'a,
+        F: super::super::file::DriverFile + 'a,
+        Ret,
+    >(
+        _anchor: &'a (),
+        dev: &'a Dev,
+        raw_data: *mut ::core::ffi::c_void,
+        raw_file: *mut drm_file,
+        f: impl FnOnce(&'a Dev, &'a mut Data, &'a super::super::File<F>) -> Ret,
+    ) -> Ret {
+        // SAFETY: Caller guarantees raw_data points to a valid instance of Data with the correct
+        // size and alignment, exclusively owned for the duration of the ioctl call.
+        let data = unsafe { &mut *(raw_data.cast::<Data>()) };
+        // SAFETY: Caller guarantees raw_file is a valid pointer to a `struct drm_file`.
+        let file = unsafe { super::super::File::<F>::from_raw(raw_file) };
+        f(dev, data, file)
+    }
 }
 
 /// Declare the DRM ioctls for a driver.
@@ -135,19 +168,19 @@ macro_rules! declare_drm_ioctls {
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
                             let dev = $crate::drm::device::Device::from_raw(raw_dev);
-                            // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
-                            // asserted above matches the size of this type, and all bit patterns of
-                            // UAPI structs must be valid.
-                            // The `ioctl` argument is exclusively owned by the handler
-                            // and guaranteed by the C implementation (`drm_ioctl()`) to remain
-                            // valid for the entire lifetime of the reference taken here.
-                            // There is no concurrent access or aliasing; no other references
-                            // to this object exist during this call.
-                            let data = unsafe { &mut *(raw_data.cast::<$crate::uapi::$struct>()) };
-                            // SAFETY: This is just the DRM file structure
-                            let file = unsafe { $crate::drm::File::from_raw(raw_file) };
-
-                            match $func(dev, data, file) {
+                            let __anchor = ();
+
+                            // SAFETY:
+                            // - The ioctl argument has size `_IOC_SIZE(cmd)`, which we asserted
+                            //   above matches the size of this type, and all bit patterns of UAPI
+                            //   structs must be valid. The argument is exclusively owned by this
+                            //   handler, guaranteed by `drm_ioctl()` to remain valid for the
+                            //   duration of the call.
+                            // - `raw_file` is a valid `struct drm_file` pointer provided by the
+                            //   DRM core.
+                            match unsafe { $crate::drm::ioctl::internal::__call_ioctl(
+                                &__anchor, dev, raw_data, raw_file, $func,
+                            ) } {
                                 Err(e) => e.to_errno(),
                                 Ok(i) => i.try_into()
                                             .unwrap_or($crate::error::code::ERANGE.to_errno()),
-- 
2.54.0

