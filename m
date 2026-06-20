Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E21ACD98F2
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:50:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2EDA10E25D;
	Sat, 20 Jun 2026 18:50:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mIBRZkP0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9CB910E25B
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:50:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5DF1F601F5;
 Sat, 20 Jun 2026 18:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06E331F00A3A;
 Sat, 20 Jun 2026 18:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981426;
 bh=/8w+Alg5cS9HB973t3dhzu08xS7/sbxeb5TgmQ6uG7c=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=mIBRZkP0PH1TrdGlmVudqTZ0XsV8nJg/xSWkvubNo8iz8zOZPnZQBy5cbZ6pMrVm/
 9XGu4h0NhG0gL5EheUG9iZbnv+zkeqlV+W7CUibYJqIY1xLJTiD6w742kcjB/Aiezi
 e8SwN5QQeZUGZg3yI6DIoM/Ipf6MSKfbf2ch5JJVss5No3aIeW0TI0ri1XgOtAKUTV
 3GqWrt9f6hRe0L1JItu5WkrsNFAyXJcLJ55F9zCOew3aK/S9M1gmN9KhtDxbZHcXIt
 fM3lyBD+mA/ti2j4L76lHlPTxoPy1tdo9YUjM/wDm9Zxg8HIOyXhw9SaDqEdYGspxT
 qSWHnxiwx3wDw==
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
Subject: [PATCH v4 11/16] rust: drm: Wrap ioctl dispatch in RegistrationGuard
Date: Sat, 20 Jun 2026 20:48:04 +0200
Message-ID: <20260620184924.2247517-12-dakr@kernel.org>
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

Ioctl handlers now receive a &Device<T, Registered> reference, proving
at the type level that the device is registered and its parent bus
device is bound.

This is achieved by calling registration_guard() on the Device<T, Ioctl>
obtained in ioctl dispatch context. If the device has been unplugged,
the ioctl returns -ENODEV without calling the handler.

To resolve the driver type parameter T for type inference, which the
compiler cannot propagate through method resolution and associated-type
projections alone, a dead-code closure and a helper function are used as
a type-inference anchor.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/file.rs | 12 ++++++----
 drivers/gpu/drm/tyr/file.rs  |  7 ++++--
 rust/kernel/drm/ioctl.rs     | 45 +++++++++++++++++++++++++++++++++---
 3 files changed, 55 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index a3b7bd36792c..19fb89b28984 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -4,7 +4,11 @@
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
-    drm::{self, gem::BaseObject},
+    drm::{
+        self,
+        gem::BaseObject,
+        Registered, //
+    },
     pci,
     prelude::*,
     uapi,
@@ -23,7 +27,7 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
 impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
-        dev: &NovaDevice,
+        dev: &NovaDevice<Registered>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
@@ -43,7 +47,7 @@ pub(crate) fn get_param(
 
     /// IOCTL: gem_create: Create a new DRM GEM object.
     pub(crate) fn gem_create(
-        dev: &NovaDevice,
+        dev: &NovaDevice<Registered>,
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -56,7 +60,7 @@ pub(crate) fn gem_create(
 
     /// IOCTL: gem_info: Query GEM metadata.
     pub(crate) fn gem_info(
-        _dev: &NovaDevice,
+        _dev: &NovaDevice<Registered>,
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
     ) -> Result<u32> {
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index 31411da203c5..fb9233eae01c 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -1,7 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0 or MIT
 
 use kernel::{
-    drm,
+    drm::{
+        self,
+        Registered, //
+    },
     prelude::*,
     uaccess::UserSlice,
     uapi, //
@@ -28,7 +31,7 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
-        ddev: &TyrDrmDevice,
+        ddev: &TyrDrmDevice<Registered>,
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index 70cf1aa4d788..6cefd26b31f9 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -71,6 +71,18 @@ pub mod internal {
     pub use bindings::drm_file;
     pub use bindings::drm_ioctl_desc;
 
+    /// Reinterpret a pointer to a DRM device with a different [`DeviceContext`], preserving the
+    /// driver type parameter `T`.
+    ///
+    /// Used by [`declare_drm_ioctls!`] to anchor type inference.
+    #[doc(hidden)]
+    #[inline(always)]
+    pub const fn __dev_ctx_cast<T: super::super::Driver>(
+        ptr: *const super::super::device::Device<T, super::super::Ioctl>,
+    ) -> *const super::super::device::Device<T, super::super::Registered> {
+        ptr.cast()
+    }
+
     /// Call an ioctl handler with lifetime-bounded references.
     ///
     /// The lifetime `'a` is tied to the `_anchor` parameter. This prevents handlers from
@@ -115,7 +127,7 @@ pub unsafe fn __call_ioctl<
 /// `user_callback` should have the following prototype:
 ///
 /// ```ignore
-/// fn foo(device: &kernel::drm::Device<Self>,
+/// fn foo(device: &kernel::drm::Device<Self, kernel::drm::Registered>,
 ///        data: &mut uapi::argument_type,
 ///        file: &kernel::drm::File<Self::File>,
 /// ) -> Result<u32>
@@ -164,11 +176,38 @@ macro_rules! declare_drm_ioctls {
                             // - The DRM device must have been registered when we're called through
                             //   an IOCTL.
                             //
+                            // INVARIANT: The `Ioctl` context requires that the device has been
+                            // registered via `drm_dev_register()` at some point; the DRM core
+                            // guarantees this for ioctl dispatch callbacks.
+                            //
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev: &$crate::drm::device::Device<_, $crate::drm::Normal> =
+                            let dev: &$crate::drm::device::Device<_, $crate::drm::Ioctl> =
                                 $crate::drm::device::Device::from_raw(raw_dev);
+                            // Cast to Registered preserving the driver type parameter.
+                            let __ptr = $crate::drm::ioctl::internal::__dev_ctx_cast(
+                                ::core::ptr::from_ref(dev),
+                            );
+
+                            // Type-inference anchor: the closure is never called but ties `dev`'s
+                            // type to `$func`'s first parameter, which the compiler cannot infer
+                            // through method resolution and associated-type projections alone.
+                            #[allow(unreachable_code)]
+                            let _ = || {
+                                $func(
+                                    // SAFETY: This closure is never executed; the dereference
+                                    // exists purely to unify the type parameter with `$func`.
+                                    // The pointer is valid regardless.
+                                    unsafe { &*__ptr },
+                                    unreachable!(),
+                                    unreachable!(),
+                                )
+                            };
+
+                            let Some(guard) = dev.registration_guard() else {
+                                return $crate::error::code::ENODEV.to_errno();
+                            };
                             let __anchor = ();
 
                             // SAFETY:
@@ -180,7 +219,7 @@ macro_rules! declare_drm_ioctls {
                             // - `raw_file` is a valid `struct drm_file` pointer provided by the
                             //   DRM core.
                             match unsafe { $crate::drm::ioctl::internal::__call_ioctl(
-                                &__anchor, dev, raw_data, raw_file, $func,
+                                &__anchor, &*guard, raw_data, raw_file, $func,
                             ) } {
                                 Err(e) => e.to_errno(),
                                 Ok(i) => i.try_into()
-- 
2.54.0

