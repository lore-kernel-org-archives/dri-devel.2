Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473D3CA5FED
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C85A10E4C3;
	Wed,  7 Oct 2026 01:32:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fnA51XYN";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AFB110E4C1
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:27 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so11485055e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336745; x=1791941545; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fZk+12RxIUpX87ik4Sju0ydtLd9LDkS9K++2ovit7qo=;
 b=fnA51XYNbdRez9v0ARNA+HPE5E7Ae5wUxrOjq6D/L/ExAkHw+Bv53x+sE8oZIvyO8G
 0NioZcm05fNQfLIjnL6WvkucHsB9AC8arU/xq8ApIAFWMvX/v/Aj0uxs9BGqIM+87YAw
 043D+hkQ/q4Sss5x8Z2Jg0rPEjUdZa+u+OKMKBlznvS7tVXbUGCvfNk+IwI2U04mWNW6
 7FrGPJWM1qi8Arr/gxHAe5rbg/Sy/fvPsXDTdi4W30qvmqGyYMyl989X4IYwvRYdpqEB
 5DP6mumrIYtbaaVrWhNz9a4eRzltPaJkOvDhtIM64JFy24czHuX72UoF4qGHQuh1+U0P
 F5Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336745; x=1791941545;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fZk+12RxIUpX87ik4Sju0ydtLd9LDkS9K++2ovit7qo=;
 b=A9d7xM/uT9XeGwEQZIFcAMg9/lVP4rHMh39zlXLTL4ePECSa1yU19fs8G1p6m4NPwf
 XNgQ9liOORJtOSvvtOu5Noj8yoQmOj6gxMUI81SrxCQs5WPaJ3BE6yhZBVUX7DDkrGW5
 qzfNpLL2oOEcsKgSx6tJURb2uEqts3kZI08oRBuCe6owkMoA2HF00Va/O8aHLo+ntc8n
 Aegt/pNcUh6Xnyp3TX17iyEZQ49/6Woesa1Zor1Qm5GU53cUsObhanm93rQNLPGfcx11
 cvhLDwzthwZYYGFl9xrerEJ+Z7ZVcGbGmKqBHlA9GOVYUfGGSBViNPu/h1/ZRU0PlCuu
 5eIA==
X-Forwarded-Encrypted: i=1;
 AKwUvBymz1w8Agyt9yK7BTM/DwRGG65iHeqgbUZWciNC03h1XGUIor/f82rjFhbsRKYKUIEDjxi7mPQhUyk=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nWreaDnscrcXgimXlRPIbmJFDjRHVfKFiCQQKlxA3RZp3jlb2b
 XJ9HSpaSH+Ak0sbplWnNP7XJaWjxYLIOfx7wR83QKRH+CFpU+/SZ3l92
X-Gm-Gg: AYBFou2XMhbqXmDjplkFNq4YHnzhe7oWOf6Kx/CZj5RHwchgFvOos4BN/ommmhficVG
 3npQCxwyzZlx1Zz2H1GcTqOC5qwLqGcAYwKMxu3wS6YHcvX3N0I7sLDK+JoOE5gsKy/zzmbd/aa
 PnXJzuDRby17EYa4VtvcCm5XnzadaQeXkWuo/zlALq4iUd4TYc6JDoyObqVTZQS7W+Tnyy2YAZ8
 hGgpkwGUmpF14r5iG6bAF/hu4wIOqlZhLvbasghg9Hj0LrHyN1kfSUqSo9bwO1lvBIxliGh3aVg
 U47aOAPWm0fcLCvhMCRhETeMy4YsapHSu7f/WRdeYwOR4fq1ayiEtCxSmrEcbr6e+g2Bz1x1us8
 hwifrgGG3gkgZXoLaIcEbv3n2Wgpq2IDKQMX+seD4rgwc6e8WP+CH1NECbDSl9CJHM9DNXAtBDy
 3FryobTwybb98fBEHtv+q+yIvLyqd1FTHBeMbNb4+1ITcx8ABiP+JdMFGFCTxiXW4i71oKH9uDX
 OIK/w0ISCE+FhuoOca4h8wOktxNQ3akAi9F1GLVijggscJ4AKg6JTgj3nS7sBr7+UrW32QeaA4s
X-Received: by 2002:a05:600c:3b8d:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a1806611acmr8359665e9.33.1791336745490; 
 Tue, 06 Oct 2026 18:32:25 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:23 -0700 (PDT)
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
Subject: [PATCH v8 08/13] nvme sgl fixup
Date: Wed,  7 Oct 2026 02:31:51 +0100
Message-ID: <e4caf53b7334af5390d4098cb5883ff551246a5c.1791336002.git.asml.silence@gmail.com>
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

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 drivers/nvme/host/pci.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 651f7654d73b..79b3c1092e4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1287,16 +1287,15 @@ static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
 		struct nvme_queue *nvmeq, unsigned int entries)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
-	struct bio *bio = req->bio;
-	struct nvme_dmabuf_map *map = to_nvme_dmabuf_map(bio->bi_dmabuf_map);
+	struct nvme_dmabuf_map *map = nvme_req_to_map(req);
 	size_t length = blk_rq_payload_bytes(req);
 	struct nvme_sgl_desc *sg_list = &iod->cmd.common.dptr.sgl;
+	size_t offset = req->bio->bi_iter.bi_offset;
 	bool pooled = entries > 1;
 	dma_addr_t sgl_dma = 0;
 	unsigned int mapped = 0;
 	unsigned long tmp;
 	struct scatterlist *sg;
-	size_t offset = bio->bi_iter.bi_offset;
 	size_t remaining = length;
 
 	if (!entries)
@@ -1305,8 +1304,6 @@ static blk_status_t nvme_rq_setup_dmabuf_sgl(struct request *req,
 	iod->cmd.common.flags = NVME_CMD_SGL_METABUF;
 	iod->total_len = length;
 
-	nvme_dmabuf_map_sync_for_device(nvmeq->dev, req);
-
 	/* entries == 1 fits in the inline descriptor; more needs a pool. */
 	if (pooled) {
 		if (entries <= NVME_SMALL_POOL_SIZE / sizeof(*sg_list))
-- 
2.54.0

