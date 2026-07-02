Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34F8DC43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E7DC10E58E;
	Fri,  3 Jul 2026 07:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="LoEdiY8W";
	dkim-atps=neutral
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com
 [209.85.221.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D56E910F330
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:05:52 +0000 (UTC)
Received: by mail-vk1-f169.google.com with SMTP id
 71dfb90a1353d-59d7db12342so421204e0c.0
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782993952; x=1783598752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KFceAFuK036YUVrKWQ2ER28PIOKf2Yja+50h/9H1BAo=;
 b=LoEdiY8WNwK56BlExI6WQpfX2TlF5y0iwbgwwyCG4f1zuffaXJbzM2WTKPMJxgslLw
 EENnO4o+4ze9y2crDL2JqqmLX27yYr7IxmGvEvvdzCqWo0N2Qu0Et48XMRfGyOEYd7ej
 Ri/7HtleHVlxGERJe3vaEOFsodeiyXSACsx80hocxtgJgyhuJ9SveKq42h/+rXCVDWcw
 20KI3Q9yfRLGyvXoSao/yQRvseK12AeLfHADuH/sDPAuZEgedaU0zYM7HadD72zn+PMl
 jKl/yQ9Jtfb204hM7wr/WUzWQLKfkFupzAm8gRPBEGP9wi3rUcbGkmqRmluJ9GlL0p/S
 RKUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993952; x=1783598752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KFceAFuK036YUVrKWQ2ER28PIOKf2Yja+50h/9H1BAo=;
 b=Gi8jfXrlmrhIuEvW7szVbTRpSuiE4OfnHFan62igNVoF/htx4WTP5ALm1xo9UnbtXN
 v/GvG17DkL8bUKOHSSeFgzvF/7U9fllU2bPmxVa5+PRYWKkV3KHTmDrci01/xBGbxwBm
 LlL+l7HIIbZbSUZcwuc7aurLslA/MVOjmUF6ItUXvaQPdrXnNlhFg0jaaoMwEsFpJHK5
 4EuAcjIa9XDHYDDZWM3stc51feFSXjWOevxi2JEqLG1BUJdps9jeivQVwsns+DPWhngg
 v/1QvzlGC99iBQpzVfgp1RFAqUy0lbtuUm9UNwY6+UCahQrzNe8OtFZGXQtz6bp7xalI
 tTBw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr1Hk2kpXqtSo25+Q3Iw2Mp4iIzeIv2S4lP5dgunR+Aeqn/F9JZrfOUZYEIfPaQyKTKK1FcOHjY8kA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyZ0CCj3jgnnIYfDCAdKFjpGxW+opGN134hN8pUKhQ2InBqcm6T
 U/A/6zZmhrbgzsVd36rNDd3YfjDzZ7s5fLFuERtT1tmAH/asolwxiLylN+HhXj+bUKg=
X-Gm-Gg: AfdE7clSOmPny7CDI/LdjpSiJR6m3L+JdzrTJpo7Lw9CWzSYSdpM1cTy1Sgt556frh0
 2HhKN1qUZiBy4qFB7jVyvQHwHbY9gl1O37K71vgRrNJILnESNNYHKH33JAxWJmhf093EOrIZpCE
 oirOhstE8QcwIqTx0dAQBLQVQ6S2ig8zQijysVUeWsEZarGHwunvOsYDDT776AZrEzL3SpEnLQr
 G3IuZ0wU/xINDVc6p26SYERY+vPnAR0SupRlO0QQ/Nb7h3hFtkNTGyCOLEEH3rCQPAYENqkR2t5
 u/+NlOjQxi1Fru5BxGxPPcUQUYcgcyzUFZJ11dfTiVPfBfxMh7F4usudlfUbo8O3IORiwpf7U/W
 YZIEnvwQCPQ/zPpusXg88lR/+rVJcJAuC3BdfF1IsnVd43te2DkF0KN+DyC+yDJPjTYsu0F6y10
 gBn5LVJUwNZGgynC3NqpKtJs6/MA==
X-Received: by 2002:a05:6102:689a:b0:73a:2195:4386 with SMTP id
 ada2fe7eead31-73daacc3e92mr2255449137.24.1782993951555; 
 Thu, 02 Jul 2026 05:05:51 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1caf43casm1182470137.11.2026.07.02.05.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:05:51 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 3/5] drm/nova: use `zerocopy` in fwsec.rs
Date: Thu,  2 Jul 2026 09:03:22 -0300
Message-Id: <20260702120324.40388-4-niyudi.honda@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260702120324.40388-1-niyudi.honda@gmail.com>
References: <20260702120324.40388-1-niyudi.honda@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 03 Jul 2026 07:04:17 +0000
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

