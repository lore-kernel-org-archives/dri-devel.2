Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90006CDE013
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1416B10F4A3;
	Fri, 26 Jun 2026 07:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="bqejsCll";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1BD910E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:11 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13986d61b4eso510217c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414371; x=1783019171; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbsiPBhRXELXlciyn8qdhc91HfKLi4Tf8gGbIsDN50U=;
 b=bqejsCllfwq0T3WhUegWVr4SzpURBdtGRn0QeIzfz1xVIOtFRBXF/Y2hT2APIjyvBO
 MTjahUZy/Z8XzR14fOUhgqAt7IfrU8WT9SSzKRH9qj9PlTcMbhLb+vUhTSzhD+5PG5Il
 mIcbLJTv47wq29JHVcdm3e8eSe/PhO9pjFSdcc9YVJ5Y2bJWYFpUeLi/reCxSSiWCyN6
 BpO6tlm9Jhbb6ZcN746tAFtD5NuE//bpjdqIpwV3+g4N1m2mEm1YjnyQexVJweewFPrs
 U+xGRfKyIpCTKdf0RYd8C+2yZwjgXJ/21UbFRqbYJlcO+uE08tKiAVbBbMYEYcXFB/7O
 0hrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414371; x=1783019171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JbsiPBhRXELXlciyn8qdhc91HfKLi4Tf8gGbIsDN50U=;
 b=YgrurvicZ1i1IeIvOT7EMsiwv3qV6zGGMDa/xI2PzmopjgxMgLqeIeZ8V4gkdv1ZSP
 oCchP9ezDJkrhlHsNCgHUgij0RiqxaNgFDIBXsgtNypQRc9MpNH7QqSChwz6IvwizVbi
 uYB1IHNjdT75vVOe+Q8vD10/Kl1cFHWrxLU1M3R3+kFcJYHl4D/TOmzoeXmHNowmKN1U
 B8VDv2JMqdrs/r3iLdOhDa13tT4CNJxqEjeayoCSF98r1R/tJM5AfaHg9NsNWifssba+
 Lsk+q1GuoFokvF4Pk1dbH4EaocF+q57PEw5xDQRKeLaPFSglG5HTS/jr1fbxMzdLCwLf
 6hmg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+hq3HKbJKJYWNT92dSKS74s00rdv+8l7HppFt3KVWNGs0LKuNd8ry1yAosP82vFjonpvsvnUqIo3k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywo/7wE8LuoLCniG+K3Of0s9X4q1NYOy16G9LqPhJZfRa+MX2Qk
 yNg292vlgsQIESflKSslHO+1gYgJrk+8jsKx11dD1Fvh6ZqS4Ric5gXiZJyeVvR5MvE=
X-Gm-Gg: AfdE7cnyKsgz0JVv7R2+Bx41KQwvmv6mZ9PvWwOyCYeP8FEGMcf4iNBOzqS+xHrDg4d
 qYyKPUOABHkXvurTHwh04QrYeO/PJrf8gM+QAkXsTxfo5NTsfUoylzZpokGBw/E+Re0Amc1AEvn
 /s2/ufFpwg1iT/KE0oKen25pRJeeyvOrPb1NEIlZCsrccZ4UTpDlkBTWao6YtGBIEL1trGbW2fe
 UhqpTEUOm4ldPXeFJQZKysvjhYn9mUYllKiVR+zCSeKSx4nG16XBjLYsOFC7Nucmo8M5soBeAut
 sLQZ5uoY9U0iX/jEu2rj5A5sFGXXJFsWwCl0jXCEvK5210hMO8b60yJEOP69Rn1X9JvK0xev3hA
 f0twVMqfTjd6IKFLCyX0MdcRS57K447VpqDiG9OaPhDZXYaUG4LQJ76qq9RJ+hIdRkyZai+8qZm
 IOtbpcUffhiyD/254=
X-Received: by 2002:a05:7022:ef10:b0:137:fc2b:1efe with SMTP id
 a92af1059eb24-139dbac09f9mr3745379c88.11.1782414370918; 
 Thu, 25 Jun 2026 12:06:10 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:10 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 2/7] drm/nova: use `zerocopy` in vbios.rs
Date: Thu, 25 Jun 2026 16:05:48 -0300
Message-Id: <20260625190553.7245-3-niyudi.honda@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625190553.7245-1-niyudi.honda@usp.br>
References: <20260625190553.7245-1-niyudi.honda@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

From: Pedro Yudi Honda <niyudi.honda@usp.br>

In vbios.rs, replave the following `transmute` traits with their
`zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/vbios.rs | 56 +++++++++++-----------------------
 1 file changed, 17 insertions(+), 39 deletions(-)

diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index e6d144587c4e..a3c0c06f6818 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -13,11 +13,8 @@
     register,
     sizes::SZ_4K,
     sync::aref::ARef,
-    transmute::FromBytes,
 };
 
-use zerocopy::FromBytes as _;
-
 use crate::{
     driver::Bar0,
     firmware::{
@@ -359,7 +356,7 @@ pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {
 }
 
 /// PCI Data Structure as defined in PCI Firmware Specification
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 #[repr(C)]
 struct PcirStruct {
     /// PCI Data Structure signature ("PCIR" or "NPDS")
@@ -388,15 +385,12 @@ struct PcirStruct {
     max_runtime_image_len: u16,
 }
 
-// SAFETY: all bit patterns are valid for `PcirStruct`.
-unsafe impl FromBytes for PcirStruct {}
-
 impl PcirStruct {
     /// The bit in `last_image` that indicates the last image.
     const LAST_IMAGE_BIT_MASK: u8 = 0x80;
 
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        let (pcir, _) = PcirStruct::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
+        let (pcir, _) = PcirStruct::read_from_prefix(data).map_err(|_| EINVAL)?;
 
         // Signature should be "PCIR" (0x52494350) or "NPDS" (0x5344504e).
         if &pcir.signature != b"PCIR" && &pcir.signature != b"NPDS" {
@@ -432,7 +426,7 @@ fn image_size_bytes(&self) -> usize {
 /// This is the head of the BIT table, that is used to locate the Falcon data. The BIT table (with
 /// its header) is in the [`PciAtBiosImage`] and the falcon data it is pointing to is in the
 /// [`FwSecBiosImage`].
-#[derive(Debug, Clone, Copy)]
+#[derive(Debug, Clone, Copy, FromBytes)]
 #[repr(C)]
 struct BitHeader {
     /// 0h: BIT Header Identifier (BMP=0x7FFF/BIT=0xB8FF)
@@ -451,12 +445,9 @@ struct BitHeader {
     checksum: u8,
 }
 
-// SAFETY: all bit patterns are valid for `BitHeader`.
-unsafe impl FromBytes for BitHeader {}
-
 impl BitHeader {
     fn new(data: &[u8]) -> Result<Self> {
-        let (header, _) = BitHeader::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
+        let (header, _) = BitHeader::read_from_prefix(data).map_err(|_| EINVAL)?;
 
         // Check header ID and signature
         if header.id != 0xB8FF || &header.signature != b"BIT\0" {
@@ -468,7 +459,7 @@ fn new(data: &[u8]) -> Result<Self> {
 }
 
 /// BIT Token Entry: Records in the BIT table followed by the BIT header.
-#[derive(Debug, Clone, Copy)]
+#[derive(Debug, Clone, Copy, FromBytes)]
 #[repr(C)]
 struct BitToken {
     /// 00h: Token identifier
@@ -481,9 +472,6 @@ struct BitToken {
     data_offset: u16,
 }
 
-// SAFETY: all bit patterns are valid for `BitToken`.
-unsafe impl FromBytes for BitToken {}
-
 impl BitToken {
     /// BIT token ID for Falcon data.
     const ID_FALCON_DATA: u8 = 0x70;
@@ -508,7 +496,7 @@ fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
                 .and_then(|data| data.get(..entry_size))
                 .ok_or(EINVAL)?;
 
-            let (token, _) = BitToken::from_bytes_copy_prefix(entry).ok_or(EINVAL)?;
+            let (token, _) = BitToken::read_from_prefix(entry).map_err(|_| EINVAL)?;
 
             // Check if this token has the requested ID
             if token.id == token_id {
@@ -525,7 +513,7 @@ fn from_id(image: &PciAtBiosImage, token_id: u8) -> Result<Self> {
 ///
 /// This header is at the beginning of every image in the set of images in the ROM. It contains a
 /// pointer to the PCI Data Structure which describes the image.
-#[derive(Debug, Clone, Copy)]
+#[derive(Debug, Clone, Copy, FromBytes)]
 #[repr(C)]
 struct PciRomHeader {
     /// 00h: Signature (0xAA55)
@@ -536,13 +524,10 @@ struct PciRomHeader {
     pci_data_struct_offset: u16,
 }
 
-// SAFETY: all bit patterns are valid for `PciRomHeader`.
-unsafe impl FromBytes for PciRomHeader {}
-
 impl PciRomHeader {
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        let (rom_header, _) = PciRomHeader::from_bytes_copy_prefix(data)
-            .ok_or(EINVAL)
+        let (rom_header, _) = PciRomHeader::read_from_prefix(data)
+            .map_err(|_| EINVAL)
             .inspect_err(|_| dev_err!(dev, "Not enough data for ROM header\n"))?;
 
         // Check for valid ROM signatures.
@@ -564,7 +549,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
 /// PCI Data Structure. It contains some fields that are redundant with the PCI Data Structure, but
 /// are needed for traversing the BIOS images. It is expected to be present in all BIOS images
 /// except for NBSI images.
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 #[repr(C)]
 struct NpdeStruct {
     /// 00h: Signature ("NPDE")
@@ -579,15 +564,12 @@ struct NpdeStruct {
     last_image: u8,
 }
 
-// SAFETY: all bit patterns are valid for `NpdeStruct`.
-unsafe impl FromBytes for NpdeStruct {}
-
 impl NpdeStruct {
     /// The bit in `last_image` that indicates the last image.
     const LAST_IMAGE_BIT_MASK: u8 = 0x80;
 
     fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
-        let (npde, _) = NpdeStruct::from_bytes_copy_prefix(data)?;
+        let (npde, _) = NpdeStruct::read_from_prefix(data).ok()?;
 
         // Signature should be "NPDE" (0x4544504E).
         if &npde.signature != b"NPDE" {
@@ -784,7 +766,7 @@ fn falcon_data_offset(&self, dev: &device::Device) -> Result<usize> {
         let data = &self.base.data;
         let (ptr, _) = data
             .get(offset..)
-            .and_then(u32::from_bytes_copy_prefix)
+            .and_then(|b| u32::read_from_prefix(b).ok())
             .ok_or(EINVAL)?;
 
         usize::from_safe_cast(ptr)
@@ -814,6 +796,7 @@ fn try_from(base: BiosImage) -> Result<Self> {
 /// The [`PmuLookupTableEntry`] structure is a single entry in the [`PmuLookupTable`].
 ///
 /// See the [`PmuLookupTable`] description for more information.
+#[derive(FromBytes)]
 #[repr(C, packed)]
 struct PmuLookupTableEntry {
     application_id: u8,
@@ -821,9 +804,6 @@ struct PmuLookupTableEntry {
     data: u32,
 }
 
-// SAFETY: all bit patterns are valid for `PmuLookupTableEntry`.
-unsafe impl FromBytes for PmuLookupTableEntry {}
-
 impl PmuLookupTableEntry {
     /// PMU lookup table application ID for firmware security license ucode.
     #[expect(dead_code)]
@@ -836,6 +816,7 @@ impl PmuLookupTableEntry {
 }
 
 #[repr(C)]
+#[derive(FromBytes)]
 struct PmuLookupTableHeader {
     version: u8,
     header_len: u8,
@@ -843,9 +824,6 @@ struct PmuLookupTableHeader {
     entry_count: u8,
 }
 
-// SAFETY: all bit patterns are valid for `PmuLookupTableHeader`.
-unsafe impl FromBytes for PmuLookupTableHeader {}
-
 /// The [`PmuLookupTableEntry`] structure is used to find the [`PmuLookupTableEntry`] for a given
 /// application ID.
 ///
@@ -857,7 +835,7 @@ struct PmuLookupTable {
 
 impl PmuLookupTable {
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        let (header, _) = PmuLookupTableHeader::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
+        let (header, _) = PmuLookupTableHeader::read_from_prefix(data).map_err(|_| EINVAL)?;
 
         let header_len = usize::from(header.header_len);
         let entry_len = usize::from(header.entry_len);
@@ -872,8 +850,8 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
 
         let mut entries = KVVec::with_capacity(entry_count, GFP_KERNEL)?;
         for i in 0..entry_count {
-            let (entry, _) = PmuLookupTableEntry::from_bytes_copy_prefix(&data[i * entry_len..])
-                .ok_or(EINVAL)?;
+            let (entry, _) = PmuLookupTableEntry::read_from_prefix(&data[i * entry_len..])
+                .map_err(|_| EINVAL)?;
             entries.push(entry, GFP_KERNEL)?;
         }
 
-- 
2.34.1

