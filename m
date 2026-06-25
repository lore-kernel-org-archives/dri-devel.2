Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064A5CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91C9510F477;
	Fri, 26 Jun 2026 07:53:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="jxXdK0Gs";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C79710F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:42 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-3078e0dcd67so528923eec.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420762; x=1783025562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzC7fmG1jZ13lVBNr652TT3bsOKLyvGJ+KuwuiC1EcU=;
 b=jxXdK0GsKmGsrdb/v3IJjbzySna5E4NtyN8o7ZnuzWlVssLUoCePGTqdBd8mIo5iJ5
 iEcNFsXYYmpGOmsSL1BzsEcH3x/35DsRvZUe9kI3Rcfs0byf1b9Za8/tWUsKgeiDcycM
 OZRZh2D3VWbs/qBurrNZsqNVE3bKHXp4ieAV5SM3UXvqH9LZT1uhtwdXh9ypDQuYXl6C
 mmsx57sOTCZm83nNBIRZVyaX2l9NY9yFwAPHENaj6kUBh0JZpDoKNicL7Rsjhrey7EG/
 ZbRv0jvYRsTkMMPqJD2MB4MYka8Wp9nOP5bUuZHZ/H2SZuXlBBsbDMgSs/IEGU3NHbkE
 EP6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420762; x=1783025562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzC7fmG1jZ13lVBNr652TT3bsOKLyvGJ+KuwuiC1EcU=;
 b=IojRG9SrrfNzr7NVI5n6jNyOsDuO3NPiTpcAV7A4HhHIsgZxjuDF4MshX7YNi6yjl6
 mdChjx7Pvy2u1lijmADVQ1OnpswHkE9oIx0Ea01npgIqVO36LYwNyEr3mcFsimvFpdes
 3hSEWq6ndVqH0E1ukzOOFPiPkWUeJrN5neoK4zfpirvLJd12w1MQZEi9NVKiMlNrI4CG
 gK7sL4JnBaHp3rxuOgS+UVh8n0PLNaq2qhCkIIH4J7rEUz4X8x+VZ/ZLIDvpp+Fqvkq6
 5OGebnuy3jecnXJCAKEqDG44iVFfEkID3UBkLeIQ0Y+fUELgBupU5nqymiaz3qe0zWfz
 hWYw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrf9J3Pw+/RJXWPOM/MpSS2N0sslXHIeMzVcAgBg4EmCqCbus36CLb7dESLmfGf1r6nCD2TV8ckVAs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz1MLGO75w370ygtghGdxxWSrqdO0nClbEvvT2j3Sd2rBVPlPdv
 pvHik9RuBT0EpAoyEReAeIbvxllB5AWJhmcJDanZEjAQm3zQrdLxTQAZeav1dgTMo24=
X-Gm-Gg: AfdE7cmxwsGei3/3lo/ObVxyxOSo92zAZycZ8Y0CzXTAWBE8gAIHYUpLdWqta8NpSkW
 zLLjdUXsqKCJPl0mYNUMtlPnzM0Bg9s/HbDq4psBlzjqnMx9xEdmJ07MYCeQQmg9q4Cx2Vvat5c
 Ewq08dSK/+7WzL39exnAawavtZHgeuE9414s59BYYDLYpso9CIJ7e9rW/4w+O69bQB1jGY+Rku0
 MqjBEV/TZlArKUX3km16jwt0YfmhhkWrHVOVUUq8dyeeUOW0TisMzNBTMjTAtjK8j2Y7/+bSort
 Y+exWL879oQ4fFNNMUDytsserzf8ncbZSSFV2aoOeT6oiFeu/V1RCXLC+B/WHAlj7Ptd1wOlRI4
 yZtsJxQKn5HtCaHYFqwGA53OyutzpbX0mVvdoXz03xasW6wV6pgvhV+ygSa95Q0pPBmnLt5i4Qi
 uq2ATLEsEFWLOoZps2NlttShB6vw==
X-Received: by 2002:a05:7301:2f8f:b0:2cb:4b8f:b2bd with SMTP id
 5a478bee46e88-30c84b1d6f7mr4694957eec.6.1782420761769; 
 Thu, 25 Jun 2026 13:52:41 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:41 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 5/7] drm/nova: use `zerocopy` in bootloader.rs
Date: Thu, 25 Jun 2026 17:51:44 -0300
Message-Id: <20260625205146.5047-6-niyudi.honda@usp.br>
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

In firmware/fwsec/bootloader.rs, replace the following `transmute`
traits with their `zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`
- `transmute::AsBytes` -> `zerocopy::IntoBytes`
- add `zerocopy::Immutable` where necessary

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 .../gpu/nova-core/firmware/fwsec/bootloader.rs   | 16 +++-------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index 13af1c381df1..6f1c8daad7d3 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -23,14 +23,8 @@
         Alignment, //
     },
     sizes,
-    transmute::{
-        AsBytes,
-        FromBytes, //
-    },
 };
 
-use zerocopy::FromBytes as _;
-
 use crate::{
     driver::Bar0,
     falcon::{
@@ -61,7 +55,7 @@
 ///
 /// Most of its fields appear to be legacy and carry incorrect values, so they are left unused.
 #[repr(C)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, FromBytes)]
 struct BootloaderDesc {
     /// Starting tag of bootloader.
     start_tag: u32,
@@ -77,15 +71,13 @@ struct BootloaderDesc {
     /// Size of data section in the image. Unused as we build the data section ourselves.
     _data_size: u32,
 }
-// SAFETY: any byte sequence is valid for this struct.
-unsafe impl FromBytes for BootloaderDesc {}
 
 /// Structure used by the boot-loader to load the rest of the code.
 ///
 /// This has to be filled by the GPU driver and copied into DMEM at offset
 /// [`BootloaderDesc.dmem_load_off`].
 #[repr(C, packed)]
-#[derive(Debug, Clone)]
+#[derive(Debug, Clone, IntoBytes, zerocopy_derive::Immutable)]
 struct BootloaderDmemDescV2 {
     /// Reserved, should always be first element.
     reserved: [u32; 4],
@@ -124,8 +116,6 @@ struct BootloaderDmemDescV2 {
     /// Arguments to be passed to the target firmware being loaded.
     argv: u32,
 }
-// SAFETY: This struct doesn't contain uninitialized bytes and doesn't have interior mutability.
-unsafe impl AsBytes for BootloaderDmemDescV2 {}
 
 /// Wrapper for [`FwsecFirmware`] that includes the bootloader performing the actual load
 /// operation.
@@ -164,7 +154,7 @@ pub(crate) fn new(
 
             fw.data()
                 .get(desc_offset..)
-                .and_then(BootloaderDesc::from_bytes_copy_prefix)
+                .and_then(|b| BootloaderDesc::read_from_prefix(b).ok())
                 .ok_or(EINVAL)?
                 .0
         };
-- 
2.34.1

