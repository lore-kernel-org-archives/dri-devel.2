Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C657606A32E
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 23:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YYUUchTe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DC8D10E75B;
	Sat, 14 Nov 2026 23:43:45 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D4010E75B
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 23:43:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E6B3041A97;
 Sat, 14 Nov 2026 23:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6A91F000C4;
 Sat, 14 Nov 2026 23:43:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794699818;
 bh=VgPgzRBTEZawyAypOvRkCasEHHDXiWmJn4tANhssVTA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=YYUUchTePltL7ctXo3UyBJwQZRaLgGaxWl6b/xU66mKxT/3Uyr5aXyJKxhEZVtuas
 RicjkwvvtmUpPwOCMSWDP69B4kQCIAOr54k0NfWxi9k1FX8qCAoCtLKWWzdDMp6tEQ
 8RnR/a3q4vjahDz+0bjd3SV+ZJmpc9PohVkkAjBvOnGxsOfJnvclpdRpECLpqIdmKV
 RsQKjhqRZQrrMufCAL2M5CTxNJ82ZQqwZJfnZRKAiU0FxzGDyGRp55M2v4WVRDMg0H
 /MTZCIu3BAct3i3ZMAU1z6yU0oZq1UML8TQJhHmfR+n4PJLRB2yhtUWSLimzOFOJum
 IrJN2RAhs0uSQ==
From: Danilo Krummrich <dakr@kernel.org>
To: dakr@kernel.org, acourbot@nvidia.com, aliceryhl@google.com,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com,
 robin.murphy@arm.com, a.hindborg@kernel.org, ojeda@kernel.org,
 boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, tmgross@umich.edu, tamird@kernel.org, work@onurozkan.dev
Cc: driver-core@lists.linux.dev, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org
Subject: [PATCH 2/2] gpu: nova-core: remove unnecessary firmware pin-init
Date: Sun, 15 Nov 2026 00:42:54 +0100
Message-ID: <20261114234324.82387-2-dakr@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114234324.82387-1-dakr@kernel.org>
References: <20261114234324.82387-1-dakr@kernel.org>
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

Now that SGTable no longer requires pinning, remove the pin-init
machinery from Radix3 and GspFirmware.

Signed-off-by: Danilo Krummrich <dakr@kernel.org>
---
 drivers/gpu/nova-core/firmware/gsp.rs    | 43 +++++--------
 drivers/gpu/nova-core/firmware/radix3.rs | 82 +++++++++++-------------
 drivers/gpu/nova-core/gsp/boot.rs        |  2 +-
 3 files changed, 56 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/gsp.rs b/drivers/gpu/nova-core/firmware/gsp.rs
index 341a8b19aa38..ff92a12b2994 100644
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
@@ -39,34 +37,27 @@ pub(crate) struct GspFirmware<'a> {
 impl<'a> GspFirmware<'a> {
     /// Loads the GSP firmware binaries, map them into `dev`'s address-space, and creates the page
     /// tables expected by the GSP bootloader to load it.
-    pub(crate) fn new(
-        dev: &'a device::Device<device::Bound>,
-        chipset: Chipset,
-    ) -> impl PinInit<Self, Error> + 'a {
-        pin_init::pin_init_scope(move || {
-            let firmware = request_tlv(dev, chipset, "gsp")?;
-            let tlv = Tlv::new(firmware.data())?;
-            dev_dbg!(dev, "loaded gsp firmware v{}\n", tlv.get_string(b"VERS")?);
+    pub(crate) fn new(dev: &'a device::Device<device::Bound>, chipset: Chipset) -> Result<Self> {
+        let firmware = request_tlv(dev, chipset, "gsp")?;
+        let tlv = Tlv::new(firmware.data())?;
+        dev_dbg!(dev, "loaded gsp firmware v{}\n", tlv.get_string(b"VERS")?);
 
-            let size = usize::from_safe_cast(tlv.get_u32(b"SIZE")?);
-            let mut fw_vvec = VVec::zeroed(size, GFP_KERNEL).map_err(|_| ENOMEM)?;
+        let size = usize::from_safe_cast(tlv.get_u32(b"SIZE")?);
+        let mut fw_vvec = VVec::zeroed(size, GFP_KERNEL).map_err(|_| ENOMEM)?;
 
-            let chip_name = chipset.name();
-            let file = tlv.get_string(b"FILE")?;
-            let filename = CString::try_from_fmt(fmt!("nvidia/{chip_name}/gsp/{file}"))?;
-            firmware::request_into_buf(&filename, dev, fw_vvec.as_mut_slice())?;
+        let chip_name = chipset.name();
+        let file = tlv.get_string(b"FILE")?;
+        let filename = CString::try_from_fmt(fmt!("nvidia/{chip_name}/gsp/{file}"))?;
+        firmware::request_into_buf(&filename, dev, fw_vvec.as_mut_slice())?;
 
-            let signatures = Coherent::from_slice(dev, tlv.get_bytes(b"SIGN")?, GFP_KERNEL)?;
+        Ok(Self {
+            radix3: Radix3::new(dev, fw_vvec)?,
+            signatures: Coherent::from_slice(dev, tlv.get_bytes(b"SIGN")?, GFP_KERNEL)?,
+            bootloader: {
+                let bl = request_tlv(dev, chipset, "gsp_bootloader")?;
 
-            Ok(try_pin_init!(Self {
-                radix3 <- Radix3::new(dev, fw_vvec),
-                signatures,
-                bootloader: {
-                    let bl = request_tlv(dev, chipset, "gsp_bootloader")?;
-
-                    RiscvFirmware::new(dev, &bl)?
-                },
-            }))
+                RiscvFirmware::new(dev, &bl)?
+            },
         })
     }
 
diff --git a/drivers/gpu/nova-core/firmware/radix3.rs b/drivers/gpu/nova-core/firmware/radix3.rs
index a3e43fc8ec86..2c8787d5930d 100644
--- a/drivers/gpu/nova-core/firmware/radix3.rs
+++ b/drivers/gpu/nova-core/firmware/radix3.rs
@@ -32,60 +32,54 @@
 };
 
 /// A radix3 page table and the data it maps.
-#[pin_data]
 pub(crate) struct Radix3<'a> {
     /// The mapped data.
-    data: SGTable<Owned<'a, VVec<u8>>>,
-    /// Level 2: one entry per page of `data`.
-    level2: SGTable<Owned<'a, VVec<u8>>>,
-    /// Level 1: one entry per page of `level2`.
-    level1: SGTable<Owned<'a, VVec<u8>>>,
-    /// Level 0: one page, whose single entry is the DMA address of the first `level1` page.
+    _data: SGTable<Owned<'a, VVec<u8>>>,
+    /// Level 2: one entry per page of `_data`.
+    _level2: SGTable<Owned<'a, VVec<u8>>>,
+    /// Level 1: one entry per page of `_level2`.
+    _level1: SGTable<Owned<'a, VVec<u8>>>,
+    /// Level 0: one page, whose single entry is the DMA address of the first `_level1` page.
     level0: Coherent<'a, [u64]>,
-    /// Length of `data`, in bytes.
+    /// Length of `_data`, in bytes.
     size: usize,
 }
 
 impl<'a> Radix3<'a> {
     /// Builds a radix3 page table over `data`, mapped for `dev` to read. May sleep.
-    pub(crate) fn new(
-        dev: &'a device::Device<device::Bound>,
-        data: VVec<u8>,
-    ) -> impl PinInit<Self, Error> + 'a {
+    pub(crate) fn new(dev: &'a device::Device<device::Bound>, data: VVec<u8>) -> Result<Self> {
         let size = data.len();
 
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
+        let data = SGTable::new(dev, data, DataDirection::ToDevice, GFP_KERNEL)?;
+
+        let l2 = build_lvl(&data)?;
+        let level2 = SGTable::new(dev, l2, DataDirection::ToDevice, GFP_KERNEL)?;
+
+        let l1 = build_lvl(&level2)?;
+        let level1 = SGTable::new(dev, l1, DataDirection::ToDevice, GFP_KERNEL)?;
+
+        // Allocate the level 0 page table as a device-visible DMA object, and map the
+        // level 1 page table onto it.
+
+        // Fill level 1 page entry.
+        let level1_entry = level1.iter().next().ok_or(EINVAL)?;
+        let level1_entry_addr = level1_entry.dma_address();
+
+        // Create level 0 page table data and fill its first entry with the level 1
+        // table.
+        let mut level0 = CoherentBox::<'_, [u64]>::zeroed_slice(
+            dev,
+            GSP_PAGE_SIZE / size_of::<u64>(),
+            GFP_KERNEL,
+        )?;
+        level0[0] = level1_entry_addr.to_le();
+
+        Ok(Self {
+            _data: data,
+            _level2: level2,
+            _level1: level1,
+            level0: level0.into(),
+            size,
         })
     }
 
diff --git a/drivers/gpu/nova-core/gsp/boot.rs b/drivers/gpu/nova-core/gsp/boot.rs
index 4fb1b69ac9d5..ac09b40832aa 100644
--- a/drivers/gpu/nova-core/gsp/boot.rs
+++ b/drivers/gpu/nova-core/gsp/boot.rs
@@ -40,7 +40,7 @@ pub(crate) fn boot(
         let dev = pdev.as_ref();
         let hal = super::hal::gsp_hal(chipset);
 
-        let gsp_fw = KBox::pin_init(GspFirmware::new(dev, chipset), GFP_KERNEL)?;
+        let gsp_fw = GspFirmware::new(dev, chipset)?;
 
         self.cmdq
             .send_command_no_wait(commands::SetSystemInfo::new(pdev, chipset))?;
-- 
2.56.1

