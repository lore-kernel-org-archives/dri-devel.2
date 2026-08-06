Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818B7C55ABF
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 12:01:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBDAE10E30E;
	Thu,  6 Aug 2026 12:01:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=picoheart.com header.i=@picoheart.com header.b="xOVSYSS/";
	dkim-atps=neutral
Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A599810E30E
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 12:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2604151535; d=picoheart.com; t=1786017687; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=AoJmxuBMw6iXTcmAismV7WTvr+lLAU35/6ICxLrNJNo=;
 b=xOVSYSS/3zGnGIsVbyxoyy13n6/04HlHx0aJNDkybJsgy2acegkn6H8IDQ8TyCEp7XvdZT
 4YirrPY0B21oJJvHlXvN5mtoXGYOp6HA31JEvmrOsSpczEOBPaoyppUONh0frjyKZM6UPY
 r3ObJjhnHvVpiImejUhyLrdYqF1Dk+qd55q/FJBYwzVOiF6JB3mTxP8nqk8ih6mHWWWLge
 0ycW35EK6Esk9Odv6AGgG+WyPdRl5FDvmoLH3KlDxaSLpRQENGNiWu6na5So0xh/xNd80l
 EZO+AdqA6+k18GlPp4YqmRatwk4Lcgfl7/80TCz3yMKy717/9l3BSiN2yRDjrQ==
X-Original-From: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
X-Lms-Return-Path: <lba+26a747796+c856c9+lists.freedesktop.org+liuzhaoyu.zackary@picoheart.com>
Date: Thu, 6 Aug 2026 20:01:22 +0800
Content-Type: text/plain; charset=UTF-8
Subject: [PATCH] drm/pagemap: no need to recheck own pagemap in
 migrate_to_devmem
Message-Id: <anR3ksBglj78TJgp@hostpc>
From: "Zhaoyu Liu" <liuzhaoyu.zackary@picoheart.com>
Mime-Version: 1.0
Content-Disposition: inline
Received: from hostpc ([183.129.139.234]) by smtp.feishu.cn with ESMTPS;
 Thu, 06 Aug 2026 20:01:25 +0800
Content-Transfer-Encoding: 7bit
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>, 
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>, 
 <thomas.hellstrom@linux.intel.com>
Cc: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
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

The second loop in drm_pagemap_migrate_to_devmem() checks
`page_pgmap(src_page) == pagemap && !can_migrate_same_pagemap` to skip
pages already on the target pagemap. However, this condition is always
false at this point: if can_migrate_same_pagemap is false and any own
pages exist, the first loop already returns -EBUSY before reaching here.

Signed-off-by: Zhaoyu Liu <liuzhaoyu.zackary@picoheart.com>
---
 drivers/gpu/drm/drm_pagemap.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 15c78eca180b..6842eadee6df 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -730,8 +730,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	if (err)
 		goto err_aborted_migration;
 
-	own_pages = 0;
-
 	for (i = 0; i < npages;) {
 		unsigned long j;
 		struct page *page = pfn_to_page(migrate.dst[i]);
@@ -744,12 +742,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			struct drm_pagemap_zdd *src_zdd =
 				drm_pagemap_page_zone_device_data(src_page);
 
-			if (page_pgmap(src_page) == pagemap &&
-			    !mdetails->can_migrate_same_pagemap) {
-				migrate.dst[i] = 0;
-				own_pages++;
-				goto next;
-			}
+			/* Own or peer device private page */
 			cur.dpagemap = src_zdd->dpagemap;
 			cur.ops = src_zdd->devmem_allocation->ops;
 			cur.device = cur.dpagemap->drm->dev;
@@ -786,7 +779,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			goto err_finalize;
 		}
 
-next:
 		i += NR_PAGES(order);
 	}
 
@@ -797,8 +789,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	if (err)
 		goto err_finalize;
 
-	drm_WARN_ON(dpagemap->drm, !!own_pages);
-
 	dma_fence_put(devmem_allocation->pre_migrate_fence);
 	devmem_allocation->pre_migrate_fence = NULL;
 
@@ -822,7 +812,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 		i += nr_pages;
 	}
 
-	if (!err && migrated_pages < npages - own_pages) {
+	if (!err && migrated_pages < npages) {
 		drm_dbg(dpagemap->drm, "Raced while finalizing migration.\n");
 		err = -EBUSY;
 	}
-- 
2.34.1
