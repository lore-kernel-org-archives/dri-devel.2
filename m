Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692FACA5FFF
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 10:06:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44F410F288;
	Tue,  6 Oct 2026 10:06:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E6gnRyUw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7C2210F288
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id CB010414D7;
 Tue,  6 Oct 2026 10:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAEA41F000FF;
 Tue,  6 Oct 2026 10:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791281162;
 bh=HaLuhfmI2200d0t+fAcSUnDd7yPphUbg2WEHqVSyuzk=;
 h=From:To:Cc:Subject:Date;
 b=E6gnRyUwot60DvB/vq5hbDsV2Frqdj5UvrhZLN5okcGmyTq/HpHK/ulcZDle1gTx8
 mejVGKAiRZ9BSkLI0GeYY1d1IkuOzMhVI8GiK9rNwAFVjHWpIB6SJUVZjSIOz+XqCK
 tuhsnCnp2+XHvxm+oH+wSxPoJBmWDt+qA1uR01ltdOb9EELexBy1uYaYtdSbcZic0n
 9IQ5TeG+0oBZX3EPDOs1EV81rGothWqv0dGemzJnbzHWbA3nkQmduJwyhN3G0zoRlq
 9DpliCvCwUM0e10Lq7Fx04fYjyhrIxKk2+31+lXTbUUEKIqJ3POGUqgd6dtR8ZmJey
 2EV3xZPjI+1Pw==
From: Thorsten Blum <blum@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Gary Guo <gary@garyguo.net>,
 Timur Tabi <ttabi@nvidia.com>, Robin Murphy <robin.murphy@arm.com>,
 Tim Kovalenko <tim.kovalenko@proton.me>
Cc: Thorsten Blum <blum@kernel.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH] gpu: nova-core: firmware: fwsec: use zeroed() to zero-pad
 buffers
Date: Tue,  6 Oct 2026 12:04:36 +0200
Message-ID: <20261006100442.80432-3-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1585; i=blum@kernel.org;
 h=from:subject; bh=7ISurMb0auFlN/SwmBEY3otzpEgamf9U/yTqct3dbz4=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlHju/68HNO1poNnkbba5ZkP5rtNFlWzF1RJvf/FGPVG
 xd1Hpkd6yhlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJrHVlZHj/raRZ2+rsM4+w
 C6YG7pNbP2+9ONPp8h8uh57XUV9MpTgYfrPmeG+f/3Lvj8KPNZuKOwKa50qfzWwInS1X/S7ZLT7
 5MScA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
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

Use KVec::zeroed() to allocate the zero-padded microcode buffer and copy
the bootloader code into it. Also use KVVec::zeroed() to initialize the
firmware object's leading zero padding.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..37dcd4bf4711 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -137,10 +137,8 @@ pub(crate) fn new(
                 .align_up(Alignment::new::<{ falcon::MEM_BLOCK_ALIGNMENT }>())
                 .ok_or(EINVAL)?;
 
-            let mut ucode = KVec::with_capacity(aligned_code_size, GFP_KERNEL)?;
-            ucode.extend_from_slice(code, GFP_KERNEL)?;
-            ucode.resize(aligned_code_size, 0, GFP_KERNEL)?;
-
+            let mut ucode = KVec::zeroed(aligned_code_size, GFP_KERNEL)?;
+            ucode[..code.len()].copy_from_slice(code);
             ucode
         };
 
@@ -162,8 +160,7 @@ pub(crate) fn new(
                     .ok_or(EOVERFLOW)?
             };
 
-            let mut firmware_obj = KVVec::new();
-            firmware_obj.extend_with(align_padding, 0u8, GFP_KERNEL)?;
+            let mut firmware_obj = KVVec::zeroed(align_padding, GFP_KERNEL)?;
             firmware_obj.extend_from_slice(firmware.ucode.0.as_slice(), GFP_KERNEL)?;
 
             (
