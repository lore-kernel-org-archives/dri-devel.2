Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E774CCDE00E
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E915010F4A0;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="tlYxxQmJ";
	dkim-atps=neutral
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BDC710F305
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 20:52:48 +0000 (UTC)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-30b9e755555so750723eec.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782420768; x=1783025568; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=tlYxxQmJ9727KSapwXup3DWnkT2q/1+9vG0GAy9VCN2KuaT7L8xJqM4aAdGeK9R1Mr
 OeThKYzSJfZLPB8t1/DbltFdpcFANX3s0iUmxHIlZqJMgFdmZ9mO9gW3jfqoDpaxPHnQ
 x1DYmDQ0NWS64kVp9BARBgC9UN/BTIWquWpZUL8E1/T8AgiAcECaTmcdgZ1gVCuEN2JX
 JpyOcoukse1mmdnJDadF+X9risb9FUiOHM5og4dOz7XPFC8pxSd8BUttN6OHI6GCIkot
 tHyrKOh+7+Ez89sYUW/Ju9qr/NyTyA14lBpLuOfDTp357HCqMaCviM8ZhZvFEPjhCRdq
 ZoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782420768; x=1783025568;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=NG4Mcyz4bg+k9dOIwTM9g/s8y8V26YWQvXEt6L+VRfxRmG8WMsPmUK0K6BUBR0penS
 jtgle43hpAo1V3nPbosXI+LDT8jlg2h0ErCVrdKDjuF8rHanLdTF7f+759Tow00D4FfY
 nrp8bsucEHTAXPZx1H683LE5OeM5AC46zNAAdWU3Whi5Fsk6ef/69Nlk1dx3R+32qL8K
 pZsF4WymQFCvb7RLQgQI/2Rx16vXTk3moPYBQbUB6Ol+vtBTNrXeAm8N7p7II0JwVSjr
 IAzRL9KjzsSZ7C/8OcFX5MC9vqZmukIl9HNab/9/K2msgQwKSxxBGYzvNnfYEUa7Wjb9
 DnGA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqqv9TSBtFZo/9tNmmq2fIeSU83gf6S4/GlJfk2JqvQdOCmU7/yS88R5xHh36b7WigEjhLPvdh+0bA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxuI5+rURIuXdlhNlYHjRN22nRAKgS00ApHqHkRa2xcgNlipq3
 auoiIqJKT3okVwBNIAVzHwOAaIiWzprtdyRmvNGnpQu/RKM+XKW8bS+6VfJ1PYQh0hA=
X-Gm-Gg: AfdE7ckyLPbLV5HDoeDbUaRTVnzLkSS3FWNXugdDsy2sW6MXCywntOkN6fBq1TvUEuM
 sOYYBIO+25h9DkiWay3YHiwJ698QNT2lN65sHVwSj37WZRozhkcjy0KearkYpS29i5yD7VxiHB2
 OL68XNtnYyB6aorHp8SJSHjPXXplThqmIDCHh/bWz9O+XvGaqmA7U9XY7q6RrTPYFtzCEgyg91x
 PzKkGLVscs+/enIFqtmqV6rkfyHPmgR/X9LPyXVXrcRX2lt/pbU5TAuhh0Ipm0MHRhZG6qmTtPF
 PphV0oVc5sHiB1VuYJAT34AgBfO6Y+XWmanv8h9Zwbcu5cnjjxuRHjmoXMn3Grh9pU99zBOuJAM
 xOh/DbllQILyUeCeSA/MYgOqgc3ofOnRz6rHrw1E149juyVyBkNu517gOixWNApADMRNauaT/Mp
 RzLkn1hM1ZyQlo1hVKKmObKlccmnBH8DuwQBgh
X-Received: by 2002:a05:7300:a497:b0:307:3a6c:ecea with SMTP id
 5a478bee46e88-30c84b95570mr4109057eec.1.1782420767666; 
 Thu, 25 Jun 2026 13:52:47 -0700 (PDT)
Received: from niyudi-linux.. (179-242-249-142.3g.claro.net.br.
 [179.242.249.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7c4c691dsm10981525eec.5.2026.06.25.13.52.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 13:52:47 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	nova-gpu@lists.linux.dev
Cc: aliceryhl@google.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH 6/7] drm/nova: use `zerocopy` in riscv.rs
Date: Thu, 25 Jun 2026 17:51:45 -0300
Message-Id: <20260625205146.5047-7-niyudi.honda@usp.br>
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

