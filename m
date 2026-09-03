Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47961C79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 07:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4204710F8AA;
	Fri,  4 Sep 2026 07:19:34 +0000 (UTC)
X-Greylist: delayed 364 seconds by postgrey-1.36 at gabe;
 Thu, 03 Sep 2026 11:24:54 UTC
Received: from mta1.migadu.com (out-116.mta1.migadu.com [95.215.58.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E2D910F51C
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 11:24:53 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by mta12.migadu.com with ESMTPS id db39fdad40467b0f;
 Thu, 03 Sep 2026 11:18:48 +0000
X-Mizu-Trace-ID: db39fdad40467b0f
X-Migadu-Flow: FLOW_OUT
From: Baoquan He <hebaoquan@kylinos.cn>
To: linux-mm@kvack.org
Cc: akpm@linux-foundation.org, hch@lst.de, harry@kernel.org,
 Baoquan He <hebaoquan@kylinos.cn>, dri-devel@lists.freedesktop.org
Subject: [PATCH 01/13] gpu: ipu-v3: Don't use GFP_DMA when calling
 dma_alloc_coherent()
Date: Thu,  3 Sep 2026 19:18:24 +0800
Message-ID: <20260903111836.1777265-2-hebaoquan@kylinos.cn>
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

dma_alloc_coherent() allocates the DMA buffer with the device's
addressing limitation in mind; the DMA core picks the zone from the
device's coherent DMA mask and ignores GFP_DMA passed by the caller.
Remove the redundant GFP_DMA flag.

Cc: dri-devel@lists.freedesktop.org
Signed-off-by: Baoquan He <hebaoquan@kylinos.cn>
---
 drivers/gpu/ipu-v3/ipu-image-convert.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/ipu-v3/ipu-image-convert.c b/drivers/gpu/ipu-v3/ipu-image-convert.c
index 29b6d36c9bb6..493be4d4b091 100644
--- a/drivers/gpu/ipu-v3/ipu-image-convert.c
+++ b/drivers/gpu/ipu-v3/ipu-image-convert.c
@@ -371,7 +371,7 @@ static int alloc_dma_buf(struct ipu_image_convert_priv *priv,
 {
 	buf->len = PAGE_ALIGN(size);
 	buf->virt = dma_alloc_coherent(priv->ipu->dev, buf->len, &buf->phys,
-				       GFP_DMA | GFP_KERNEL);
+				       GFP_KERNEL);
 	if (!buf->virt) {
 		dev_err(priv->ipu->dev, "failed to alloc dma buffer\n");
 		return -ENOMEM;
-- 
2.54.0

