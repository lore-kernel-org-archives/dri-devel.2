Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4A9CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60C3F10E37B;
	Wed,  7 Oct 2026 01:32:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SYlQc+hK";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E5F510E37B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:20 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so21777045e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336739; x=1791941539; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=SYlQc+hK2YfHdmDiSy7cM2P0dMi3aONCs2fcoV8R/ruraT0L6O4IYMGi/naSAyouJc
 cSGTcg1ewueQmnwKnBXT3tYjQMkWba86rQot7sIlpeQeJZq+srX5RmzzjraVoMPZn8jY
 BQCQBKVqeU3/P2/Qdoqr1StGaaEiE5T0srvbb7P/TzrxQubwpAK4/yk7yqsGyfLq53Zb
 ZR+aanad/Djo9X3LaPy3U6SLojn6mfu5ZPCsy9vA3NlpewspNZO25Xr3NhLEsw5a3iEx
 sxBTygq2gP60gTKGueO52SLKaE7ARmrI4hveCZm5VtChtzitakRH84Lh/DA2uBY2d7zt
 PMEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336739; x=1791941539;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=rcDkSmLXvsNxiiAq8j+PuqVCDIm67D5QjABqIAYXokLYcrTZaNIU5iQuYQi0UgpjvB
 eIgwIk4YFsWhqasn9gSg/QtORhKAeKpHI66n6fq3AX23BVoB3QS4EnuQjkizmQt0ddPi
 8h1daGVmqVKef048bARf/0rHSn/TKCSZ2zeDtt5uXXMgL+wYZONp356hRBbFT2Up5whz
 7O+fxXc9hCYo5mZa9V3tpuOsqV2xKM49puRWv+yA4HG+doMs/72VUJwExJc+Z1fOrXFb
 eqNvjzpIPEMIIHR4q4Gh1w0JXdOX/FGDxmhkRxHx6IoCsboYh3j1BnFeQ2SRY0UCYkjT
 W6pg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy7IvfINLhhAjBMyji1+/EwjnQU+x0tzwpB/K6dN78tYY8Sr9q77fIVMDwD/KOlVpPxvrm4MkQ+MOY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kQLKJ0vJzi2UFUA6tHpxGp+515RevFCdbAmGYmsJhscQOwrRai
 P6yoIznHzbfe8cIWrBufqLmRPEjnqaVDTZinW+75iwpeboQRkHo4Rhl8
X-Gm-Gg: AYBFou1bANRUc6uRKpSQqIAFBOQS9TWpTm6Kla6VYb2kn5zfFxwoTydUQ7vDjAs3Hk/
 8P7Tzs0+/gCl83PA6tGiSrWIghQ80d7A2QC2/ZAR8D8L/BFqyl+QUDXv23vZ4ZIi0oKsrji8jwG
 AxuZUp5enXvD3V+JkDjyIBFtQyLZKhW6Cwjektc67rfuZe+pl5SLkfKSnzhIjc9K6J4riSS3Msx
 F92NMlennM2B/WQrbKK9lELhra0v3+5O/JpnYIKwbOey9ngia3rAJrpude2rJBScRKco099R69G
 xQ3lWS37S+sT+KMRttCfuN7rGlA+QDA/y2MqQb6RFKHBh1WtN9RDfH9lMuPOfSHagXihXYPgz5R
 cDhdHA22mseCIRoqlSw68UYOlnCQiZLnigvgaeNeHf1hNGlrhImeEOs4JIDGkJEpHWq4zG9HuQo
 h4gVqpY/MQi2DgfYoGa43ny9bLl+siMVkKWOxjiOEcv0N4L1Sbf0q9gvuASnpeAehUcl0DBe51q
 /32QjX2pnmZ7Bu4buh/JcL3jeXQSARxk07l8uoMPdnlPZtmxNcjUpepv2xC9Qyp8/94JURfjbyN
 y7h0OG+V7xE=
X-Received: by 2002:a05:600c:3f0c:b0:4a0:251c:fa72 with SMTP id
 5b1f17b1804b1-4a1803038damr7433835e9.11.1791336738926; 
 Tue, 06 Oct 2026 18:32:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:18 -0700 (PDT)
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
Subject: [PATCH v8 04/13] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Wed,  7 Oct 2026 02:31:47 +0100
Message-ID: <2f8b57f68fd3e432085b3a7767971778bc7d1919.1791336002.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336002.git.asml.silence@gmail.com>
References: <cover.1791336002.git.asml.silence@gmail.com>
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

