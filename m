Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 340E1C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2D6A10EDB9;
	Thu, 30 Jul 2026 06:16:52 +0000 (UTC)
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BF9910EDB9
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:16:50 +0000 (UTC)
X-UUID: 3b4723f28bde11f1aa26b74ffac11d73-20260730
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:bf69a04d-1604-4d9a-99c6-5dce613aa77c, IP:0,
 U
 RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
 release,TS:0
X-CID-META: VersionHash:e7bac3a, CLOUDID:977fc7254810ece84cceaff0ae7418d7,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:102|123|850|865|898,TC:nil,Content:0|15|
 50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0
 ,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b4723f28bde11f1aa26b74ffac11d73-20260730
X-User: yaolu@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <yaolu@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 217884325; Thu, 30 Jul 2026 14:16:41 +0800
From: yaolu@kylinos.cn
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Lu Yao <yaolu@kylinos.cn>
Subject: [PATCH] drm/pagemap: Remove unreachable code in
 drm_pagemap_migrate_to_devmem()
Date: Thu, 30 Jul 2026 14:16:35 +0800
Message-Id: <20260730061635.132619-1-yaolu@kylinos.cn>
X-Mailer: git-send-email 2.25.1
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

From: Lu Yao <yaolu@kylinos.cn>

If it can satisfy the condition of "page_pgmap(src_page) == pagemap
&& ! mdetails->can_migrate_same_pagemap", it will be return -EBUSY in
the precondition checks above the loop.

Fixes: 75af93b3f5d0 ("drm/pagemap, drm/xe: Support destination migration over interconnect")
Signed-off-by: Lu Yao <yaolu@kylinos.cn>
---
 drivers/gpu/drm/drm_pagemap.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 892b325fa99b..23d60a271f17 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -746,12 +746,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			struct drm_pagemap_zdd *src_zdd =
 				drm_pagemap_page_zone_device_data(src_page);
 
-			if (page_pgmap(src_page) == pagemap &&
-			    !mdetails->can_migrate_same_pagemap) {
-				migrate.dst[i] = 0;
-				own_pages++;
-				goto next;
-			}
 			cur.dpagemap = src_zdd->dpagemap;
 			cur.ops = src_zdd->devmem_allocation->ops;
 			cur.device = cur.dpagemap->drm->dev;
@@ -788,7 +782,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 			goto err_finalize;
 		}
 
-next:
 		i += NR_PAGES(order);
 	}
 
@@ -799,8 +792,6 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	if (err)
 		goto err_finalize;
 
-	drm_WARN_ON(dpagemap->drm, !!own_pages);
-
 	dma_fence_put(devmem_allocation->pre_migrate_fence);
 	devmem_allocation->pre_migrate_fence = NULL;
 
-- 
2.25.1

