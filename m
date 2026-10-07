Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C46CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFE5110F449;
	Wed,  7 Oct 2026 01:43:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HHFBLZxT";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 189FF10F13C
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:24 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so39591965e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337402; x=1791942202; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SSeH33Tp73HrlxrRD40ZRw/kp0xshqtHbX/nV8WDcGA=;
 b=HHFBLZxT8FYkc9wfYH3R5PtHLSeI2wt6kkduc0iNjRgkcvU10NqdH6DBbJQLXjWZmm
 UrEV+gqd3+W89xsXfbinKDfHhiyLn/2zXqOHlobxE58ILwHNKkfR2ErbHIc6BWR89bad
 U18elOn5VJmPz/kfLuOdFq0nwRizCi9e+XKOuHQ5HVk0HMWv/41PyP43Wyqq/IWMiM+Q
 LmyhKFKvigWgfTk3jXYVIdNQPdzGdQE4rFjhxn5bE7S0RcLL3xALCsTpwhZFQZiLaOfR
 i6D6a2l+7nxAiEuL1jcdyYHiXgh67e12UNG7GUt4I99rONcDj16zvVRpagHfhZ+bp3Cm
 5MNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337402; x=1791942202;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SSeH33Tp73HrlxrRD40ZRw/kp0xshqtHbX/nV8WDcGA=;
 b=wZ6+mdGBCScObicQH4+7cpMTsjBNdwaxQQ2JcYkuvmzTc7A9SNUMnFcVpRL3jVns8T
 kqgJydnyY2JRze3SSnND59nRoieajOyz2+WvppZ4H7TRNwNaoMIjk9ULWprdzIjtqqlL
 ypqwcSynXYwKhzVugB2zbAjl244xC/j/3O9WIov8i6inzsjAtv9UGSmpS5uL1dp1Zrj/
 S/HnMZexNOobg4HNkvWKtcpOYwjCP2OBnVtwEdA1iJQhSUI+pQrsborPvwGwDlzJiJRE
 Nbg53e5FT0MXrsLnY4KQQmZtdfNz5qiFy2JkU5v2YcRgbAFoeE1L/BwiwM8MA9gG/6uF
 9oiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz+8cS0vtfbggmmstwTHEUs6HSrVn4EnOYV3K0WaRf88s7OHvoZ74GTNHEfL5A1ZO6OWGVYly0nueU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nN67b+x1Wm4+ztBVAQPeacg3ohtz7PnKeC5Kqd7SGkYM0yJcGg
 x098KtI0YNPWLR8Jk6hjOFXOv9kFgf827dJKJY14/KFyoxuM7KdwoMfa
X-Gm-Gg: AYBFou2rfzicQmOVSiL9wGiLHzgsj7dn3C7L9IA5PnxlPJfT/qi+OMNQOdk5mYuZCn5
 1vLKbXHa6VZK3xX7XczcDExcYAxQNUTb6giWCLpLzJBeNkPSV7S6opHME0SFo3Ycn4P7V3c8C/D
 WqXLknnCjjnGQx5uxM9aJnltykYOk14POmj4xt/B/Xw+K1tqqifB7aLZYSadHBEMgxtw31j5vxS
 sbB2s83aSQoiWwBmXMsTnUSDZoxNzVMLTD7XR8OH6zGnDuum/pz7RRPDa8tort3+PcN/7zSFIXh
 1tj0e2oSPzJAvBq9QDzVltGZLJCagiAwj90nhRwDEApVvJoG0vtPVr/3bxuqMDPAM813dfpXfyG
 DevXSJlY2jI2HcwNm2+E1I6zf4xIoh5cOfqv7A/ZyK//SvfS5DbGQdtZoYZX73dYNOOaYuDqZdY
 iqbCK+1G9zEA9cnDP6/70qy90TP2MsIZx+hNqS9o6m441MEknWzi61Xq6IT//dwn8h18egJ5ztx
 oOLHMe1f2Rt7dhy7NnC+zTRcwukaraZDHHKMNzphhqkLmUUDktBtCEpyBDcYTtx5+ZAdOpn6/F5
X-Received: by 2002:a05:600c:3e88:b0:4a0:b6:4619 with SMTP id
 5b1f17b1804b1-4a1800807b4mr8642425e9.0.1791337402388; 
 Tue, 06 Oct 2026 18:43:22 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:21 -0700 (PDT)
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
 Matthew Brost <matthew.brost@intel.com>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Subject: [PATCH v9 08/13] nvme-pci: add SGL support for the dmabuf path
Date: Wed,  7 Oct 2026 02:42:51 +0100
Message-ID: <0613da77bbb89c3128221ffed3a76af4817981cd.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
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
 drivers/nvme/host/pci.c | 150 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 146 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a0506c93fa16..79b3c1092e4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1223,12 +1223,18 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
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
@@ -1239,6 +1245,142 @@ static void nvme_pci_sgl_set_seg(struct nvme_sgl_desc *sge,
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
+	struct nvme_dmabuf_map *map = nvme_req_to_map(req);
+	size_t length = blk_rq_payload_bytes(req);
+	struct nvme_sgl_desc *sg_list = &iod->cmd.common.dptr.sgl;
+	size_t offset = req->bio->bi_iter.bi_offset;
+	bool pooled = entries > 1;
+	dma_addr_t sgl_dma = 0;
+	unsigned int mapped = 0;
+	unsigned long tmp;
+	struct scatterlist *sg;
+	size_t remaining = length;
+
+	if (!entries)
+		return BLK_STS_IOERR;
+
+	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
+	iod->total_len = length;
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
@@ -1334,7 +1476,7 @@ static blk_status_t nvme_map_data(struct request *req)
 	blk_status_t ret;
 
 	if (blk_mq_rq_is_dmabuf(req))
-		return nvme_rq_setup_dmabuf_map(req, nvmeq);
+		return nvme_rq_setup_dmabuf(req, nvmeq, use_sgl);
 
 	/*
 	 * Try to skip the DMA iterator for single segment requests, as that
-- 
2.54.0

