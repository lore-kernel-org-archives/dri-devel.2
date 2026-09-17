Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4088CC88E72
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:34:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FB0D10EEA4;
	Thu, 17 Sep 2026 12:34:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="PMVym+np";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A903010EE89
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789648436;
 bh=aJVJGqAxRDrukH3Sf8Wf633FJCiWUOMYXyKmSTk8psc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PMVym+npNkzn/YnoZkk2K045nv22SIaInlPRspHzByEei6WmbA3fpC1ywBnnLWi3z
 Sd8SbIcXKPmvjz6mB9InzfPzF6E2vYCui7PvURB0XCRvS6t67nj3Ld180sHU3Zplm1
 /5HEL3LPulZctjvXmUfCR6TdX6aze0tQ1JpsBH5HsmdGnzAUKDnr7B88IuwnzRxV5J
 JZtHxdn44SKx2KzkGtZtEYb84Mnc7PAPhdJuyWtuooNBR2eC0ADcMfy/Hlq0tjVf6X
 hQZzTKa7QQr1Wpee770lL9fvPSCFoJQjSN1bF0ao6vEf0TLUzfCFMBJTRXN8Fsn9pe
 dICrZt0uFem1Q==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F297D17E0D43;
 Thu, 17 Sep 2026 14:33:55 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 17 Sep 2026 14:33:45 +0200
Subject: [PATCH 3/4] drm/panthor: Consolidate the is-huge-page-mapping test
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-panthor-fix-partial-unmap-v1-3-c7008f15fea3@collabora.com>
References: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
In-Reply-To: <20260917-panthor-fix-partial-unmap-v1-0-c7008f15fea3@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Akash Goel <akash.goel@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789648434; l=4892;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=aJVJGqAxRDrukH3Sf8Wf633FJCiWUOMYXyKmSTk8psc=;
 b=ZeMKwZBDEOsY/YkZUiqu6zw+QTNEw8GXV/jgm0fdnWGXrJq/+KyIQN/AGkOwdDYTKoG1CQogC
 fm1/V5LMhlaCfbRcKC0v6G8WqMGnK0kZlT+6jp9w61F98FYYO2vk99P
X-Developer-Key: i=boris.brezillon@collabora.com; a=ed25519;
 pk=eN+ORdOgQY7d5U+0kA8h5bf67XdD8bhKbjD/TCHexSY=
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

Right now the logic to determine whether a given VA in the drm_gpuva
being unmapped is a huge page mapping or not is scattered
in two functions: unmap_hugepage_align() and
iova_mapped_as_huge_page(). This makes it harder to reason about the
logic being implemented for very little gain (some simple checks being
done twice), so let's consolidate all the checks related to huge page
mapping testing in iova_mapped_as_huge_page() and leave
unmap_hugepage_align() as a simple user of this helper that aligns the
area to unmap based on the return of iova_mapped_as_huge_page().

Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 57 +++++++++++++++++------------------
 1 file changed, 28 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index 6cef954e2cba..d2897099763e 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2301,10 +2301,11 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
 	u64 aligned_va = ALIGN_DOWN(va, SZ_2M);
 	pgoff_t bo_offset;
 
-	/* If the 2M-aligned VA is outside the mapping being tested, we know
-	 * it's not a huge map.
+	/* If the 2M section being tested is crossing the mapping boundary
+	 * we know it's not a huge map.
 	 */
-	if (aligned_va < mapping->va.addr)
+	if (aligned_va < mapping->va.addr ||
+	    aligned_va + SZ_2M > mapping->va.addr + mapping->va.range)
 		return false;
 
 	bo_offset = aligned_va - mapping->va.addr + mapping->gem.offset;
@@ -2337,10 +2338,21 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
 		return false;
 	} else {
 		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
+		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
+		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
 
-		/* In case of shmem backing, we know we can only have a huge mapping
-		 * if the bo_offset is 2M aligned, meaning we can skip the folio size
-		 * check if it's not the case.
+		/* If the unmapped VMA stands for a sparse mapping, always
+		 * assume the backing storage is a THP, since the overhead of
+		 * unmapping 2MiB worth of 4KiB pages and remapping some of
+		 * them is offset by the logic of working out whether it's
+		 * the opposite case right below.
+		 */
+		if (is_sparse)
+			return true;
+
+		/* In case of shmem backing, we know we can only have a huge
+		 * mapping if the bo_offset is 2M aligned, meaning we can skip
+		 * the folio size check if it's not the case.
 		 */
 		if (!IS_ALIGNED(bo_offset, SZ_2M))
 			return false;
@@ -2353,36 +2365,23 @@ static void
 unmap_hugepage_align(const struct drm_gpuva_op_remap *op,
 		     u64 *unmap_start, u64 *unmap_range)
 {
-	struct panthor_vma *unmap_vma = container_of(op->unmap->va, struct panthor_vma, base);
-	bool is_sparse = unmap_vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
-	u64 aligned_unmap_start, aligned_unmap_end, unmap_end;
-
-	unmap_end = *unmap_start + *unmap_range;
-	aligned_unmap_start = ALIGN_DOWN(*unmap_start, SZ_2M);
-	aligned_unmap_end = ALIGN(unmap_end, SZ_2M);
+	u64 unmap_end = *unmap_start + *unmap_range;
 
 	/* If we're dealing with a huge page, make sure the unmap region is
-	 * aligned on the start of the page. If the unmapped VMA stands for
-	 * a sparse mapping, always assume the backing storage is a THP, since
-	 * the overhead of unmapping 2MiB worth of 4KiB pages and remapping
-	 * some of them is offset by the logic of working out whether it's
-	 * the opposite case right below. This also holds true for op->next.
+	 * aligned on the start of the page.
 	 */
-	if (op->prev && aligned_unmap_start < *unmap_start &&
-	    op->prev->va.addr <= aligned_unmap_start &&
-	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, *unmap_start))) {
-		*unmap_range += *unmap_start - aligned_unmap_start;
-		*unmap_start = aligned_unmap_start;
-	}
+	if (op->prev && !IS_ALIGNED(*unmap_start, SZ_2M) &&
+	    iova_mapped_as_huge_page(op->unmap->va, *unmap_start))
+		*unmap_start = ALIGN_DOWN(*unmap_start, SZ_2M);
 
 	/* If we're dealing with a huge page, make sure the unmap region is
 	 * aligned on the end of the page.
 	 */
-	if (op->next && aligned_unmap_end > unmap_end &&
-	    op->next->va.addr + op->next->va.range >= aligned_unmap_end &&
-	    (is_sparse || iova_mapped_as_huge_page(op->unmap->va, unmap_end - 1))) {
-		*unmap_range += aligned_unmap_end - unmap_end;
-	}
+	if (op->next && !IS_ALIGNED(unmap_end, SZ_2M) &&
+	    iova_mapped_as_huge_page(op->unmap->va, unmap_end - 1))
+		unmap_end = ALIGN(unmap_end, SZ_2M);
+
+	*unmap_range = unmap_end - *unmap_start;
 }
 
 static int panthor_gpuva_sm_step_remap(struct drm_gpuva_op *op,

-- 
2.55.0

