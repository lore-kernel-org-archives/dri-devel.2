Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52808CDE013
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 419E410F4B0;
	Fri, 26 Jun 2026 07:53:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="PXKyb1pe";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A9E110E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:15 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-13981833e13so283878c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414375; x=1783019175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOafAK7HDkFPoXdNsVBZ8vVOqlRlb6xT0ugQxmB4YIM=;
 b=PXKyb1ped0Dfkedg6IBXP8aIpn5cBsdEBoSPudz+YpuJUFjC+TwQ+mu8Ob8jLTOIAU
 3oUd7QfKGLlWgXNEo5HV+lND0Wsy5Mau3Inf/Mkszk5Zhpwwkz2TbhIpt4jdHUQUFbSB
 olDZPdUoPkl+/ehEvNZWwBvOhoRnNK7OSXiPOYnnJ9N6Fysl0YMrHakjiZKLFUhsjyS+
 jiECgeGuxtZnlkkQ/AlgQEMIzPF9nBofy/2vYch7ucd+4vMPzyaSibVl3u68QeeLb9ob
 QodyaXrfuGeacbcTbXMvXLvO/TeAFcBqPwsl95BcZ0uAWQ/vPvZltr9VM1G2XSDqRFkh
 7+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414375; x=1783019175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WOafAK7HDkFPoXdNsVBZ8vVOqlRlb6xT0ugQxmB4YIM=;
 b=rekti9wQYTve5jSjwpSnu+EyTiPv36jnbWLCB5tJblfeFoB4mNRd5DpCTh1iL8yyEN
 4/VmjhDGeK8utjQNB1CdmD5nOWIeoc5v8U+XGceaRAodk7YKhKEo1taWz5cBEiLwNIfv
 KhYJ6yYRQROUXgkLvYzi8j9P82j65UL6wbsiKSz6HB8Y9rxe5CNRAwCbsCf9pUIApItI
 lcRMNOueq/Z6J56+Wmjm+MtIom6ksBcoFkQhjPsRC0rNNFxvMtXXA+BLVrdduMsMzpsX
 zxj01ucUTyDVB4Fhnab+65bc2zdVIJPaUiTeSIrVBmibNVx4JjTA5/2c9A7088YLx3B6
 gsLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9awuB6Y590wYLcYhifIZg3S2kpVtIu0Lyhkxb5ADBKKdfJUwFXmyV3opeQYyPtbfqdH7Nl924O0jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhIiGEFF6ZPm4Da9wdXyV//lzWkasgzCkJrmgSyK0ptmitfCaf
 IMB37mWrEcLLfOV87SndGeQUDzqhOJubYA284VGzv8gFYe6bXSmQgS2yPaMDHdFLVho=
X-Gm-Gg: AfdE7cmHamCYCjSMvlhw/gE++ktqPheKU9arJjZWawCwp4O8ZH5iIa8jb6gYcRmY1hB
 ILZ3VXvo3K/Xab1/mUmxf7TG7YaWGpM7LXXvoqRtnTvBTxOfxugLUzGLUCD4/PaLtWEN4MfRMLT
 fPdvON9PBNgo2+DSTttowHaHyQAwRg470LPi76nLJB9OHm6skmIRLmD7fGP2OspRfUjfT4UNyai
 n1HbSfTm/oDc8QDxwpvqyz/R4Gc3ysVaXnv9mGfO8mzK19hKs2QL4MjBqyxWjxRRjEJGYln5YFy
 C+qtcq5R6LfqcWxPaEMwzzhr4j6lFSdc7dl1t1p7lVkk1Jc6Wvam3GjrfVm0+9PS08uOP+btr8P
 BYwrd/qR5BWmFi6V2Wzu00yvv1y0JPdLMcATOxa6jPsJtO92nGtqpxQ0Wph5WksHMPBsxTWuzhG
 UGezhd19e+9cAf9hE=
X-Received: by 2002:a05:7022:1003:b0:139:bf81:638b with SMTP id
 a92af1059eb24-139dba0627cmr3156576c88.4.1782414374519; 
 Thu, 25 Jun 2026 12:06:14 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:14 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 3/7] drm/nova: use `zerocopy` in booter.rs
Date: Thu, 25 Jun 2026 16:05:49 -0300
Message-Id: <20260625190553.7245-4-niyudi.honda@usp.br>
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

In firmware/booter.rs, replace the following `transmute` traits with
their `zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware/booter.rs | 26 +++++++-----------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index d9313ac361af..0cda2c50fbbe 100644
--- a/drivers/gpu/nova-core/firmware/booter.rs
+++ b/drivers/gpu/nova-core/firmware/booter.rs
@@ -10,8 +10,7 @@
 use kernel::{
     device,
     dma::Coherent,
-    prelude::*,
-    transmute::FromBytes, //
+    prelude::*, //
 };
 
 use crate::{
@@ -44,7 +43,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], offset: usize) -> Result<S>
     let end = offset.checked_add(size_of::<S>()).ok_or(EINVAL)?;
     slice
         .get(offset..end)
-        .and_then(S::from_bytes_copy)
+        .and_then(|b| S::read_from_bytes(b).ok())
         .ok_or(EINVAL)
 }
 
@@ -53,7 +52,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], offset: usize) -> Result<S>
 /// Such firmwares have an application-specific payload that needs to be patched with a given
 /// signature.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct HsHeaderV2 {
     /// Offset to the start of the signatures.
     sig_prod_offset: u32,
@@ -76,9 +75,6 @@ struct HsHeaderV2 {
     header_size: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsHeaderV2 {}
-
 /// Heavy-Secured Firmware image container.
 ///
 /// This provides convenient access to the fields of [`HsHeaderV2`] that are actually indices to
@@ -145,6 +141,7 @@ fn signatures_iter(&'a self) -> Result<impl Iterator<Item = BooterSignature<'a>>
 
 /// Signature parameters, as defined in the firmware.
 #[repr(C)]
+#[derive(FromBytes)]
 struct HsSignatureParams {
     /// Fuse version to use.
     fuse_ver: u32,
@@ -154,9 +151,6 @@ struct HsSignatureParams {
     ucode_id: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsSignatureParams {}
-
 impl HsSignatureParams {
     /// Returns the signature parameters contained in `hs_fw`.
     ///
@@ -171,14 +165,14 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
         hs_fw
             .fw
             .get(start..end)
-            .and_then(Self::from_bytes_copy)
+            .and_then(|b| Self::read_from_bytes(b).ok())
             .ok_or(EINVAL)
     }
 }
 
 /// Header for code and data load offsets.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct HsLoadHeaderV2 {
     // Offset at which the code starts.
     os_code_offset: u32,
@@ -192,9 +186,6 @@ struct HsLoadHeaderV2 {
     num_apps: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsLoadHeaderV2 {}
-
 impl HsLoadHeaderV2 {
     /// Returns the load header contained in `hs_fw`.
     ///
@@ -206,7 +197,7 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
 
 /// Header for app code loader.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct HsLoadHeaderV2App {
     /// Offset at which to load the app code.
     offset: u32,
@@ -214,9 +205,6 @@ struct HsLoadHeaderV2App {
     len: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsLoadHeaderV2App {}
-
 impl HsLoadHeaderV2App {
     /// Returns the [`HsLoadHeaderV2App`] for app `idx` of `hs_fw`.
     ///
-- 
2.34.1

