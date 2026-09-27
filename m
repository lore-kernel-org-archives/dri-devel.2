Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D393C98324
	for <dri-devel@archiver.kernel.org>; Sun, 27 Sep 2026 08:27:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B43B10E41C;
	Sun, 27 Sep 2026 08:27:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YcpCyJho";
	dkim-atps=neutral
Received: from mail-pj2-f42.google.com (mail-pj2-f42.google.com
 [74.125.227.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F09BE10E452
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 08:27:27 +0000 (UTC)
Received: by mail-pj2-f42.google.com with SMTP id
 98e67ed59e1d1-398cb5615deso1769184a91.3
 for <dri-devel@lists.freedesktop.org>; Sun, 27 Sep 2026 01:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790497647; x=1791102447; darn=lists.freedesktop.org;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t4U13ItbJ0ZD2xH3wybFDs4byUeHHQl2NVsga6UTsOc=;
 b=YcpCyJhoYrar9/Obzq4eIZfmD7johA34S5YjM2jvtwEVsRps1AwhgURxwb+jsvB97x
 VtajBYr1p+HyDwTnwScOD832xCIg0Ff1tQtZvMFXbyx8uQggByoB/WqUxlFfqwWSeVoF
 KRutrEzKNhE+P9XLPqlc0lDw6x0v91Wumabt3Y3hfxstiqfRzhB3G+CwjUNJiTQOhLuc
 vyCn2fpriwuqxOachs30SafkkyB0eYq+5U2GiN4s4OsuXvsFAT7i18R2017sRMsUpsGZ
 VMgxYQGbDRIUQIAgJioFgkeLqaiSr2rN5L2gGzuXlQ/Ev7PWCJxecaXElvmISohAU0YB
 +VHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790497647; x=1791102447;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=t4U13ItbJ0ZD2xH3wybFDs4byUeHHQl2NVsga6UTsOc=;
 b=VwdEd8xO3uusk0EvcdxMtDDc+BFMxHOVeTslkEwGTvxcCeINxGz2/vesY1sg1y1QGL
 abAQA2T4reiN1dJQAm5czeVNgJLWVsQRsn5rKUDvVoUdntZqAwnVG1ZQ2luxicDjiSiB
 vFO1MxAyWbcUs8gaq+GHoBxWqbG/WD/IzvaPkHpxkqR3pgErOreHJFOOoRpnuOM648t9
 qSVQ1vZL5ClqzVp+DHvT/dnLvZd/3o3TWzjUM3kobs5+2BX/8qAImNihogdg/z84fjwi
 8m9l4JaSrpJSxtOJvyHRZqN74Cp/09OkoBCKuUhBBZ2mlPpBqj7zK/uK16kzzzK+JJPu
 ariA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwwZP5GsMp7rUG99UBxoZ2JipGrBgtaM4HWAhJgnOpuTSvvt22Pi3ExT71/JULgDXeY7NUj9gssam0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJl+YK5K5zp6p4BKoBiav6y5xbCII/0ogAdETLEe2xrfTOrbzmv
 yOqoc3D6tOFaQ4PInx0bFl8kS919Tz+X9uHMzLKyBwd/FERt7Z5mi8J2
X-Gm-Gg: AYBFou1WRqTO3kwU5OvkD+xbwkW42wxX1+3RtvSA2Jhe/vlai2KtfAeGV36tUAaGsnw
 5RIeb1rXxctqCBv5qOIiPWrDxeX+bqW5RkIUI5gW6qktavooCfxD+ZWFLQxV/rNPbNsM0/t2P69
 2Hk5i7VIhu4oJG58tJHmvItc1O0tWXwlZYC6GgllVgYHWPe0Upxh0zk2t/vFFyIdpvFJ2v7wLaE
 /aZ8VSuBinC3/YT2rdEc2uhXmoGPtYO6VOsBUH5RBgiMdSA+Uv+Bd9tESm8W6kOx/LZnycYlmIL
 jzLIBr8/14QsVYoiLoHzk+8bJ2QDdZv9Z5BX5CzTUabaxgR0lb/41ZXoXD/47kjOCiMd9kLAZHv
 FXH0lrsDBboJ/kdGAupw0W1gvWWAAEtnOKNbDzpuNN5gQdrIFpMzJCsHmggyia/J3GoQxyB28Jg
 VS4mmOQtTkil37r0IZa+J77BUa4bZBJUUrdV3osdnNyUWA05PwsaePYeQ9T2CAvLk=
X-Received: by 2002:a17:90b:39a7:b0:3a0:bbd8:5b9b with SMTP id
 98e67ed59e1d1-3a0bbd8792cmr5620700a91.66.1790497647218; 
 Sun, 27 Sep 2026 01:27:27 -0700 (PDT)
Received: from [127.0.1.1] ([1.243.227.27]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a2b1e4d5basm1921496a91.9.2026.09.27.01.27.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Sep 2026 01:27:26 -0700 (PDT)
From: Gyeyoung Baek <gye976@gmail.com>
Date: Sun, 27 Sep 2026 17:25:55 +0900
Subject: [PATCH 3/3] drm/imagination: Size page table preallocation by
 device address
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-pvr-fixes-a-v1-3-7f5b18ab989a@gmail.com>
References: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
In-Reply-To: <20260927-pvr-fixes-a-v1-0-7f5b18ab989a@gmail.com>
To: Alessio Belle <alessio.belle@imgtec.com>, 
 Luigi Santivetti <luigi.santivetti@imgtec.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
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

pvr_mmu_op_context_create() preallocates the page tables a mapping
needs. How many is set by the device-virtual address being mapped, not
by the offset into the object's pages, which it used instead.

Size the preallocation from the device address instead.

Fixes: ff5f643de0bf ("drm/imagination: Add GEM and VM related code")
Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
---
 drivers/gpu/drm/imagination/pvr_mmu.c | 27 ++++++++++++++-------------
 drivers/gpu/drm/imagination/pvr_mmu.h |  3 ++-
 drivers/gpu/drm/imagination/pvr_vm.c  |  5 +++--
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_mmu.c b/drivers/gpu/drm/imagination/pvr_mmu.c
index 3e494bfa936..dd5f6d32864 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.c
+++ b/drivers/gpu/drm/imagination/pvr_mmu.c
@@ -2335,7 +2335,8 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
  * pvr_mmu_op_context_create() - Create an MMU op context.
  * @ctx: MMU context associated with owning VM context.
  * @sgt: Scatter gather table containing pages pinned for use by this context.
- * @sgt_offset: Start offset of the requested device-virtual memory mapping.
+ * @sgt_offset: Offset into @sgt of the start of the requested mapping.
+ * @device_addr: Device-virtual address at the start of the requested mapping.
  * @size: Size in bytes of the requested device-virtual memory mapping. For an
  * unmapping, this should be zero so that no page tables are allocated.
  *
@@ -2346,7 +2347,7 @@ void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx)
  */
 struct pvr_mmu_op_context *
 pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *sgt,
-			  u64 sgt_offset, u64 size)
+			  u64 sgt_offset, u64 device_addr, u64 size)
 {
 	int err;
 
@@ -2362,18 +2363,18 @@ pvr_mmu_op_context_create(struct pvr_mmu_context *ctx, struct sg_table *sgt,
 
 	if (size) {
 		/*
-		 * The number of page table objects we need to prealloc is
-		 * indicated by the mapping size, start offset and the sizes
-		 * of the areas mapped per PT or PD. The range calculation is
-		 * identical to that for the index into a table for a device
-		 * address, so we reuse those functions here.
+		 * The page tables needed are set by the device-virtual range
+		 * being mapped: one level 1 table per 1GiB region and one
+		 * level 0 table per 2MiB region the range touches. Tables that
+		 * already exist are not consumed, so this is an upper bound.
 		 */
-		const u32 l1_start_idx = pvr_page_table_l2_idx(sgt_offset);
-		const u32 l1_end_idx = pvr_page_table_l2_idx(sgt_offset + size);
-		const u32 l1_count = l1_end_idx - l1_start_idx + 1;
-		const u32 l0_start_idx = pvr_page_table_l1_idx(sgt_offset);
-		const u32 l0_end_idx = pvr_page_table_l1_idx(sgt_offset + size);
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
diff --git a/drivers/gpu/drm/imagination/pvr_mmu.h b/drivers/gpu/drm/imagination/pvr_mmu.h
index a8ecd460168..7088f80805e 100644
--- a/drivers/gpu/drm/imagination/pvr_mmu.h
+++ b/drivers/gpu/drm/imagination/pvr_mmu.h
@@ -99,7 +99,8 @@ dma_addr_t pvr_mmu_get_root_table_dma_addr(struct pvr_mmu_context *ctx);
 void pvr_mmu_op_context_destroy(struct pvr_mmu_op_context *op_ctx);
 struct pvr_mmu_op_context *
 pvr_mmu_op_context_create(struct pvr_mmu_context *ctx,
-			  struct sg_table *sgt, u64 sgt_offset, u64 size);
+			  struct sg_table *sgt, u64 sgt_offset,
+			  u64 device_addr, u64 size);
 
 int pvr_mmu_map(struct pvr_mmu_op_context *op_ctx, u64 size, u64 flags,
 		u64 device_addr);
diff --git a/drivers/gpu/drm/imagination/pvr_vm.c b/drivers/gpu/drm/imagination/pvr_vm.c
index c5ae0b79fe6..7bb58ca14e4 100644
--- a/drivers/gpu/drm/imagination/pvr_vm.c
+++ b/drivers/gpu/drm/imagination/pvr_vm.c
@@ -276,7 +276,8 @@ pvr_vm_bind_op_map_init(struct pvr_vm_bind_op *bind_op,
 		goto err_bind_op_fini;
 
 	bind_op->mmu_op_ctx =
-		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, sgt, offset, size);
+		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, sgt, offset,
+					  device_addr, size);
 	err = PTR_ERR_OR_ZERO(bind_op->mmu_op_ctx);
 	if (err) {
 		bind_op->mmu_op_ctx = NULL;
@@ -318,7 +319,7 @@ pvr_vm_bind_op_unmap_init(struct pvr_vm_bind_op *bind_op,
 	}
 
 	bind_op->mmu_op_ctx =
-		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, 0, 0);
+		pvr_mmu_op_context_create(vm_ctx->mmu_ctx, NULL, 0, 0, 0);
 	err = PTR_ERR_OR_ZERO(bind_op->mmu_op_ctx);
 	if (err) {
 		bind_op->mmu_op_ctx = NULL;

-- 
2.43.0

