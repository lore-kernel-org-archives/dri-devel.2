Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0889CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3797310F4A5;
	Fri, 26 Jun 2026 07:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="KtWzbuiI";
	dkim-atps=neutral
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3109E10F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:33 +0000 (UTC)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-13809223fd4so370385c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420752; x=1783025552; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WOafAK7HDkFPoXdNsVBZ8vVOqlRlb6xT0ugQxmB4YIM=;
 b=KtWzbuiIv+p88aWZzuhO1v2GEmKiVJJcShh876QJYD2PWxh0h+fzSgiwFyqxQ7jpfP
 1Ets+Cdtzd+bntDay0AtCYfw0KqqNTlxo6fxy8dTAYUx0ecA0iMIugNLx0Fi2Q7suXsf
 Z/1ZRR02HqJ263pADxpAE5jMu4wT5jJ9qd+gcHgbnrZ9vVraPmlAZl1IOhnHapU6FUcj
 dzndMZag2GklHMncRwQstdcl30Eq2luzExI81Ws0b0RCNlhtvW0V3YQMsKrR2/zccXGe
 wP0kwE7N1hXJZ3uUtQBmBS2kQBw60uT3h9o10ghdmzgWgKvCQKo1M+11S3IBMqEGpveg
 RzYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420752; x=1783025552;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=WOafAK7HDkFPoXdNsVBZ8vVOqlRlb6xT0ugQxmB4YIM=;
 b=CFg436k4G48QdUF/H/byUH93l1n2If5wChc9k0552zvG+xfWS+hZwjicNsVe9F8tgL
 /Srr24Dl6cEPPbxRXP/MkeyCtdAWDQ2QTnWGbISLt2GuYV4pKK5VZU791U3x/NiXMPkB
 79nRq2dgVs7HHjknr0x8wiNilkyFqybEgoZwQdjmMBqfLlWMrISpx+eDyZ0aFH8WNP61
 CNKoJkaXq00iuzSTAZvTXuAIsDOc11m0Uh8ZBUFEatlhuJ7NIOK2s0oA9bpowCGlwpvu
 xQSl34PED+sYmi/7QAUHaenRVvGa1OXEdnlg0Dr0Ysc48KdLxAwI9dKGIA8CGS3/z4An
 yRng==
X-Forwarded-Encrypted: i=1;
 AHgh+RowMZlwdEaIqD67hWXDrBK92BBADORQWN2N8aWl1qYuSofTirHmrHJYYhUEIxZ6Lrzlyp/SXFui3ns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy38qIjUXNDwWXSsaSzsB6xnc44qdDSl4bwKMmS/qgsPVGEVKaB
 uAj8hrsU4yRMOaV1T2efWjRIrSa/BQQZX+lh/fkFnfFY8VSCsS48HD9B4fzpqbL384k=
X-Gm-Gg: AfdE7clxUYY6OauASGbwVYeC/yUDX0jaOicFAm0x3WS3zojX1ANAvSPpO78vtWPX3/O
 5Ax0Z3igeSWnTefHicPoAj0PB3i2zW0E2bAJTH2I1jJRnjsHQsFtG8bcSmd8Cn1Zp3b3qUEEZn6
 CJguUh3/i5lpPqp7rsHhH76XconFUyhLuFmlwF+FBYDYNuEQLBPmWOAjgYmk3qlx2XLCYL8/ZjI
 3C6z3pesOEbQhdBPjX450NArdD6EXmCd1aX5nUPA9sycxiZ00FssqeG/m8UVSfX05Eb6ZfwmKTL
 sYiJhwY58qwenJQtOJynbj9bfXHHMqVZejk4ulGlXhh783+9hHxlh10yMCdcDf2Wkw5qIcpqN7p
 fN/ANLOvtN5o12lsMQwZolElkDws07hNVHr2bWf/zcbZqDFD389B7rpJ9eTs8XJQjNjbMCzhr4n
 XQZ1PQcaDJk1NGk0uJGGpHiIcopOZEXj3yuPCU
X-Received: by 2002:a05:7300:8c2c:b0:30c:2af0:1cc with SMTP id
 5a478bee46e88-30c84fdf0c5mr4811586eec.34.1782420752189; 
 Thu, 25 Jun 2026 13:52:32 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:31 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 3/7] drm/nova: use `zerocopy` in booter.rs
Date: Thu, 25 Jun 2026 17:51:42 -0300
Message-Id: <20260625205146.5047-4-niyudi.honda@usp.br>
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

