Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E194CC6B19
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:55:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAA910F9E1;
	Tue, 13 Oct 2026 20:55:38 +0000 (UTC)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D829410F9E1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:55:29 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so906747f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791924928; x=1792529728; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=LEt1irGVwQtQrLumPPYlPdNNeV6UCn4EjE//I49puWwgnTYh7Sfwgb7rLvgujcz0/d
 XF7T7Gy4oObveXIMV7mY1SWR4+uS5oKuSgXt4MzURrJ7Du+8V8macicGbW1qO7HkcCQO
 Jgr5Thg28avPVma86hgO5eObMHqaO85BznqRNPqDHzTsDIxNwulpVBXliqDWvTy5eyl+
 tspaD2fOiq6qPuiy2rubcpcqJmF0T9osx0veP/MzJ5Wuw8j9tCSavTWnmnKBfeT1EgA6
 /2oM8sKitj39RVj8NS9EI8GtpV8AVCiSC86x91r1ifUzcsI75FoC57jZTkrZzMO1SI6f
 YsSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791924928; x=1792529728;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=WgbHoRIM7BiHARXO+ypg2UvpaOOIvlZ1DF8q4NGxUy9lbEbfGIo9PfcVkBySCx3EqL
 pkok9pIt25sulKVilbgspFpuyL+MmlY2Ry43+rUFBNv0rn9NQFyxOHcyxtWw0SixyMgr
 D6eO+LsbBSkDjdOZgRz1AXM89w0Mf6qed+e+iCJBnir5sT0DL0W6vY8Mqt5GVMlJ1EeA
 YSWJSu4KdWyWrM8DAX8tU2y8R+SFSXH4/7+xYWYKrC/1bsND0YUpFaANiXj0Y1znSDCK
 ZyacINCRsA8XPppPZ1EIw7GOvg+8o7MdZvFYw1Ous/Wj/mtEXJ4qESALG0Tfykd46Mru
 mHLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVHJu0z+L16VAztDjSCYs3EOJM+pZ5/rwj9bf9tWZlQTcGClzrHk87/fDKZSPiy0NIQkWu12cr8vE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIUSapkOMJeJIcYBRMJ8zDMVJ1wgpHbV/tV1fkRiho6NrVtEp8S
 LcUBT4Jx96qcT3Yapnz5hMh/8Jf1YouIKKw4eiIOHv7q/KPMZgC9TroU
X-Gm-Gg: AYBFou0TFH/znrzyE2QLgEmthW6Q6kKtqGXI0sTcDQxOYRCEr+lualfecNN8KU7MI5C
 hi/U8Ri3zpb8k+f3Of2ioVQ7e+3ObpM9N/k7RBiYbDRkBUgdrxbTu1U3GBVhgxKXXh+PlakJDEl
 5IbPYnJkLbYG02q+pP15goM0Yc/2XMeqJK1WKSfnTY75mgj9SACI6zBQCzkn/9gs/LITqNbmJ8f
 5MIyxLUaIaLa4gznIqaSmd3k0BJqS89v2gbsERCSKu3+KA/bic0b0YZYT8+++eDilPvgGjYZDBz
 SXGVHjHeviPE5l4IAYaw6xlkrqsqw9JrzpBTgoPQ1hlmyvLjdT2zDPvFe+36qoLUsDcZg8DzwVf
 fxcSBUu8BqShoELbR3C+zYku3ykNWHF0ErMTQ+Cfxdpl2cExwsj+Hh54rJnEz6D09YoYO2M/iif
 xnRyst88JVNn4UtstDIcyD9apng+7wKmtx8x3s0EFHBK0vj8A00vjx09yEMoly6ME88MWP3WHOd
 x+u+9+eE7CaPa91qbu1NNLpu1WcjihqQpPoGLG01ee1bWH4XyKHoKorUZz9Ki36JkCv8ySFHQkL
X-Received: by 2002:a05:6000:186f:b0:48c:7c69:2dce with SMTP id
 ffacd0b85a97d-48dbace9dfemr26073729f8f.16.1791924928152; 
 Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:55:27 -0700 (PDT)
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
Subject: [PATCH v10 06/13] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Tue, 13 Oct 2026 21:54:50 +0100
Message-ID: <54f1186d20a7c24075dd38eda1dfc7ac3705a13e.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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

