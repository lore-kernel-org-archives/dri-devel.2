Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FA53CD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 21:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6AAE810EED1;
	Wed,  6 May 2026 21:53:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jNmvh8hJ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE80B10EED1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 21:53:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C607B4436E;
 Wed,  6 May 2026 21:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651ECC2BCF5;
 Wed,  6 May 2026 21:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778104409;
 bh=eNzpTvhmzibrNZ7+pOvewsfEGIExrdgY3tVgUF7aVt8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=jNmvh8hJd5VlZAfnTNiW15wW4oU4VlOju5HNc1H30/6+ngs78wFHVCXuvg0uftl3Q
 tWv9P70WoJ4VPB4OPRe0KOjdk3mkzHbLkYnsF+ML3cpz7T79ZMQVl/3oYHPJ9sYh/c
 //mrsPGVehfUfqB7Z4eAejw1IvzY0nkA84AeHj0gSk46PdtaycobJUoBq9B8jSNOhN
 ainGZY8s0C9ZcVOm95b0SDMchtikZMoGrM4w3i9WFPnlSjFf9gOJdKd3AzjO3B81wp
 G6GFUXQSBlICG4nPULdgnvtBFTurNO3YrpTtyf5PvolaLZeDyuRVR9zw9j313quem3
 Nq87CLxxFtp2A==
From: Danilo Krummrich <dakr@kernel.org>
To: gregkh@linuxfoundation.org, rafael@kernel.org, acourbot@nvidia.com,
 aliceryhl@google.com, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, viresh.kumar@linaro.org, m.wilczynski@samsung.com,
 ukleinek@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 abdiel.janulgue@gmail.com, robin.murphy@arm.com, markus.probst@posteo.de,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 tmgross@umich.edu, igor.korotin@linux.dev, daniel.almeida@collabora.com
Cc: driver-core@lists.linux.dev, linux-kernel@vger.kernel.org,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-pm@vger.kernel.org, linux-pwm@vger.kernel.org,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH v2 19/25] samples: rust: rust_driver_pci: use HRT lifetime for
 Bar
Date: Wed,  6 May 2026 23:50:55 +0200
Message-ID: <20260506215113.851360-20-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506215113.851360-1-dakr@kernel.org>
References: <20260506215113.851360-1-dakr@kernel.org>
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

Convert the sample driver to SampleDriver<'bound>, taking advantage of
the lifetime-parameterized Driver trait.

The driver struct holds &'bound pci::Device directly instead of
ARef<pci::Device>, and pci::Bar<'bound> directly instead of
Devres<pci::Bar>. This removes PinnedDrop, pin_init_scope, and runtime
revocation checks on BAR access.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 samples/rust/rust_driver_pci.rs | 89 +++++++++++++++------------------
 1 file changed, 39 insertions(+), 50 deletions(-)

diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_driver_pci.rs
index bbcb816456e0..a7b7e580685c 100644
--- a/samples/rust/rust_driver_pci.rs
+++ b/samples/rust/rust_driver_pci.rs
@@ -9,7 +9,6 @@
         Bound,
         Core, //
     },
-    devres::Devres,
     io::{
         register,
         register::Array,
@@ -17,8 +16,7 @@
     },
     num::Bounded,
     pci,
-    prelude::*,
-    sync::aref::ARef, //
+    prelude::*, //
 };
 
 mod regs {
@@ -45,7 +43,7 @@ mod regs {
     pub(super) const END: usize = 0x10;
 }
 
-type Bar0 = pci::Bar<'static, { regs::END }>;
+type Bar0<'bound> = pci::Bar<'bound, { regs::END }>;
 
 #[derive(Copy, Clone, Debug)]
 struct TestIndex(u8);
@@ -66,26 +64,24 @@ impl TestIndex {
     const NO_EVENTFD: Self = Self(0);
 }
 
-#[pin_data(PinnedDrop)]
-struct SampleDriver {
-    pdev: ARef<pci::Device>,
-    #[pin]
-    bar: Devres<Bar0>,
+struct SampleDriver<'bound> {
+    pdev: &'bound pci::Device,
+    bar: Bar0<'bound>,
     index: TestIndex,
 }
 
 kernel::pci_device_table!(
     PCI_TABLE,
     MODULE_PCI_TABLE,
-    <SampleDriver as pci::Driver<'_>>::IdInfo,
+    <SampleDriver<'_> as pci::Driver<'_>>::IdInfo,
     [(
         pci::DeviceId::from_id(pci::Vendor::REDHAT, 0x5),
         TestIndex::NO_EVENTFD
     )]
 );
 
-impl SampleDriver {
-    fn testdev(index: &TestIndex, bar: &Bar0) -> Result<u32> {
+impl SampleDriver<'_> {
+    fn testdev(index: &TestIndex, bar: &Bar0<'_>) -> Result<u32> {
         // Select the test.
         bar.write_reg(regs::TEST::zeroed().with_index(*index));
 
@@ -138,7 +134,7 @@ fn config_space(pdev: &pci::Device<Bound>) {
     }
 }
 
-impl<'bound> pci::Driver<'bound> for SampleDriver {
+impl<'bound> pci::Driver<'bound> for SampleDriver<'bound> {
     type IdInfo = TestIndex;
 
     const ID_TABLE: pci::IdTable<Self::IdInfo> = &PCI_TABLE;
@@ -147,54 +143,47 @@ fn probe(
         pdev: &'bound pci::Device<Core>,
         info: &'bound Self::IdInfo,
     ) -> impl PinInit<Self, Error> + 'bound {
-        pin_init::pin_init_scope(move || {
-            let vendor = pdev.vendor_id();
-            dev_dbg!(
-                pdev,
-                "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
-                vendor,
-                pdev.device_id()
-            );
-
-            pdev.enable_device_mem()?;
-            pdev.set_master();
-
-            Ok(try_pin_init!(Self {
-                bar: pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?
-                    .into_devres()?,
-                index: *info,
-                _: {
-                    let bar = bar.access(pdev.as_ref())?;
-
-                    dev_info!(
-                        pdev,
-                        "pci-testdev data-match count: {}\n",
-                        Self::testdev(info, bar)?
-                    );
-                    Self::config_space(pdev);
-                },
-                pdev: pdev.into(),
-            }))
+        let vendor = pdev.vendor_id();
+        dev_dbg!(
+            pdev,
+            "Probe Rust PCI driver sample (PCI ID: {}, 0x{:x}).\n",
+            vendor,
+            pdev.device_id()
+        );
+
+        pdev.enable_device_mem()?;
+        pdev.set_master();
+
+        let bar = pdev.iomap_region_sized::<{ regs::END }>(0, c"rust_driver_pci")?;
+
+        dev_info!(
+            pdev,
+            "pci-testdev data-match count: {}\n",
+            Self::testdev(info, &bar)?
+        );
+        Self::config_space(pdev);
+
+        Ok(Self {
+            pdev,
+            bar,
+            index: *info,
         })
     }
 
-    fn unbind(pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
-        if let Ok(bar) = this.bar.access(pdev.as_ref()) {
-            // Reset pci-testdev by writing a new test index.
-            bar.write_reg(regs::TEST::zeroed().with_index(this.index));
-        }
+    fn unbind(_pdev: &'bound pci::Device<Core>, this: Pin<&'bound Self>) {
+        this.bar
+            .write_reg(regs::TEST::zeroed().with_index(this.index));
     }
 }
 
-#[pinned_drop]
-impl PinnedDrop for SampleDriver {
-    fn drop(self: Pin<&mut Self>) {
+impl Drop for SampleDriver<'_> {
+    fn drop(&mut self) {
         dev_dbg!(self.pdev, "Remove Rust PCI driver sample.\n");
     }
 }
 
 kernel::module_pci_driver! {
-    type: SampleDriver,
+    type: SampleDriver<'_>,
     name: "rust_driver_pci",
     authors: ["Danilo Krummrich"],
     description: "Rust PCI driver",
-- 
2.54.0

