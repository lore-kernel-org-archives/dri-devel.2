Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33E1CCD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 22:10:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93C9910EEDE;
	Wed,  6 May 2026 22:10:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jW4NqOd2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDCE110EEDE
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 22:10:43 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id ED7DD61141;
 Wed,  6 May 2026 22:10:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71481C2BCF6;
 Wed,  6 May 2026 22:10:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778105442;
 bh=bALF/IYTJIqtzlU1XsvpEU8iNO0MoFwZPtOvka/AV1Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jW4NqOd2ITWs7bcupuc+pcnamlrDh/tUSYzAO/vw0oaffZIMZh6Lxo4Ugu/dqCJnA
 6Ix3aue/N93hwT8uISFOOvVwnDM41rkJ51fk505IIW4MhbQ0rf0pXX32LWXkqGTgBL
 WkkmNHy2PcOd0FM8akF+6vYeqY0a0DR2mii7yjKWArOi9Ei5E8BQ8lkI8auOnvHASP
 b+6jbO2oafL2KgedAFwkIvldI3+SClMKgdWE8L9jPWFXQLp1caJK0bWbQqvtTOWFgu
 /j8MOi8+nXg3CzDnEVbQgrDFyPaprKKuDWHtr2+I9Mesc0JV6vaecSk5CzXeeGPQ6x
 mSe+k2BkP2h1A==
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
Subject: [PATCH 1/6] rust: drm: Add Driver::ParentDevice associated type
Date: Thu,  7 May 2026 00:05:59 +0200
Message-ID: <20260506221027.858481-2-dakr@kernel.org>
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

Add a ParentDevice associated type to the Driver trait, allowing each
DRM driver to declare its parent bus device type (e.g.
auxiliary::Device, platform::Device).

Change UnregisteredDevice::new() to take &T::ParentDevice<Bound>,
ensuring at the type level that the DRM device's parent matches the
declared bus device type.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 8 ++++++--
 drivers/gpu/drm/tyr/driver.rs  | 6 ++++--
 rust/kernel/drm/device.rs      | 7 +++++--
 rust/kernel/drm/driver.rs      | 3 +++
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 9eef28b506bb..9d4100f01ea7 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -2,7 +2,10 @@
 
 use kernel::{
     auxiliary,
-    device::Core,
+    device::{
+        Core,
+        DeviceContext, //
+    },
     drm::{
         self,
         gem,
@@ -59,7 +62,7 @@ fn probe(
     ) -> impl PinInit<Self, Error> + 'bound {
         let data = try_pin_init!(NovaData { adev: adev.into() });
 
-        let drm = drm::UnregisteredDevice::<Self>::new(adev.as_ref(), data)?;
+        let drm = drm::UnregisteredDevice::<Self>::new(adev, data)?;
         let drm = drm::Registration::new_foreign_owned(drm, adev.as_ref(), 0)?;
 
         Ok(Self { drm: drm.into() })
@@ -71,6 +74,7 @@ impl drm::Driver for NovaDriver {
     type Data = NovaData;
     type File = File;
     type Object<Ctx: drm::DeviceContext> = gem::Object<NovaObject, Ctx>;
+    type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
 
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 2743178af325..747745d23f31 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -8,7 +8,8 @@
     device::{
         Bound,
         Core,
-        Device, //
+        Device,
+        DeviceContext, //
     },
     drm,
     drm::ioctl,
@@ -131,7 +132,7 @@ fn probe(
                 gpu_info,
         });
 
-        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev.as_ref(), data)?;
+        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
         let tdev = drm::driver::Registration::new_foreign_owned(tdev, pdev.as_ref(), 0)?;
 
         let driver = TyrPlatformDriverData {
@@ -176,6 +177,7 @@ impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
     type File = TyrDrmFileData;
     type Object<R: drm::DeviceContext> = drm::gem::Object<TyrObject, R>;
+    type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
 
     const INFO: drm::DriverInfo = INFO;
 
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index d91f19dcc375..492c2f2c7ca4 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -197,7 +197,10 @@ impl<T: drm::Driver> UnregisteredDevice<T> {
     /// Create a new `UnregisteredDevice` for a `drm::Driver`.
     ///
     /// This can be used to create a [`Registration`](kernel::drm::Registration).
-    pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<Self> {
+    pub fn new(
+        dev: &T::ParentDevice<device::Bound>,
+        data: impl PinInit<T::Data, Error>,
+    ) -> Result<Self> {
         // `__drm_dev_alloc` uses `kmalloc()` to allocate memory, hence ensure a `kmalloc()`
         // compatible `Layout`.
         let layout = Kmalloc::aligned_layout(Layout::new::<Device<T, Uninit>>());
@@ -207,7 +210,7 @@ pub fn new(dev: &device::Device, data: impl PinInit<T::Data, Error>) -> Result<S
         // - `dev` is valid by its type invarants,
         let raw_drm: *mut Device<T, Uninit> = unsafe {
             bindings::__drm_dev_alloc(
-                dev.as_raw(),
+                dev.as_ref().as_raw(),
                 &Self::VTABLE,
                 layout.size(),
                 mem::offset_of!(Device<T, Uninit>, dev),
diff --git a/rust/kernel/drm/driver.rs b/rust/kernel/drm/driver.rs
index 294e17af86a3..9d06f8c5b2da 100644
--- a/rust/kernel/drm/driver.rs
+++ b/rust/kernel/drm/driver.rs
@@ -114,6 +114,9 @@ pub trait Driver {
     /// The type used to represent a DRM File (client)
     type File: drm::file::DriverFile;
 
+    /// The bus device type of the parent device that the DRM device is associated with.
+    type ParentDevice<Ctx: device::DeviceContext>: device::AsBusDevice<Ctx>;
+
     /// Driver metadata
     const INFO: DriverInfo;
 
-- 
2.54.0

