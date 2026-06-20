Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7F90CD98FA
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 00:59:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 093CD10E149;
	Sat, 20 Jun 2026 00:59:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="D2IZOFgm";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E446410E149
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 00:59:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 696A5601F8;
 Sat, 20 Jun 2026 00:59:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 335441F00A3A;
 Sat, 20 Jun 2026 00:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781917154;
 bh=mNiEcu5XWNVyEyIaUUq1tJDCgK3b18j4JyJuq9z1Krk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=D2IZOFgmGYVBfy3ukCfCp9cyJcMtLAWv3ZVJzu+me/PLW5QRTWanlBp/T02VMrwH0
 KTZ2WLSJ83o2HrQnOhg9Tadf4sUJOWIISSYHBqB32v9muFaBrjBWhJalmvWscr9awQ
 Plkkz+l8L5Gt5DTwyM/jvMSqRgcj9dxDapfzkjMBCgK5daHy6jWh1+MRbru2tqQmfO
 QH7mP7NhDlUDyYUnhm7jbBuY+Y3NWDjfjjVJk6tewfdHuinbiTKnYIgwf1po35lKCZ
 pYYJJceHuUL788afc0XPPwRhZytH+6C88qGzhqqLmqnGFffODddYvzE4QwmYBKOs6X
 fNKE7LARnPh+Q==
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
Subject: [PATCH v3 03/13] rust: drm: change default DeviceContext to Normal
Date: Sat, 20 Jun 2026 02:51:15 +0200
Message-ID: <20260620005431.1562115-4-dakr@kernel.org>
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

Change the default DeviceContext from Registered to Normal for
drm::Device, gem::Object, gem::shmem::Object and
gem::shmem::ObjectConfig.

Normal is the general-purpose, reference-counted context suitable for
most uses; Registered represents a device that was registered with
userspace and will become a non-owning context obtained through a
RegistrationGuard.

Update the create_handle/lookup_handle bounds from Object<Registered> to
Object<Normal> to match the new default context of GEM objects, and
update the driver device type aliases (NovaDevice, TyrDrmDevice) to
default to Normal.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 2 +-
 drivers/gpu/drm/tyr/driver.rs  | 2 +-
 rust/kernel/drm/device.rs      | 2 +-
 rust/kernel/drm/gem/mod.rs     | 7 ++++---
 rust/kernel/drm/gem/shmem.rs   | 6 +++---
 5 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index c5b0313006bd..8ddb81fd0c87 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -26,7 +26,7 @@ pub(crate) struct Nova {
 }
 
 /// Convienence type alias for the DRM device type for this driver
-pub(crate) type NovaDevice<Ctx = drm::Registered> = drm::Device<NovaDriver, Ctx>;
+pub(crate) type NovaDevice<Ctx = drm::Normal> = drm::Device<NovaDriver, Ctx>;
 
 #[pin_data]
 pub(crate) struct NovaData {
diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 338c25ccc151..180631daff02 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -47,7 +47,7 @@
 pub(crate) struct TyrDrmDriver;
 
 /// Convenience type alias for the DRM device type for this driver.
-pub(crate) type TyrDrmDevice<Ctx = drm::Registered> = drm::Device<TyrDrmDriver, Ctx>;
+pub(crate) type TyrDrmDevice<Ctx = drm::Normal> = drm::Device<TyrDrmDriver, Ctx>;
 
 pub(crate) struct TyrPlatformDriver;
 
diff --git a/rust/kernel/drm/device.rs b/rust/kernel/drm/device.rs
index 23eb4c0a65ef..d712387707d2 100644
--- a/rust/kernel/drm/device.rs
+++ b/rust/kernel/drm/device.rs
@@ -246,7 +246,7 @@ pub fn new(
 /// * The data layout of `Self` remains the same across all implementations of `C`.
 /// * Any invariants for `C` also apply.
 #[repr(C)]
-pub struct Device<T: drm::Driver, C: DeviceContext = Registered> {
+pub struct Device<T: drm::Driver, C: DeviceContext = Normal> {
     dev: Opaque<bindings::drm_device>,
     data: T::Data,
     _ctx: PhantomData<C>,
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index c8b66d816871..1023ddccd785 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -10,6 +10,7 @@
         self,
         device::{
             DeviceContext,
+            Normal,
             Registered, //
         },
         driver::{
@@ -183,7 +184,7 @@ fn size(&self) -> usize {
     fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object<Registered> = Self, File = F>,
+        D: drm::Driver<Object<Normal> = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
         let mut handle: u32 = 0;
@@ -198,7 +199,7 @@ fn create_handle<D, F>(&self, file: &drm::File<F>) -> Result<u32>
     fn lookup_handle<D, F>(file: &drm::File<F>, handle: u32) -> Result<ARef<Self>>
     where
         Self: AllocImpl<Driver = D>,
-        D: drm::Driver<Object<Registered> = Self, File = F>,
+        D: drm::Driver<Object<Normal> = Self, File = F>,
         F: drm::file::DriverFile<Driver = D>,
     {
         // SAFETY: The arguments are all valid per the type invariants.
@@ -254,7 +255,7 @@ impl<T: IntoGEMObject> BaseObjectPrivate for T {}
 /// * Any type invariants of `Ctx` apply to the parent DRM device for this GEM object.
 #[repr(C)]
 #[pin_data]
-pub struct Object<T: DriverObject + Send + Sync, Ctx: DeviceContext = Registered> {
+pub struct Object<T: DriverObject + Send + Sync, Ctx: DeviceContext = Normal> {
     obj: Opaque<bindings::drm_gem_object>,
     #[pin]
     data: T,
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index 34af402899a0..f47a90cdb95b 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -17,7 +17,7 @@
         private::Sealed,
         Device,
         DeviceContext,
-        Registered, //
+        Normal, //
     },
     error::to_result,
     prelude::*,
@@ -43,7 +43,7 @@
 /// This is used with [`Object::new()`] to control various properties that can only be set when
 /// initially creating a shmem-backed GEM object.
 #[derive(Default)]
-pub struct ObjectConfig<'a, T: DriverObject, C: DeviceContext = Registered> {
+pub struct ObjectConfig<'a, T: DriverObject, C: DeviceContext = Normal> {
     /// Whether to set the write-combine map flag.
     pub map_wc: bool,
 
@@ -62,7 +62,7 @@ pub struct ObjectConfig<'a, T: DriverObject, C: DeviceContext = Registered> {
 /// - Any type invariants of `C` apply to the parent DRM device for this GEM object.
 #[repr(C)]
 #[pin_data]
-pub struct Object<T: DriverObject, C: DeviceContext = Registered> {
+pub struct Object<T: DriverObject, C: DeviceContext = Normal> {
     #[pin]
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
-- 
2.54.0

