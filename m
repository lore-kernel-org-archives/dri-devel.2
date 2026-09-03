Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1F9C79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1B3E10F89F;
	Fri,  4 Sep 2026 07:19:32 +0000 (UTC)
Received: from mta1.migadu.com (out-124.mta1.migadu.com [95.215.58.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322F710F51C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:25:03 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta10.migadu.com with ESMTPS id 42ffe0522571fddf;
 Thu, 03 Sep 2026 11:18:57 +0000
X-Mizu-Trace-ID: 42ffe0522571fddf
X-Migadu-Flow: FLOW_OUT
From: Baoquan He <hebaoquan@kylinos.cn>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hch@lst.de, harry@kernel.org,
 Baoquan He <hebaoquan@kylinos.cn>, dri-devel@lists.freedesktop.org
Subject: [PATCH 02/13] drm/sti: Don't use GFP_DMA when calling dma_alloc_wc()
Date: Thu,  3 Sep 2026 19:18:25 +0800
Message-ID: <20260903111836.1777265-3-hebaoquan@kylinos.cn>
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

dma_alloc_wc() allocates the DMA buffer with the device's
addressing limitation in mind; the DMA core picks the zone from the
device's coherent DMA mask and ignores GFP_DMA passed by the caller.
Remove the redundant GFP_DMA flag.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Baoquan He <hebaoquan@kylinos.cn>
---
 drivers/gpu/drm/sti/sti_cursor.c | 4 ++--
 drivers/gpu/drm/sti/sti_hqvdp.c  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_cursor.c b/drivers/gpu/drm/sti/sti_cursor.c
index d0b89b28e50c..a0ec671477fd 100644
--- a/drivers/gpu/drm/sti/sti_cursor.c
+++ b/drivers/gpu/drm/sti/sti_cursor.c
@@ -240,7 +240,7 @@ static int sti_cursor_atomic_check(struct drm_plane *drm_plane,
 		cursor->pixmap.base = dma_alloc_wc(cursor->dev,
 						   cursor->pixmap.size,
 						   &cursor->pixmap.paddr,
-						   GFP_KERNEL | GFP_DMA);
+						   GFP_KERNEL);
 		if (!cursor->pixmap.base) {
 			DRM_ERROR("Failed to allocate memory for pixmap\n");
 			return -EINVAL;
@@ -380,7 +380,7 @@ struct drm_plane *sti_cursor_create(struct drm_device *drm_dev,
 	/* Allocate clut buffer */
 	size = 0x100 * sizeof(unsigned short);
 	cursor->clut = dma_alloc_wc(dev, size, &cursor->clut_paddr,
-				    GFP_KERNEL | GFP_DMA);
+				    GFP_KERNEL);
 
 	if (!cursor->clut) {
 		DRM_ERROR("Failed to allocate memory for cursor clut\n");
diff --git a/drivers/gpu/drm/sti/sti_hqvdp.c b/drivers/gpu/drm/sti/sti_hqvdp.c
index cf1ed8a33b8e..b0d66834bcbe 100644
--- a/drivers/gpu/drm/sti/sti_hqvdp.c
+++ b/drivers/gpu/drm/sti/sti_hqvdp.c
@@ -860,7 +860,7 @@ static void sti_hqvdp_init(struct sti_hqvdp *hqvdp)
 	size = NB_VDP_CMD * sizeof(struct sti_hqvdp_cmd);
 	hqvdp->hqvdp_cmd = dma_alloc_wc(hqvdp->dev, size,
 					&dma_addr,
-					GFP_KERNEL | GFP_DMA);
+					GFP_KERNEL);
 	if (!hqvdp->hqvdp_cmd) {
 		DRM_ERROR("Failed to allocate memory for VDP cmd\n");
 		return;
-- 
2.54.0

