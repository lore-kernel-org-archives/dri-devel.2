Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FAC606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 17:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b9cCKlxk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B5EB10E626;
	Sun, 22 Nov 2026 17:14:31 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB49410E60C
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 17:13:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 73FB8405F8;
 Sun, 22 Nov 2026 17:13:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 780411F000C0;
 Sun, 22 Nov 2026 17:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795367638;
 bh=yUNaSCM1KvdhOrAYcb8mGrRXSwHXAOI/5jdKnnBOGBY=;
 h=From:To:Cc:Subject:Date;
 b=b9cCKlxkFFIzVTRL/IzW5cvjhaDaOgffWKN5AHbUNzUEArNWBJ6p/pJvFw6YawdtM
 iOkc7Ai3ZNJVwP3xfdDGGU6lFCOP5s5Lxn20TFITaByeH1JQdS+l/PxNFHwB0q8mwp
 G8cwOCzxwPq3Iif5GMg6xHCcztlvEBQWP3ERPztlERm4jpeEHVzIojwUY1qh/elJl6
 xsPEiKTpceD6RrP6dXOAUerny7zWQ8DB5a33Yh0ReQJt+gN8wajf/J1rFPzHPg/Fe+
 lqOjDziVku78jMyoBLT8j0ICOn27UaBODDeOoRq7rYAFGpOzb02dnZU4+5lZ9jm7sI
 qvLf2M6oDBPUg==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org,
	acourbot@nvidia.com
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: nova-core: use Init for firmware initialization
Date: Sun, 22 Nov 2026 18:13:50 +0100
Message-ID: <20261122171353.963020-1-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that SGTable no longer requires pinning, move Radix3 and GspFirmware
from PinInit to Init.

In an x86-64 build, GspFirmware is 312 bytes, including its 216-byte
Radix3. This is reasonable for the stack, but returning it by value
increases boot()'s local stack reservation from 432 to 1040 bytes.

On TU102 for instance, the nested hal.boot() call reserves another 1128
bytes for locals.

Thus, keep the KBox allocation and in-place initialization.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
Changes in v2:
  - Convert to impl Init to not increase the overall stack usage.
---
 drivers/gpu/nova-core/firmware/gsp.rs    |  8 ++-
 drivers/gpu/nova-core/firmware/radix3.rs | 67 +++++++++++-------------
 drivers/gpu/nova-core/gsp/boot.rs        |  3 +-
 3 files changed, 36 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 341a8b19aa38..1cf17d0fb36b 100644
--- a/drivers/gpu/nova-core/firmware/gsp.rs
+++ b/drivers/gpu/nova-core/firmware/gsp.rs
@@ -25,10 +25,8 @@
 };
 
 /// The GSP firmware image, its signatures, and the GSP bootloader.
-#[pin_data]
 pub(crate) struct GspFirmware<'a> {
     /// The firmware image and the radix3 table that maps it.
-    #[pin]
     radix3: Radix3<'a>,
     /// Device-mapped GSP signatures matching the GPU's [`Chipset`].
     pub(crate) signatures: Coherent<'a, [u8]>,
@@ -42,8 +40,8 @@ impl<'a> GspFirmware<'a> {
     pub(crate) fn new(
         dev: &'a device::Device<device::Bound>,
         chipset: Chipset,
-    ) -> impl PinInit<Self, Error> + 'a {
-        pin_init::pin_init_scope(move || {
+    ) -> impl Init<Self, Error> + 'a {
+        pin_init::init_scope(move || {
             let firmware = request_tlv(dev, chipset, "gsp")?;
             let tlv = Tlv::new(firmware.data())?;
             dev_dbg!(dev, "loaded gsp firmware v{}\n", tlv.get_string(b"VERS")?);
@@ -58,7 +56,7 @@ pub(crate) fn new(
 
             let signatures = Coherent::from_slice(dev, tlv.get_bytes(b"SIGN")?, GFP_KERNEL)?;
 
-            Ok(try_pin_init!(Self {
+            Ok(try_init!(Self {
                 radix3 <- Radix3::new(dev, fw_vvec),
                 signatures,
                 bootloader: {
diff --git a/drivers/gpu/nova-core/firmware/radix3.rs b/drivers/gpu/nova-core/firmware/radix3.rs
index a3e43fc8ec86..b17d1363e48f 100644
--- a/drivers/gpu/nova-core/firmware/radix3.rs
+++ b/drivers/gpu/nova-core/firmware/radix3.rs
@@ -32,7 +32,6 @@
 };
 
 /// A radix3 page table and the data it maps.
-#[pin_data]
 pub(crate) struct Radix3<'a> {
     /// The mapped data.
     data: SGTable<Owned<'a, VVec<u8>>>,
@@ -51,41 +50,37 @@ impl<'a> Radix3<'a> {
     pub(crate) fn new(
         dev: &'a device::Device<device::Bound>,
         data: VVec<u8>,
-    ) -> impl PinInit<Self, Error> + 'a {
-        let size = data.len();
-
-        pin_init::pin_init_scope(move || {
-            Ok(try_pin_init!(Self {
-                data: SGTable::new(dev, data, DataDirection::ToDevice, GFP_KERNEL)?,
-                level2: {
-                    let l2 = build_lvl(data)?;
-                    SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL)?
-                },
-                level1: {
-                    let l1 = build_lvl(level2)?;
-                    SGTable::new(dev, l1, DataDirection::ToDevice, GFP_KERNEL)?
-                },
-                level0: {
-                    // Allocate the level 0 page table as a device-visible DMA object, and map the
-                    // level 1 page table onto it.
-
-                    // Fill level 1 page entry.
-                    let level1_entry = level1.iter().next().ok_or(EINVAL)?;
-                    let level1_entry_addr = level1_entry.dma_address();
-
-                    // Create level 0 page table data and fill its first entry with the level 1
-                    // table.
-                    let mut level0 = CoherentBox::<'_, [u64]>::zeroed_slice(
-                        dev,
-                        GSP_PAGE_SIZE / size_of::<u64>(),
-                        GFP_KERNEL,
-                    )?;
-                    level0[0] = level1_entry_addr.to_le();
-
-                    level0.into()
-                },
-                size,
-            }))
+    ) -> impl Init<Self, Error> + 'a {
+        try_init!(Self {
+            size: data.len(),
+            data: SGTable::new(dev, data, DataDirection::ToDevice, GFP_KERNEL)?,
+            level2: {
+                let l2 = build_lvl(data)?;
+                SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL)?
+            },
+            level1: {
+                let l1 = build_lvl(level2)?;
+                SGTable::new(dev, l1, DataDirection::ToDevice, GFP_KERNEL)?
+            },
+            level0: {
+                // Allocate the level 0 page table as a device-visible DMA object, and map the
+                // level 1 page table onto it.
+
+                // Fill level 1 page entry.
+                let level1_entry = level1.iter().next().ok_or(EINVAL)?;
+                let level1_entry_addr = level1_entry.dma_address();
+
+                // Create level 0 page table data and fill its first entry with the level 1
+                // table.
+                let mut level0 = CoherentBox::<'_, [u64]>::zeroed_slice(
+                    dev,
+                    GSP_PAGE_SIZE / size_of::<u64>(),
+                    GFP_KERNEL,
+                )?;
+                level0[0] = level1_entry_addr.to_le();
+
+                level0.into()
+            },
         })
     }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 4fb1b69ac9d5..defe1f331918 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -40,7 +40,8 @@ pub(crate) fn boot(
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
-        let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
+        // Initialize the firmware in place to limit stack usage during boot.
+        let gsp_fw = KBox::init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
 
         self.cmdq
             .send_command_no_wait(commands::SetSystemInfo::new(pdev, chipset))?;

base-commit: 0504beeb95d1be229d7cce00a12033468f5ac50b
-- 
2.56.1

