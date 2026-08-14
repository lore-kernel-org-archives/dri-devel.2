Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9045EC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 23:09:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52E110E189;
	Fri, 14 Aug 2026 23:09:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kmnOytQh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2124610E107
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 23:09:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9816D601DE;
 Fri, 14 Aug 2026 23:09:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D451F00A3A;
 Fri, 14 Aug 2026 23:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786748975;
 bh=CcCMjsoinR53+ljjs1ik9JtiuPEjroGPVh8Wrd/zOaI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kmnOytQhQyltB48W9oOLQZc9qNqvuyY0HwPA39ujoEUbCSQ5fc8G/oFbx77d0lL3Y
 ctbxEOoceFhjC2s3GCFtEuD258gY/7NvIZUXIHGB5UKJSiUVp99OSJmqss3OpEy+nq
 xuE0DVyMrnX7KhT6RIMfDGb77r3nKphlAXAgJMJBdfYkCEjMQZ6q5u7fDhlsQofZIa
 vJzT2+/DGmij2+FNzhiU5UKK7R2hW4u2cnxyTnI3UC+nex85tM1caLGUKh8GNfBfEX
 YN2qtoi5qkjGsXf/iAzkC+bezZYi/Xsnreqriof5/i74DUGFVCX1pqR30t0RcHr+hp
 YO2QTH459On6w==
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
Subject: [PATCH 1/7] rust: drm: rename Ioctl device context to Userspace
Date: Sat, 15 Aug 2026 01:08:59 +0200
Message-ID: <20260814230923.1292966-2-dakr@kernel.org>
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

The Ioctl DeviceContext typestate represents a device that has been
registered with userspace at some point. This context is not specific to
ioctl dispatch; it applies equally to GEM handle callbacks, mmap,
fdinfo, and any other operation triggered by userspace on a registered
device.

Rename it to Userspace to accurately reflect its semantics.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 21 ++++++++++++---------
 rust/kernel/drm/ioctl.rs  | 12 ++++++------
 rust/kernel/drm/mod.rs    |  2 +-
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index f43c6887ad23..be83287fe161 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -79,12 +79,12 @@ macro_rules! drm_legacy_fields {
 ///
 /// - [`Normal`]: The general-purpose, reference-counted context. A [`Device`] in this context may
 ///   or may not be registered with userspace.
-/// - [`Ioctl`]: The device has been registered with userspace at some point; used in ioctl
-///   dispatch context.
+/// - [`Userspace`]: The device has been registered with userspace at some point; used in
+///   callbacks triggered by userspace operations.
 /// - [`Registered`]: The device is currently registered with userspace and the parent bus device
 ///   is bound.
 ///
-/// Both `Device<T, Ioctl>` and `Device<T, Registered>` dereference to `Device<T>` ([`Normal`]),
+/// Both `Device<T, Userspace>` and `Device<T, Registered>` dereference to `Device<T>` ([`Normal`]),
 /// so any method available on a [`Normal`] device is also available in the other contexts.
 pub trait DeviceContext: Sealed + Send + Sync + 'static {}
 
@@ -120,14 +120,17 @@ impl DeviceContext for Registered {}
 /// unregistering or already unregistered. `drm_dev_enter()` can guard against this, ensuring the
 /// device remains registered for the duration of the critical section.
 ///
+/// This context is used for all callbacks triggered by userspace operations: ioctls, GEM handle
+/// management, mmap, fdinfo, etc.
+///
 /// # Invariants
 ///
 /// A [`Device`] in this context has been registered with userspace via `drm_dev_register()` at
 /// some point.
-pub struct Ioctl;
+pub struct Userspace;
 
-impl Sealed for Ioctl {}
-impl DeviceContext for Ioctl {}
+impl Sealed for Userspace {}
+impl DeviceContext for Userspace {}
 
 /// A [`Device`] which is known at compile-time to be unregistered with userspace.
 ///
@@ -343,7 +346,7 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
     }
 }
 
-impl<T: drm::Driver> Device<T, Ioctl> {
+impl<T: drm::Driver> Device<T, Userspace> {
     /// Guard against the parent bus device being unbound.
     ///
     /// Returns a [`RegistrationGuard`] if the device has not been unplugged, [`None`] otherwise.
@@ -466,12 +469,12 @@ fn deref(&self) -> &Self::Target {
     }
 }
 
-impl<T: drm::Driver> Deref for Device<T, Ioctl> {
+impl<T: drm::Driver> Deref for Device<T, Userspace> {
     type Target = Device<T>;
 
     #[inline]
     fn deref(&self) -> &Self::Target {
-        // SAFETY: The caller holds a `Device<T, Ioctl>`, which guarantees all invariants
+        // SAFETY: The caller holds a `Device<T, Userspace>`, which guarantees all invariants
         // of the weaker `Normal` context.
         unsafe { self.assume_ctx() }
     }
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 64af9eacc306..9934b23c36eb 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -71,14 +71,14 @@ pub mod internal {
     pub use bindings::drm_file;
     pub use bindings::drm_ioctl_desc;
 
-    /// Cast an [`Ioctl`] DRM device pointer to [`Registered`], preserving the driver type
+    /// Cast a [`Userspace`] DRM device pointer to [`Registered`], preserving the driver type
     /// parameter `T`.
     ///
     /// Used by [`declare_drm_ioctls!`] to anchor type inference.
     #[doc(hidden)]
     #[inline]
     pub const fn __dev_ctx_cast<T: crate::drm::Driver>(
-        ptr: *const crate::drm::Device<T, crate::drm::Ioctl>,
+        ptr: *const crate::drm::Device<T, crate::drm::Userspace>,
     ) -> *const crate::drm::Device<T, crate::drm::Registered> {
         ptr.cast()
     }
@@ -144,14 +144,14 @@ macro_rules! declare_drm_ioctls {
                             // - The DRM device must have been registered when we're called through
                             //   an IOCTL.
                             //
-                            // INVARIANT: The `Ioctl` context requires that the device has been
-                            // registered via `drm_dev_register()` at some point; the DRM core
-                            // guarantees this for ioctl dispatch callbacks.
+                            // INVARIANT: The `Userspace` context requires that the device has
+                            // been registered via `drm_dev_register()` at some point; the DRM
+                            // core guarantees this for ioctl dispatch callbacks.
                             //
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev: &$crate::drm::device::Device<_, $crate::drm::Ioctl> =
+                            let dev: &$crate::drm::device::Device<_, $crate::drm::Userspace> =
                                 $crate::drm::device::Device::from_raw(raw_dev);
 
                             // Type-inference anchor: the closure is never called but ties `dev`'s
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index fd6ed35bc35a..7fcf2465a82e 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -11,11 +11,11 @@
 
 pub use self::device::Device;
 pub use self::device::DeviceContext;
-pub use self::device::Ioctl;
 pub use self::device::Normal;
 pub use self::device::Registered;
 pub use self::device::RegistrationGuard;
 pub use self::device::UnregisteredDevice;
+pub use self::device::Userspace;
 pub use self::driver::Driver;
 pub use self::driver::DriverInfo;
 pub use self::driver::Registration;
-- 
2.55.0

