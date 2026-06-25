Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFF23CDE008
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F20B610F486;
	Fri, 26 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="wuLpQMlw";
	dkim-atps=neutral
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D322710E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:22 +0000 (UTC)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-1397e093f90so674386c88.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414382; x=1783019182; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZzC7fmG1jZ13lVBNr652TT3bsOKLyvGJ+KuwuiC1EcU=;
 b=wuLpQMlwmeeALyNrDaxjkU/7Lj6upusYIwryvh0Mj7f2oW17Mf5vIXa4uNdtuI8kgx
 S8jhc2QXp7ECZMHIqTCJr2S5Fcf0qsjj+0OrjAoYN1m0wIl0VHcLSceW6i3KC9UUhp/F
 2mRs5hbQoNYPg7o3RVb32kuWBLJYHgQpHre4XXq744X7aSBnQboBLkpuX54kgC4xb0NO
 LxTxvV7lN49ZNS1EDrhRAn+UMFqznZXox77JBRbMA/pYExcFpgai6qmgAM0G7vU0ulPg
 ZVR5aX8D7gkZtWFqbB8pb4RoZZuQ49iblbtlSVvao/eGCpTeOdUt7Nh6WLCvVmrCncGL
 V4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414382; x=1783019182;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZzC7fmG1jZ13lVBNr652TT3bsOKLyvGJ+KuwuiC1EcU=;
 b=Gz9Rf71IcK3Gruws70L/dcViX6czOdMdWPIH6pUtzyCPE+fw9PfikDXs2vqFC6xIZP
 vSRmsWqYYD45DFpdHbmc3WdcinPjUM1xJwHUY4Bj6T3XW5bZK43kS1zJHWJ6aUuz97iQ
 rg7F5Nmq6XOAPQUYUNXmxLYCPAkuvWRnSVsF0SmjVmWTKxOBAsozEx3p7yEAfZPgSn+4
 iKef5E42zc6RPaF7keEt9MuQZfknLcGHjQRHcwP4I+jBWsP0RhfoH7kN7yC3u66u0WBS
 6Ybufxd7ryz3/Qg8oCkNKGByucHFVd/RvB+pdDm00lsiBcOu4qeSMhi0iiQYlAUY7Dsk
 HlzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/k3tgKz7pjwJJ+P37wQld+qBP6QpPKBATCzw7Pt49t+ZKVEKS6VAqDNKpMpsMnBfHrVdVEEfNI2qE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyWMlLD0UT+JuZHcmuLdqX8V+7WJjGNaDxljIjB2yiPtXPMHqYu
 l+BX2ONB/6h6Tc9kvqnGcRsjAUNaIz/1m+0pPU72gO2mmIVpiHRc3dHqLYf8AlJXw6A=
X-Gm-Gg: AfdE7cmTaGabmTMp1NXrTZwLvwDqIu4Fwnb8j6eqNl3zjaKlIw6hobh8ibcjbCtXgxX
 EQs1AfLMUduSfw2uAwI1i9lI7PiuRVeINS84NFFX9tXrDzq6MP1FfdVpgOoZ+HwQKMOFpo5obyu
 vjaziGHn4wptHuJEYuG8EWg178svT2koTu991vX/pE8R/zIy0DGGnIAxjXT1QxEF+xZpR4zwCcE
 kIDR/3YNc7qtmt8piJ/vcf6NMFsR5HXj0+wQMsyh6an5S27nMa0AptAoqHmrjb1Z3CeEmymxtq1
 7d7K4ztC8MlY0bJNF+jIiPyA35tTyN+VU7H2fX7TaEHw8pk8x+6FTRbk0AMYpuIVwwdxkMjHaFQ
 /fK3e2p+dTJjISl/rZkcm96kgOy9z8Q8YPHBZvSmslixHkk2dyE7Asa/s8sjTm08AsYEneK1rMx
 ulgw7I9BaAFrJ1tD8=
X-Received: by 2002:a05:7022:2226:b0:139:90ab:36bc with SMTP id
 a92af1059eb24-139dbb05d2cmr3690379c88.38.1782414382014; 
 Thu, 25 Jun 2026 12:06:22 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:21 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 5/7] drm/nova: use `zerocopy` in bootloader.rs
Date: Thu, 25 Jun 2026 16:05:51 -0300
Message-Id: <20260625190553.7245-6-niyudi.honda@usp.br>
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

