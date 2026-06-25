Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A66FECDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36A510F4B8;
	Fri, 26 Jun 2026 07:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="jhoKOKnD";
	dkim-atps=neutral
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com
 [74.125.82.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2B6310F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:29 +0000 (UTC)
Received: by mail-dy1-f169.google.com with SMTP id
 5a478bee46e88-30c591fb1cbso471555eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420749; x=1783025549; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JbsiPBhRXELXlciyn8qdhc91HfKLi4Tf8gGbIsDN50U=;
 b=jhoKOKnD6geBCnEDMrBgGaqywRpKD90Si2ts4JbsfpPyIOxVc1V6ec4svCkHZstzpK
 PfNTuQfFAeExRapg1hfUsnnOM2TMOzvUqVAq1mCzL8s/pJwXqDj3x0gP615RO6EUDzfI
 7oJa70JDdJlGEBB8OjZsQ9URek+WwntC1EAibS3jGIz7lvlx0RkCDhGLdsI59XtkJ3WJ
 gKtmmJxKuNUn6uuYYnY4DcBYtVvmswNMrGZwC8yCKx09Yrs4+w3Heu5VaLlMGtPjduuN
 u4JHBZHecE9bUBYkpDf9FtkJe63Tm5da2SwD6EghUtg44WShIDZwAKAQxQHfMumMt6+L
 sEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420749; x=1783025549;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JbsiPBhRXELXlciyn8qdhc91HfKLi4Tf8gGbIsDN50U=;
 b=XUFHLbqgyiVl3b1V2/bHxPFlzWQSfJRaxLv2JRicTGdxqhfYxqIyyoQlrn7EqNa89t
 8WsV4ZEG32Hkjvns6wso1/PpeqVJ7+QPAT5nFHvDqjChuYPZLMu0ZnnK2lkn8gLeSSWb
 SBnOw8jzG2TKICI/2wOxi4j3UZbza8sCP8Qy9koayGlOuuMiI1fRGd4HZrNaKeH04GBq
 bcAFNk/4LtUzC82svmvdlga1OxmfGFs2QNQrkNniAkPagDFkB4YZ0qGxWGVxS7T+FjVs
 p9GAevXJxhWbJg/jxGbEipYpOFUVGD4PZl0TGP0NOJtR2Bt09RxIygZHG1QhDV+prg23
 2Wyg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqakMtOYw9wqLLQHqg40SRuLBfZZqGkEBe9QZ73gPkZGw4ffdhWZpWUTDTA9Y/iQEzhQI9rZgK7aLs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YysJvgHXizUuK0Ahi2JjiA6A9IIUW598x6JQqUIzTAc7d4uBUVQ
 EHvPO1+2LYICtVSYifYrix1p6Wd3PX1sib2ZjbSLBUN24rTD44p+OkgfQMmc999kcB5hXBOG4DI
 7ly4XV3kK9w==
X-Gm-Gg: AfdE7ck8jTtdp2LQ40uVG/IPFuKmumbAwaK48+Kyzf0lA+rsZ2kUIC1fMKpgcwz3QH8
 R2txlV27NnZ773vATbR9v5jGZNXoxoJfo8zFG/sbdvQl/Cidzq0DP7HGrAzI2UuER2RvMd3F9bM
 Ec1ebiTakInZSex9MOM98qdS4dupEUaEaWAbhs5/Edq9tNje8jZDnSIdfDIBbJzR0s85ls+ivv9
 e/7TMB01rKA5kWxUt7WvY9+KN6UfwpuPB/eRCxx9upQWLump2vgJZwmgNwbU++lro87ZJrDoylL
 xi2YQPa8Ke1/Xg4MymGTUNsfJzd5cNeSxQACMtY36iTXfzDBUNVAkoXNfG7ClWDvGZlGlTL/fOS
 Zbuvb+nIqdack58SRG24fgiD1lW+QicgkmnLXkTPE7SC99yQPaq10XFzFGLaao8k1r1DFohDUwi
 5GWHNnsi6f0mAeB/m3jJA7HRVUWw==
X-Received: by 2002:a05:7300:7242:b0:304:dd1c:737e with SMTP id
 5a478bee46e88-30c84d0e939mr4353344eec.16.1782420748745; 
 Thu, 25 Jun 2026 13:52:28 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:28 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 2/7] drm/nova: use `zerocopy` in vbios.rs
Date: Thu, 25 Jun 2026 17:51:41 -0300
Message-Id: <20260625205146.5047-3-niyudi.honda@usp.br>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260625205146.5047-1-niyudi.honda@usp.br>
References: <20260625205146.5047-1-niyudi.honda@usp.br>
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

