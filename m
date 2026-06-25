Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 296DFCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5D5D10F484;
	Fri, 26 Jun 2026 07:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="OIkXyhxw";
	dkim-atps=neutral
Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326E710E249
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 19:06:26 +0000 (UTC)
Received: by mail-dl1-f41.google.com with SMTP id
 a92af1059eb24-139986373b8so333565c88.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 12:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782414385; x=1783019185; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=OIkXyhxwWcyE++n3e8JXWwSrzCFTcXemiOcfcxJGgXiCt5lBJ4JBANkocpH6wpU04a
 47fF9TwONh1MGbWV3equWIV34tfbX6jvpeXbCF0aWLmBYhMnB1q8ueOfRk7DRQJriASr
 M8g1zxTn+INHO1w8kytPlNoIc+alKvtrkEV7+w/nFa7ZMPUwwh1a5jjWywqcjM/ISKrG
 ljDBZUQGKHb5gRMidUrk/o0yl+xRgLwNezeq5fWQAimMBqoKBH33uLBN3Gg2zBYaDr29
 3SR7Ez7+pUPDQs09NQnn/W026jD8DpE0b5IgUsAdsD8MTKfPraknK1QNcBUz6AUsg+Z7
 qYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782414385; x=1783019185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=F3RKNsuApcdgFhopRp8w149fSLmsejSAIExHILT03oz1t6LTpKT/cn0EeqkTrHWvwG
 xyIgI21EO1tnU/6On+tHH1lNqTZlRmS/zeRj6o3dQPk6OKESvLxDCHp9rxfnOJDBAj98
 CzIf86re1Xe6LCQenqciAZR10Jv/74scDiy6lkKnxtwIi4Fs7of6Fy4oNMdkF+zcS3eS
 NhVeyxON0GszTgakBl4ZStyYH7ucEYZGHDyt/6Oyk5IZ1x8427h4ErW8FAhZytmOH5XC
 4w/CIC3Z0LLzislg7iNKgj8Hg27E04PCY8Lw0oiJpVU/OJlEJtV89eh0b8JUWi8o5lRU
 rtxQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Ybojhh1tkrb2A0JOl09WOC9ny3SjQdgbBBv9SuOvG9z5AWNE0XCfHRBj8hBO4bL0tyS381iep64E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRHmGuAvShdE4UvuW9I1a1LrLcbcb+2rIQQnp0sLiRDVuIf6hd
 Mt8VetqatZcIbIPLtNUg/xjH787kemz9s84QVuDGIux/xLisuVxG/qvDaLtDfxqvpjY=
X-Gm-Gg: AfdE7cngmdUvFcOTuiuNXIotC7Pfkwrid3GVMAvEHxXRdIG8WIfd5O96WGB74RhdTFS
 t5JPCGUFSAPOyoqI+dVDlfAa0+Y+uf8mqGDVqLiLwP7k3R7mpcrql1eOeD2SEMAVKJLLSAmcILk
 GiHZOvzyeWHmdByOCA8+tpdnHx89EmoQvfjLFRbxD+JASdYzcwAQikHtqxvMbAe2t04WVQUoPCk
 21Xw3o8ZsQEwm5pEWtJOe5wO8yc0AO4LQPumQPpiSe0VPPdDjWM4DEacb8xC6dA6Ojo+i7XI7pF
 pFb8bHCe8FW3BVlfJI9Bu1u/UmwusnbAFPOyVkdkjmH+StEH2fH5bg4ODtCNN6O9sALRZC612GY
 jve+aZRzdQjmKrGBBTidhcnrJnpZUEBXaVdeILBgPoOTtuAhU/LMj+4ctTc3SxOhgJU8yM1y0t2
 542SMCPrlBbhfB+qc=
X-Received: by 2002:a05:7022:6a6:b0:138:12fa:377e with SMTP id
 a92af1059eb24-139dbb8ff32mr3631680c88.20.1782414385281; 
 Thu, 25 Jun 2026 12:06:25 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10742999c88.6.2026.06.25.12.06.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 12:06:24 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvida.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vgdm.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 6/7] drm/nova: use `zerocopy` in riscv.rs
Date: Thu, 25 Jun 2026 16:05:52 -0300
Message-Id: <20260625190553.7245-7-niyudi.honda@usp.br>
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

In riscv.rs, replave the following `transmute` traits with their
`zerocopy` equivalents:

- `transmute::FromBytes` -> `zerocopy::FromBytes`

Update call sites accordingly.

Signed-off-by: Pedro Yudi Honda <niyudi.honda@usp.br>
---
 drivers/gpu/nova-core/firmware/riscv.rs | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/riscv.rs b/drivers/gpu/nova-core/firmware/riscv.rs
index 2afa7f36404e..ba56bc7d4188 100644
--- a/drivers/gpu/nova-core/firmware/riscv.rs
+++ b/drivers/gpu/nova-core/firmware/riscv.rs
@@ -7,8 +7,7 @@
     device,
     dma::Coherent,
     firmware::Firmware,
-    prelude::*,
-    transmute::FromBytes, //
+    prelude::*, //
 };
 
 use crate::{
@@ -18,7 +17,7 @@
 
 /// Descriptor for microcode running on a RISC-V core.
 #[repr(C)]
-#[derive(Debug)]
+#[derive(Debug, FromBytes)]
 struct RmRiscvUCodeDesc {
     version: u32,
     bootloader_offset: u32,
@@ -36,9 +35,6 @@ struct RmRiscvUCodeDesc {
     monitor_code_size: u32,
 }
 
-// SAFETY: all bit patterns are valid for this type, and it doesn't use interior mutability.
-unsafe impl FromBytes for RmRiscvUCodeDesc {}
-
 impl RmRiscvUCodeDesc {
     /// Interprets the header of `bin_fw` as a [`RmRiscvUCodeDesc`] and returns it.
     ///
@@ -50,7 +46,7 @@ fn new(bin_fw: &BinFirmware<'_>) -> Result<Self> {
         bin_fw
             .fw
             .get(offset..end)
-            .and_then(Self::from_bytes_copy)
+            .and_then(|b| Self::read_from_bytes(b).ok())
             .ok_or(EINVAL)
     }
 }
-- 
2.34.1

