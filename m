Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B88FEC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 07:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A60710F1EA;
	Thu,  2 Jul 2026 07:51:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="RCfZIDcM";
	dkim-atps=neutral
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com
 [209.85.210.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22FC710E0A3
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 17:41:30 +0000 (UTC)
Received: by mail-pf1-f181.google.com with SMTP id
 d2e1a72fcca58-8478fe07f0fso753754b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 01 Jul 2026 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1782927690; x=1783532490; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=RCfZIDcM9q0jftCW6FJb8q4pY/ex4h//g2G8unb0UZDe1MM3twAGYzazQe0/D0VSIZ
 MMLEcTHQQJIBRfxniFG26//KFWgDDS7vLW3idhW3tPOlq/tO7ERfTpHeAauK8VRREGXe
 lr71xfg48ksiZdC7oKKIyooqnxRsQK8EGT5g/vgwxFOKc7GxMc0C3/2Md8Q6AdpNbH3E
 x9gopxC2N5nnTKg0z/KAxpszUOIrR4cI7dp1Qqex4rq8+DzxaK3B+aDvBLniREJHiQVo
 kp9Biiry5M00AEVeq27CCMFG4Z70SuzIAJgyabSIVE2wnZzTY0aCS+4mZ4FIK/SRMU8A
 wdGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782927690; x=1783532490;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9cVZWX31i00/Q+AQyz7DVfvfVMzM7hxRZQOP4HWyMgo=;
 b=a57k8BmV6XboCBl2tm7jNzQAQ0c5RxHCN6Swm2DNm2Dg10kiWCF/qpZ704LSbD0opT
 4CHh+4fgpBqLQJzyelizHZMWsguqGSJiow+RUzKSpmEW5RC60n58OlWWUxNAnE6ZOJZl
 hE8rxNMfJmPIh2jspOGyuNb5Nx8E0lo6pUZZY9mhzNyhxrxa15c651Tn6AWmwuxd9F7e
 GXfSrFYSmkVfwTx4IZM5qOMDegFiCdMec+1OEVmerbzsC5Z3CDA+vKRasTdgdNgoOqkY
 Zj2oBcv58tec+FPlBl9AyFcryx6g62Y5X3NH2ePGWrzTi6K+6IKD9ZtT3PpXwvHnXVvC
 8apw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqvK141EksSjGiFAXDqmri5LdPATIaBzbdUG2K5P7knCFn5f04Tb7gDqIk+mmpjPSQnUq99E2+k44s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxbctXj/xcNalcney1aNuSAirTvP77Nug2bwW2szRhvKt2O/G32
 ow22cXrhwsRiRsgJbs6/4D95pXRqmiUZbRgH2pDxeYyXrZ7JBBgN4LvX1HSWe7aBeM8=
X-Gm-Gg: AfdE7cmkVAgeVMqxcPTHl9sEc1gyyhdL6tq7PAvWbX+D0U9pVasQNW5ozMqQbMJHD/r
 uVIPKVntANQpD8I3/EJ6rEnqlqgM+81nSnTKrO9wEeH87FFi0uuWdm63sv1TjcXPsztD47qN7zW
 sFN/sFetXbaRX2kUvoln0MiH5wd8DuGNRzVGKZxXWWDtLVu0Hpx0xM93L1DGYZ9Hq1kkidqC7xV
 gXwe0dxVxdYJEIHr2dfpsQe7Gs2pr8sIe57pauNBDPZG0HydhfxoWQ6Sk1Z/2ah++zWUqlG+Tk+
 wVUwaXlXBZyRZ0NejZpETsl9IE6fo5aALTW02Btz82NNPbjZlQ+8GqJGzbAaroV+mABN3uYtNEp
 q8Td5Slw72sj/84czb4f/wKLJ5m/TGXxq5jLlOsJCOniNELqJzwz6t14qhUWwanuhOsuwj+V1aY
 yB+kTdaUlyyqDAh54=
X-Received: by 2002:a05:6a00:1bc4:b0:845:e4c1:22ca with SMTP id
 d2e1a72fcca58-847c088a919mr2322057b3a.48.1782927689594; 
 Wed, 01 Jul 2026 10:41:29 -0700 (PDT)
Received: from niyudi-linux.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847cb6dc4d0sm150943b3a.3.2026.07.01.10.41.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 10:41:29 -0700 (PDT)
From: Pedro Yudi Honda <niyudi.honda@usp.br>
X-Google-Original-From: Pedro Yudi Honda
To: dakr@kernel.org,
	acourbot@nvidia.com,
	apopple@nvidia.com
Cc: nico.antinori.7@gmail.com, aliceryhl@google.com, airlied@gmail.com,
 simona@ffwll.ch, dri-devel@lists.freedesktop.org, ojeda@kernel.org,
 rust-for-linux@vger.kernel.org, Pedro Yudi Honda <niyudi.honda@usp.br>
Subject: [PATCH v2 5/5] drm/nova: use `zerocopy` in riscv.rs
Date: Wed,  1 Jul 2026 14:40:56 -0300
Message-Id: <20260701174056.12604-6-niyudi.honda@gmail.com>
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

