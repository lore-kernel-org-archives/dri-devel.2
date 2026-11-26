Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF588606A327
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mYNg7xja
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 49299112494;
	Thu, 26 Nov 2026 14:19:58 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0C94112470;
 Thu, 26 Nov 2026 14:19:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0A9E40823;
 Thu, 26 Nov 2026 14:19:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 460CC1F000CF;
 Thu, 26 Nov 2026 14:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795702791;
 bh=qTtoQav1e0mPKUJi3xGwyEJuXSQqz7+AIi65Xpjvqks=;
 h=From:To:Cc:Subject:Date;
 b=mYNg7xjauKUq3DGtXABXWAVcEK4uEr4zclFPym8iC8JbMgBbHSuAZWQl9Yu91HwSs
 epPTm3viGzuQcuhGwWcIjzKwo9SbJdab9dIxwQK3q+lYAwvw5ZoqZG+uIxGRITxGed
 unq99GPU+17FAJc4xubKvCO2ORQdt58S3VChW6fQO0dyinJTkpfJGmYk6O6yIZnabG
 Y+UUsuIDH0WcXcH55EpNmtlQgyKuC5rkGwukNNyrEid9+YGw/nBuhPN/GiXWDa41Ma
 9ebARrA1rIDqdxnqSo7fh4FQf5K51PxloamzkgzTFUweOJAqZGzp6Y5JRLlxqp9i0r
 kx10pG7elvshQ==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>
Cc: Abhinav Kumar <abhinav.kumar@linux.dev>,
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Pengyu Luo <mitltlatltl@gmail.com>, Alexander Koskovich <akoskovich@pm.me>,
 Abel Vesa <abel.vesa@oss.qualcomm.com>,
 Kavan Smith <kavansmith82@gmail.com>, Jonathan Marek <jonathan@marek.ca>,
 Jordan Crouse <jordan@cosmicpenguin.net>, linux-arm-msm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH] drm/msm/dsi: Fix TX buffer pin leak on command transfers
Date: Thu, 26 Nov 2026 16:19:42 +0200
Message-ID: <20261126141942.335280-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The DSI 6G TX buffer is allocated by msm_gem_kernel_new(), which pins
the buffer object in the KMS address space and returns its IOVA, but the
returned IOVA is ignored. Instead dsi_dma_base_get_6g() calls
msm_gem_get_and_pin_iova() on every DSI command transfer to get the TX
buffer address, and the buffer is never unpinned after the transfer.

As a result the pin count of the TX buffer object grows with every
transmitted DSI command, and when the buffer is freed by
msm_gem_kernel_put(), which drops only the pin taken on allocation,
the object is freed while still pinned:

  msm_obj->pin_count
  WARNING: drivers/gpu/drm/msm/msm_gem.c:173 at update_lru_locked+0x90/0x98
  Call trace:
   update_lru_locked+0x90/0x98 (P)
   put_pages+0x8c/0x104
   msm_gem_free_object+0x1bc/0x244
   drm_gem_object_free+0x1c/0x30
   msm_gem_kernel_put+0xa4/0xb8
   msm_dsi_tx_buf_free+0x2c/0x64
   dsi_unbind+0x20/0x40

Save the IOVA returned on the TX buffer allocation and use it as the DMA
base of command transfers without pinning the buffer again.

Fixes: 9fe041f6fdfe ("drm/msm: Add msm_gem_get_and_pin_iova()")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/gpu/drm/msm/dsi/dsi_host.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/dsi_host.c b/drivers/gpu/drm/msm/dsi/dsi_host.c
index 78f0fd259421..5a6fb1a5a890 100644
--- a/drivers/gpu/drm/msm/dsi/dsi_host.c
+++ b/drivers/gpu/drm/msm/dsi/dsi_host.c
@@ -153,6 +153,7 @@ struct msm_dsi_host {
 	/* DSI 6G TX buffer*/
 	struct drm_gem_object *tx_gem_obj;
 	struct drm_gpuvm *vm;
+	u64 tx_iova;
 
 	/* DSI v2 TX buffer */
 	void *tx_buf;
@@ -1261,6 +1262,7 @@ int dsi_tx_buf_alloc_6g(struct msm_dsi_host *msm_host, int size)
 
 	msm_gem_object_set_name(msm_host->tx_gem_obj, "tx_gem");
 
+	msm_host->tx_iova = iova;
 	msm_host->tx_size = msm_host->tx_gem_obj->size;
 
 	return 0;
@@ -1422,14 +1424,13 @@ static int dsi_long_read_resp(u8 *buf, const struct mipi_dsi_msg *msg)
 
 int dsi_dma_base_get_6g(struct msm_dsi_host *msm_host, uint64_t *dma_base)
 {
-	struct drm_device *dev = msm_host->dev;
-	struct msm_drm_private *priv = dev->dev_private;
-
 	if (!dma_base)
 		return -EINVAL;
 
-	return msm_gem_get_and_pin_iova(msm_host->tx_gem_obj,
-				priv->kms->vm, dma_base);
+	/* The TX buffer is pinned on allocation by msm_gem_kernel_new() */
+	*dma_base = msm_host->tx_iova;
+
+	return 0;
 }
 
 int dsi_dma_base_get_v2(struct msm_dsi_host *msm_host, uint64_t *dma_base)
-- 
2.51.0

