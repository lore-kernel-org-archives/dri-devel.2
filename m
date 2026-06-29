Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5554BC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF63B10E09C;
	Mon, 29 Jun 2026 14:20:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fO0mOP5w";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1718D10E09C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:20:22 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-30bf8b2bd20so6710061eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782742821; x=1783347621; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AupvSFaqPtFwZHXXd++aD6dS9DxYuU7xGlZB7kUfSKk=;
 b=fO0mOP5w/mw3zJnCyiWlBE/UcRkwgew82Mjbl4ROlKrlC1ZIHB2BPUmLtKdtWZjMCP
 kxoE7IgVeZ+AYrEyRzkjEEusx9gBSzpnVW2TyFRdq0ZlzgeDfDdWUBajnZt/cSd+ncGD
 U5JRIL89jlBt3J5z8thEERF2OO1IRCsyN/YjOSlY6a1kuoSRGGpaZUgs2m22xs+tiow0
 giCTWX3M4UtqFgpc4Dni/0SkMXXWZufSAE3JW80enRy9Up+XNjCOQwiMGXZ5p+MxSj29
 aPP2goXXXV19ubunBFdsdSUsP+tPA4WrQTHDf7G/+KK6KGzZGZ+IIfhg6OR5qCeqTmLo
 V5rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782742821; x=1783347621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AupvSFaqPtFwZHXXd++aD6dS9DxYuU7xGlZB7kUfSKk=;
 b=Q9Gy5ig4xsQssc5Viv8jAaiBzYuTTqu7OMJVsBXajXaqiRRzsxQwaZkv/bHbF01tv+
 +mFH4Zoof36LSStHItM7TeQrUoBvoOzeSs5aOwvApkgZGuPk71e94x3DwEMIjQNg7aun
 Cy+H5AbGrQDniFvgWIFZSDs8r6LGeC9FTH2TvlF+e0qRpjCT7LN7Pd0Mel4usO8sUr5B
 t5Cn5Tarz21Hl7yugof+86MsVlzCfqEXPqMUmdwOGjhZOj3ctVWiMbQDQEhXDErcHIUG
 srjus/nzqW3VovzJ2PKFS6pP2iSSEjOAB8tPqR9CydGteAYlZyRmKFJtVv22DNz5NGbp
 lw5A==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro6I84ZVjkMq9KjjTfUrk87AV+0MbTL+7946WgubF1xxjTFi9wpTuZi06v8mXDnR2euWPEP65cuFhk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGuhlMnkHH+S12gHrV67A0Zm68rmxCmL+d2ElOLF52mn+o2y4y
 1tfJAF+cmq+H1bIQqZWuYcFB1HuSB/4gEcnXwmyJ5qLucsIJt2ybI9M=
X-Gm-Gg: AfdE7cmO1AlAn74szDNyJOldxdbP7/4MNpy52DEGTY6SG512x/Quqmb/CX3dxNMlvi3
 CKpAuUiamb43svD4Jnjxk+Wr5Tx9mQuaQVScSRw3IFpxDF37O1TWrzLq3OZOuRMUF1qm2mDhuhR
 YhQvqbulYPWs9rsfW5/6myHf+k8Fiw8dj+9yiwkBr5UomhyQbswgkRUXMdd7otJpRdzV8nHuxpi
 1M+/FLfwRNkXxoYrjD9GGgWtMMF5d7X2S1Xa9BtGPIdRFnaoFXxQJbbAUrolfszsnIQ98u44y5Q
 iDVhgkfxUDbMnLoH90KgJnn8O7ePl1GMVGA0OBT8fCHr3V4x0LY+/AXLNtJZsjaJU+plfNkpiEi
 dwHRqxSN/uf3DlFbJgdW1qn0ybbDs7PW1vHm1lIwK/IruHjNyd0Kvo86sca+VwlMAaftu54Wyuq
 pAptXpctymcskJHNEtKDK3Vl9OcjQIcvEmpFzHchk9Ni3iU8iFbaIeNXcoV1tVfiYd
X-Received: by 2002:a05:693c:88cd:10b0:30c:ab97:d7b3 with SMTP id
 5a478bee46e88-30cab97dc2dmr6285271eec.45.1782742821002; 
 Mon, 29 Jun 2026 07:20:21 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c52eed6sm44396852eec.9.2026.06.29.07.20.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 07:20:20 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Alice Ryhl <aliceryhl@google.com>, David Airlie <airlied@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Pedro Yudi Honda <niyudi.honda@usp.br>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev
Subject: [PATCH v2] gpu: nova-core: parse structs via zerocopy
Date: Mon, 29 Jun 2026 11:20:05 -0300
Message-ID: <20260629142007.269873-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Replace the unsafe `kernel::transmute::FromBytes` trait implementation
for the `FalconUCodeDescV3`, `PcirStruct`, `BitHeader`, `BitToken`,
`NpdeStruct`, `PciRomHeader`, `PmuLookupTableEntry` and
`PmuLookupTableHeader` structs with the derivable `zerocopy::FromBytes`
trait.

This change eliminates the manual unsafe implementations in favor of a
derivable trait. When this trait is derived, validity checks are
performed at compile time to ensure that the type can safely implement
`FromBytes`.

Link: https://github.com/Rust-for-Linux/linux/issues/1241
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
Changelog:
v2:
 - Rebased on top of drm-rust-next
 - Added derive macro FromBytes for BitToken, PciRomHeader, and
   PmuLookupTableEntry
v1: Link to lore [1]

NOTE: Compile-tested only. I don't own a piece of hardware where I can
test the nova driver.

NOTE 2: In firmware.rs, the BinHdr struct is another user of
transmute::FromBytes, but that conversion is intentionally omitted
here as it is handled in Pedro's patch series [2].

[1]: https://lore.kernel.org/nova-gpu/20260621143647.264770-1-nico.antinori.7@gmail.com/
[2]: https://lore.kernel.org/nova-gpu/20260625205146.5047-2-niyudi.honda@usp.br/

 drivers/gpu/nova-core/firmware.rs |  6 +--
 drivers/gpu/nova-core/vbios.rs    | 64 +++++++++----------------------
 2 files changed, 20 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 80e948bf7511..a94820a3b335 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -88,7 +88,7 @@ pub(crate) struct FalconUCodeDescV2 {

 /// Structure used to describe some firmwares, notably FWSEC-FRTS.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 pub(crate) struct FalconUCodeDescV3 {
     /// Header defined by `NV_BIT_FALCON_UCODE_DESC_HEADER_VDESC*` in OpenRM.
     hdr: u32,
@@ -119,10 +119,6 @@ pub(crate) struct FalconUCodeDescV3 {
     _reserved: u16,
 }

-// SAFETY: all bit patterns are valid for this type, and it doesn't use
-// interior mutability.
-unsafe impl FromBytes for FalconUCodeDescV3 {}
-
 /// Enum wrapping the different versions of Falcon microcode descriptors.
 ///
 /// This allows handling both V2 and V3 descriptor formats through a
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c6e6bfcd6a1f..c03650ee5226 100644
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
+            .and_then(|p| u32::read_from_prefix(p).ok())
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

@@ -929,15 +907,11 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
         let ver = data.get(1).copied().ok_or(EINVAL)?;
         match ver {
             2 => {
-                let v2 = FalconUCodeDescV2::read_from_prefix(data)
-                    .map_err(|_| EINVAL)?
-                    .0;
+                let (v2, _) = FalconUCodeDescV2::read_from_prefix(data).map_err(|_| EINVAL)?;
                 Ok(FalconUCodeDesc::V2(v2))
             }
             3 => {
-                let v3 = FalconUCodeDescV3::from_bytes_copy_prefix(data)
-                    .ok_or(EINVAL)?
-                    .0;
+                let (v3, _) = FalconUCodeDescV3::read_from_prefix(data).map_err(|_| EINVAL)?;
                 Ok(FalconUCodeDesc::V3(v3))
             }
             _ => {
--
2.47.3

