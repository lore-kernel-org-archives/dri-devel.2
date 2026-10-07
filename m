Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12712CA6002
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 20:31:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FEA910E6A0;
	Wed,  7 Oct 2026 20:31:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h3eQmIAX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3FD3D10E6A0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 20:31:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E508B43849;
 Wed,  7 Oct 2026 20:31:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08F231F000FF;
 Wed,  7 Oct 2026 20:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791405096;
 bh=qojxThXJYnvOU2hZpJJBuTXsweww2zb+UtRFzWYglJ0=;
 h=From:To:Cc:Subject:Date;
 b=h3eQmIAXESzouTrZ81ueiSiZoMKSoIMHjDQzIJO/vqVIpgYIbcpe1eSDrBDA92qXj
 kMPQ0vLQdyD71ulktOs4bqkfnWeOeLljS6dyBBB4h7uplnqla6s6i5byQklTG0lZ8H
 j4gUsxCWfL/pPspNRZaXQpqkHBeivxQ+eoaXHpJQ7rg8219o6SXYyZq5D0+FrAnTfQ
 JOs6WBKma12CmmVUdpbCRdBRRh+IC3/aOevvl/v0pGH80d+yZJ6SkekS4Z2DrqNJlB
 hI2H4+Qf02TuuJvNFgDy2ZtTGGf4ojlAK/EX2FWNv9fXZmysjy1fnF+J/yx7VJTYn+
 4brNQIN9zHaJw==
From: Thorsten Blum <blum@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, Alice Ryhl <aliceryhl@google.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Gary Guo <gary@garyguo.net>, Timur Tabi <ttabi@nvidia.com>,
 Tim Kovalenko <tim.kovalenko@proton.me>
Cc: Thorsten Blum <blum@kernel.org>, Eliot Courtney <ecourtney@nvidia.com>,
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] gpu: nova-core: firmware: fwsec: use KVVec::zeroed() to
 zero-pad buffer
Date: Wed,  7 Oct 2026 22:30:29 +0200
Message-ID: <20261007203035.162075-4-blum@kernel.org>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1230; i=blum@kernel.org;
 h=from:subject; bh=HTFw+9IG+V7FoK8E2jpa6clxuJyqvReEoNTSCovpnH8=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnHVr82eLyhq+NKfjpjQ4XEpPSvXXub07Qufdz45/qUh
 rd3ru/n6ShlYRDjYpAVU2R5MOvHDN/SmspNJhE7YeawMoEMYeDiFICJGNgyMuwofMh3a57NnUVX
 XU60XOovOK5ilXuwVnW2/OXLxyRncIUw/Ga7P82ENYI1qOYai2UDS3LWzvUsN/hs1+nM++56M+n
 IIk4A
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

Use KVVec::zeroed() to initialize the firmware object's leading zero
padding.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
Changes in v3:
- Drop the hunk that could panic for now (Alexandre)
- v2: https://lore.kernel.org/r/20261007080708.124563-2-blum@kernel.org/

Changes in v2:
- Add a // PANIC comment to copy_from_slice() (Danilo)
- v1: https://lore.kernel.org/r/20261006100442.80432-3-blum@kernel.org/
---
 drivers/gpu/nova-core/firmware/fwsec/bootloader.rs | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
index ec4d92317a93..c487dd9eba82 100644
--- a/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
+++ b/drivers/gpu/nova-core/firmware/fwsec/bootloader.rs
@@ -162,8 +162,7 @@ pub(crate) fn new(
                     .ok_or(EOVERFLOW)?
             };
 
-            let mut firmware_obj = KVVec::new();
-            firmware_obj.extend_with(align_padding, 0u8, GFP_KERNEL)?;
+            let mut firmware_obj = KVVec::zeroed(align_padding, GFP_KERNEL)?;
             firmware_obj.extend_from_slice(firmware.ucode.0.as_slice(), GFP_KERNEL)?;
 
             (
