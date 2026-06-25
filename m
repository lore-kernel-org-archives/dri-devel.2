Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AA87CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A23B10F482;
	Fri, 26 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="mEW7gW8L";
	dkim-atps=neutral
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B97310F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:37 +0000 (UTC)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c6874d295so165645eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420757; x=1783025557; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Whz9p3Ho44DCR9pjX+bz8mpXVMfXqyHIujw7aYpp2e0=;
 b=mEW7gW8LVtEXaXeslSqUNYbwfv3vcYwUXD5zd3rDX9tvgYZdvE9zPd+0p+qSCa7ygk
 ssVdpBdL893TU1Xw3+vbD/OIfmuLKxiqB+z6y/7rP8kB5VySssbVYhxrqo1Cpy4glNwv
 2GJS7FInqz/ZY3ecXiUbxbHjBQdpQ7Cs5vsan1lroDYaZJMxYAWcMe1ikLrFQBbT2vqJ
 mV5MuitzVHsiumtY3+m95imesJ2nhkmfG8ndCyH8pqhYpvOR2HQ3Mw1LFJlZ9s3QqBke
 knSezqsJ8ViFE2aBHFI3gm3yFsyIyz7h1kLVNNs41t2pG4zBfkFPKXQGrykIzpZ6S4zK
 6a8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420757; x=1783025557;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Whz9p3Ho44DCR9pjX+bz8mpXVMfXqyHIujw7aYpp2e0=;
 b=EU9FLlAqlODdcK6YQ9v7LcbGwFLc0mWT/wAP+pw4IpsOfoa3a5XblvRmM9peVeTXwt
 i6/LSMZGycfvBHwvHgH45I7nQSquzN2kyPEVjkXpHzgRl2VtSdKa1DGVpcMw/YAY3v4Y
 d+dNfVr1mKoaelTnZFYk6IQONOiVk6ytSXxFtNEnhNrsl9kFcX2CT/Ee9UBQ+f3Ueblo
 YJT4QC/22q/YpsRmjQM0oTtQ3bgAT+Zn0n2ZiwWEjF/bXFAhasUwlhx9tY5R2ReniIDj
 W8V+IKkn6AdcOijT4LOhTP1K0IsFkWyGMNYZKgPXyt2pGNTDDiipx6bw++VK0DzdUjlN
 Kpiw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/eUkrOMpuHpyeqYoOesDYPy28SygqUXzyHOD8G2VeJfMxQl7r8JLmF2Qwvy0R1ECocrX4nI+oSVc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxc2EEgozAV3sZuk5t8PK7B5hCrZcwLxMaJyjboxpb++HfnlrC9
 Acfcb8O7mE/kWf2S7aDRqHNkl0Ch7ochtihpYql/tVNPUcwoh9pAY30he5i3/rqsvwI=
X-Gm-Gg: AfdE7cmd8Ou4dKMvgGPGVRLmTDHIipoSOrDnEqu+xPtfjcy0YdlmEKDMsssAqVo+UEj
 foQCnqScxu825aj0Llqf1Ca9fb58tUT81pXo/TqCb8ZUHPglVBiAbE0MZvNwcXFiYMl7MomX6Bk
 oJs1niOLV01cUTytFKs2sTFq1bTlQ+xsQWGuocyKCC7T2LUKW1KBrl9J9MI9ma+8BUuKHpeHWaq
 u9G6MNoI0apCB1yYjXNticc+3ORBUpSzjwjxhM8D6QYGLhR5khhS7tyFjrSrKLl99bRKJysGc+o
 zjq6m4ONi5hLNT8x8Bn4/Z6rNOIXbpLreLTJiFVvZbWR+QKj6ovz0R9HPsim8TPpgADwrcaYM6z
 TutF4qzKfZhg/KTp6LSHeLV3hMD6+Y/uNQRyoewVavfrF3hpV7z4tzn9b14XiMiYJwisRNiNxut
 FDi8FhU9TuS6l8MpGa7TPQJJ06Vg==
X-Received: by 2002:a05:7300:fd08:b0:30b:fb88:f059 with SMTP id
 5a478bee46e88-30c5562a8a3mr11239343eec.15.1782420756594; 
 Thu, 25 Jun 2026 13:52:36 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:35 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 4/7] drm/nova: use `zerocopy` in fwsec.rs
Date: Thu, 25 Jun 2026 17:51:43 -0300
Message-Id: <20260625205146.5047-5-niyudi.honda@usp.br>
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

In firmware/fwsec.rs, replace the following `transmute` traits with
their `zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`
- `transmute::AsBytes` -> `zerocopy::IntoBytes`
- add `zerocopy::KnownLayout` where necessary

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware/fwsec.rs | 47 ++++++-------------------
 1 file changed, 11 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec.rs b/drivers/gpu/nova-core/firmware/fwsec.rs
index 199ae2adb664..aafa481d805f 100644
--- a/drivers/gpu/nova-core/firmware/fwsec.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec.rs
@@ -20,10 +20,6 @@
         Device, //
     },
     prelude::*,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    },
 };
 
 use crate::{
@@ -50,26 +46,22 @@
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
@@ -90,12 +82,8 @@ struct FalconAppifDmemmapperV3 {
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
@@ -104,12 +92,8 @@ struct ReadVbios {
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
@@ -118,22 +102,15 @@ struct FrtsRegion {
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
@@ -152,11 +129,9 @@ pub(crate) enum FwsecCommand {
 
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
@@ -229,7 +204,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
         let hdr = ucode
             .get(hdr_offset..)
-            .and_then(FalconAppifHdrV1::from_bytes_prefix)
+            .and_then(|b| FalconAppifHdrV1::read_from_prefix(b).ok())
             .ok_or(EINVAL)?
             .0;
 
@@ -247,7 +222,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
             let app = ucode
                 .get(entry_offset..)
-                .and_then(FalconAppifV1::from_bytes_prefix)
+                .and_then(|b| FalconAppifV1::read_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0;
 
@@ -264,7 +239,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
             let dmem_mapper = ucode
                 .get_mut(dmem_mapper_offset..)
-                .and_then(FalconAppifDmemmapperV3::from_bytes_mut_prefix)
+                .and_then(|b| FalconAppifDmemmapperV3::mut_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0;
 
@@ -282,7 +257,7 @@ fn new_fwsec(bios: &Vbios, cmd: FwsecCommand) -> Result<Self> {
 
             let frts_cmd = ucode
                 .get_mut(frts_cmd_offset..)
-                .and_then(FrtsCmd::from_bytes_mut_prefix)
+                .and_then(|b| FrtsCmd::mut_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0;
 
-- 
2.34.1

