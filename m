Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6463AC43602
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 07:04:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1D8910F661;
	Fri,  3 Jul 2026 07:04:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="DQjR6Cyv";
	dkim-atps=neutral
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com
 [209.85.217.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3CC10E4A9
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 12:05:48 +0000 (UTC)
Received: by mail-vs1-f46.google.com with SMTP id
 ada2fe7eead31-737de525d2eso992736137.2
 for <dri-devel@lists.freedesktop.org>; Thu, 02 Jul 2026 05:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782993947; x=1783598747; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzHdYWFcDkZu4PsS/Wd20QSDadRqyTQZHFMjtpnEEdU=;
 b=DQjR6CyvVsByHfGB6as5y55tlZkZSGgzk0o2BX9Fv/siAgwUXhbv9SOOGDv5TMh6JI
 bxVtKeZcnmwrpO7niMHDrYyPs9voInUsNrN87f6hhrNZEHR9AXkt06yZbQxOo3UVcb88
 u5D/1L+6TDqTZC5I5ULDu5Ew6wmVqHxGBOjT+CWEufOtExR72Wh1j9QhpMA2JMAzaAcM
 RneAGdrEDj2NhcaW95qkhoJf21XOHohCBAA46iKVj1U/b5ygqmOH+OfSMM6auteX2vCs
 Fubpp4YTmd5EsDSDxWD++TIXDIUCHTSQ3JYfYa9GstGAWXstcSER1d7rPbHGP1dzFhrD
 S9yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782993947; x=1783598747;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzHdYWFcDkZu4PsS/Wd20QSDadRqyTQZHFMjtpnEEdU=;
 b=X+mmLrLNOHcLTuYOGn7BJKMxNJLCu46thEsT7Bj3Kh4SusoHbJAbREY8Xsn5hW2lKa
 9kJudqQFw0ap5eYmQ1ZtA9AP2Yq9hGgTelM6gZZFTHB8HFCKyDrG8d8WwkfD3LFZBI25
 mM8QPdSuJxmcRSe3oGYaeBjSQWgXQCTOyfcSYWgOScgwZManQA5JFa3UdAZP0hbOauqT
 7cOCwC9/1FLCXQyehNBTbo+LxocN8NT/YKReCfB2FkzDnyXX5kzgJWrbzu5k52hkpCZW
 kKHAnI50f/Fvezvpcz4rnsBMc6aY6cWJFHzR5l9oy3Oev/ds1eJ3vbMWKNlYbgVt6txd
 RpHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpDidi0U8wIP3VgUqFE4WZou/F1FLrea0p3eMjaOloxpxKx5NExqROllpm81/F1V0u32e/ydcNMcLI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOdqI5edRnt1rY8R/lDksOKWygOCc8cX6s0yRbw0pxUtn6rFH+
 m+CmzhtU5VVmzFmYCRSEUJgD5sO4lDsXChW6QsoZ5TvJdq1LdN1nCWqk/MtFpfGZcvg=
X-Gm-Gg: AfdE7cmJ7herdH27M/KyP5WmncBH/kgHAxB4AHbdYzF1/NQS9LQKtdboLasfWXLpdLk
 aHixaOjYK9IH+vc9opKyXFY9LTRRVaa85bIpy/hfH5gGYZRhIVL6gdWxMfxgH7HPCZnogfI29By
 W58v8jkN0aXvMwxU06RQJEjfknDnJekuBbZBUlqHtprKGsNyAsWAWAAQXWoUw6pVRFnLS5bCjei
 sfMnN7EFhNaP9wiie0ro6CwFgPNYoR+Cs/U0lNNpT0wG1Z4HKKt3XTZWwtgR5NF3PGruTz/ZnUM
 5ikOkyfvRGKBa/CnrDqlv2dUCgmhekjidZQOjA6Umh1uvprzTaWBsj1JDhlL7TwCnV3z82GCckL
 IBrdEd675CKVOmd2pTY07d5p2XPHhfqy0cbiTzcc/MEdRmh3hcVluTRcZH7c3ghN7LE8ssMQdDc
 +p2+ZMqyLA4fmLnqI=
X-Received: by 2002:a05:6102:5125:b0:737:2ce5:7b2d with SMTP id
 ada2fe7eead31-73da8a57499mr2742053137.9.1782993946770; 
 Thu, 02 Jul 2026 05:05:46 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-73e1caf43casm1182470137.11.2026.07.02.05.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 05:05:46 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, nova-gpu@lists.linux.dev,
 Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 2/5] drm/nova: use `zerocopy` in booter.rs
Date: Thu,  2 Jul 2026 09:03:21 -0300
Message-Id: <20260702120324.40388-3-niyudi.honda@gmail.com>
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

In firmware/booter.rs, replace the following `transmute` traits with
their `zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware/booter.rs | 26 +++++++-----------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/booter.rs b/drivers/gpu/nova-core/firmware/booter.rs
index acb7f4d8a532..fe9389b84b90 100644
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
@@ -43,7 +42,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], offset: usize) -> Result<S>
     let end = offset.checked_add(size_of::<S>()).ok_or(EINVAL)?;
     slice
         .get(offset..end)
-        .and_then(S::from_bytes_copy)
+        .and_then(|b| S::read_from_bytes(b).ok())
         .ok_or(EINVAL)
 }
 
@@ -52,7 +51,7 @@ fn frombytes_at<S: FromBytes + Sized>(slice: &[u8], offset: usize) -> Result<S>
 /// Such firmwares have an application-specific payload that needs to be patched with a given
 /// signature.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct HsHeaderV2 {
     /// Offset to the start of the signatures.
     sig_prod_offset: u32,
@@ -75,9 +74,6 @@ struct HsHeaderV2 {
     header_size: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsHeaderV2 {}
-
 /// Heavy-Secured Firmware image container.
 ///
 /// This provides convenient access to the fields of [`HsHeaderV2`] that are actually indices to
@@ -144,6 +140,7 @@ fn signatures_iter(&'a self) -> Result<impl Iterator<Item = BooterSignature<'a>>
 
 /// Signature parameters, as defined in the firmware.
 #[repr(C)]
+#[derive(FromBytes)]
 struct HsSignatureParams {
     /// Fuse version to use.
     fuse_ver: u32,
@@ -153,9 +150,6 @@ struct HsSignatureParams {
     ucode_id: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsSignatureParams {}
-
 impl HsSignatureParams {
     /// Returns the signature parameters contained in `hs_fw`.
     ///
@@ -170,14 +164,14 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
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
@@ -191,9 +185,6 @@ struct HsLoadHeaderV2 {
     num_apps: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for HsLoadHeaderV2 {}
-
 impl HsLoadHeaderV2 {
     /// Returns the load header contained in `hs_fw`.
     ///
@@ -205,7 +196,7 @@ fn new(hs_fw: &HsFirmwareV2<'_>) -> Result<Self> {
 
 /// Header for app code loader.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct HsLoadHeaderV2App {
     /// Offset at which to load the app code.
     offset: u32,
@@ -213,9 +204,6 @@ struct HsLoadHeaderV2App {
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

