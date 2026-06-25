Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0EBCDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6765410F481;
	Fri, 26 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="NUEJ+Q8H";
	dkim-atps=neutral
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78CBE10F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:25 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-304f590dd91so425696eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420745; x=1783025545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3AKNe+HW/iOAU2SHoyF/WHAkP5lgz/mE/XVIjRk/zXs=;
 b=NUEJ+Q8HBRG94HcjAkC6BlpcrQyjwlXyab7+3Vr7v+70xdAcrvOb6WbkT65YHHlYvI
 1Dgh/O6gE96BJ2to1rU0PG7D6EU2Xb6tZbuea/miRkQzZjYgnqy0WJ9AJVhnyBFO7GJ7
 fwMyPsLmXtA+QtdepQE0iWL8PbGKOqYwQbCfasAvrRLKoevPDjmRPgxZGok0IEpPs7+H
 MHvG58+zcRv4fF3iUw8gTZrmQ/pVx5n8+eJZ0YRgmckmSP0qE9DMUrZR+2s+X+pUbCky
 i1mGIoFInrHF345T1PD78zIT4qQkzWA6STKNk4IrOzzKzPGyz+4VVowHSo7gdsjttbxq
 6q8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420745; x=1783025545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3AKNe+HW/iOAU2SHoyF/WHAkP5lgz/mE/XVIjRk/zXs=;
 b=OHcCIZOcS83uYMvY6S+SQpFXlNX3ZFQu5OvyRzTYrSnHnEhcWNg0pzQv60uQo3hNpz
 Jsau46q8fKeTXiYWjqGyAAPIUTuyxnO7YzzCJk1bAEqloMchWewhB8pLXHWQ8MPMJQku
 pRSY7brg2StYarha15CcLpO8VYSBzeMVH9G7tNshLtUupOgR1hnX1FY65pBEMXnlypVm
 12XXt+skwVXW55E1z9TJkMzvSCttX1dQGy2LnrN+Hgy/9ZFAfcbx/oRF0nxHzxGeIELC
 7e66IiSs+/GUXrNQqmLbONH7AQdYt5QiOh+Wzd2FOWLH0jI6CcAsiAvRUF6uAls6diCR
 S89A==
X-Forwarded-Encrypted: i=1;
 AHgh+RrfVZKC3nZp1p73T0R8DDHrgx8OOay1odfn0qjY6juY9ljxx5eDuPXfH/3kvQN4aEU6FBr9V19EbT4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybBKcJqllbC1p7R3ISHJxK+/pHpj9Gs/nc5hvojHZymDnxD1/j
 NxUH5T/Ls9jaX/feN967niwrsa64MKwaJ8IPN5qKFp8ICRo4N7eZhMLY6LKHS59trmI=
X-Gm-Gg: AfdE7clzE3atwtEbtIVB5CZOEaJ5Z10MTiKZo+sSVv2zFitzKQBfDbE4D8Hk+U1spSa
 D39/QUCk09TxBIQpCsvsmc4yBzYUT8Q3jFh5W2l9XoC/BbJvdU2KBbjNtjVWlsB3jNIwfJkXVuE
 8iQGcfTEItycoYWN+nt5bKnXWyEMuBcZlUNJR+lFyiXtxxVUh2+DNUPMFkskDdkVeO7acQ5693h
 2yp0LxRQMW1beaeEHqit2L2lXCoJcAhbN1hLqzcekMZlxZURh8ZI375fm1bmahNfHNLoe9KRmic
 a94hyJVTvVWkpH2ay0+FLvq8Y+bLE+9GFeXiMEfIUTm2fLHCWjjV3mS2hfl/MLVTbYUwzatOXqj
 apXnnkBh/5KdGw8tXYTX5SkYNDmFidrjWkcQcGmTS6VodL9z0Ga+Sr3j3zEfOQqQmktWHiO187l
 8bfbwPBgCZqLGExk94HvHzw6HRvQ==
X-Received: by 2002:a05:7300:190e:b0:30c:4f01:2239 with SMTP id
 5a478bee46e88-30c84d572f2mr4100921eec.9.1782420744677; 
 Thu, 25 Jun 2026 13:52:24 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:24 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 1/7] drm/nova: use `zerocopy` in firmware.rs
Date: Thu, 25 Jun 2026 17:51:40 -0300
Message-Id: <20260625205146.5047-2-niyudi.honda@usp.br>
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

