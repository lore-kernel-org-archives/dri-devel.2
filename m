Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D03AC982D1
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B153F10EE9B;
	Thu, 17 Sep 2026 12:33:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="gUIhr/FC";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A70610EE89
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 12:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789648435;
 bh=+/6KEJbBTvcP3lAfbZbBakogb+HfHH7iLFVHHmk1YoU=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=gUIhr/FC9+Cl5DFVzrJYVeO0JcJTA1T15TJvK8x3B0FWu5TUhOi8IVS0kUX1yhuHB
 6SVYGKPWW0GYnUAGKeMipVbSVau3gkC2yaXkoz268wud29FJuGKydD6OIoRQrwPSYW
 sQ17H4tEdlERTIRpl25zU+EBvIbXvuMJ8rdnltKrEzPTHK+3hBDmi1d22Fia7odM3r
 1b/xvYMQmoXmMRWnI9aVbzJM6uLHl+OUHoL3pfMae0RRP1XgCSE1cqMEabeMlKBjRQ
 00/WRAVFXLVP0Mo96sfzoN+ZBW9d9XTUdwLk9/K8qIKlyVypwjxy6JOB+OHeyjBmDR
 8G247a+Xro7MA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 636D017E0CFC;
 Thu, 17 Sep 2026 14:33:55 +0200 (CEST)
From: Boris Brezillon <boris.brezillon@collabora.com>
Date: Thu, 17 Sep 2026 14:33:44 +0200
Subject: [PATCH 2/4] drm/panthor: Fix iova_mapped_as_huge_page() for
 imported BOs
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-panthor-fix-partial-unmap-v1-2-c7008f15fea3@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789648434; l=2952;
 i=boris.brezillon@collabora.com; s=20260429; h=from:subject:message-id;
 bh=+/6KEJbBTvcP3lAfbZbBakogb+HfHH7iLFVHHmk1YoU=;
 b=/6f0RvsmRgtCwqThhT/PPj2gaRskYBI2YfE6ievX8O1cQq6L4EofKhrSDQWV+efX7B6Ltird6
 +2avVtJSqAeAs4VE14V24hhr/lZWazV7AkFGTiaGW3h0CgmqZ/5R+5Q
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

Imported BOs have no backing.pages array allocated, leading to a NULL
deref when iova_mapped_as_huge_page() gets called on them.

Implement this check through and sgt walk to reach the position of the
sgt targeted by a VA, and check that the DMA address is properly aligned
and the size remaining in the SG entry is bigger than a huge page.
This is basically matching the logic in vm_map_pages(), with get_pgsize()
being replaced by a simpler test, because we don't care about the pgcount
info.

Reported-by: Akash Goel <akash.goel@arm.com>
Fixes: 8e7460eac786 ("drm/panthor: Support partial unmaps of huge pages")
Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
---
 drivers/gpu/drm/panthor/panthor_mmu.c | 44 ++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
index b0a7033480e6..6cef954e2cba 100644
--- a/drivers/gpu/drm/panthor/panthor_mmu.c
+++ b/drivers/gpu/drm/panthor/panthor_mmu.c
@@ -2299,7 +2299,6 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
 {
 	struct panthor_gem_object *bo = to_panthor_bo(mapping->gem.obj);
 	u64 aligned_va = ALIGN_DOWN(va, SZ_2M);
-	const struct page *pg;
 	pgoff_t bo_offset;
 
 	/* If the 2M-aligned VA is outside the mapping being tested, we know
@@ -2309,16 +2308,45 @@ iova_mapped_as_huge_page(struct drm_gpuva *mapping, u64 va)
 		return false;
 
 	bo_offset = aligned_va - mapping->va.addr + mapping->gem.offset;
-	pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
 
-	/* In case of shmem backing, we know we can only have a huge mapping
-	 * if the bo_offset is 2M aligned, meaning we can skip the folio size
-	 * check if it's not the case.
-	 */
-	if (!IS_ALIGNED(bo_offset, SZ_2M))
+	if (drm_gem_is_imported(&bo->base)) {
+		struct sg_table *sgt = bo->dmap.sgt;
+		struct scatterlist *sgl;
+		unsigned int count;
+
+		/* If this is an imported BO, we have to walk the SGT and
+		 * check the dma address/size alignment to determine if it's
+		 * a huge map or not.
+		 */
+		for_each_sgtable_dma_sg(sgt, sgl, count) {
+			size_t len = sg_dma_len(sgl);
+			dma_addr_t daddr;
+
+			if (len <= bo_offset) {
+				bo_offset -= len;
+				continue;
+			}
+
+			len -= bo_offset;
+			daddr = sg_dma_address(sgl) + bo_offset;
+
+			return IS_ALIGNED(daddr, SZ_2M) &&
+			       len >= SZ_2M;
+		}
+
 		return false;
+	} else {
+		const struct page *pg = bo->backing.pages[bo_offset >> PAGE_SHIFT];
 
-	return folio_size(page_folio(pg)) >= SZ_2M;
+		/* In case of shmem backing, we know we can only have a huge mapping
+		 * if the bo_offset is 2M aligned, meaning we can skip the folio size
+		 * check if it's not the case.
+		 */
+		if (!IS_ALIGNED(bo_offset, SZ_2M))
+			return false;
+
+		return folio_size(page_folio(pg)) >= SZ_2M;
+	}
 }
 
 static void

-- 
2.55.0

