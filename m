Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECB6ACA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:07:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45D9510F47B;
	Wed,  7 Oct 2026 08:07:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GHrB9CWb";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F72F10F47B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:07:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0491F43D0F;
 Wed,  7 Oct 2026 08:07:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E08C21F0089B;
 Wed,  7 Oct 2026 08:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791360448;
 bh=v/y3T7/e/MaOX8mZoAbby3DasOlpB0U8DdGRdhK4/GE=;
 h=From:To:Cc:Subject:Date;
 b=GHrB9CWb16Dac9KvY773Ok9m4S+vLWRkzORIt4qPGzTq7SKknnk6VsOrvmQcg85xk
 GcjPZUzkYxT4mFHXqFp8QWNzjGn2bgFVSjvBzzPNUEKhbEgmwuZH/uZq5YNvdmpgw+
 ZJ9ackZO28kDQZIM2qEFOuYF+nOxUfQOrukq0xyHOw+psKf0ZEpGOynFF3vqNJj1tj
 vjOvZzXQJKGb1c9a2Jky2JE2EbmS9SdfDOq8h/0rnqI3PXe6B+3rnLMaM0eFN5s9go
 qOupokHriqzeJYOzdcCOJ7k8h86PMqGMB/CtM5zqtmaH0CKrbwa8Z/V+fEQZM9qI2P
 K2LGP8vt2hBUQ==
From: Thorsten Blum <blum@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, Timur Tabi <ttabi@nvidia.com>,
 Eliot Courtney <ecourtney@nvidia.com>,
 Tim Kovalenko <tim.kovalenko@proton.me>
Cc: Thorsten Blum <blum@kernel.org>, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] gpu: nova-core: firmware: fwsec: use zeroed() to zero-pad
 buffers
Date: Wed,  7 Oct 2026 10:07:00 +0200
Message-ID: <20261007080708.124563-2-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1825; i=blum@kernel.org;
 h=from:subject; bh=Bemw368FDGIdywFg9idqBuBIQkyeP2E/D2Q1PzjEZSw=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFlH/65pONd2yGXhyyNln05e9zQ4UMKQIVT/esalHU/ip
 kn7c1drd5SyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEyrIZGVb37mPacoV3IU+k
 HOeq/TlL8zgaGpq3fK0NClQ7MO3r5F5Ghp3hryZpKZ/dxfoo6Parr0llCX8nrA07LbQs82L3p5p
 2bk4A
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
Changes in v2:
- Add a // PANIC comment to copy_from_slice() (Danilo)
- v1: https://lore.kernel.org/r/20261006100442.80432-3-blum@kernel.org/
---
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..1aa08ae8de78 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -137,10 +137,9 @@ pub(crate) fn new(
                 .align_up(Alignment::new::<{ falcon::MEM_BLOCK_ALIGNMENT }>())
                 .ok_or(EINVAL)?;
 
-            let mut ucode = KVec::with_capacity(aligned_code_size, GFP_KERNEL)?;
-            ucode.extend_from_slice(code, GFP_KERNEL)?;
-            ucode.resize(aligned_code_size, 0, GFP_KERNEL)?;
-
+            let mut ucode = KVec::zeroed(aligned_code_size, GFP_KERNEL)?;
+            // PANIC: ucode is sliced to code.len(); code.len() <= aligned_code_size.
+            ucode[..code.len()].copy_from_slice(code);
             ucode
         };
 
@@ -162,8 +161,7 @@ pub(crate) fn new(
                     .ok_or(EOVERFLOW)?
             };
 
-            let mut firmware_obj = KVVec::new();
-            firmware_obj.extend_with(align_padding, 0u8, GFP_KERNEL)?;
+            let mut firmware_obj = KVVec::zeroed(align_padding, GFP_KERNEL)?;
             firmware_obj.extend_from_slice(firmware.ucode.0.as_slice(), GFP_KERNEL)?;
 
             (
