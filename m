Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271CDC43458
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4132110F1C6;
	Thu,  2 Jul 2026 07:51:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="KHERXnYG";
	dkim-atps=neutral
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com
 [209.85.210.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 918BA10E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:41:16 +0000 (UTC)
Received: by mail-pf1-f170.google.com with SMTP id
 d2e1a72fcca58-845e363246aso721692b3a.1
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927676; x=1783532476; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzHdYWFcDkZu4PsS/Wd20QSDadRqyTQZHFMjtpnEEdU=;
 b=KHERXnYGNa7eo4qVaB408s0inOQbN3d73U+bG0Ty4CS4xXoSrAm+l9AcGwWQAnT2s4
 xMIf8S5B1rLj/P+qBHw0+DUsvp4ZdHA7vjESZVET3lKVqGDpCdxLke1l2pE130jz8IKq
 YX42HunAD6mYgGYfqxuvxEREKbHyojlsNXau7REXhDj06W+n9gC8iDgM706+5P/gIYfi
 Zlgudxb5lQnKFqZtxp27P1BPf0ToNfFjDDcu0YiFhw3YHqxNRLXugulLZ7uFjrtCGGTf
 YvTr3GRk41VFT4lRF/ZMeSgh7buUN1aPXm2HocFNqJagil2jt+ss7wiTRRgjX8RebNRl
 jYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927676; x=1783532476;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzHdYWFcDkZu4PsS/Wd20QSDadRqyTQZHFMjtpnEEdU=;
 b=Ta+jEuByR4xGVHKhA9OLcTtAr7ifAklvvRDx1us2H0JxCXrq5RturLJX3JI2xByfp4
 2D+13CfHxsh9iNrKEeA4TADi3M/9j/0GZvUCT+b48SEUoTbqTI53PX72m7Nue1T0w+lk
 9JZEX/GFcZa9jZ9dJ8fmobp6pk9QwRwmBhDUNVwevFYmfT5M6fx4KVQhyaXQarSMbgvR
 /94vcIMgeVhgpRj6xXbpB7MaR86fRqYZA8Y/lyNfBKH1BJvwbaihih0RvTyVxun7YF2A
 uJa+bws5ll7nNmTMEuWLnreTlNyB2J0mOeJdP8/5ydDXSdO96gv3BL5QBxnWPR7+GdGs
 qwiA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6Fs2VmGTzdWqlAIQqF8mNQkh7dl62yRBA4spkaIBBDBcOna60ygurd6XyM9J7tXw6aSdFhc9e3qE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzprXFZIeVc1NOylKWinMo1KPWQ8Dv3eMCkL3l02oH+amV6qPs1
 Iwd4tBa7hMt3P8xzfza7bmZjI3kdpyvvTVv5fCxDz5GMJD59HoFET0cUSWX6UeFgFfY=
X-Gm-Gg: AfdE7ckfxNc8w2FLOCq8nGfifWPW02hxTuCTdFcCBxISHpb0Xj5I4SR51pfkd8hrZhL
 zzcHqWqbRvo7gk2vXwDU9NqjNz8J+FDDaeWjQQJS3bomBbUPK+9+Fg8ISTHyLVBwLzrbur9zs0I
 6XuV+ujG3HiIn4eSDX1OKQLS3ScWrqBkGx2Nt1bBOC/d2D0UJXX8c55m1Cm0pXVPwWl2U8EwSWY
 O94hO9lyohKFWxQ3XPB6N2Fh5X1Uw0XPXaC4huYWDGl5ECpH/A4bR8XhVQNW8ohsU9bqLH13UnE
 ps8l8p/A7icPvUXWJltF7bKainXCNdUl0FadS5JNutu/4dhRbiuhrR98kwiZyWPB0O70Sz8A5rq
 BYMhWlZyysd3X2FG/rR1hKJOqVFmlnXQSS7ulmG/LnSn4oYFAYFsX7NpjmfyR/com7eZk4ZbRWA
 NeCKdrJNWY1u+3jZz9/YzfXE1a1Q==
X-Received: by 2002:a05:6a00:3485:b0:846:bc60:5bf8 with SMTP id
 d2e1a72fcca58-847c0673eb2mr2342327b3a.5.1782927676058; 
 Wed, 01 Jul 2026 10:41:16 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc4d0sm150943b3a.3.2026.07.01.10.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:41:15 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 2/5] drm/nova: use `zerocopy` in booter.rs
Date: Wed,  1 Jul 2026 14:40:53 -0300
Message-Id: <20260701174056.12604-3-niyudi.honda@gmail.com>
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

