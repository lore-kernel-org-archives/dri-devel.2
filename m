Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62053606A33D
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 14:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SzPep4VP
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7F9E10E19C;
	Tue, 24 Nov 2026 14:57:01 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 75C4D10E279
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 14:56:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1AFF642338;
 Tue, 24 Nov 2026 14:56:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82F3C1F00AD4;
 Tue, 24 Nov 2026 14:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795532215;
 bh=6ljZQd+A8hlRvztSzlA4/q0WCsIDb1/JrAE0c3c4d8k=;
 h=From:To:Cc:Subject:Date;
 b=SzPep4VPN8Sy0XElS+PRpLcSrLY94bccshHxN0x0U0IoOntw/c6kHDYYq32aQQM04
 QF9Q8mgTGTslsQDXQZWfcR/oKmoXxTSXXG5thr6SKqwgGOYWQaX6Drc9xNqZZ7sdjZ
 W8xywf85qO4XMdg5sY/Mcp0UrGXvDm8Eh8tWMoMPtwNBg5+ZMTkDTRpAwUssklgTqa
 aci/67iepvEVnrgjMNe4ai2dHRktRczm1tWHTkjGsXWY49Bm0pr6pD+KKSXBuy0EQ2
 oISVd1pCU3DSZiWHnl5Eg4tEvSJLYYOJGOsDAGKVUvgPiiS8qp/kruQQEXj8zuoHVo
 KKzloYXbCO0Wg==
From: Sasha Levin <sashal@kernel.org>
To: Mark Brown <broonie@kernel.org>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Jai Luthra <jai.luthra@ideasonboard.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-rpi-kernel@lists.infradead.org,
 Linux Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: semantic conflict between the drm-misc and broadcom trees
Date: Tue, 24 Nov 2026 09:56:52 -0500
Message-ID: <20261124145652.3657102-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mark,

The current drm-misc tree has a semantic conflict with the broadcom
tree that breaks the build:

  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:217:3: error: call to undeclared function 'dma_buf_unmap_attachment_unlocked'
  drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c:438:8: error: call to undeclared function 'dma_buf_map_attachment_unlocked'

77e0b2d2f4f3 ("treewide: Rename dma_buf_(un)map_attachment() to
dma_buf_(un)map_sgt()") in the drm-misc tree renames the functions, and
6e0a8f1a8347 ("platform/raspberrypi: Add VideoCore shared memory
support") in the broadcom tree adds a new user of the old names. It is
the only caller in next-20261123 that the rename doesn't cover.

The fix for the merge:

diff --git a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
--- a/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
+++ b/drivers/platform/raspberrypi/vc-sm-cma/vc_sm.c
@@ -214,9 +214,8 @@ static void vc_sm_clean_up_dmabuf(struct vc_sm_buffer *buffer)
 {
 	/* Handle cleaning up imported dmabufs */
 	if (buffer->sgt) {
-		dma_buf_unmap_attachment_unlocked(buffer->attach,
-						  buffer->sgt,
-						  DMA_BIDIRECTIONAL);
+		dma_buf_unmap_sgt_unlocked(buffer->attach, buffer->sgt,
+					   DMA_BIDIRECTIONAL);
 		buffer->sgt = NULL;
 	}
 	if (buffer->attach) {
@@ -435,7 +434,7 @@ vc_sm_cma_import_dmabuf_internal(struct dma_buf *dma_buf,
 		goto error;
 	}

-	sgt = dma_buf_map_attachment_unlocked(attach, DMA_BIDIRECTIONAL);
+	sgt = dma_buf_map_sgt_unlocked(attach, DMA_BIDIRECTIONAL);
 	if (IS_ERR(sgt)) {
 		ret = PTR_ERR(sgt);
 		goto error;
@@ -550,8 +549,7 @@ vc_sm_cma_import_dmabuf_internal(struct dma_buf *dma_buf,
 		free_kernel_id(import.kernel_id);
 	kfree(buffer);
 	if (sgt)
-		dma_buf_unmap_attachment_unlocked(attach, sgt,
-						  DMA_BIDIRECTIONAL);
+		dma_buf_unmap_sgt_unlocked(attach, sgt, DMA_BIDIRECTIONAL);
 	if (attach)
 		dma_buf_detach(dma_buf, attach);
 	dma_buf_put(dma_buf);

-- 
Thanks,
Sasha
