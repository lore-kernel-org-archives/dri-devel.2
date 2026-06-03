Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B593BCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:28:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C46113BC6;
	Wed,  3 Jun 2026 01:28:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RaMoqAwd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90002113BC6
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:28:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7735D432C1;
 Wed,  3 Jun 2026 01:28:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4AD1F00898;
 Wed,  3 Jun 2026 01:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780450107;
 bh=/Uzv2Gm7jENTbbTq3bRLEhLW5ARZCqwdxuR6ti+4xL8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=RaMoqAwdveFJ4vYzNN1wBZroIwEH6ImX18p4Inr8AyFxK0RPPqwkpRdgls9kTn7h0
 2d89Ohk9QIPYsPqQ6ua6h3hxZC7umNU6EFLAnZDJDKQOzRIo1l/tVQD/j++Tm2HEsK
 3RBkSO5Xk3RGob6+Iivcos6RJmYVD9qhFhRnyCHTbxPKvf9xYVL2qM4IKz9/o3XSX2
 ZeVxmY5/JK/O5UvKMh/9oVCTbYRfr107hzX/iPJzwvUzYYQiQE06HKbxME0C5Xh8Eg
 vKcpklwLFfsA9Ges+q8PJApcTcsi2M7ka4iBAobvyR6OMRMKmfeSJ0lJ/nkYkvlsHK
 XDPS4b5HY4FcA==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, aliceryhl@google.com, daniel.almeida@collabora.com,
 acourbot@nvidia.com, ecourtney@nvidia.com, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, tmgross@umich.edu,
 deborah.brouwer@collabora.com, boris.brezillon@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH v2 7/7] drm: nova: convert to use DRM registration data
Date: Wed,  3 Jun 2026 03:15:49 +0200
Message-ID: <20260603011711.2077361-8-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603011711.2077361-1-dakr@kernel.org>
References: <20260603011711.2077361-1-dakr@kernel.org>
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

Move the auxiliary device reference from drm::Device data into
RegistrationData, replacing the ARef<auxiliary::Device> with a borrowed
&'bound auxiliary::Device<Bound>. This makes the data lifetime-aware and
exercises the registration data path through the ioctl handlers.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 20 ++++++++++----------
 drivers/gpu/drm/nova/file.rs   | 19 +++++++++++--------
 2 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 4267e6e6dbb4..f46d7ff6fee3 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -3,6 +3,7 @@
 use kernel::{
     auxiliary,
     device::{
+        Bound,
         Core,
         DeviceContext, //
     },
@@ -13,7 +14,7 @@
     },
     prelude::*,
     sync::aref::ARef,
-    types::ForLt, //
+    types::CovariantForLt, //
 };
 
 use crate::file::File;
@@ -30,9 +31,8 @@ pub(crate) struct Nova<'bound> {
 /// Convienence type alias for the DRM device type for this driver
 pub(crate) type NovaDevice<Ctx = drm::Registered> = drm::Device<NovaDriver, Ctx>;
 
-#[pin_data]
-pub(crate) struct NovaData {
-    pub(crate) adev: ARef<auxiliary::Device>,
+pub(crate) struct NovaData<'bound> {
+    pub(crate) adev: &'bound auxiliary::Device<Bound>,
 }
 
 const INFO: drm::DriverInfo = drm::DriverInfo {
@@ -65,10 +65,10 @@ fn probe<'bound>(
         adev: &'bound auxiliary::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        let data = try_pin_init!(NovaData { adev: adev.into() });
-
-        let drm = drm::UnregisteredDevice::<Self>::new(adev, data)?;
-        let reg = drm::Registration::new(adev.as_ref(), drm, (), 0)?;
+        let drm = drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
+        let reg_data = NovaData { adev };
+        // SAFETY: We never bypass the destructor of `reg`.
+        let reg = unsafe { drm::Registration::new_with_lt(adev.as_ref(), drm, reg_data, 0)? };
 
         Ok(Nova {
             drm: reg.device().into(),
@@ -79,8 +79,8 @@ fn probe<'bound>(
 
 #[vtable]
 impl drm::Driver for NovaDriver {
-    type Data = NovaData;
-    type RegistrationData = ForLt!(());
+    type Data = ();
+    type RegistrationData = CovariantForLt!(NovaData<'_>);
     type File = File;
     type Object<Ctx: drm::DeviceContext> = gem::Object<NovaObject, Ctx>;
     type ParentDevice<Ctx: DeviceContext> = auxiliary::Device<Ctx>;
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index df9760947d58..cd6c37b01e22 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -1,6 +1,10 @@
 // SPDX-License-Identifier: GPL-2.0
 
-use crate::driver::{NovaDevice, NovaDriver};
+use crate::driver::{
+    NovaData,
+    NovaDevice,
+    NovaDriver, //
+};
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
@@ -25,15 +29,14 @@ fn open(_dev: &NovaDevice) -> Result<Pin<KBox<Self>>> {
 impl File {
     /// IOCTL: get_param: Query GPU / driver metadata.
     pub(crate) fn get_param(
-        dev: &NovaDevice,
+        _dev: &NovaDevice,
         _adev: &auxiliary::Device<Bound>,
-        _reg_data: &(),
+        reg_data: &NovaData<'_>,
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
-        let adev = &dev.adev;
-        let parent = adev.parent();
-        let pdev: &pci::Device = parent.try_into()?;
+        let parent = reg_data.adev.parent();
+        let pdev: &pci::Device<Bound> = parent.try_into()?;
 
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
@@ -49,7 +52,7 @@ pub(crate) fn get_param(
     pub(crate) fn gem_create(
         dev: &NovaDevice,
         _adev: &auxiliary::Device<Bound>,
-        _reg_data: &(),
+        _reg_data: &NovaData<'_>,
         req: &mut uapi::drm_nova_gem_create,
         file: &drm::File<File>,
     ) -> Result<u32> {
@@ -64,7 +67,7 @@ pub(crate) fn gem_create(
     pub(crate) fn gem_info(
         _dev: &NovaDevice,
         _adev: &auxiliary::Device<Bound>,
-        _reg_data: &(),
+        _reg_data: &NovaData<'_>,
         req: &mut uapi::drm_nova_gem_info,
         file: &drm::File<File>,
     ) -> Result<u32> {
-- 
2.54.0

