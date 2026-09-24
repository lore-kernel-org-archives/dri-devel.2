Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75553C98317
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 11:05:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 89C8010F47C;
	Thu, 24 Sep 2026 11:05:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="oPEz3aWT";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E0C310F477
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 11:04:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1790247889;
 bh=XXFQmfxbeg12M2OgKN8dJ9l8UIV4ldaUbZSuiynE7b4=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oPEz3aWTOD7BORoXvzIu8ZcdFFTYDR65DWxRg6vPai1wDhU70fz7IgiTAI/n2VvcF
 AI/sDLpbXbEgWG4QZ2+tmah/F7SgFxptiITV887SDZG9ciMHQbdePrn9DtmWwDoACG
 7uQNuNQid/AsK3XQbXaWmV1qyGzFvngvTrdkijVPxwhq4If7aDi5uPXKfsT5iEOk3X
 /KrkNEYeJob2TT6zzTH4Yo0ab3Qj1o79BV1FL3meTVbnYLA0PxOLvI09uL0QVZaByX
 qm84l1crTV9aWsPIbBJRAkm5gqT7AChFcaM4SnA6RWRs6Tksw6Jjfi8qdA97IP8a9P
 TnPNHuqPprXug==
Received: from fedora-32.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 9DD9117E0B0F;
 Thu, 24 Sep 2026 13:04:48 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 24 Sep 2026 13:04:41 +0200
Subject: [PATCH v2 4/5] drm/panthor: Actually check huge-page mapping on
 sparse regions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-panthor-fix-partial-unmap-v2-4-59a68a1f9e14@collabora.com>
References: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
In-Reply-To: <20260924-panthor-fix-partial-unmap-v2-0-59a68a1f9e14@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 =?utf-8?q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>, 
 Akash Goel <akash.goel@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Boris Brezillon <boris.brezillon@collabora.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790247886; l=2529;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=XXFQmfxbeg12M2OgKN8dJ9l8UIV4ldaUbZSuiynE7b4=;
 b=l/2yTWBNMeOJtPU6XlpqndFiYPPeycUcG7eZjtPC93NZDKhi11vFCOgO9xHR4iERb/9oXymjD
 Hcq/8fsUb4/C1JTK92i1i/K6v53+WNIjkB7qYNx9lkrI/NVzvWkvgah
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

With the recent changes to iova_mapped_as_huge_page(), the check for
huge-page mapping of sparse BOs is actually simple:

- for a sparse mapping, we know the BO offset any VA in this regions is
  va & (SZ_2M - 1)
- the VA we're searching the BO offset for is the 2M-aligned
  aligned_va value

This guarantees that the BO offset to check is always zero in that case.

This is simple enough to let the code check if page 0 is a huge page
and save the unmap+map dance when the dummy BO is not backed by a
a huge page. So let's do that and kill the comment that says it's too
complicated.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>
Reviewed-by: Akash Goel <akash.goel@arm.com>
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index d2897099763e..01564d250adf 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2337,18 +2337,18 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
 
 		return false;
 	} else {
-		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
 		struct panthor_vma *vma = container_of(mapping, struct panthor_vma, base);
 		bool is_sparse = vma->flags & DRM_PANTHOR_VM_BIND_OP_MAP_SPARSE;
+		const struct page *pg;
 
-		/* If the unmapped VMA stands for a sparse mapping, always
-		 * assume the backing storage is a THP, since the overhead of
-		 * unmapping 2MiB worth of 4KiB pages and remapping some of
-		 * them is offset by the logic of working out whether it's
-		 * the opposite case right below.
+		/* BO offset on a sparse mapping is chosen so that 2M-aligned
+		 * VAs point to the start of the BO. Since aligned_va (the
+		 * address we check huge-page against) is 2M-aligned, the BO
+		 * offset is guaranteed to be zero.
+		 * Check panthor_fix_sparse_map_offset() for more details.
 		 */
 		if (is_sparse)
-			return true;
+			bo_offset = 0;
 
 		/* In case of shmem backing, we know we can only have a huge
 		 * mapping if the bo_offset is 2M aligned, meaning we can skip
@@ -2357,6 +2357,7 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
 		if (!IS_ALIGNED(bo_offset, SZ_2M))
 			return false;
 
+		pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
 		return folio_size(page_folio(pg)) >= SZ_2M;
 	}
 }

-- 
2.55.0

