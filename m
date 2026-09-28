Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0908DCA5FA5
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1939710EA6A;
	Mon, 28 Sep 2026 13:33:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NLVP5fEv";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2B3E10EA55
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:32:56 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso1298247f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:32:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790602375; x=1791207175; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=;
 b=NLVP5fEvjhChKFI/BMvJ7BdNnSC6fYTX8/sTiriJUh52jIJMF1QNg5coSjYMEJDSRE
 0oz91prGwfW/0sLb8bgcXdQTes/cWI/AiQMWhe4xWVmO8u4mWhj0Qz1jvTzX6ihoVj48
 mZxCuXjOYFoSdPhQU1Yt0r8NnYcTQf3JbYuqXmOIo5caMzd+6rA/Qk/NO1k0eTvScm1F
 uuorKRJ4b7KYJUMpSOg8r0j6wwFmPbyFvUPW1QizDxpdWF12gcTLNsFKZoEnlhcZv4JI
 DKih13f+TA4S4fngVzK7Sp6ML12FoLem2pbc2WCnyvkiOBBlFjR8aqQ+RdjzbJGs3xmD
 K35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602375; x=1791207175;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z28dlsJTIpkqTAOZ5w69VF46XysVuY21MZeRZQmbEno=;
 b=SXJ6km3Lin0sjAzUo5Fbd1EwyVL6Ou6aHDs4geNI0qG3hLx+qaLFR8Q5nM1BE24Ve9
 m/P/Qb1EOHQVQiDovwpAGXf5lrDLArs6GDPbD9qedMSe66rsxhTgsjocBqTyysWputna
 /h2RQbvFViszjNAIVC0cRRNy94JSv4kWWIrM1GGOJ+glPb+r2HccRlPwpxvZhHeWGsNC
 c5LvKnPBjfFWKCO8Ct4/qQZJlOMZDpDuGJjlMAL2B9VJeQOjfP3sPQRL34FJWkWuFg3w
 TnLvtxnt78+eRK5FpjidXP4Bdh5YWkFjOnmVExTsL51C+XosRC/lurBM1+rPE3eNlYR7
 2FGA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4brkZHPDmFimLPBW01wuN4xgm8ymPelkUZ+aBahcwduvVLiFBXpSWPHXShGp31hLnngQw6n4ZSCM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtWk6FbGBaJVkIEQdAlqv9gaSxxo9+C0bOF+cfv4YjUuScCk/a
 eqqnp6mlODwHDuZAIVkdIEVys9Gah4sO1gw8v+JtfDP100L9h//MeA8o
X-Gm-Gg: AYBFou3fcWfbfLkm+6ROACE8aU3LqkHDiB6KcXbgNs+U8kxWRN34ehdImk9MEfKNL6/
 +nxk8EThI5VMv3CmrSgAFTzTJixcUD9APRQEiVd2a9JOFojLSq+Whzwl/3OmaUccFAQ9G5kQEEb
 3tA1ghNaEj5UCKO1bF/03b7A1cTeDMdkBEx24LWeq7XmRMk79U9GN1OyNVKo9PiYDKobodu4ThV
 7+7czrkrq2w3Sn9E5CQX46Zs2csCrz5r+E9lra9YIv+ZA/mYh5lAcC9In6fXummJ28juZVjWwn4
 J5oxdiD61uFVu5b1VJMJooOjJXru5w9E6cE478AzRFVts0N1m3IQc1Cw0JE+CdIm5EoLlC6Pu7z
 eEV3Ju5GXhpnBWNIYasBCavX3JPUfGbnJYqxuqW1DgKH/uQEbiLV7PqdmxXHeMJjqD9r9GK3Z7S
 J3aMNj+5TnowwYODnnBsN0rhHoMX0WQ7Knfve3xnpUWeWD8v3lR1G35DARQgkls6eDJhv6vn3ZB
 ghPpOiTO+7auisLshZYUGGSQFo2DoeR7f+qGy7EHIDUvtT9xhY6vyd307bTrPzfVFz9HmFPKXvY
X-Received: by 2002:a5d:5d87:0:b0:487:342:d147 with SMTP id
 ffacd0b85a97d-4887db39b7fmr20252053f8f.39.1790602374884; 
 Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:32:54 -0700 (PDT)
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
Subject: [PATCH v7 07/13] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Mon, 28 Sep 2026 14:32:23 +0100
Message-ID: <f950827b5805d13f08f0060df0eebc4ed56814fc.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
index e58bdd9a4098..bb8051c62926 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1277,7 +1277,7 @@ static blk_status_t nvme_pci_setup_data_prp(struct request *req,
 	return BLK_STS_IOERR;
 }
 
-static void nvme_pci_sgl_set_data(struct nvme_sgl_desc *sge,
+static void nvme_pci_dma_iter_set_sgl(struct nvme_sgl_desc *sge,
 		struct blk_dma_iter *iter)
 {
 	sge->addr = cpu_to_le64(iter->addr);
@@ -1307,7 +1307,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 
 	if (entries == 1 || blk_rq_dma_map_coalesce(&iod->dma_state)) {
-		nvme_pci_sgl_set_data(&iod->cmd.common.dptr.sgl, iter);
+		nvme_pci_dma_iter_set_sgl(&iod->cmd.common.dptr.sgl, iter);
 		iod->total_len += iter->len;
 		return BLK_STS_OK;
 	}
@@ -1329,7 +1329,7 @@ static blk_status_t nvme_pci_setup_data_sgl(struct request *req,
 			iter->status = BLK_STS_IOERR;
 			break;
 		}
-		nvme_pci_sgl_set_data(&sg_list[mapped++], iter);
+		nvme_pci_dma_iter_set_sgl(&sg_list[mapped++], iter);
 		iod->total_len += iter->len;
 	} while (blk_rq_dma_map_iter_next(req, nvmeq->dev->dev, iter));
 
@@ -1492,13 +1492,13 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
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

