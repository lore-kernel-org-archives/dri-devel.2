Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A750C44503
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 00:47:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 765F210F330;
	Thu,  9 Jul 2026 00:47:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=collabora.com header.i=deborah.brouwer@collabora.com header.b="Sf3ONKxk";
	dkim-atps=neutral
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com
 [136.143.188.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5929D10E4F3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 00:47:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783558051; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=VDYMd9XNgR3w6Px0J/yt8jirJ9kC9gylOAjKcayQGmUKva/yykQONi8VweQY3HjG+gN14+yKk2JLhTPEjwrt83U4+dmZIZoK1LbVLsfZ2q+iUNkvX/Q6koKePAHD2XS2W+HR1erVlgzGXzytYZrejtOqWpsVRCJgKYXRjJLHTWs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1783558051;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=IanYi/nNoUFNzSvTX02sn7aORfT3WtzfHkwI4OaGl6o=; 
 b=O2G9fZypqutA8CjmTipKyEVulZpu97QVuTpQjpEydnR27aFzVRU9rFCwBnfNMj5s7HroL488KQUbJorDfibhS99jU8n0hlZ/ZrCqlqLKHyLbGK+wH+oQSvDyG2w7ys12y6nkXd+ac0wsTLDz2Ch4h+/N49mDRWURZSV3IR6DAg4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=deborah.brouwer@collabora.com;
 dmarc=pass header.from=<deborah.brouwer@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1783558051; 
 s=zohomail; d=collabora.com; i=deborah.brouwer@collabora.com; 
 h=From:From:Date:Date:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Message-Id:References:In-Reply-To:To:To:Cc:Cc:Reply-To;
 bh=IanYi/nNoUFNzSvTX02sn7aORfT3WtzfHkwI4OaGl6o=;
 b=Sf3ONKxkF+EbMBE0MD/fbT8tJ4j1JQsbwNbVQiMvLf7HepXRHBmjK0IiFtLmk94C
 KCpuzZUeC0WXrsxKqRJa26V/btM+CUKNaMExB1BYGGoWl2NTY/UtCf2BJYFb1I6vfpL
 2XM5KkGo7D7DIW6Z9JcbFPfCBjDJPnLAVEKpCiRc=
Received: by mx.zohomail.com with SMTPS id 1783558049501338.52042341409697;
 Wed, 8 Jul 2026 17:47:29 -0700 (PDT)
From: Deborah Brouwer <deborah.brouwer@collabora.com>
Date: Wed, 08 Jul 2026 17:47:07 -0700
Subject: [PATCH v5 1/7] drm/tyr: add resources to RegistrationData
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-fw-boot-b4-v5-1-7792ab68e359@collabora.com>
References: <20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com>
In-Reply-To: <20260708-fw-boot-b4-v5-0-7792ab68e359@collabora.com>
To: Daniel Almeida <daniel.almeida@collabora.com>, 
 Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Benno Lossin <lossin@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, 
 Deborah Brouwer <deborah.brouwer@collabora.com>, 
 boris.brezillon@collabora.com, work@onurozkan.dev, samitolvanen@google.com, 
 steven.price@arm.com, laura.nao@collabora.com, alvin.sun@linux.dev, 
 beata.michalska@arm.com, acourbot@nvidia.com, lyude@redhat.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4780;
 i=deborah.brouwer@collabora.com; h=from:subject:message-id;
 bh=W60+jWwQgSDWG1mg1BeFeMEXJtzbD9TahmOIfMNB2Vk=;
 b=owGbwMvMwCVWuULzOU9c7WvG02pJDFl+7+f/Mer9x+E1+d/yXiv7xXseVKb7MkxcuFJTKv1f7
 5al2euqO0pZGMS4GGTFFFnO2hv1iFe9N9Kd/78ZZg4rE8gQBi5OAZjIv5sM/907t/UKrX7O9Wum
 j/4U84+r5+e8/bGX73uU50P5BcGSP64wMvTZGe2V9LpicPHQkuDwZwwrFkmvuihfudpNxYmNRbc
 4ix0A
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

Move Tyr's parent platform device, clocks, regulators, and MMIO mapping to
its RegistrationData. This allows Tyr to access these resources with
lifetime awareness while the DRM device is registered with userspace.

Signed-off-by: Deborah Brouwer <deborah.brouwer@collabora.com>
---
 drivers/gpu/drm/tyr/driver.rs | 38 ++++++++++++++++++++++++++------------
 drivers/gpu/drm/tyr/file.rs   |  5 +++--
 2 files changed, 29 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/tyr/driver.rs b/drivers/gpu/drm/tyr/driver.rs
index 8348c6cd3929..2d2a44c19b6d 100644
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
@@ -57,9 +58,24 @@ pub(crate) struct TyrPlatformDriverData<'bound> {
     _reg: drm::Registration<'bound, TyrDrmDriver>,
 }
 
+/// Data owned by the DRM [`Device`].
+///
+/// This data is stored in the DRM device itself and is not tied to the DRM
+/// registration or parent platform device binding lifetime.
 #[pin_data]
 pub(crate) struct TyrDrmDeviceData {
-    pub(crate) pdev: ARef<platform::Device>,
+    /// GPU information read from hardware during probe.
+    pub(crate) gpu_info: GpuInfo,
+}
+
+/// Data owned by the DRM [`Registration`].
+///
+/// This data can have references tied to the parent platform device binding scope
+/// and is accessible only while the DRM device is registered with userspace.
+#[pin_data]
+pub(crate) struct TyrDrmRegistrationData<'bound> {
+    /// Parent platform device.
+    pub(crate) pdev: &'bound platform::Device<Bound>,
 
     #[pin]
     clks: Mutex<Clocks>,
@@ -67,10 +83,8 @@ pub(crate) struct TyrDrmDeviceData {
     #[pin]
     regulators: Mutex<Regulators>,
 
-    /// Some information on the GPU.
-    ///
-    /// This is mainly queried by userspace, i.e.: Mesa.
-    pub(crate) gpu_info: GpuInfo,
+    /// GPU MMIO register mapping.
+    pub(crate) iomem: IoMem<'bound>,
 }
 
 fn issue_soft_reset(dev: &Device, iomem: &IoMem<'_>) -> Result {
@@ -134,10 +148,11 @@ fn probe<'bound>(
         // other threads of execution.
         unsafe { pdev.dma_set_mask_and_coherent(DmaMask::try_new(pa_bits)?)? };
 
-        let platform: ARef<platform::Device> = pdev.into();
+        let drm_data = try_pin_init!(TyrDrmDeviceData { gpu_info });
+        let unreg_dev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, drm_data)?;
 
-        let data = try_pin_init!(TyrDrmDeviceData {
-                pdev: platform.clone(),
+        let reg_data = try_pin_init!(TyrDrmRegistrationData {
+                pdev,
                 clks <- new_mutex!(Clocks {
                     core: core_clk,
                     stacks: stacks_clk,
@@ -147,13 +162,12 @@ fn probe<'bound>(
                     _mali: mali_regulator,
                     _sram: sram_regulator,
                 }),
-                gpu_info,
+                iomem,
         });
 
-        let tdev = drm::UnregisteredDevice::<TyrDrmDriver>::new(pdev, data)?;
         // SAFETY: `reg` is stored in `TyrPlatformDriverData` and dropped when the driver is
         // unbound; it is never forgotten.
-        let reg = unsafe { drm::Registration::new(pdev.as_ref(), tdev, (), 0)? };
+        let reg = unsafe { drm::Registration::new(pdev.as_ref(), unreg_dev, reg_data, 0)? };
 
         let driver = TyrPlatformDriverData {
             _device: reg.device().into(),
@@ -185,7 +199,7 @@ fn drop(self: Pin<&mut Self>) {}
 #[vtable]
 impl drm::Driver for TyrDrmDriver {
     type Data = TyrDrmDeviceData;
-    type RegistrationData<'a> = ();
+    type RegistrationData<'bound> = TyrDrmRegistrationData<'bound>;
     type File = TyrDrmFileData;
     type Object = drm::gem::shmem::Object<BoData>;
     type ParentDevice<Ctx: DeviceContext> = platform::Device<Ctx>;
diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index b686041d5d6b..72c32e524be9 100644
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
@@ -32,7 +33,7 @@ fn open(_dev: &drm::Device<Self::Driver>) -> Result<Pin<KBox<Self>>> {
 impl TyrDrmFileData {
     pub(crate) fn dev_query(
         ddev: &TyrDrmDevice<Registered>,
-        _reg_data: &(),
+        _reg_data: &TyrDrmRegistrationData<'_>,
         devquery: &mut uapi::drm_panthor_dev_query,
         _file: &TyrDrmFile,
     ) -> Result<u32> {

-- 
2.54.0

