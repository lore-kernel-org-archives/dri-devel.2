Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF59CC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C782F10F8BA;
	Fri,  4 Sep 2026 07:19:58 +0000 (UTC)
X-Greylist: delayed 1806 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 11:55:28 UTC
Received: from mta0.migadu.com (out-233.mta0.migadu.com [91.218.175.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0F6610F54A
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:55:28 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta11.migadu.com with ESMTPS id c3b095fa7e51e4a4;
 Thu, 03 Sep 2026 11:19:17 +0000
X-Mizu-Trace-ID: c3b095fa7e51e4a4
X-Migadu-Flow: FLOW_OUT
From: Baoquan He <hebaoquan@kylinos.cn>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hch@lst.de, harry@kernel.org,
 Baoquan He <hebaoquan@kylinos.cn>, dri-devel@lists.freedesktop.org
Subject: [PATCH 05/13] fbdev: fsl-diu-fb: Don't use GFP_DMA when calling
 dmam_alloc_coherent()
Date: Thu,  3 Sep 2026 19:18:28 +0800
Message-ID: <20260903111836.1777265-6-hebaoquan@kylinos.cn>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260903111836.1777265-1-hebaoquan@kylinos.cn>
References: <20260903111836.1777265-1-hebaoquan@kylinos.cn>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 04 Sep 2026 07:19:31 +0000
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

dmam_alloc_coherent() allocates the DMA buffer with the device's
addressing limitation in mind; the DMA core picks the zone from the
device's coherent DMA mask and ignores GFP_DMA passed by the caller.
Remove the redundant GFP_DMA flag.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Baoquan He <hebaoquan@kylinos.cn>
---
 drivers/video/fbdev/fsl-diu-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/fsl-diu-fb.c b/drivers/video/fbdev/fsl-diu-fb.c
index b71d15794ce8..d7ed007915c1 100644
--- a/drivers/video/fbdev/fsl-diu-fb.c
+++ b/drivers/video/fbdev/fsl-diu-fb.c
@@ -1690,7 +1690,7 @@ static int fsl_diu_probe(struct platform_device *pdev)
 	int ret;
 
 	data = dmam_alloc_coherent(&pdev->dev, sizeof(struct fsl_diu_data),
-				   &dma_addr, GFP_DMA | __GFP_ZERO);
+				   &dma_addr, __GFP_ZERO);
 	if (!data)
 		return -ENOMEM;
 	data->dma_addr = dma_addr;
-- 
2.54.0

