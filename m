Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44526CA9ED1
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 13:00:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2D7910F05F;
	Mon, 12 Oct 2026 13:00:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E4D8210EF1A
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 12:59:57 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E3411A00;
 Mon, 12 Oct 2026 05:59:54 -0700 (PDT)
Received: from e120398-lin.trondheim.arm.com (e120398-lin.trondheim.arm.com
 [10.42.46.160])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3A31D3F66F;
 Mon, 12 Oct 2026 05:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791809997; bh=SwCssg1TtHWQq2cdAinXB1qI41TqJtYDamzkLDOC6fA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=HdAw3cBO1/tCgaMzK0D2MgS4llSSUEKQ3hye7w4v3eiQ3q+hMh0qxVj8vEAdqXhzt
 kYbJ62I5aISbD1mepAjka+MXBYlAXnF/eKPYXfW1bF4nKosadA8oGKdSn0DrdNCrxs
 ZT6ILx2aahPEIAMHxgZcy5WWkgyMd1/jx5N5dyJw=
From: Ketil Johnsen <ketil.johnsen@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Alice Ryhl <aliceryhl@google.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Ketil Johnsen <ketil.johnsen@arm.com>
Subject: [PATCH v4 01/12] drm/panthor: De-duplicate FW memory section sync
Date: Mon, 12 Oct 2026 14:59:29 +0200
Message-ID: <20261012125940.3291951-2-ketil.johnsen@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125940.3291951-1-ketil.johnsen@arm.com>
References: <20261012125940.3291951-1-ketil.johnsen@arm.com>
MIME-Version: 1.0
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

Handle the sync to device of FW memory sections inside
panthor_fw_init_section_mem() so that the callers do not have to.

This small improvement is also critical for protected FW sections,
so we avoid issuing memory transactions to protected memory from
CPU running in normal mode.

Signed-off-by: Ketil Johnsen <ketil.johnsen@arm.com>
Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Steven Price <steven.price@arm.com>
---
 drivers/gpu/drm/panthor/panthor_fw.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
index 4f1fab66a13bf..5f9f7a92c56a8 100644
--- a/drivers/gpu/drm/panthor/panthor_fw.c
+++ b/drivers/gpu/drm/panthor/panthor_fw.c
@@ -449,6 +449,7 @@ static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
 					struct panthor_fw_section *section)
 {
 	bool was_mapped = !!section->mem->kmap;
+	struct sg_table *sgt;
 	int ret;
 
 	if (!section->data.size &&
@@ -467,6 +468,12 @@ static void panthor_fw_init_section_mem(struct panthor_device *ptdev,
 
 	if (!was_mapped)
 		panthor_kernel_bo_vunmap(section->mem);
+
+	/* An sgt should have been requested when the kernel BO was GPU-mapped. */
+	sgt = to_panthor_bo(section->mem->obj)->dmap.sgt;
+	if (!drm_WARN_ON_ONCE(&ptdev->base, !sgt))
+		dma_sync_sgtable_for_device(ptdev->base.dev, sgt,
+					    DMA_TO_DEVICE);
 }
 
 /**
@@ -639,7 +646,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 
 	if (section_size) {
 		u32 cache_mode = hdr.flags & CSF_FW_BINARY_IFACE_ENTRY_CACHE_MODE_MASK;
-		struct panthor_gem_object *bo;
 		u32 vm_map_flags = 0;
 		u64 va = hdr.va.start;
 
@@ -676,14 +682,6 @@ static int panthor_fw_load_section_entry(struct panthor_device *ptdev,
 		}
 
 		panthor_fw_init_section_mem(ptdev, section);
-
-		bo = to_panthor_bo(section->mem->obj);
-
-		/* An sgt should have been requested when the kernel BO was GPU-mapped. */
-		if (drm_WARN_ON_ONCE(&ptdev->base, !bo->dmap.sgt))
-			return -EINVAL;
-
-		dma_sync_sgtable_for_device(ptdev->base.dev, bo->dmap.sgt, DMA_TO_DEVICE);
 	}
 
 	if (hdr.va.start == CSF_MCU_SHARED_REGION_START)
@@ -738,17 +736,10 @@ panthor_reload_fw_sections(struct panthor_device *ptdev, bool full_reload)
 	struct panthor_fw_section *section;
 
 	list_for_each_entry(section, &ptdev->fw->sections, node) {
-		struct sg_table *sgt;
-
 		if (!full_reload && !(section->flags & CSF_FW_BINARY_IFACE_ENTRY_WR))
 			continue;
 
 		panthor_fw_init_section_mem(ptdev, section);
-
-		/* An sgt should have been requested when the kernel BO was GPU-mapped. */
-		sgt = to_panthor_bo(section->mem->obj)->dmap.sgt;
-		if (!drm_WARN_ON_ONCE(&ptdev->base, !sgt))
-			dma_sync_sgtable_for_device(ptdev->base.dev, sgt, DMA_TO_DEVICE);
 	}
 }
 
-- 
2.43.0

