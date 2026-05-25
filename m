Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DFFCD5BC9
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 20:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A822410E407;
	Mon, 25 May 2026 20:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kB36nmiP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2CF110E407
 for <dri-devel@lists.freedesktop.org>; Mon, 25 May 2026 20:32:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5653260008;
 Mon, 25 May 2026 20:32:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313461F00A3A;
 Mon, 25 May 2026 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779741122;
 bh=cz4y8M1GiwY6FWOeDCyuhnlKEpB7EMBObHZNfzMoKFc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=kB36nmiPeLWjK9MuZYO1n2hhOVi1mahYYeE42W+5vQvO7zNrGoUHFZhxd1AxFPRTY
 yEthQETelTJ/OzNxVRaJ7e80BFACQSImycJoXQYlsHtRqcBu5KAMw+9ufCabc3f7+b
 AlwV97p4vX4lsdIf7ZFlrexP1rr0h2n9SRMrUOKcdAlz8iK9ErbmXmx9yrTUGyJz3C
 6YlR3TxSSuY2TeK7eaQVHo2FA2G+yvbMo+qR3+Y4HGs3PdvEin70Ik/V7Kv008hN0K
 /sxxVcq6Kj2l5RlAedLUjwOaFi1/yHxhUitBTK+P3f796Pjvf5TUYwa0weV6m7BepT
 ifCWNxla4rVNQ==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com,
 pcolberg@redhat.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>
Subject: [PATCH v5 21/24] gpu: nova-core: separate driver type from driver data
Date: Mon, 25 May 2026 22:21:08 +0200
Message-ID: <20260525202921.124698-22-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525202921.124698-1-dakr@kernel.org>
References: <20260525202921.124698-1-dakr@kernel.org>
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

Introduce NovaCoreDriver as the driver type implementing pci::Driver,
keeping NovaCore as the per-device data type. This prepares for making
NovaCore lifetime-parameterized once auxiliary::Registration requires a
lifetime for the binding scope.

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>
Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/driver.rs    | 14 ++++++++------
 drivers/gpu/nova-core/nova_core.rs |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driver.rs
index 7dbec0470c26..fa898fe5c893 100644
--- a/drivers/gpu/nova-core/driver.rs
+++ b/drivers/gpu/nova-core/driver.rs
@@ -35,6 +35,8 @@ pub(crate) struct NovaCore {
     _reg: Devres<auxiliary::Registration<()>>,
 }
 
+pub(crate) struct NovaCoreDriver;
+
 const BAR0_SIZE: usize = SZ_16M;
 
 // For now we only support Ampere which can use up to 47-bit DMA addresses.
@@ -50,7 +52,7 @@ pub(crate) struct NovaCore {
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <NovaCore as pci::Driver>::IdInfo,
+    <NovaCoreDriver as pci::Driver>::IdInfo,
     [
         // Modern NVIDIA GPUs will show up as either VGA or 3D controllers.
         (
@@ -72,15 +74,15 @@ pub(crate) struct NovaCore {
     ]
 );
 
-impl pci::Driver for NovaCore {
+impl pci::Driver for NovaCoreDriver {
     type IdInfo = ();
-    type Data<'bound> = Self;
+    type Data<'bound> = NovaCore;
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
 
     fn probe<'bound>(
         pdev: &'bound pci::Device<Core<'_>>,
         _info: &'bound Self::IdInfo,
-    ) -> impl PinInit<Self, Error> + 'bound {
+    ) -> impl PinInit<NovaCore, Error> + 'bound {
         pin_init::pin_init_scope(move || {
             dev_dbg!(pdev, "Probe Nova Core GPU driver.\n");
 
@@ -98,7 +100,7 @@ fn probe<'bound>(
                 GFP_KERNEL,
             )?;
 
-            Ok(try_pin_init!(Self {
+            Ok(try_pin_init!(NovaCore {
                 gpu <- Gpu::new(pdev, bar.clone(), bar.access(pdev.as_ref())?),
                 _reg: auxiliary::Registration::new(
                     pdev.as_ref(),
@@ -113,7 +115,7 @@ fn probe<'bound>(
         })
     }
 
-    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&Self>) {
+    fn unbind<'bound>(pdev: &'bound pci::Device<Core<'_>>, this: Pin<&NovaCore>) {
         this.gpu.unbind(pdev.as_ref());
     }
 }
diff --git a/drivers/gpu/nova-core/nova_core.rs b/drivers/gpu/nova-core/nova_core.rs
index 04a1fa6b25f8..073d87714d3a 100644
--- a/drivers/gpu/nova-core/nova_core.rs
+++ b/drivers/gpu/nova-core/nova_core.rs
@@ -47,7 +47,7 @@ struct NovaCoreModule {
     // Fields are dropped in declaration order, so `_driver` is dropped first,
     // then `_debugfs_guard` clears `DEBUGFS_ROOT`.
     #[pin]
-    _driver: Registration<pci::Adapter<driver::NovaCore>>,
+    _driver: Registration<pci::Adapter<driver::NovaCoreDriver>>,
     _debugfs_guard: DebugfsRootGuard,
 }
 
-- 
2.54.0

