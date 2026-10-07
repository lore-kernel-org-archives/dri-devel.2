Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20864CA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54C0710F44A;
	Wed,  7 Oct 2026 01:43:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgGRgHCA";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09EF010F44A
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:21 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so10913345e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337399; x=1791942199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=KgGRgHCASlEnDtqiTApdZiVt150cKUfip1K1ojcEY1ZqDtc/I9j9iXZOlgJGRLCu6M
 2ltwLhmELNQa8jMJS6p5CS7SQ/C1F9562n4FnIsaOOq0dMfDYB64s/30ez/JuvaDfymM
 4SFkUWwNeF43IHAdoy0Ac4YAPa4E5By4xGEPMNSFw7DqzjuWnIfVxQfEm0oQAdxX32L0
 zkcaXR7AZXVp/S8wIimg5j9BuNDPx6y8e4WhrmkbY2gywhj8fQmd2tBv9qZCTnxzH9Zb
 5EXl6nLcIRUzPnh4KodYocI36ndMPU/YmLQcAjw1C1bz00zo2S5r5edc+jL+26X93g2A
 JL/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337399; x=1791942199;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=dc+bKgeyOe14IkP4+MYvF6iBr/GYbU4MzmEzCYHRj7BeblkyRIa26jlojoTMF4w+lG
 quNI5F416rGTqyST0UC/4V/teWh22oi4zHLf55B5ESNhNIRz/jNZ4i/Yssmi/lTbjtg5
 3DxgU0XP2Y5253myRggcU2iV0+OwPfxMrlfl9XyyJQ2uNlUXsvVXFijAkvHfmBGz5xBe
 sHTSFVL5HRKjaAMFApLi1PbcgYSD6ug3u9k4zmqy2OBVkEI+edYA2tqGBVsQLBfBhkXi
 dmnhb7FPyDuXcNn2y/0pnf0U0TngfaCWgswVrdwYMWd4vpwm3C8nvN5uodtL4ejFk5yT
 aT/g==
X-Forwarded-Encrypted: i=1;
 AKwUvByP7PqwryfKVplWkju0CqMSpIhMQxE5CLnZXXC4sG3zPoicdbI+dUdh+xNC49Wx32gqx0OvLMkWdho=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m6MaTnffJRfeqNWb09F5Z5uSLjzi/EBFz2wFMlG+NrBEZsDc7I
 jMVAAb1Z4BW70/EhJ/v48RneRsdkNRE2uqGxiTUKgfxcMlHNiOtCrfJr
X-Gm-Gg: AYBFou0CdwGvaN+iQnSBhuHxWM9i5/JJjrbwaj7K2xAiVDtXGTKO09gPG+b/ooNeEsR
 yMq4QKlzjigPTgYQl9vq3WCgnEWeTbpfa5wJ4f3Ij9rRTPxpODq8O/jWj8xkhhy2gW45zTZJCX9
 nq9CuJzBn657qHsaNUUiyEkNDu9l5gCK8wcJQYuLx68HyiOHcQqiROaqMx+7J/rMw9v3DgLMLmg
 WBDdc5t6uxSe1QFlPms5E0JhpMvpCtEtc8SmhqMHp0d2O4J63OlwWWuogYv9bj/35AWIGzPYhLc
 fbK57gY2O3ful3/LXb5HOuW2nImdNn+7CX0d8JZGQpgygsuEn9MMuXJT8K8Fx5QqHhustQ7KLeJ
 ANv5VWoOiY0dg9iS3MXXJD0nbHgquRHhP7dF1RMAItjCE7U9MHRj6TPS5ixFFlZnW/V2Y+rCJc3
 Ek4ka6/ryESZyLBoQRGvQwEl2xVi8/E76aWEMcGhjYZb+wSe0d2K4DjKgsVfFfF4N0gCr+Oyko5
 eZL/Z1dlRdRhSnqR/tN814odrDRnwgzRcC+mTi/NzJKEote1qoFNq9eg7sM+eWsIBtAio54occs
X-Received: by 2002:a05:600c:348f:b0:49f:dd9f:6038 with SMTP id
 5b1f17b1804b1-4a18043b38dmr6958715e9.25.1791337399492; 
 Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
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
Subject: [PATCH v9 06/13] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Wed,  7 Oct 2026 02:42:49 +0100
Message-ID: <2f8b57f68fd3e432085b3a7767971778bc7d1919.1791336930.git.asml.silence@gmail.com>
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

Rename the blk_dma_iter based nvme_pci_sgl_set_data() to
nvme_pci_dma_iter_set_sgl().

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 77317e5d00f9..a65b77726e4b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1147,7 +1147,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1177,7 +1177,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1199,7 +1199,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1359,13 +1359,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	iod->cmd.common.metadata = cpu_to_le64(sgl_dma);
 	if (entries == 1) {
 		iod->meta_total_len = iter.len;
-		nvme_pci_sgl_set_data(sg_list, &iter);
+		nvme_pci_dma_iter_set_sgl(sg_list, &iter);
 		return BLK_STS_OK;
 	}
 
 	sgl_dma += sizeof(*sg_list);
 	do {
-		nvme_pci_sgl_set_data(&sg_list[++i], &iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[++i], &iter);
 		iod->meta_total_len += iter.len;
 	} while (blk_rq_integrity_dma_map_iter_next(req, dev->dev, &iter));
 
-- 
2.54.0

