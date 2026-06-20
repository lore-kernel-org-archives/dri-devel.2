Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32C76CD98E4
	for <dri-devel@archiver.kernel.org>; Sat, 20 Jun 2026 18:50:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96DC110E262;
	Sat, 20 Jun 2026 18:50:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MnCPJi6j";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CDB510E26A
 for <dri-devel@lists.freedesktop.org>; Sat, 20 Jun 2026 18:50:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 01EEF601E3;
 Sat, 20 Jun 2026 18:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC9E1F000E9;
 Sat, 20 Jun 2026 18:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781981448;
 bh=0uIMdj24RIqH/QbXlggEkKnv+8TDDu+JVkTsWI9K8zk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=MnCPJi6jdKJM2p+Ap9kjp1QnEccAcEjNnimiaIh0DQdNI81T6YLhCdhB5H//GhR2V
 0/gMlXoZbphDXc+Ib9Tmoc5l06ETEpGCaDItRxp1XvaPCdjmr3DqXqf6GIqL4EQpxf
 5qGJbRbrKIBs1MnC1nr4j+folc2xOxq4iXtjf+OfwARgUktyGdjWEZMf33gLK4+9IG
 ToxbjHG24UqioDmmSO1fCDlszZ9rB3NuKFi9xZs3PKpJomF4kkE0Vf6NZReLxEp/Mb
 x3I/eL5fLlRAR1W03O7YqDuCZQplgbCtKCd3Y2gjO85LOE8zaVaYYpFRxkRosFz1Nh
 kNKDmDVf+lK+g==
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
Subject: [PATCH v4 16/16] drm: nova: Use drm::Device<Registered> to access the
 parent bus device
Date: Sat, 20 Jun 2026 20:48:09 +0200
Message-ID: <20260620184924.2247517-17-dakr@kernel.org>
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

The get_param ioctl needs access to the parent auxiliary device. Since
ioctl handlers run inside a RegistrationGuard, accept
&NovaDevice<Registered> to obtain &auxiliary::Device<Bound> via as_ref()
directly. This removes the need for drm::Device data, hence set it to
().

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/drm/nova/driver.rs | 11 ++---------
 drivers/gpu/drm/nova/file.rs   |  7 ++++---
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/nova/driver.rs b/drivers/gpu/drm/nova/driver.rs
index 131212df94d3..81df8158d83b 100644
--- a/drivers/gpu/drm/nova/driver.rs
+++ b/drivers/gpu/drm/nova/driver.rs
@@ -30,11 +30,6 @@ pub(crate) struct Nova<'bound> {
 /// Convienence type alias for the DRM device type for this driver
 pub(crate) type NovaDevice<Ctx = drm::Normal> = drm::Device<NovaDriver, Ctx>;
 
-#[pin_data]
-pub(crate) struct NovaData {
-    pub(crate) adev: ARef<auxiliary::Device>,
-}
-
 const INFO: drm::DriverInfo = drm::DriverInfo {
     major: 0,
     minor: 0,
@@ -65,9 +60,7 @@ fn probe<'bound>(
         adev: &'bound auxiliary::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self::Data<'bound>, Error> + 'bound {
-        let data = try_pin_init!(NovaData { adev: adev.into() });
-
-        let drm = drm::UnregisteredDevice::<Self>::new(adev, data)?;
+        let drm = drm::UnregisteredDevice::<Self>::new(adev, Ok(()))?;
         // SAFETY: `reg` is stored in `Nova` and dropped when the driver is unbound; it is
         // never forgotten.
         let reg = unsafe { drm::Registration::new(adev.as_ref(), drm, (), 0)? };
@@ -81,7 +74,7 @@ fn probe<'bound>(
 
 #[vtable]
 impl drm::Driver for NovaDriver {
-    type Data = NovaData;
+    type Data = ();
     type RegistrationData = ForLt!(());
     type File = File;
     type Object = gem::Object<NovaObject>;
diff --git a/drivers/gpu/drm/nova/file.rs b/drivers/gpu/drm/nova/file.rs
index 208be4e38188..298c02bacb4b 100644
--- a/drivers/gpu/drm/nova/file.rs
+++ b/drivers/gpu/drm/nova/file.rs
@@ -4,6 +4,8 @@
 use crate::gem::NovaObject;
 use kernel::{
     alloc::flags::*,
+    auxiliary,
+    device::Bound,
     drm::{
         self,
         gem::BaseObject,
@@ -32,9 +34,8 @@ pub(crate) fn get_param(
         getparam: &mut uapi::drm_nova_getparam,
         _file: &drm::File<File>,
     ) -> Result<u32> {
-        let adev = &dev.adev;
-        let parent = adev.parent();
-        let pdev: &pci::Device = parent.try_into()?;
+        let adev: &auxiliary::Device<Bound> = dev.as_ref();
+        let pdev: &pci::Device<Bound> = adev.parent().try_into()?;
 
         let value = match getparam.param as u32 {
             uapi::NOVA_GETPARAM_VRAM_BAR_SIZE => pdev.resource_len(1)?,
-- 
2.54.0

