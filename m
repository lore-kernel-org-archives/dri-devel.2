Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AD2CDB471
	for <dri-devel@archiver.kernel.org>; Tue, 23 Jun 2026 08:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D79C10E9C7;
	Tue, 23 Jun 2026 08:06:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcOHDHPx";
	dkim-atps=neutral
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com
 [209.85.219.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A93B310E1DD
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 14:37:23 +0000 (UTC)
Received: by mail-qv1-f42.google.com with SMTP id
 6a1803df08f44-8dc87f7d68bso41109486d6.3
 for <dri-devel@lists.freedesktop.org>; Sun, 21 Jun 2026 07:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782052642; x=1782657442; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kVQ3xkWLXL4IaDjUu6wCV48CVGQrhtl6ZKE5IwOl7lU=;
 b=YcOHDHPxljOaDOLeOf8q8vNzuLJQWPq7wwOxUL2+IrUcGQbHqBa+mW0/G2+UsQu3qx
 Rl9UKV7sMoJ9jtry7AcIFG1rsLnePVTdQqlPSAmow2/cgl1D/ppBSQK6KZ13zNMXiIaF
 gMvCAvEFdwbLc8UTdvq2+xu5X3x2FC0M9ubFHVjcABpPlww4C+/NjbaETY0Crg65Naht
 Elmql9zPzA5RF5Wdzb0QcVmw+V2wwZ0bwIZxuvDh09tyUW1Drkc3SFRIuIA0GqbQ+Mx+
 fnlIBo11IzV1N+hOqrV2AAw8EP68rXW6cZldfBBaUUdXfiqjErLuEpXOSF1iSBjBvulS
 OH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782052642; x=1782657442;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kVQ3xkWLXL4IaDjUu6wCV48CVGQrhtl6ZKE5IwOl7lU=;
 b=QrLvGtCObsZqPdO0TnBM4IQdaxSUE0vfPGTA1MCZjsbmzycTLhtOXWsZqxkFOrceEw
 6Scpq7pIcIY3n3nofCYxz00fr7kwUhyn6OLH0fq1xp0OdlX/xyjOUrIMIOfTHj1s8NTL
 z1O56ZgoEZ9JaS1/Lqao+gyHhVFO++n76e8ma+vPsV5UKdg9iHb+B3xRm50oS4AKpP9+
 OJK4/fX+pfI3+hm0YitDagwjuMxpATjp3comeC4Y7zdvuZGptkJs99x7fHueJSoC32hr
 bfDzKERbIJqZvNH3FS6I1StA5NprRl974KK2MTq+vjvRbnM0InwO+bGL5SZ5EURQvpvL
 v5wQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLbdEyVYkVmBNonBChgxF7KJ126n+CVHWYBNoLu1CWCct1QDVCBAUOnMrrfZ2P40WWyhM2VehPg1Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywmtq9vB27BNfTVNEFxhQaT46qCysLZo7RpTWYrN5M0gWuDj9GF
 p6fhBAJgXh3S7xup0fNWiBwahQVfFBvrSMgicgxq7h0ww4s1rxKZgkI=
X-Gm-Gg: AfdE7ckHeWZit5DhnW9jw+AWDnao66L84vfFYiJG/72aYI38a7oOTxUDrE/FOuupAEi
 Ws8AUoWEUN2Y8Bvh+Jyb4DFwvjkzFhevT3p2StRTdm8TjLhnzvHCN0B31MN29DUfKHstGFvNfYX
 1wh1IKGHqaftIEVdYUn3GHW/kihKXz05IVTOHPBT22bWCVXCbInBByjGiWI0y8NrBi4GRdjxIbh
 5AHyCXBgKsEHnli136P+f72fMM8gRNqghMIA+f14g0In+U2lfOdSul3w0GXnlJ7E+N2ZLoXTqIk
 dLeQ+7ERtzEeRC3BW15nY6PQNjIG+SqZpv/INxF/qu1F4RVkTQomLTa5lcSzfU2nEfATyD28wTp
 Oi38nNfyfmOanGufP58LQgqne4rA7Uv/QqqyPPXT9E+HNW6R/jE8pX1x7MPWihBNnVQ+VbqZsy/
 Q3OYU+dlk5gpiCU39VAZE3Pr8xU/spz0PRhJht/tgZkSiqph7iez+6COoazDoutI/L
X-Received: by 2002:ad4:5dc7:0:b0:8ce:b2e9:a4b9 with SMTP id
 6a1803df08f44-8de3bef23demr215020686d6.12.1782052642405; 
 Sun, 21 Jun 2026 07:37:22 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8df7f018011sm65579506d6.5.2026.06.21.07.37.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 21 Jun 2026 07:37:22 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Shuah Khan <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Tamir Duberstein <tamird@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, linux-kernel-mentees@lists.linux.dev,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 nova-gpu@lists.linux.dev
Subject: [PATCH] gpu: nova-core: parse structs via zerocopy
Date: Sun, 21 Jun 2026 11:36:44 -0300
Message-ID: <20260621143647.264770-1-nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 23 Jun 2026 08:06:53 +0000
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
for the `FalconUCodeDescV3`, `PcirStruct`, `BitHeader`, `NpdeStruct`,
and `PmuLookupTableHeader` structs with the derivable
`zerocopy::FromBytes` trait.

This change eliminates the manual unsafe implementations in favor of a
derivable trait. When this trait is derived, validity checks are
performed at compile time to make sure that the type can safely
implement `FromBytes`.

Link: https://github.com/Rust-for-Linux/linux/issues/1241
Suggested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Nicolás Antinori <nico.antinori.7@gmail.com>
---
NOTE: Compile-tested only. I don't own a piece of hardware where I can
test the nova driver.

 drivers/gpu/nova-core/firmware.rs |  6 +----
 drivers/gpu/nova-core/vbios.rs    | 38 ++++++++-----------------------
 2 files changed, 11 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index ad37994ac15a..0afd1d3fe5ad 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -86,7 +86,7 @@ pub(crate) struct FalconUCodeDescV2 {

 /// Structure used to describe some firmwares, notably FWSEC-FRTS.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 pub(crate) struct FalconUCodeDescV3 {
     /// Header defined by `NV_BIT_FALCON_UCODE_DESC_HEADER_VDESC*` in OpenRM.
     hdr: u32,
@@ -117,10 +117,6 @@ pub(crate) struct FalconUCodeDescV3 {
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
index 8b7d17a24660..754812bcbdde 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -13,11 +13,8 @@
         Alignment, //
     },
     sync::aref::ARef,
-    transmute::FromBytes,
 };

-use zerocopy::FromBytes as _;
-
 use crate::{
     driver::Bar0,
     firmware::{
@@ -301,7 +298,7 @@ pub(crate) fn fwsec_image(&self) -> &FwSecBiosImage {
 }

 /// PCI Data Structure as defined in PCI Firmware Specification
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 #[repr(C)]
 struct PcirStruct {
     /// PCI Data Structure signature ("PCIR" or "NPDS")
@@ -330,12 +327,9 @@ struct PcirStruct {
     max_runtime_image_len: u16,
 }

-// SAFETY: all bit patterns are valid for `PcirStruct`.
-unsafe impl FromBytes for PcirStruct {}
-
 impl PcirStruct {
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        let (pcir, _) = PcirStruct::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
+        let (pcir, _) = PcirStruct::read_from_prefix(data).map_err(|_| EINVAL)?;

         // Signature should be "PCIR" (0x52494350) or "NPDS" (0x5344504e).
         if &pcir.signature != b"PCIR" && &pcir.signature != b"NPDS" {
@@ -371,7 +365,7 @@ fn image_size_bytes(&self) -> usize {
 /// This is the head of the BIT table, that is used to locate the Falcon data. The BIT table (with
 /// its header) is in the [`PciAtBiosImage`] and the falcon data it is pointing to is in the
 /// [`FwSecBiosImage`].
-#[derive(Debug, Clone, Copy)]
+#[derive(Debug, Clone, Copy, FromBytes)]
 #[repr(C)]
 struct BitHeader {
     /// 0h: BIT Header Identifier (BMP=0x7FFF/BIT=0xB8FF)
@@ -390,12 +384,9 @@ struct BitHeader {
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
@@ -533,7 +524,7 @@ fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
 /// PCI Data Structure. It contains some fields that are redundant with the PCI Data Structure, but
 /// are needed for traversing the BIOS images. It is expected to be present in all BIOS images
 /// except for NBSI images.
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 #[repr(C)]
 struct NpdeStruct {
     /// 00h: Signature ("NPDE")
@@ -548,12 +539,9 @@ struct NpdeStruct {
     last_image: u8,
 }

-// SAFETY: all bit patterns are valid for `NpdeStruct`.
-unsafe impl FromBytes for NpdeStruct {}
-
 impl NpdeStruct {
     fn new(dev: &device::Device, data: &[u8]) -> Option<Self> {
-        let (npde, _) = NpdeStruct::from_bytes_copy_prefix(data)?;
+        let (npde, _) = NpdeStruct::read_from_prefix(data).ok()?;

         // Signature should be "NPDE" (0x4544504E).
         if &npde.signature != b"NPDE" {
@@ -845,6 +833,7 @@ fn new(data: &[u8]) -> Result<Self> {
 }

 #[repr(C)]
+#[derive(FromBytes)]
 struct PmuLookupTableHeader {
     version: u8,
     header_len: u8,
@@ -852,9 +841,6 @@ struct PmuLookupTableHeader {
     entry_count: u8,
 }

-// SAFETY: all bit patterns are valid for `PmuLookupTableHeader`.
-unsafe impl FromBytes for PmuLookupTableHeader {}
-
 /// The [`PmuLookupTableEntry`] structure is used to find the [`PmuLookupTableEntry`] for a given
 /// application ID.
 ///
@@ -867,7 +853,7 @@ struct PmuLookupTable {

 impl PmuLookupTable {
     fn new(dev: &device::Device, data: &[u8]) -> Result<Self> {
-        let (header, _) = PmuLookupTableHeader::from_bytes_copy_prefix(data).ok_or(EINVAL)?;
+        let (header, _) = PmuLookupTableHeader::read_from_prefix(data).map_err(|_| EINVAL)?;

         let header_len = usize::from(header.header_len);
         let entry_len = usize::from(header.entry_len);
@@ -1013,15 +999,11 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
         let data = self.base.data.get(falcon_ucode_offset..).ok_or(EINVAL)?;
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

