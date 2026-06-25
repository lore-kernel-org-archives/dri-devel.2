Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ECA5CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A204510F4B7;
	Fri, 26 Jun 2026 07:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="SF5am4+g";
	dkim-atps=neutral
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8367810E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:08 +0000 (UTC)
Received: by mail-dl1-f51.google.com with SMTP id
 a92af1059eb24-1384ebe7a10so480718c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414368; x=1783019168; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AKNe+HW/iOAU2SHoyF/WHAkP5lgz/mE/XVIjRk/zXs=;
 b=SF5am4+gMoOPk1cuIHEinNrQlrGgw51eebHuaaJ2pnIEtbhdKe7rqIbxOQQRZlpuVf
 njpz9ijld+qOUU99U7LWodFdow6NPx9quttOgVEuyK+RizF26rtdaKRw7tIrD6YXjClY
 lfc7icHhRBPo2AJ3vSi23aoeuYfXoQ9TYgvk7VHlmqtKiuBsGI1Oo3XfmV+bBV5nKG7J
 63hxhnARK+APRLWl4w1dJF/E7ZpqOlIWH44FY0iwutUfyGyAC2LHJF5NY7d796o8XAWu
 e/EwabqWwAsCvvckdNg/K0a9gq1l9ratow2uPNRIdSRPu7bvYvxle62qVv4xAC0jC6Fu
 lMHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414368; x=1783019168;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3AKNe+HW/iOAU2SHoyF/WHAkP5lgz/mE/XVIjRk/zXs=;
 b=WQPfzolpJH7OVWAPjdvJEcbXh62lJUI0S6ElUpozodc0I9QZU/LqGlGXPrjTRynPak
 AAVmyaZmMufSzUnqjsE7+hY0MryjtGAzK4shoakpDe8FhvVxqN/GGdB9Ob6fH20t0RKP
 HyOWDtavYnDZxzXy4y2lZBcelF2AxSbylQTaQ1VpP9i6F9RcTjQSxjOv9xV7qlfr/1IC
 VO5+kfi3/X0ioqbIj2oGnRTYh1Uq5c4XBBwIZKLXaXcK+jedJoTcw+4qBtx1MDbRdNJu
 NY/zrJl3WyDqjHWg02om2cbw2iCMhAhJ+kZTfL0LGYtt7IcGW45RIaSBMAi5C3iyxjBg
 THpg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+7iWvMBDHwVYHYnRr+6+ZqgDEci791O8B5+Hampd8mfJz2ilZB1ExgOZStkCjtYk1rp7g5OFpRNvg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwfCHiz9Cs4khmyubo+RJ7Ah62JFY5JyelsAB8jjiRZD/f63lgz
 pTwfJOkoe5r/LD6P2iNDPWYIhs6mG4UhP3fS7FIVOTpTbgMm1Ul1UIHZa3A6nCJ3iZ0=
X-Gm-Gg: AfdE7clH5hldU/noi+9yAOhlBvMceqwbu4fLHiSZiIOvyOAj4A/ymMdDiLu+kIkN8GV
 qAH5sTQDRSWHsx/aHWFiQUsX0a0PUXu1aUQax1WswXUaCpDCPSXoLClXVkOYUvIZktLJjq2AEsw
 Wcgk47nttwAhp6v2ycOiEZIV9PtMbBP7QnzBuEDlo/32sjboG3wsQLX7XBVI6kiflMwu5aT2Lwd
 lCSUWSrSy5I7dJrQvo5HGwDQfJ8XBFAFzI/yy8Y7ccRcLoyuKw3uaXttvYjafz1kbWY3XkR4tcx
 60f5OpWLV8xx/AcJBcvs6KOctKIR02NATCMcS+iBeNiWSh49uhPXTywkl6HNIhbX41TGVVSLLCD
 OpgZNar50ILleJA1o9ASHoQjOCErOSg4qiLJW+EcctMIvOVHcZAAFrtHki9qtlWmKRRYg4Puowb
 v/Cp4K+4WVSc9BFV0=
X-Received: by 2002:a05:7022:90a:b0:130:9b78:b17b with SMTP id
 a92af1059eb24-139dbb8fd11mr3540098c88.38.1782414367476; 
 Thu, 25 Jun 2026 12:06:07 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:06 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 1/7] drm/nova: use `zerocopy` in firmware.rs
Date: Thu, 25 Jun 2026 16:05:47 -0300
Message-Id: <20260625190553.7245-2-niyudi.honda@usp.br>
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

In firmware.rs, replace the following `transmute` traits with their
`zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Note that the module `elf` is untouched, as the bindings generated by
bindgen do not implement `FromBytes` for the structs.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware.rs                | 16 ++++------------
 .../gpu/nova-core/firmware/fwsec/bootloader.rs   |  4 +++-
 drivers/gpu/nova-core/vbios.rs                   |  4 ++--
 3 files changed, 9 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware.rs b/drivers/gpu/nova-core/firmware.rs
index 1e89390209f5..1eae03344a61 100644
--- a/drivers/gpu/nova-core/firmware.rs
+++ b/drivers/gpu/nova-core/firmware.rs
@@ -11,8 +11,7 @@
     device,
     firmware,
     prelude::*,
-    str::CString,
-    transmute::FromBytes, //
+    str::CString, //
 };
 
 use crate::{
@@ -88,7 +87,7 @@ pub(crate) struct FalconUCodeDescV2 {
 
 /// Structure used to describe some firmwares, notably FWSEC-FRTS.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 pub(crate) struct FalconUCodeDescV3 {
     /// Header defined by `NV_BIT_FALCON_UCODE_DESC_HEADER_VDESC*` in OpenRM.
     hdr: u32,
@@ -119,10 +118,6 @@ pub(crate) struct FalconUCodeDescV3 {
     _reserved: u16,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use
-// interior mutability.
-unsafe impl FromBytes for FalconUCodeDescV3 {}
-
 /// Enum wrapping the different versions of Falcon microcode descriptors.
 ///
 /// This allows handling both V2 and V3 descriptor formats through a
@@ -351,7 +346,7 @@ fn no_patch_signature(self) -> FirmwareObject<F, Signed> {
 
 /// Header common to most firmware files.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct BinHdr {
     /// Magic number, must be `0x10de`.
     bin_magic: u32,
@@ -367,9 +362,6 @@ struct BinHdr {
     data_size: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for BinHdr {}
-
 // A firmware blob starting with a `BinHdr`.
 struct BinFirmware<'a> {
     hdr: BinHdr,
@@ -385,7 +377,7 @@ fn new(fw: &'a firmware::Firmware) -> Result<Self> {
 
         fw.get(0..size_of::<BinHdr>())
             // Extract header.
-            .and_then(BinHdr::from_bytes_copy)
+            .and_then(|b| BinHdr::read_from_bytes(b).ok())
             // Validate header.
             .filter(|hdr| hdr.bin_magic == BIN_MAGIC)
             .map(|hdr| Self { hdr, fw })
diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 039920dc340b..13af1c381df1 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -29,6 +29,8 @@
     },
 };
 
+use zerocopy::FromBytes as _;
+
 use crate::{
     driver::Bar0,
     falcon::{
@@ -154,7 +156,7 @@ pub(crate) fn new(
         let hdr = fw
             .data()
             .get(0..size_of::<BinHdr>())
-            .and_then(BinHdr::from_bytes_copy)
+            .and_then(|b| BinHdr::read_from_bytes(b).ok())
             .ok_or(EINVAL)?;
 
         let desc = {
diff --git a/drivers/gpu/nova-core/vbios.rs b/drivers/gpu/nova-core/vbios.rs
index c6e6bfcd6a1f..e6d144587c4e 100644
--- a/drivers/gpu/nova-core/vbios.rs
+++ b/drivers/gpu/nova-core/vbios.rs
@@ -935,8 +935,8 @@ pub(crate) fn header(&self) -> Result<FalconUCodeDesc> {
                 Ok(FalconUCodeDesc::V2(v2))
             }
             3 => {
-                let v3 = FalconUCodeDescV3::from_bytes_copy_prefix(data)
-                    .ok_or(EINVAL)?
+                let v3 = FalconUCodeDescV3::read_from_prefix(data)
+                    .map_err(|_| EINVAL)?
                     .0;
                 Ok(FalconUCodeDesc::V3(v3))
             }
-- 
2.34.1

