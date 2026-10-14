Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29C1ECC6B24
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B9CA10FCEE;
	Wed, 14 Oct 2026 11:02:43 +0000 (UTC)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7F5210FCFB
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:31 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a16aaf2067so10596685e9.0
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975750; x=1792580550; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=O8nB5qV//Hi4Nl5FHOkAVRS7Epad8CpJhN7zhbYspyo6xRsn4i8l/LMuvXAzOkjCGj
 EyiuVxOdO2m8/mae9SjKGiFkac0cwwsnE0liI3tfZfJd99KwwnlvfF32N040BIYnqiR5
 Rl/L9yFmc+a+GAa6RodM9RYnf6r2mVTJEgJ0Z9Dx0nbVXYJUJ+ya+16Io2BwfC6xkh7c
 dVyUR1EF+d5tjcjSW5H3QLxB/XM+pTShpOkcTQQfaIY4mXPfCXlqLewWTlb3dtFIujP0
 YpePXHd8w9zER/6HGw8l0N/BjHNqX/dsmQ7JOSoGsI1AWhaKguupb858vnGImDwbaXMs
 RlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975750; x=1792580550;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SVgIYOF9sl5M4BcUqDAxFWbO5yiW+j2eX94ter+J4Q4=;
 b=uVOC20Cjx+Qfhl+3Bs+0T8j/59DMso/12EQjVlAPve+XP/NfhNPuKY89o4vrwhY1Up
 eQmbFtZ4GtnZnB3ROEGi/M6W15pheODSziaLqv6LGQ8t/lVDH3ZTZYbIP5ynYWGht6bE
 oGS0N20A7tm8SQQK1odC6dCmHlNSuFle+rnOGrqmcoi+g8CgtcfSPn22ojksM+4RTM2Q
 ZSwkarfVF7sGtg3nmulidzCKLFKkTXVKgTFlUghQUf/I7lccp6laeU0imLGt9+1nOqEb
 j39ExVZAKGlC60UBhSbcSynrJBEscjW3fuEFGabh9JXkE+dQVPYiRU7rbCG8ZpCo8lA1
 Hvgg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwBeiRE+0xkbV4CUWvgZzzmoDSaWCrm/E7H59YIvfqQ3qiP+tV+7oQtGyu2DA9jGOc/c/x9ZJUXnqw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKCfTvPUtjk7ZOFk2WFK0fSBx/dLYmXLS8wEZJwGRr2tEqoEVh0
 /zWacxzoRpjCeFuuU5xhELcFOB0tgr4CYkvuL4XfUj0eyhkFo0cymt9z
X-Gm-Gg: AYBFou2z2uVNcNcIoE6mk7RIaBuV5mIhlsM1cPoDLV58qMOlQoCtohKu3y+ufRegQyE
 yp+Z3eGEOb94CXjyufi4vYUm82sAuqF22ehp6BbZdGLTK18XWrS/m8+WaASc5XaxCY8ZEmwuQmQ
 BOc4VoMpVUUXv9A7Ni+jpcKbtDh23kjomo1uSVumxJTiZ6FVLmI9j1+sjXuSpR5XJh2lFnSWpvf
 ZIEWr4irbKpkDh5HWHieptcrC+PO4oo8LS5niR460knPRrvTeDtGZOdyHixDKKreEjHuJGZdYVu
 5WSiSZZ5473Eajb8TlOqzL1ZMQoOr1glMwrmPTr+QhiBiG3U+8f5cO5cQD5j16wOVjap03FtY/t
 UEqVCnOruUjDGQmkvJp3yngGM2ugUL2vEMAKiOrqHEDUcvZ3ebukN50Cq+AXRSbfQczXW5I8PAE
 WjwxqkMvTWlZddHvPpdwIQx0+C6Y09alYPVd1Y2ARXuMGUgN8izrg++OX76mln0UQP2j5It7NFP
 qaR51iSippU7WWYIj/LXclOvju+rzA163s2JLppwl4lsei6FGBvdK7skspLq9CWx3c1xidKdq5i
X-Received: by 2002:a05:600c:3e87:b0:4a0:a34:6e7d with SMTP id
 5b1f17b1804b1-4a18e4bacbfmr282470095e9.18.1791975749999; 
 Wed, 14 Oct 2026 04:02:29 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:29 -0700 (PDT)
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
Subject: [PATCH v11 06/13] nvme-pci: rename nvme_pci_sgl_set_data to
 nvme_pci_dma_iter_set_sgl
Date: Wed, 14 Oct 2026 12:02:04 +0100
Message-ID: <42788b01948b58b891476006cb7ee9f9f5e917db.1791975048.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
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

