Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57611C43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32F3110F1E4;
	Thu,  2 Jul 2026 07:51:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="WZZ2ZKvj";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4BF810E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:41:21 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8478a25f268so545472b3a.2
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927681; x=1783532481; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFceAFuK036YUVrKWQ2ER28PIOKf2Yja+50h/9H1BAo=;
 b=WZZ2ZKvjFFVLVmEboMGU+g9PPiaSNBwxh9mE38H9UGIsJ1hXnYfDaa+YD54rqncwuv
 GHxArAsbiiqmxLMHE0CEiqr/EmYAHbPBbiz+MF6RgeE7MfP7UHep34n1z3JwXtB9rFaw
 fCOPsxq5Sgk1PUDu0ICBpo2bX4OxEdrxIEVTYlFJngCZ+G3zpO5Wu3jsu7Aj0FZToi59
 sxLKs2EdpSbrmiEujxly1c3tCQz/UrKfe5cpS0mlw8axblMBPIa3Dqms3j65XUoNjNVX
 R8IhxbAWoUohcPC63m+pGzIBoHQxgqGABOLqhShqoBR8ucYC8/+3yc0Qy0CoSH6aWhHG
 cJzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927681; x=1783532481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFceAFuK036YUVrKWQ2ER28PIOKf2Yja+50h/9H1BAo=;
 b=B8pqme4pwX2gPmEsYLsKkMLD+KRy2kUiy2LU0hXsKTEJwxn2Mk1OLcBn2fTt3Xh+vB
 aqRklZI/T0AMVWLsTTHNOqBtJiPmevTN2ztPpDqNaYibd3FTe8x+jbB1Huuz6leSL2+A
 DeKkl3Cqv+n8C5IU2eMcqMvVYyrPEipv/scsOyPf9VLM4/kEYpzYMh7oylsnMPQav3H7
 QA16fG5uyaRYI0IlC2rHv/mXx7alKk2EslmWMGgEbkUmYRu3It/XNAL6vP33DEjeiKxM
 ZXbmIvDtck9LVQJscE9qXdqkzKWDhYNpx6uOjxyYcMC45VkY1XtqPU3cm2YeVryZ0z8K
 G8xg==
X-Forwarded-Encrypted: i=1;
 AHgh+RojIwGPi8y0txZbUMQ5eWy5V/1M0h11K8rtC5+iqqR0cL1Qe0+3PmNQiB/e4UK6Kd9iVULDYK9OJJs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwI+Hz+FOvUzLsJd4/1u/aNdNhIT1EXlrGXEbIfynYfvLCw93r+
 AsTHTTMZdufnJnvsaHhBCNAYJYtBvY2HtgPBdyqHCkup8nuTVngiUegUMa7oXen3190=
X-Gm-Gg: AfdE7cnEcp+2qsmZk/mBFjyESMJFntI4i6rdPVk26DQzi2aTUp1ZE7wXoOKE7nTHPQD
 rRxe48CWk/FNc74O+QW4nFGCgJasgtZzzZM0MBtZ18XlhrRJ4UPjAwSx8cfqrvnlkUZ50hvijfg
 JUtPBy8mZ+l06VRlfqqXLbtR7U5JyCM4D/uf/d5R87OmuAVj5YS7LgQ16PWL6FVAO9wdTxhc8Mn
 BeRa+KhAaksDAvbqOqURGpfnuUb22vWFvfQZ7E/blObggawHwfAG90ZSeTnyLMtTGtZOxebIb0g
 fm5yRfJzQnaoCbn1B7PTa9CnCTHlmnMyoOaAMDVOgNmDF4avn1CABI/C4zZjxhUpBjGYS29d8TG
 tJaP+gn8GjUY2Fc0DrsVDGTUWIjMby63hNceWrrVB7482twhzlchfgNOB8f54ccCtPa8p7JBMl4
 owH1Ei1GZ7MWaccs8=
X-Received: by 2002:a05:6a00:194b:b0:847:78ad:e1e3 with SMTP id
 d2e1a72fcca58-847c5182f69mr1755324b3a.41.1782927680927; 
 Wed, 01 Jul 2026 10:41:20 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc4d0sm150943b3a.3.2026.07.01.10.41.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:41:20 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 3/5] drm/nova: use `zerocopy` in fwsec.rs
Date: Wed,  1 Jul 2026 14:40:54 -0300
Message-Id: <20260701174056.12604-4-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260701174056.12604-1-niyudi.honda@gmail.com>
References: <20260701174056.12604-1-niyudi.honda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 02 Jul 2026 07:51:30 +0000
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

In firmware/fwsec.rs, replace the following `transmute` traits with
their `zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`
- `transmute::AsBytes` -> `zerocopy::IntoBytes`
- add `zerocopy::KnownLayout` where necessary

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware/fwsec.rs | 49 ++++++-------------------
 1 file changed, 12 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 95e0dd77746b..1b75cdc02256 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -19,11 +19,7 @@
         self,
         Device, //
     },
-    prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    },
+    prelude::*, //
 };
 
 use crate::{
@@ -49,26 +45,22 @@
 const NVFW_FALCON_APPIF_ID_DMEMMAPPER: u32 = 0x4;
 
 #[repr(C)]
-#[derive(Debug)]
+#[derive(Debug, FromBytes)]
 struct FalconAppifHdrV1 {
     version: u8,
     header_size: u8,
     entry_size: u8,
     entry_count: u8,
 }
-// SAFETY: Any byte sequence is valid for this struct.
-unsafe impl FromBytes for FalconAppifHdrV1 {}
 
 #[repr(C, packed)]
-#[derive(Debug)]
+#[derive(Debug, FromBytes)]
 struct FalconAppifV1 {
     id: u32,
     dmem_base: u32,
 }
-// SAFETY: Any byte sequence is valid for this struct.
-unsafe impl FromBytes for FalconAppifV1 {}
 
-#[derive(Debug)]
+#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
 #[repr(C, packed)]
 struct FalconAppifDmemmapperV3 {
     signature: u32,
@@ -89,12 +81,8 @@ struct FalconAppifDmemmapperV3 {
     ucode_cmd_mask1: u32,
     multi_tgt_tbl: u32,
 }
-// SAFETY: Any byte sequence is valid for this struct.
-unsafe impl FromBytes for FalconAppifDmemmapperV3 {}
-// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
-unsafe impl AsBytes for FalconAppifDmemmapperV3 {}
 
-#[derive(Debug)]
+#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
 #[repr(C, packed)]
 struct ReadVbios {
     ver: u32,
@@ -103,12 +91,8 @@ struct ReadVbios {
     size: u32,
     flags: u32,
 }
-// SAFETY: Any byte sequence is valid for this struct.
-unsafe impl FromBytes for ReadVbios {}
-// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
-unsafe impl AsBytes for ReadVbios {}
 
-#[derive(Debug)]
+#[derive(Debug, FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
 #[repr(C, packed)]
 struct FrtsRegion {
     ver: u32,
@@ -117,22 +101,15 @@ struct FrtsRegion {
     size: u32,
     ftype: u32,
 }
-// SAFETY: Any byte sequence is valid for this struct.
-unsafe impl FromBytes for FrtsRegion {}
-// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
-unsafe impl AsBytes for FrtsRegion {}
 
 const NVFW_FRTS_CMD_REGION_TYPE_FB: u32 = 2;
 
 #[repr(C, packed)]
+#[derive(FromBytes, IntoBytes, zerocopy_derive::KnownLayout)]
 struct FrtsCmd {
     read_vbios: ReadVbios,
     frts_region: FrtsRegion,
 }
-// SAFETY: Any byte sequence is valid for this struct.
-unsafe impl FromBytes for FrtsCmd {}
-// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
-unsafe impl AsBytes for FrtsCmd {}
 
 const NVFW_FALCON_APPIF_DMEMMAPPER_CMD_FRTS: u32 = 0x15;
 const NVFW_FALCON_APPIF_DMEMMAPPER_CMD_SB: u32 = 0x19;
@@ -151,11 +128,9 @@ pub(crate) enum FwsecCommand {
 
 /// A single signature that can be patched into a FWSEC image.
 #[repr(transparent)]
+#[derive(FromBytes)]
 pub(crate) struct Bcrt30Rsa3kSignature([u8; BCRT30_RSA3K_SIG_SIZE]);
 
-/// SAFETY: A signature is just an array of bytes.
-unsafe impl FromBytes for Bcrt30Rsa3kSignature {}
-
 impl From<[u8; BCRT30_RSA3K_SIG_SIZE]> for Bcrt30Rsa3kSignature {
     fn from(sig: [u8; BCRT30_RSA3K_SIG_SIZE]) -> Self {
         Self(sig)
@@ -228,7 +203,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
         let hdr = ucode
             .get(hdr_offset..)
-            .and_then(FalconAppifHdrV1::from_bytes_prefix)
+            .and_then(|b| FalconAppifHdrV1::read_from_prefix(b).ok())
             .ok_or(EINVAL)?
             .0;
 
@@ -246,7 +221,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
             let app = ucode
                 .get(entry_offset..)
-                .and_then(FalconAppifV1::from_bytes_prefix)
+                .and_then(|b| FalconAppifV1::read_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0;
 
@@ -263,7 +238,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
             let dmem_mapper = ucode
                 .get_mut(dmem_mapper_offset..)
-                .and_then(FalconAppifDmemmapperV3::from_bytes_mut_prefix)
+                .and_then(|b| FalconAppifDmemmapperV3::mut_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0;
 
@@ -281,7 +256,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
             let frts_cmd = ucode
                 .get_mut(frts_cmd_offset..)
-                .and_then(FrtsCmd::from_bytes_mut_prefix)
+                .and_then(|b| FrtsCmd::mut_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0;
 
-- 
2.34.1

