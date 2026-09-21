Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF90AC982F7
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:40:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9C6810E795;
	Mon, 21 Sep 2026 13:39:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c1Vfgztn";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C06AD10E78F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:48 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e7d2bb404so9633215e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997987; x=1790602787; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mH7BvLrcnLu8WRQAlFxz4vQAXzatlrTdCQIygZg9AG4=;
 b=c1Vfgztnj2AxiaNkC/5cv/Ekyu4UumorqB1g9BXe3xaThSeJMC9qJrAJv44nVofWes
 5l8WZQavLQrKh9mNSa9AIbGaL66HEvmTNr3YehCFBFgN49C/3aU2kMHV1nXkne0t/u9l
 wsj01bXlWsS+4fOWpBcylFSjCnAYWS16dhWvA2v3GURYvRan4QyK3J2N5eQaq49JPpda
 52oU/m3bB/28HLpdtnAKT0IZ9S3xcg9qa/TnrCQRMgCZHunlARblsXJrP2TbjmYSyhiD
 xvMtyFZE19REUewXasgLJrCOJLzBP+EmQXPpSJrrRmu72Xi155FU4vvhdV3k05dyYPWo
 SeXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997987; x=1790602787;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=mH7BvLrcnLu8WRQAlFxz4vQAXzatlrTdCQIygZg9AG4=;
 b=Nwr/5vtHRf6/UedYmOmsJYjursUDgLOVNdGId94g/16DlAFbkJRGm5WFfCvMaS2k8p
 kZs3zC7QITL5oaZbcuMrVzrQCKMIJIDY6oXaZq/ZlX5GNRtOKhCu0g0QmwUqN6HeULMl
 re1GtudwiebwJgw7C235O4YRrHYziB4iF7StrajpqSKY6JI+PJqjmp/92OnhguIZ+KnP
 TDmztT+W+liowluLifSaHxsVOATdFcvLOJUwvIo3Vvcj9su0kTzsS1nWgxqEA+W+cFXt
 KxlrINYUjZ1mjLnqgNRhEwJPFL9Et8MNBs0Qx538qQYjxPyrw64oEpAH4PEXW44fd6vC
 YCFA==
X-Forwarded-Encrypted: i=1;
 AKwUvByELia1yyoS1K0XG68ZR6Gpuepcl35nGEacvZVpBeZ8vsQ2yrochKpHBnwVixwC7JRed3h2OZASBYU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kgzglGG8nCfRrDKkIBV62JNgPZtJ0i5opXhmXLy0JYUwg+eZGU
 V5bud+VzQskNdi5cn4deVrpJeD2sgxvbSATcKL3KDuq7kMr+JwpZYFqO
X-Gm-Gg: AYBFou1YCc1CBLkYts2VggTZMTBb9pUA/FbvNsmh/jbzvOyAnJ5V1M4pATuMm3FX+if
 nkck2jkfqf7pXZI3Hhfm2f0EGG9wm6W1rrzUTPGmKXUC2oet6kdzcwBfxG8zzfnNjQRCaYj0uQe
 PdYaIFg0964ukGCPVeYe3w+lfeRamsnsuEWKc++bdvQUrNSJ4OC9/s7DEPBP5ZnFak53+8ne5tX
 n0n6w/89g2SG3hKp+yvav2SOpjQNA6vvVlsDzQAeZK2Z6m5Rs916IfaE0fOQRMIkIc7yj3AnDKP
 P9U9LFVfK+XYsQwvIgUhREENlndEidyxlUiWCaNpR2kiZHewzgjN1DzJl2cNmqDG4AncfE9RWUB
 4P6r40XyBSuG4XjeJncs1nYzaRn//4ydWKnoOYw7CLETYlZc/FEFVmsQ04HJkbZt2dwhg+Mv8lz
 T5aIFpf56gPOWxisDAe2NcTJucqOXJYsK1IaHy5/mkTgColoC4Bw98V16xuvzYr1N6a6laFf3aN
 3WO6Pqb/TxPlGcLYXIBYjEA2Nf+kOQy4/oBCyV30xoRKbTuhr5vmR+OSNimGc/lowBQ5hprFOr5
 +JimrTPtbfpP4VEhLpjZ8YLGv1n9sQ==
X-Received: by 2002:a05:600c:1d06:b0:49e:8222:3451 with SMTP id
 5b1f17b1804b1-49fc5001358mr167903285e9.14.1789997987144; 
 Mon, 21 Sep 2026 06:39:47 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:46 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: linux-block@vger.kernel.org
Cc: asml.silence@gmail.com, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, linux-nvme@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Andrew Morton <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>,
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v6 08/13] nvme-pci: add SGL support for the dmabuf path
Date: Mon, 21 Sep 2026 14:38:52 +0100
Message-ID: <1a50e7e88263f97403f8df8583dbb1953600f2a9.1789997898.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
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

From: Anuj Gupta <anuj20.g@samsung.com>

Add SGL support in addition to PRP for dmabuf-backed requests,
building the descriptor list from the mapping's sg_table.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 153 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 149 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8dc4002fa696..4756f114154c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1297,12 +1297,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
+static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+		dma_addr_t addr, u32 len)
+{
+	sge->addr = cpu_to_le64(addr);
+	sge->length = cpu_to_le32(len);
+	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+}
+
 static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
-	sge->addr = cpu_to_le64(iter->addr);
-	sge->length = cpu_to_le32(iter->len);
-	sge->type = NVME_SGL_FMT_DATA_DESC << 4;
+	nvme_pci_sgl_set_data(sge, iter->addr, iter->len);
 }
 
 static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
@@ -1313,6 +1319,145 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
 	sge->type = NVME_SGL_FMT_LAST_SEG_DESC << 4;
 }
 
+static unsigned int nvme_pci_dmabuf_sgl_nents(struct request *req)
+{
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct scatterlist *sg;
+	unsigned long tmp;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = blk_rq_payload_bytes(req);
+	unsigned int nents = 0;
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		sg_len -= offset;
+		offset = 0;
+
+		do {
+			size_t chunk = min(remaining, sg_len);
+
+			nents++;
+			sg_len -= chunk;
+			remaining -= chunk;
+		} while (sg_len && remaining);
+	}
+
+	if (unlikely(remaining))
+		return 0;
+
+	return nents;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
+		struct nvme_queue *nvmeq, unsigned int entries)
+{
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+	struct bio *bio = req->bio;
+	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	size_t length = blk_rq_payload_bytes(req);
+	struct nvme_sgl_desc *sg_list = &iod->cmd.common.dptr.sgl;
+	bool pooled = entries > 1;
+	dma_addr_t sgl_dma = 0;
+	unsigned int mapped = 0;
+	unsigned long tmp;
+	struct scatterlist *sg;
+	size_t offset = bio->bi_iter.bi_offset;
+	size_t remaining = length;
+
+	if (!entries)
+		return BLK_STS_IOERR;
+
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+	iod->total_len = length;
+
+	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
+
+	/* entries == 1 fits in the inline descriptor; more needs a pool. */
+	if (pooled) {
+		if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
+			iod->flags |= IOD_SMALL_DESCRIPTOR;
+
+		sg_list = dma_pool_alloc(nvme_dma_pool(nvmeq, iod), GFP_ATOMIC,
+					 &sgl_dma);
+		if (!sg_list)
+			return BLK_STS_RESOURCE;
+		iod->descriptors[iod->nr_descriptors++] = sg_list;
+	}
+
+	for_each_sgtable_dma_sg(map->sgt, sg, tmp) {
+		size_t sg_len = sg_dma_len(sg);
+		dma_addr_t addr = sg_dma_address(sg);
+
+		if (!remaining)
+			break;
+		if (offset >= sg_len) {
+			offset -= sg_len;
+			continue;
+		}
+
+		addr += offset;
+		sg_len -= offset;
+		offset = 0;
+
+		do {
+			u32 chunk = min_t(size_t, remaining, sg_len);
+
+			if (WARN_ON_ONCE(mapped == entries))
+				goto err_free;
+			nvme_pci_sgl_set_data(&sg_list[mapped++], addr, chunk);
+
+			addr += chunk;
+			sg_len -= chunk;
+			remaining -= chunk;
+		} while (sg_len && remaining);
+	}
+
+	if (unlikely(remaining))
+		goto err_free;
+
+	if (pooled)
+		nvme_pci_sgl_set_seg(&iod->cmd.common.dptr.sgl, sgl_dma,
+				     mapped);
+	return BLK_STS_OK;
+err_free:
+	if (pooled) {
+		iod->nr_descriptors--;
+		dma_pool_free(nvme_dma_pool(nvmeq, iod), sg_list, sgl_dma);
+	}
+	return BLK_STS_IOERR;
+}
+
+static blk_status_t nvme_rq_setup_dmabuf(struct request *req,
+		struct nvme_queue *nvmeq, enum nvme_use_sgl use_sgl)
+{
+	unsigned int entries;
+	size_t avg_seg;
+
+	if (use_sgl == SGL_UNSUPPORTED)
+		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+
+	entries = nvme_pci_dmabuf_sgl_nents(req);
+
+	if (use_sgl == SGL_FORCED)
+		return nvme_rq_setup_dmabuf_sgl(req, nvmeq, entries);
+
+	avg_seg = entries ?
+		DIV_ROUND_UP(blk_rq_payload_bytes(req), entries) : 0;
+	if (sgl_threshold && avg_seg >= sgl_threshold)
+		return nvme_rq_setup_dmabuf_sgl(req, nvmeq, entries);
+
+	return nvme_rq_setup_dmabuf_map(req, nvmeq);
+}
+
 static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 		struct blk_dma_iter *iter)
 {
@@ -1408,7 +1553,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	blk_status_t ret;
 
 	if (blk_mq_rq_is_dmabuf(req))
-		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+		return nvme_rq_setup_dmabuf(req, nvmeq, use_sgl);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0

