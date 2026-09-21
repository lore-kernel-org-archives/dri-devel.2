Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01307C982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C352610E790;
	Mon, 21 Sep 2026 13:39:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EuOEkx5M";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E0C110E78F
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:45 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49ccead2aecso14457755e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997984; x=1790602784; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=;
 b=EuOEkx5Mnye1lBpXPICVMLIKZlYSRjpENFpOona7yPOc/DxU2rMnOSjyCs1+OHcwhf
 TwZgbSmrR4+STssTkNI25RMLmAlrCCpMznrr4wv+w2CQhQAeayvNaQlSHNvq0ijQz1Ca
 QWVH8zyBHm6SAlqB+4DFcjfRweXxdDYJ2QYfDxDE84ObUXpiU6Yu1WiOPKvUXw8XFSOS
 x5tlNJjN8uopZO5biHCttwHHXqxSoXG8yZ2jA/jifTDU9r9G3V11yPTFOVlRlecnSqnG
 7lh/uZidhnYH3Re+OpahNxEVWDAt7BFy+wboHNo+UcXbj2N37lFKakBOixxJmQT0HpuJ
 HRSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997984; x=1790602784;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EHTjFNHsfPkUevAeFTZNd93AhuEIP81I0y/DmV6dihY=;
 b=XW9kdMHzkjOiRqhkXfPpuBOGsywhymEJxq/FNNk/hBIPX8zTlUCHvHPmMZ2Fq6Dbpd
 ghr6X0eZ8n/HM99qHqDVMu7/pFWrI11kuv1mnb+/mza8h8QJ0e+EL45h8gQkn15UDaAB
 AYPyHkrwTCAsgPJPDVU8QuU3Oi1OrJjbn2NraUtOnD8K9kW4Tf1ifBAMr7KH1pWQJ5Ed
 iZYXcc/vMozs63ozhoJ3h6Uh5Lled6/96kZYFWhcWhJuLiLJHCAB35ysn7wOFRteGhLx
 XuWuDZ2mu5O2rtdOG6+fFuIg22x/g9BlX7tYw4ic85LWJZApMc9Bi/8AnNNLhWDPdZaC
 1Z5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBwlmcCHy0U5RwqJqwhVpLW5AJOAmBrjapMvLMwyc3gVnYxedr7M72suVGBrq3yy72PtHeCyEWo12yI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQoCLFRoECNV3yfCtae/k/TvAR5YaYGwGanTVQOEQhGJflHpKk
 lKqDj0ydlj2M2AvJ8FbfsZ15ixOaYU+c/Et5B6Sp6LVGJIW7VekTGim9
X-Gm-Gg: AYBFou1SBDlF67+eSn/ILwkY9E7Y91ts/4ygooNmj64AL7YMpRxxCh39Ptu9RU2qIG4
 wd5cWw4/gArmIpWIG2E24lm9VvxLOaolokSvb1I5Gb+hAi3YSqtOPAxd0KVboI4q4Yd9GL+HqGM
 9KZN/3/AGK4470JBuzis2YIuS+Gz+RdHI8SiJ1czk4jIJS/pHqSdsUpCfEj6CHOc/Y9SuWDz9Vb
 i43fYtwrSu0uDmty1c+AKEp3/iX8vQwzcx5CX5ppPaTxb5L0w1bJKfaVS+Y7/xRrKWgJBTesf9M
 CqUQNv7nalrufOAA0hK+8i+Z2CcaCKglxFk0URSJ4JTl+7/SA3ZPJ7UndTZs4JLUr2VRYC4YhTp
 AIOaDtEvQjvj8uXJ6kZp6LnL0FN2O3bEudJYzBjJtW3Ljc3dPsdB7/F+42OEiiupI3Hqj0cWfHO
 OvnxHMLLS05D8DdFhqdZs3VfrkmvqDzRewr5VDMcK71dYnQGGgr2Wpr7/Pm/K0yvJIJ8ubIYiA4
 D3X75A6rYgtR0dj6qaiIpJ7BOrAAyEylUObpGjU51qPhzddryvfg0iGvwrj5b/ShiUyYfq3luGq
 f6tVm930YaGjUKBFRlpKoeomykVAAg==
X-Received: by 2002:a05:600c:4505:b0:49a:a101:4157 with SMTP id
 5b1f17b1804b1-49fc56db92fmr154368075e9.7.1789997983642; 
 Mon, 21 Sep 2026 06:39:43 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:43 -0700 (PDT)
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
Subject: [PATCH v6 07/13] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Mon, 21 Sep 2026 14:38:51 +0100
Message-ID: <114bc2087c7811c849fafbf1392abd7edfb24471.1789997898.git.asml.silence@gmail.com>
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
index 3d645324f04e..8dc4002fa696 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1297,7 +1297,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1327,7 +1327,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1349,7 +1349,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1512,13 +1512,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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

