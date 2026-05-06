Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F2ECD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:10:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D175B10EEE0;
	Wed,  6 May 2026 22:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnFlSaTA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00ED310EEE0
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:10:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7974D60583;
 Wed,  6 May 2026 22:10:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B04BC2BCC4;
 Wed,  6 May 2026 22:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778105447;
 bh=TcNbTks32PZMaqi4Rmd1A9s7dMtJPREgNvFJTYp1+Do=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=VnFlSaTAD/f0e5baL8v+kavr1bwseoFY0Z2YgsGDC21grEHakKcHbWla6OLmSI+9Z
 /e8FgYoHUteFbNm8AFH+bXzme9p1NJ5hmHR0B4ZL8mQnHiZ5G0ulf5XQwtZmkdAOEA
 xwM9gbOSAZtVhbGwyZElERJrbRIMW1MM5qXJbEoyd0u9DIxpFnIuZNPHwhfIUL9TJ/
 NMBI+n0qZ69REl7rejYva1lmrv4S6PEFGcGqp77NqMC1NCbkszid2/NZmXN5NkeY88
 2wEINAEyHLXqn3RW3bOOrE6/OpsORRf7B0RCxj6Txcl0yAPOXhUTqfJs9+riY21eBj
 Gp05PSIRKqhnw==
From: Danilo Krummrich <dakr@kernel.org>
To: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 daniel.almeida@collabora.com, acourbot@nvidia.com, apopple@nvidia.com,
 ecourtney@nvidia.com, deborah.brouwer@collabora.com, lyude@redhat.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 2/6] rust: drm: Add UnbindGuard for drm_dev_enter/exit
 critical sections
Date: Thu,  7 May 2026 00:06:00 +0200
Message-ID: <20260506221027.858481-3-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506221027.858481-1-dakr@kernel.org>
References: <20260506221027.858481-1-dakr@kernel.org>
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

Add UnbindGuard, a guard object representing a drm_dev_enter/exit SRCU
critical section that dereferences to &Device<Bound> of the parent bus
device. The guard is only available on Device<T, Registered>, ensuring
it cannot be used on unregistered devices.

Also add with_unbind_guard() as a convenience helper that executes a
closure with the bound device reference.

Switch Registration::drop from drm_dev_unregister() to drm_dev_unplug()
to provide the SRCU barrier that UnbindGuard's safety argument relies on.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs | 80 ++++++++++++++++++++++++++++++++++++++-
 rust/kernel/drm/driver.rs | 10 ++++-
 2 files changed, 87 insertions(+), 3 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 492c2f2c7ca4..bb685165032d 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -6,7 +6,11 @@
 
 use crate::{
     alloc::allocator::Kmalloc,
-    bindings, device,
+    bindings,
+    device::{
+        self,
+        AsBusDevice as _, //
+    },
     drm::{
         self,
         driver::AllocImpl,
@@ -334,6 +338,80 @@ pub(crate) unsafe fn assume_ctx<NewCtx: DeviceContext>(&self) -> &Device<T, NewC
     }
 }
 
+impl<T: drm::Driver> Device<T, Registered> {
+    /// Guard against the parent bus device being unbound.
+    ///
+    /// Returns an [`UnbindGuard`] if the device has not been unplugged, [`None`] otherwise.
+    ///
+    /// The returned guard dereferences to the parent bus device in the [`device::Bound`] context
+    /// (see [`Driver::ParentDevice`](drm::Driver::ParentDevice)).
+    /// Between `drm_dev_enter()` and `drm_dev_exit()` the parent device is guaranteed to be bound.
+    #[must_use]
+    pub fn unbind_guard(&self) -> Option<UnbindGuard<'_, T>> {
+        let mut idx: i32 = 0;
+        // SAFETY: `self.as_raw()` is a valid pointer to a `struct drm_device` by the type
+        // invariants of `Device<T, Registered>`.
+        if unsafe { bindings::drm_dev_enter(self.as_raw(), &mut idx) } {
+            Some(UnbindGuard { dev: self, idx })
+        } else {
+            None
+        }
+    }
+
+    /// Execute a closure while the parent bus device is guaranteed to be bound.
+    ///
+    /// Acquires the [`UnbindGuard`] and, if the device has not been unplugged, calls `f` with the
+    /// parent bus device. Returns `None` if the device has been unplugged.
+    pub fn with_unbind_guard<R>(
+        &self,
+        f: impl FnOnce(&T::ParentDevice<device::Bound>) -> R,
+    ) -> Option<R> {
+        let guard = self.unbind_guard()?;
+        Some(f(&guard))
+    }
+}
+
+/// A guard preventing the parent bus device from being unbound.
+///
+/// The guard dereferences to [`Driver::ParentDevice<Bound>`](drm::Driver::ParentDevice), providing
+/// access to the parent bus device with the guarantee that it is bound for the entire duration of
+/// the critical section.
+///
+/// Internally this is backed by a `drm_dev_enter()` / `drm_dev_exit()` SRCU critical section.
+///
+/// See [`Device::unbind_guard`] for details on the safety argument.
+///
+/// # Invariants
+///
+/// - `idx` is the SRCU read lock index returned by a successful `drm_dev_enter()` call.
+/// - The parent bus device of `dev` is bound for the lifetime of this guard.
+#[must_use]
+pub struct UnbindGuard<'a, T: drm::Driver> {
+    dev: &'a Device<T, Registered>,
+    idx: i32,
+}
+
+impl<T: drm::Driver> Deref for UnbindGuard<'_, T> {
+    type Target = T::ParentDevice<device::Bound>;
+
+    fn deref(&self) -> &Self::Target {
+        // SAFETY:
+        // - The parent `struct device` is embedded in a `T::ParentDevice`, as guaranteed by
+        //   `UnregisteredDevice::new` taking a `&T::ParentDevice<device::Bound>`.
+        // - By the type invariants of `UnbindGuard`, the parent device is bound for the lifetime
+        //   of this guard.
+        unsafe { T::ParentDevice::from_device(self.dev.as_ref().as_bound()) }
+    }
+}
+
+impl<T: drm::Driver> Drop for UnbindGuard<'_, T> {
+    fn drop(&mut self) {
+        // SAFETY: `self.idx` was returned by a successful `drm_dev_enter()` call, as guaranteed
+        // by the type invariants of `UnbindGuard`.
+        unsafe { bindings::drm_dev_exit(self.idx) };
+    }
+}
+
 impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
     type Target = T::Data;
 
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 9d06f8c5b2da..751a68bb27e1 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -187,8 +187,14 @@ unsafe impl<T: Driver> Send for Registration<T> {}
 
 impl<T: Driver> Drop for Registration<T> {
     fn drop(&mut self) {
+        // Use `drm_dev_unplug` rather than `drm_dev_unregister` to ensure that existing
+        // `drm_dev_enter()` critical sections complete before unregistration proceeds. This
+        // is required for the safety of `UnbindGuard`, which relies on the SRCU barrier in
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
-- 
2.54.0

