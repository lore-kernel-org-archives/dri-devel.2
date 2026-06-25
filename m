Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 366C8CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C0810F490;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="NyEqThqT";
	dkim-atps=neutral
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE77210E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:18 +0000 (UTC)
Received: by mail-dl1-f45.google.com with SMTP id
 a92af1059eb24-137eb0d76beso648067c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414378; x=1783019178; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Whz9p3Ho44DCR9pjX+bz8mpXVMfXqyHIujw7aYpp2e0=;
 b=NyEqThqTQidmV8hTFUiz2g+DTck723+tsmGr4Kt8wucy1/umBwY/8+/CBPEhY/l8xK
 4l7nC2cBsE0ctwQFOObYUDV6j/0pnu1JoJ4pI58sPjM+iBOBlouCZVO4gHAj4ray8/Xp
 N+dmd2tiAV4Rr/R/NPgcQzH1b57Ycl20iQtEfr/p1VRjkklvBu+fFH6ADMCwEk8VYCLx
 AFIEHkqVlBXcOBDKL0DUXPZT7+vsT0cgfglHbN9+Iuc0WgGKdHoIf1JGUWm1mOyGk7Jo
 tTeFRbKrshUau64UkXdnTr62d1SX6nCxaUZSivvR7KP4AF2LEhk/voWYLogkztnQyZpm
 8Xgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414378; x=1783019178;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Whz9p3Ho44DCR9pjX+bz8mpXVMfXqyHIujw7aYpp2e0=;
 b=Eb81dOjv/MUB+0JRodNRIQOvN4LYUYE5rF1Wq7WujuFKLHiiI+WuTxaaBprBi/pMUr
 zKlPtVOQriwUE0Qk1wtjFQRZl4k4+X+5s6Dp2By6zBTBdTp6t41OVGmoB1gbUtKebT+R
 K7T12Q5NN42yOku+39mduaYp+tLhWFa7TkY83bbQyow32xDO2S164EFfLEV2JOIA6R8s
 TSkXcNVr6dLN/cECuWvzmvz0HyZ8tl7BVcWkmROBNv62fCb8MghBatPWYG15nIIvpzSx
 90dbrDkBnUc9hbO+8eq0awNxGDFCNfQaImHb/H5vPDXUpbLJ7tb4fPUhJb9LZ7N4vrrw
 3PCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wgsAfI+akEjy/IA3SNnzZZZOYXFzBkhlvDDt209amqI4sXVSMq0NWGrYCBny1HKdX+ndgN1Ks+y8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEFIK58exr3HsN6h1UdJUl+nuRWWIVwTgVzJJoiUN+xL84yWb+
 dFZ6rP8qJwfGKsV5afQS2jy+37233wO5OSLvVFQWdcCk93tOL45Vp2xUDAAagrh/zDo=
X-Gm-Gg: AfdE7cnRUxwtHTCIG6QqOe01cphQvdUXMnmOJ0MNlmL5mrliCDuUyC0ytoPQHKYRGL1
 DgqCT0TUSR2QPjXQstiThPmTEqesm8YxPBqEodMG1HRJyPJWK+rMm3X7mr21Y+cBPIpP7Blys/I
 6iJQKGTlfHfz3PrMuTn0wtFXBE5K6O71i6KbsNkki2aYsY523I3oesyVmUA4bXpD5mAuXOrWau+
 JXYR7uBRKmbOlv5xzHYJ9BZe9vnd07m2MTKT2GOC0xxgGuyDEhq+8FfWYriYMy3DFWWLZTuqayb
 8wjQWutXzI0arMm1T1cGdv3hG0OMjw093uhbYVho89vKNOYreCVG9nUvoBCpQlN/iIuQ+9yZuhS
 2CZg5S5KqB74zN4KKuGTzL1m4A5D1jiH7/+yDFkvwS8jcV7sxJhe6UCZeCfF78Zzbi0XhpfscL9
 hsLS6HD7TdiWl0L88=
X-Received: by 2002:a05:7022:f9b:b0:139:85c2:d7bc with SMTP id
 a92af1059eb24-139c3c1f8a7mr10323239c88.6.1782414378043; 
 Thu, 25 Jun 2026 12:06:18 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:17 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 4/7] drm/nova: use `zerocopy` in fwsec.rs
Date: Thu, 25 Jun 2026 16:05:50 -0300
Message-Id: <20260625190553.7245-5-niyudi.honda@usp.br>
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

