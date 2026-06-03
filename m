Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DCD0CD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:42:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91BA610F754;
	Wed,  3 Jun 2026 01:42:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="NYhSJkFL";
	dkim-atps=neutral
X-Greylist: delayed 414 seconds by postgrey-1.36 at gabe;
 Wed, 03 Jun 2026 01:42:48 UTC
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com
 [91.218.175.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F90310F754
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:42:48 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780450552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=HExVF90/xRMJOCIBWPxUryKc84gRK04Xn6EiupoYnxI=;
 b=NYhSJkFLoi0guDzdszjPoV3lsxp7XIuZqbWC18nZEKtoXe8F5GpUYqSSwMe+9rxWJZxq55
 dqYD2WwdKnp+gmTRTvLDnf6soUDojPtyaslDxJC5wo4Ig6Kxx+TaESLNoJBpqZX7huYlHl
 IDWNNJikkxPjcB0hQtJ4DUxcev/xVmY=
From: Jackie Liu <liu.yun@linux.dev>
To: mamin506@gmail.com,
	lizhi.hou@amd.com
Cc: dri-devel@lists.freedesktop.org
Subject: [PATCH 1/2] accel/amdxdna: fix memory leak in amdxdna_iommu_alloc()
 when iommu_map() fails
Date: Wed,  3 Jun 2026 09:35:42 +0800
Message-ID: <20260603013543.94835-1-liu.yun@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
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

From: Jackie Liu <liuyun01@kylinos.cn>

When iommu_map() fails in amdxdna_iommu_alloc(), the code jumps to
the 'free_iova' label which only frees the IOVA allocation. The
physical pages allocated by __get_free_pages() are not freed, causing
a memory leak.

Add a 'free_pages' intermediate label to properly release the pages
before freeing the IOVA, matching the cleanup order in
amdxdna_iommu_free().

Fixes: ece3e8980907 ("accel/amdxdna: Allow forcing IOVA-based DMA via module parameter")
Signed-off-by: Jackie Liu <liuyun01@kylinos.cn>
---
 drivers/accel/amdxdna/amdxdna_iommu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/accel/amdxdna/amdxdna_iommu.c b/drivers/accel/amdxdna/amdxdna_iommu.c
index 4626434d4180..af67e059d599 100644
--- a/drivers/accel/amdxdna/amdxdna_iommu.c
+++ b/drivers/accel/amdxdna/amdxdna_iommu.c
@@ -110,10 +110,12 @@ void *amdxdna_iommu_alloc(struct amdxdna_dev *xdna, size_t size, dma_addr_t *dma
 			iova_align(&xdna->iovad, size),
 			IOMMU_READ | IOMMU_WRITE, GFP_KERNEL);
 	if (ret)
-		goto free_iova;
+		goto free_pages;
 
 	return cpu_addr;
 
+free_pages:
+	free_pages((unsigned long)cpu_addr, get_order(size));
 free_iova:
 	__free_iova(&xdna->iovad, iova);
 	return ERR_PTR(ret);
-- 
2.54.0

