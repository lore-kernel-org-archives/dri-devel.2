Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AE15C43602
	for <dri-devel@archiver.kernel.org>; Sun, 28 Jun 2026 14:55:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7B5A10E627;
	Sun, 28 Jun 2026 14:55:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZSJX+Dxw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD64610E625
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 14:55:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B1350401BF;
 Sun, 28 Jun 2026 14:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B324E1F00A3A;
 Sun, 28 Jun 2026 14:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782658504;
 bh=x8Z+En08jS5dDwWeT6XTkMeaujP+D7cO4CR0aV9JJyg=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ZSJX+DxwKFzmSIqNF55jbTZo7sNa7YhSeti2bD+GX/DfHebIs2EnZElNz4nAjmdoR
 h0ekpztTeB5QUyg939RU8jAKgLOsxJupHBrxsXF2UFuf2BmyaBYqrqZF1oId6ZZiqF
 vygbnJekO2Imp0aMfzQSr9s1Qx6qEDq4rNnbukO2WM903Vu7unPLwNoDdp01lk7Hor
 Ok2P4hZfm1YRjpBs0pFDxNNpW/qgXrx1IAmI+NTjMnlLYM/2VSn0GiOHSdubScx40c
 V6P5NG0qSBhoRyzJPuv9ZfEE+yt7LdDVKIUeRxmuHOhRWbCxStmj5daGvEeQ8HmKUg
 qfnYkcNBYx1jg==
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
Subject: [PATCH v5 12/19] rust: drm: Add RegistrationGuard for
 drm_dev_enter/exit critical sections
Date: Sun, 28 Jun 2026 16:53:32 +0200
Message-ID: <20260628145406.2107056-13-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260628145406.2107056-1-dakr@kernel.org>
References: <20260628145406.2107056-1-dakr@kernel.org>
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
guard is obtained from Device<T, Ioctl> and proves at runtime that the
device is still registered.

Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug()
to provide the SRCU barrier that RegistrationGuard's safety argument
relies on.

Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 85 ++++++++++++++++++++++++++++++++++-----
 rust/kernel/drm/driver.rs | 10 ++++-
 rust/kernel/drm/mod.rs    |  1 +
 3 files changed, 83 insertions(+), 13 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index d429b4655449..c32cc0f0eba0 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -80,7 +80,8 @@ macro_rules! drm_legacy_fields {
 ///   or may not be registered with userspace.
 /// - [`Ioctl`]: The device has been registered with userspace at some point; used in ioctl
 ///   dispatch context.
-/// - [`Registered`]: The device has been registered with userspace at some point.
+/// - [`Registered`]: The device is currently registered with userspace and the parent bus device
+///   is bound.
 ///
 /// Both `Device<T, Ioctl>` and `Device<T, Registered>` dereference to `Device<T>` ([`Normal`]),
 /// so any method available on a [`Normal`] device is also available in the other contexts.
@@ -98,18 +99,15 @@ pub trait DeviceContext: Sealed + Send + Sync {}
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
@@ -260,8 +258,8 @@ pub fn new(
 
 /// A typed DRM device with a specific [`drm::Driver`] implementation and [`DeviceContext`].
 ///
-/// A device in the [`Registered`] context is guaranteed to have been registered with userspace
-/// at some point. The [`Normal`] context is the general-purpose, reference-counted context.
+/// A device in the [`Registered`] context is currently registered with userspace and its parent
+/// bus device is bound. The [`Normal`] context is the general-purpose, reference-counted context.
 ///
 /// # Invariants
 ///
@@ -340,6 +338,71 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
     }
 }
 
+impl<T: drm::Driver> Device<T, Ioctl> {
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
+            // INVARIANT:
+            // - `idx` is the SRCU index from the successful `drm_dev_enter()` above.
+            // - The parent bus device is bound: `drm_dev_enter()` succeeded, meaning
+            //   `drm_dev_unplug()` has not completed; since it is only called from
+            //   `Registration::drop()` during parent unbind, the parent is still bound.
+            Some(RegistrationGuard {
+                // SAFETY: See INVARIANT above; the `Registered` context invariant holds.
+                dev: unsafe { self.assume_ctx() },
+                idx,
+                _not_send: NotThreadSafe,
+            })
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
+    dev: &'a Device<T, Registered>,
+    idx: i32,
+    _not_send: NotThreadSafe,
+}
+
+impl<T: drm::Driver> Deref for RegistrationGuard<'_, T> {
+    type Target = Device<T, Registered>;
+
+    #[inline]
+    fn deref(&self) -> &Self::Target {
+        self.dev
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
index 5152a18a8312..3cda8dceb498 100644
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
index a6693d2b84b8..fd6ed35bc35a 100644
--- a/rust/kernel/drm/mod.rs
+++ b/rust/kernel/drm/mod.rs
@@ -14,6 +14,7 @@
 pub use self::device::Ioctl;
 pub use self::device::Normal;
 pub use self::device::Registered;
+pub use self::device::RegistrationGuard;
 pub use self::device::UnregisteredDevice;
 pub use self::driver::Driver;
 pub use self::driver::DriverInfo;
-- 
2.54.0

