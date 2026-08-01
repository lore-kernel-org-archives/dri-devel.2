Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5160EC55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:50:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DE810E347;
	Sat,  1 Aug 2026 15:50:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UepwB2aL";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D23C310E347
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:50:24 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2cacf197759so28983295ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599424; x=1786204224; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=;
 b=UepwB2aLpOIav8RybKr4zjLJXliB8Ijz1lIiLfsBeJr3xbJvD3/AoAG+kfvH+Hrb1S
 1bSIbH+lSs6LT1vVfpphx6pDul1zvyIWclXEmUq0vu2Moj2AgWIdHdzrnMvcZVAtjfzc
 0ftHPeXjx9F2jDfgBFwZlagbO/lucmhQluZjFPyZfG51dYSXr4XlcwhRDPGL26SyWNAH
 uZ7YYQBCerMOhpqQ+2meuS0SL5Ods6npMSRP0dfdi/XMhA2Y4U27qliDi7jM7dc9Okp/
 KnGrLB838Ocg+TBzHsmtwCkOKBs6L2JtgzTLYzwPZ7hj6IuU7SAg523IZ1MwCDiIGcmT
 4Xhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599424; x=1786204224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UQw568s99USSdIytlPm2Vpoz5MduETOEjKRltqiPXcQ=;
 b=bdQkB3wEetKcLHlksHMdrf/52/NdPjDRyE1Rtk9VPEITu736WjwqcycHfwpfCs0CIR
 aPgjCSA20IpTC9o4QOYHyWM870pbxt00yykIljoUj+pYBZ1+RyXPQ0hL0e3c18DWnDun
 Cr6FVUQUj4zViz66my3RTRUPoam7Dpgqa3KZJ7Mo58Uznv0XgG2uv7rmQzluC2jbkxZX
 T0tkLSLFFzlkgO+SUuQDy6/cmA72NsOWEYIH5PVRTMXdqh61hKMAR8KmEXbbD0t8UXei
 3yw4Ka3hsTLOw1FLcV/v/qDOzsTYaR8xesuFx4ZaUIHN+53eB2gjcVwGzxmUJf2huaEF
 u8Hw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2wjcJLRfSdKQ+3emSA8ENvd/CvfgWAw9o624i7tn6kRrdvBM07OCS9QZ6i6oulDmJkj0KrUm5wTE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxWKl/h6rc0ner+gUckn2flVHfEbyiqbj0cXZHA/ZvP/azLvZo2
 hEb94kX3W4CqgjJ7zvZPZPYylrB9SHMCcIb8R8zIt8FXuBSfJoStT3SW
X-Gm-Gg: AR+sD13yeFJjIulyD4PrJdzx0ZfAagKGZFt52hgMuVxyn6j4v5Xlh+JQ62ImPfJK8cz
 cwqHTHqlCByDuNIweYg+v6idvHB/uuw6GnVK/DUr1iuSc7/vXP/OeeSLxxqJ11htJ1nkH6CcigH
 Al2MnDEOPFkohweOuq2Rk/8AdzJWzuMDRSHRWvK7FHqS9GwLGtidCX9KkXKPfTTvNsJBhHvynfv
 UqXfpVd+Ho4JZwuteyav4cXa14eWJkdLMW+Fld+n3FjX3jJ+V3VpCQkuVrLH696a4pZBbKdT/1x
 LglSn5XB44UsphW5vrTvfrk4YtbjbffPsSJNt9/fA4Ay0DOzWszbfSKbqdt+MMFL8j1i3tbBNlv
 LddvSHwN5wBPczqX4GUWfCyMg8IR9sqOPYNoEBlj8e6RIjy4tl+afF2OFoUtzCvC8wBt2rYUztX
 SzWiUHm3mfhtlZqQSJc6Umnsp2n1B6MYx/YQ+AQ8I/2MWP9q23H92Ldx/emVMIdtSYEQBYtepI9
 JlKvDh28aXLwIk+Mfxh4mpX9mn5axsKpKpwtiPVi9k267HE+bnkjuXuSg==
X-Received: by 2002:a17:902:d2cf:b0:2ca:a03a:29b2 with SMTP id
 d9443c01a7336-2d0521a5657mr42155635ad.8.1785599424386; 
 Sat, 01 Aug 2026 08:50:24 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.50.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:50:23 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nitesh Shetty <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>,
 Anuj Gupta <anuj20.g@samsung.com>, Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Damien Le Moal <dlemoal@kernel.org>, Alasdair Kergon <agk@redhat.com>,
 Mike Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>,
 Benjamin Marzinski <bmarzins@redhat.com>,
 Vishal Verma <vishal.l.verma@intel.com>, David Sterba <dsterba@suse.com>,
 Ilya Dryomov <idryomov@gmail.com>, dm-devel@lists.linux.dev,
 nvdimm@lists.linux.dev, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org
Subject: [PATCH v5 10/16] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Sat,  1 Aug 2026 16:46:22 +0100
Message-ID: <ff507b4895521074938d82fe2647e003359ec2be.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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
Signed-off-by: Anuj Gupta <anuj20.g@samsung.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5608ede6c479..7b8ed101a13b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,7 +1287,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1317,7 +1317,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1339,7 +1339,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1502,13 +1502,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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

