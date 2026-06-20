Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8863FCD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E54EF10E150;
	Sat, 20 Jun 2026 00:59:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dYztD8Hj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 197BE10E153
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8F70C601E3;
 Sat, 20 Jun 2026 00:59:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D2AA1F00A3A;
 Sat, 20 Jun 2026 00:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917181;
 bh=OIKBr1i4T/n3+7dsoij726Xq6HWOrPSKiM18XbY403M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=dYztD8HjAGUyt5EGhS9MbGmFteVT5/Sm6Two2wmKSGNjQayim5x+UKpnpX65eZ8yz
 cxJfOFpTuabxUcx1FWxQpZ3idrzrrmV6eIcCFKNvM/7hjdK0y0YX63kNY5iO+g3rTy
 hMrPjvozI5Pi7XPLlDBYFFb24B75Usp4xk3RMQ+8hAawjVQYPFXKGwp+t2AS1FLkqu
 x9PyfPJ7cuLiLEtRZih80MCCrJmz5o+MGqzfVXtJLLTOXJU7DTAaN0S9y3eba5i0jR
 QOeR8XtsMZpgA11q0Kk+I+9g5VaSTiz0cBItYhR9r83CriJ7FjHag0OmF0GPkyYbWS
 Fik+0oVKcRyZA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com,
 lyude@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v3 09/13] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
Date: Sat, 20 Jun 2026 02:51:21 +0200
Message-ID: <20260620005431.1562115-10-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620005431.1562115-1-dakr@kernel.org>
References: <20260620005431.1562115-1-dakr@kernel.org>
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

DRM ioctls do not guarantee that the parent bus device is still bound.
However, since DRM device registration is managed through Devres, using
drm_dev_unplug() on unregistration ensures that between drm_dev_enter()
and drm_dev_exit() the parent device must be bound.

Add RegistrationGuard, a guard object representing a drm_dev_enter/exit
SRCU critical section that dereferences to &Device<T, Registered>. The
guard is obtained from Device<T> (Normal) and proves at runtime that the
device is still registered.

Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug()
to provide the SRCU barrier that RegistrationGuard's safety argument
relies on.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 76 +++++++++++++++++++++++++++++++++------
 rust/kernel/drm/driver.rs | 10 ++++--
 rust/kernel/drm/mod.rs    |  1 +
 3 files changed, 74 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 885077e270eb..bc8cfd753596 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -78,7 +78,8 @@ macro_rules! drm_legacy_fields {
 ///
 /// - [`Normal`]: The general-purpose, reference-counted context. A [`Device`] in this context may
 ///   or may not be registered with userspace.
-/// - [`Registered`]: The device has been registered with userspace at some point.
+/// - [`Registered`]: The device is currently registered with userspace and the parent bus device
+///   is bound.
 ///
 /// `Device<T, Registered>` dereferences to `Device<T>` ([`Normal`]), so any method available on a
 /// [`Normal`] device is also available on a [`Registered`] one.
@@ -96,18 +97,15 @@ pub trait DeviceContext: Sealed + Send + Sync {}
 impl Sealed for Normal {}
 impl DeviceContext for Normal {}
 
-/// The [`DeviceContext`] of a [`Device`] that was registered with userspace at some point.
+/// The [`DeviceContext`] of a [`Device`] that is currently registered with userspace.
 ///
-/// This represents a [`Device`] which is guaranteed to have been registered with userspace at
-/// some point in time. Such a DRM device is guaranteed to have been fully-initialized.
-///
-/// Note: A device in this context is not guaranteed to remain registered with userspace for its
-/// entire lifetime, as this is impossible to guarantee at compile-time.
+/// A [`Device`] in this context is guaranteed to be registered and its parent bus device is
+/// guaranteed to be bound. This is enforced at runtime by [`RegistrationGuard`], which holds a
+/// `drm_dev_enter()` / `drm_dev_exit()` SRCU critical section.
 ///
 /// # Invariants
 ///
-/// A [`Device`] in this [`DeviceContext`] is guaranteed to have been registered with userspace
-/// at some point in time.
+/// The parent bus device is bound for the duration of any reference to a `Device<T, Registered>`.
 pub struct Registered;
 
 impl Sealed for Registered {}
@@ -243,8 +241,8 @@ pub fn new(
 
 /// A typed DRM device with a specific [`drm::Driver`] implementation and [`DeviceContext`].
 ///
-/// A device in the [`Registered`] context is guaranteed to have been registered with userspace
-/// at some point. The [`Normal`] context is the general-purpose, reference-counted context.
+/// A device in the [`Registered`] context is currently registered with userspace and its parent
+/// bus device is bound. The [`Normal`] context is the general-purpose, reference-counted context.
 ///
 /// # Invariants
 ///
@@ -323,6 +321,62 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
     }
 }
 
+impl<T: drm::Driver> Device<T> {
+    /// Guard against the parent bus device being unbound.
+    ///
+    /// Returns a [`RegistrationGuard`] if the device has not been unplugged, [`None`] otherwise.
+    ///
+    /// While [`RegistrationGuard`] is held the parent device is guaranteed to be bound.
+    #[must_use]
+    pub fn registration_guard(&self) -> Option<RegistrationGuard<'_, T>> {
+        let mut idx: i32 = 0;
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_device`.
+        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {
+            Some(RegistrationGuard { dev: self, idx })
+        } else {
+            None
+        }
+    }
+}
+
+/// A guard proving the DRM device is registered and the parent bus device is bound.
+///
+/// The guard dereferences to [`Device<T, Registered>`], providing access to the DRM device with
+/// the guarantee that the parent bus device is bound for the entire duration of the critical
+/// section.
+///
+/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` SRCU critical section.
+///
+/// # Invariants
+///
+/// - `idx` is the SRCU read lock index returned by a successful `drm_dev_enter()` call.
+/// - The parent bus device of `dev` is bound for the lifetime of this guard.
+#[must_use]
+pub struct RegistrationGuard<'a, T: drm::Driver> {
+    dev: &'a Device<T>,
+    idx: i32,
+}
+
+impl<T: drm::Driver> Deref for RegistrationGuard<'_, T> {
+    type Target = Device<T, Registered>;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        // SAFETY: A successful `drm_dev_enter()` guarantees that the device is registered and
+        // the parent bus device is bound.
+        unsafe { self.dev.assume_ctx() }
+    }
+}
+
+impl<T: drm::Driver> Drop for RegistrationGuard<'_, T> {
+    #[inline]
+    fn drop(&mut self) {
+        // SAFETY: `self.idx` was returned by a successful `drm_dev_enter()` call, as guaranteed
+        // by the type invariants of `RegistrationGuard`.
+        unsafe { bindings::drm_dev_exit(self.idx) };
+    }
+}
+
 impl<T: drm::Driver> Deref for Device<T> {
     type Target = T::Data;
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 9ba7dc3a7a97..ceb2829985c7 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -199,8 +199,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
 
 impl<T: Driver> Drop for Registration<T> {
     fn drop(&mut self) {
+        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
+        // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
+        // is required for the safety of `RegistrationGuard`, which relies on the SRCU barrier in
+        // `drm_dev_unplug()` to guarantee that the parent device is still bound within the
+        // critical section.
+        //
         // SAFETY: Safe by the invariant of `ARef<drm::Device<T>>`. The existence of this
-        // `Registration` also guarantees the this `drm::Device` is actually registered.
-        unsafe { bindings::drm_dev_unregister(self.0.as_raw()) };
+        // `Registration` also guarantees that this `drm::Device` is actually registered.
+        unsafe { bindings::drm_dev_unplug(self.0.as_raw()) };
     }
 }
diff --git a/rust/kernel/drm/mod.rs b/rust/kernel/drm/mod.rs
index e5bfaf130342..6cfb01eec7ee 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -13,6 +13,7 @@
 pub use self::device::DeviceContext;
 pub use self::device::Normal;
 pub use self::device::Registered;
+pub use self::device::RegistrationGuard;
 pub use self::device::UnregisteredDevice;
 pub use self::driver::Driver;
 pub use self::driver::DriverInfo;
-- 
2.54.0

