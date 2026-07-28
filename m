Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9824C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 18:39:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C7CE10E9B9;
	Tue, 28 Jul 2026 18:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="In+vig4v";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2241510E9B9
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 18:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1785263972; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=l8cF46xC8WNLdWAq5UImiTF41Np5X+2kkp1zAICTL01zurI5Y2/Fz7GYINPGorAVMakCoH7eWN1ggjRC8D8AVytFRXPHgeLpDZO4fHJ1MOF88BKhID5aYEol+UDDFWrnzBBykSzmZWpcbHfYEed1PzkP4q+BFCx8Rj70yFRgS0A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1785263972;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=C8L41XL+9w4dA28uTpK5rTYNFopPU7UCuhx9QkmCyJM=; 
 b=F6/EfUA0Z+VuTaAZ8UKJero3thhHp03Lmu2BWvVDzwY0a2Yz+kWaO1EAhjTOx5xngxUErGd7J3rK/giEZvlouAppSNNbw3fen6RNIwDqlTX3HQbe9qXnKo9wDaVANolrXtK4nd2g5ZC7LOenVucphsJ05AZhBKSEFRUi+9/eWhc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1785263972; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=C8L41XL+9w4dA28uTpK5rTYNFopPU7UCuhx9QkmCyJM=;
 b=In+vig4vkiK2nciJKvbh3NJ97PeWKu3VKsyK0/OibV9qxMjbSEirR9VJIYWxCzcP
 sBjCqfftQTESGTVHeX3/EhX/4Kj/eRDsKqMNUsDHwpj7u0JBSy1s9Bdm8I0/UCP6AYA
 KN+YOn+7QreDTXiowEH0wrviWvFZinFLx5ZFLU2w=
Received: by mx.zohomail.com with SMTPS id 1785263971531962.3514704408411;
 Tue, 28 Jul 2026 11:39:31 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Tue, 28 Jul 2026 11:39:23 -0700
Subject: [PATCH v10 1/7] drm/tyr: add resources to RegistrationData
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260728-fw-boot-b4-v10-1-9187aefa3f2f@collabora.com>
References: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
In-Reply-To: <20260728-fw-boot-b4-v10-0-9187aefa3f2f@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, laura.nao@collabora.com, 
 samitolvanen@google.com, lyude@redhat.com, beata.michalska@arm.com, 
 boris.brezillon@collabora.com, steven.price@arm.com, alvin.sun@linux.dev
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=5779;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=3HDTihCPAbJ+G6Sv/2fJzcd+ujn64YTyAfde1Cm3Oog=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFkZ3xO0YzoX+j9M//D8dKxd0fNZP54L8nbGbe1MyJDbF
 uS131iho5SFQYyLQVZMkeWsvVGPeNV7I935/5th5rAygQxh4OIUgInkWjH8s3Re2ni0sV1oqpa7
 UE6/OcO6Vexd5ncSCo2POb2dmKRmxsjQ/dp7+s3FzG8smY4EXPmWE27WYzRjW1WQ2/Ed75S0Dh3
 mBQA=
X-Developer-Key: i=deborah.brouwer@collabora.com; a=openpgp;
 fpr=CD3F328C177AEF322D9FFF8379A829E70C5E7DEB
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

Currently Tyr is not storing any resources in its drm::Driver
RegistrationData.

Move Tyr's device-private resources and gpu information from
drm::Driver::Data to drm::Driver::RegistrationData. This allows Tyr to
access this data safely within the lifetime of its binding to its parent
platform device and while registered with userspace.

Reviewed-by: Daniel Almeida <daniel.almeida@collabora.com>
Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 42 +++++++++++++++++++++---------------------
 drivers/gpu/drm/tyr/file.rs   | 11 ++++++-----
 2 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 8348c6cd3929..728a8388d591 100644
--- a/drivers/gpu/drm/tyr/driver.rs
+++ b/drivers/gpu/drm/tyr/driver.rs
@@ -6,6 +6,7 @@
         OptionalClk, //
     },
     device::{
+        Bound,
         Core,
         Device,
         DeviceContext, //
@@ -27,10 +28,7 @@
     regulator,
     regulator::Regulator,
     sizes::SZ_2M,
-    sync::{
-        aref::ARef,
-        Mutex, //
-    },
+    sync::Mutex,
     time, //
 };
 
@@ -53,13 +51,17 @@
 
 #[pin_data(PinnedDrop)]
 pub(crate) struct TyrPlatformDriverData<'bound> {
-    _device: ARef<TyrDrmDevice>,
     _reg: drm::Registration<'bound, TyrDrmDriver>,
 }
 
+/// Data owned by the DRM [`Registration`].
+///
+/// This data can have references tied to the parent platform device binding scope
+/// and is accessible only while the DRM device is registered with userspace.
 #[pin_data]
-pub(crate) struct TyrDrmDeviceData {
-    pub(crate) pdev: ARef<platform::Device>,
+pub(crate) struct TyrDrmRegistrationData<'drm> {
+    /// Parent platform device.
+    pub(crate) pdev: &'drm platform::Device<Bound>,
 
     #[pin]
     clks: Mutex<Clocks>,
@@ -67,9 +69,10 @@ pub(crate) struct TyrDrmDeviceData {
     #[pin]
     regulators: Mutex<Regulators>,
 
-    /// Some information on the GPU.
-    ///
-    /// This is mainly queried by userspace, i.e.: Mesa.
+    /// GPU MMIO register mapping.
+    pub(crate) iomem: IoMem<'drm>,
+
+    /// GPU information read from hardware during probe.
     pub(crate) gpu_info: GpuInfo,
 }
 
@@ -134,10 +137,10 @@ fn probe<'bound>(
         // other threads of execution.
         unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
 
-        let platform: ARef<platform::Device> = pdev.into();
+        let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, Ok(()))?;
 
-        let data = try_pin_init!(TyrDrmDeviceData {
-                pdev: platform.clone(),
+        let reg_data = try_pin_init!(TyrDrmRegistrationData {
+                pdev,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
@@ -147,18 +150,15 @@ fn probe<'bound>(
                     _mali: mali_regulator,
                     _sram: sram_regulator,
                 }),
+                iomem,
                 gpu_info,
         });
 
-        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
         // SAFETY: `reg` is stored in `TyrPlatformDriverData` and dropped when the driver is
         // unbound; it is never forgotten.
-        let reg = unsafe { drm::Registration::new(pdev.as_ref(), tdev, (), 0)? };
+        let reg = unsafe { drm::Registration::new(pdev.as_ref(), unreg_dev, reg_data, 0)? };
 
-        let driver = TyrPlatformDriverData {
-            _device: reg.device().into(),
-            _reg: reg,
-        };
+        let driver = TyrPlatformDriverData { _reg: reg };
 
         // We need this to be dev_info!() because dev_dbg!() does not work at
         // all in Rust for now, and we need to see whether probe succeeded.
@@ -184,8 +184,8 @@ fn drop(self: Pin<&mut Self>) {}
 
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
-    type Data = TyrDrmDeviceData;
-    type RegistrationData<'a> = ();
+    type Data = ();
+    type RegistrationData<'drm> = TyrDrmRegistrationData<'drm>;
     type File = TyrDrmFileData;
     type Object = drm::gem::shmem::Object<BoData>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index b686041d5d6b..9f60a90d4948 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -12,7 +12,8 @@
 
 use crate::driver::{
     TyrDrmDevice,
-    TyrDrmDriver, //
+    TyrDrmDriver,
+    TyrDrmRegistrationData, //
 };
 
 #[pin_data]
@@ -31,15 +32,15 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
-        ddev: &TyrDrmDevice<Registered>,
-        _reg_data: &(),
+        _ddev: &TyrDrmDevice<Registered>,
+        reg_data: &TyrDrmRegistrationData<'_>,
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {
         if devquery.pointer == 0 {
             match devquery.type_ {
                 uapi::drm_panthor_dev_query_type_DRM_PANTHOR_DEV_QUERY_GPU_INFO => {
-                    devquery.size = core::mem::size_of_val(&ddev.gpu_info) as u32;
+                    devquery.size = core::mem::size_of_val(&reg_data.gpu_info) as u32;
                     Ok(0)
                 }
                 _ => Err(EINVAL),
@@ -53,7 +54,7 @@ pub(crate) fn dev_query(
                     )
                     .writer();
 
-                    writer.write(&ddev.gpu_info)?;
+                    writer.write(&reg_data.gpu_info)?;
 
                     Ok(0)
                 }

-- 
2.55.0

