Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C4C4CD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE55610EEE1;
	Wed,  6 May 2026 22:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WgSii8GN";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9F4B10EEE1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:10:56 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id B2B0C44297;
 Wed,  6 May 2026 22:10:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62279C2BCC4;
 Wed,  6 May 2026 22:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778105456;
 bh=5z11vUM2l987/nev8SzbXOKwxTlBkMgkO23FG+Hi7kQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=WgSii8GNp6mTSfBPZjyHKef2aj/2DCoa9yAT+/MVTyXFgLUHOHEJCbex9oJWRougp
 JuXYl999I8AmmhgkdSBFL2kO5xdNzkK2a/Q5p3eBKVN0rj0EjGfL4holT1KNuBqaIe
 Ed4C2La5I44YhS7mCDfdZ0RmXs9h3eOGS9ZrDRCP5fuAGh5A/0oJFe2mvPju1gIWt3
 aDWYW3sDWyyLN7Ro8izTTKDwU6/ZPvejvItoNNAnV+3zzFPQP+oDYMsONKF8gkOc6b
 nmT6E8SdGeH3DHR5ZQFhsicspkbaM1jvxN3b5ZUIPyQa74NHwHemPKI6o9KqnZEudN
 GmHL8uLJBbbBA==
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
Subject: [PATCH 4/6] rust: drm: Wrap ioctl dispatch in UnbindGuard
Date: Thu,  7 May 2026 00:06:02 +0200
Message-ID: <20260506221027.858481-5-dakr@kernel.org>
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

Run every ioctl handler inside a drm_dev_enter/exit critical section via
UnbindGuard. If the device has been unplugged, the ioctl returns ENODEV
without calling the handler.

A free-function wrapper is added because the macro context prevents
method resolution from inferring the driver type.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 rust/kernel/drm/device.rs |  7 +++++++
 rust/kernel/drm/ioctl.rs  | 13 +++++++++++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 11edbe6f9f42..0049ea69f716 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -452,6 +452,13 @@ fn drop(&mut self) {
     }
 }
 
+/// Free-function equivalent of [`Device::unbind_guard()`] for use in macro contexts where method
+/// resolution cannot infer the driver type.
+#[doc(hidden)]
+pub fn unbind_guard<T: drm::Driver>(dev: &Device<T, Registered>) -> Option<UnbindGuard<'_, T>> {
+    dev.unbind_guard()
+}
+
 impl<T: drm::Driver, C: DeviceContext> Deref for Device<T, C> {
     type Target = T::Data;
 
diff --git a/rust/kernel/drm/ioctl.rs b/rust/kernel/drm/ioctl.rs
index cf328101dde4..aa72b44f645d 100644
--- a/rust/kernel/drm/ioctl.rs
+++ b/rust/kernel/drm/ioctl.rs
@@ -87,7 +87,10 @@ pub mod internal {
 ///        file: &kernel::drm::File<Self::File>,
 /// ) -> Result<u32>
 /// ```
-/// where `Self` is the drm::drv::Driver implementation these ioctls are being declared within.
+/// where `Self` is the `drm::Driver` implementation these ioctls are being declared within.
+///
+/// The ioctl runs inside a `drm_dev_enter/exit` critical section. If the device has been
+/// unplugged, the ioctl returns `ENODEV` without calling the handler.
 ///
 /// # Examples
 ///
@@ -134,7 +137,13 @@ macro_rules! declare_drm_ioctls {
                             // FIXME: Currently there is nothing enforcing that the types of the
                             // dev/file match the current driver these ioctls are being declared
                             // for, and it's not clear how to enforce this within the type system.
-                            let dev = $crate::drm::device::Device::from_raw(raw_dev);
+                            let dev = unsafe {
+                                $crate::drm::device::Device::from_raw(raw_dev)
+                            };
+                            let _guard = match $crate::drm::device::unbind_guard(dev) {
+                                Some(g) => g,
+                                None => return $crate::error::code::ENODEV.to_errno(),
+                            };
                             // SAFETY: The ioctl argument has size `_IOC_SIZE(cmd)`, which we
                             // asserted above matches the size of this type, and all bit patterns of
                             // UAPI structs must be valid.
-- 
2.54.0

