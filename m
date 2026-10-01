Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28F70CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:40:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7417310F68E;
	Thu,  1 Oct 2026 13:40:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PwF0fiHG";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A2410E1DF
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:40:02 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-396ccb1a98fso4674396a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 06:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790862002; x=1791466802; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=36wHVkYrC+tsJPWWup994ozux9gG08Y2bixz1oomwOE=;
 b=PwF0fiHGEqQkdS+SaZ0cZ9uMc+vtW9BCO1aCKntML0A9I/VLMDeJnLYSNa9sD7niFV
 mMP3J4COpU//WkkT1GXFIgUO1QfpPZ9Q7r2XxdrLnjaIsHIPyXivnWGAYZGEwSiYoqyZ
 FA7r+QmXH4ujMWFA2M/oCu6qLLpDEh2Id+ITdy3W1zO1fBKjzy4B7rLSVPs9akEru2LX
 uLBVcpcNKI+4uzoJf+uO5/jMsc4z9e9y0DMuQ4kGqHi/s7IUtuJsvA/jSRGr72lfiRNP
 U2HoVP5voXk/vg4siX5+bN2VN2ZjJn7pNKou5zn+12TETnfQXwGZMsMu1738DneJePG8
 AqfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790862002; x=1791466802;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=36wHVkYrC+tsJPWWup994ozux9gG08Y2bixz1oomwOE=;
 b=XsHvLovSLjUsGI2A7aUL6DNpnm81mMVEWWjczCmZNGPVpg5SIh87XC27xqGwH365zK
 P1u36g0IxeIJaXNLzch3ad1pJ3rWn8/vf0E/aYjvWa7XJox6KG0OGCKlG2gWzM3bkOF9
 whydOYZx8cqE3wG/kmb6i4ybDoBzAOtrmiVFMGW1NK/zfamS6UArT2QYkYBRKzqLxL+6
 6POUtX6BXQG2ylr2nuPDTm673mvSRMPZRZriy1PuFqjgkc/jxb9VximDOL1e4Tj3Si9h
 WhJcfEWCRaBW00XJSbsVNL3HPCTdGrDTQQhWds1MObpxi3zfWZdyEeBuuxIkfEvtagiu
 ppyQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM5LHwJ1kR3koQ9oxMMkpsGjO9sOBTRX6A5DsWS9+bc+s5bXzoC3nRo9U6Jzf5flna427mgcbUk2c=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKk4YIEvpX9OtVXckKrNyV0Xu4/zA8WlorTlTZbsGMX3MD+y8gd
 0y9GgaSjrtzROlPmi+Lv1GXUrN78ItcLyhrjc3r6dMBPo/u2CdJ1qv5G
X-Gm-Gg: AYBFou2+PkNAvXTwlWCARnECVaY2hNNKc2sWNo9DMt9MpIfboYhYG/5ncan71NMxgnX
 qVIiyI7gRt1Y1XrCoLBUTYopFnzb7mVDHnkir7WEvISK9SAuE0r1xi8y5Anr93pZbdPyFrGd7dc
 MpANGGxcu6hPkA9fVCLXsFHOOBaJ45iQZTicKkZtnkX3lmmOQvYn3LTZncik+7W42XdwCVvAr5x
 6VUWRUk3/B0ch63Ub1gaeUvEBEXzsOYcTKF/Tj6nUjSc8ornCuLiLJDvEdliUe93l2VMUCmMTar
 bCq96k/kmwmkrgtp1Z7EWCFlKhIMIyGxzxnhNzrFhaB3XVP93550QoLUOvWp9Bi9ws7bzkouf9B
 NIiCNQNYL+Zp8QJ8V1G+rmaOp+uIPwAkggDuNSAlNWcOYcUTVYEsoJy0b21dYIdpnneSdnEKiwC
 egmJCp8V+NXyWqc2CQzEwd3XSC4G9R720Pv4G8oyc2acUB5MaDi+XoUuLWMiP8FN8Q7hc1RAA53
 A==
X-Received: by 2002:a17:90b:2545:b0:3a0:574f:5854 with SMTP id
 98e67ed59e1d1-3a4d18cb4a1mr4364490a91.39.1790862002057; 
 Thu, 01 Oct 2026 06:40:02 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f47cb357sm4673435a91.17.2026.10.01.06.39.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 06:40:01 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Thu, 01 Oct 2026 22:39:13 +0900
Subject: [PATCH v2 2/2] drm/imagination: Size page table preallocation by
 device address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-pvr-fixes-a-v2-2-f58254e5dfb8@gmail.com>
References: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
In-Reply-To: <20261001-pvr-fixes-a-v2-0-f58254e5dfb8@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexandru Dadu <alexandru.dadu@imgtec.com>, 
 Brajesh Gupta <brajesh.gupta@imgtec.com>
Cc: imagination@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Gyeyoung Baek <gye976@gmail.com>
X-Mailer: b4 0.15.1
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

Commit 0a8224058a58 ("drm/imagination: Fix page count for page table for
map() interface") passed the device address to
pvr_mmu_op_context_create(), but the preallocation is still sized from
device_addr + sgt_offset with an exclusive end. The offset into the
object's pages has no place in a device-virtual range, and the exclusive
end allocates one table too many when the range ends on a table
boundary.

Count the tables from device_addr and the inclusive end of the range.

Fixes: 0a8224058a58 ("drm/imagination: Fix page count for page table for map() interface")
Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 62eae7fcd5a..67e73d7d5d0 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -2337,7 +2337,7 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
  * @ctx: MMU context associated with owning VM context.
  * @sgt: Scatter gather table containing pages pinned for use by this context.
  * @device_addr: Virtual device address at the start of the requested mapping.
- * @sgt_offset: Start offset of the requested device-virtual memory mapping.
+ * @sgt_offset: Offset into @sgt of the start of the requested mapping.
  * @size: Size in bytes of the requested device-virtual memory mapping. For an
  * unmapping, this should be zero so that no page tables are allocated.
  *
@@ -2350,7 +2350,6 @@ struct pvr_mmu_op_context *
 pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *sgt,
 			  u64 device_addr, u64 sgt_offset, u64 size)
 {
-	u64 start_addr = device_addr + sgt_offset;
 	int err;
 
 	struct pvr_mmu_op_context *op_ctx = kzalloc_obj(*op_ctx);
@@ -2365,18 +2364,18 @@ pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *sgt,
 
 	if (size) {
 		/*
-		 * The number of page table objects we need to prealloc is
-		 * indicated by the mapping size, start address and the sizes
-		 * of the areas mapped per PT or PD. The range calculation is
-		 * identical to that for the index into a table for a device
-		 * address, so we reuse those functions here.
+		 * The page tables needed are set by the device-virtual range
+		 * being mapped: one level 1 table per 1GiB region and one
+		 * level 0 table per 2MiB region the range touches. Tables that
+		 * already exist are not consumed, so this is an upper bound.
 		 */
-		const u32 l1_start_idx = pvr_page_table_l2_idx(start_addr);
-		const u32 l1_end_idx = pvr_page_table_l2_idx(start_addr + size);
-		const u32 l1_count = l1_end_idx - l1_start_idx + 1;
-		const u32 l0_start_idx = pvr_page_table_l1_idx(start_addr);
-		const u32 l0_end_idx = pvr_page_table_l1_idx(start_addr + size);
-		const u32 l0_count = l0_end_idx - l0_start_idx + 1;
+		const u64 last_addr = device_addr + size - 1;
+		const u64 l1_count =
+			(last_addr >> ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT) -
+			(device_addr >> ROGUE_MMUCTRL_VADDR_PC_INDEX_SHIFT) + 1;
+		const u64 l0_count =
+			(last_addr >> ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT) -
+			(device_addr >> ROGUE_MMUCTRL_VADDR_PD_INDEX_SHIFT) + 1;
 
 		/*
 		 * Alloc and push page table entries until we have enough of

-- 
2.43.0

