Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1FBFF887E
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 15:26:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38F5C10F078;
	Wed, 29 Apr 2026 15:26:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ftfZj3Ow";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D564210F078
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 15:26:50 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d6fbd0954so9596368f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 08:26:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777476409; x=1778081209; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=;
 b=ftfZj3OwZEHun+ISJsWWk+Z8xXru1WvnPvJpDA+3NtRo19s9G34MtNmLiNqK/V58I4
 SM5RTXpixCJnOhubCsEDVFMK7H8gjIhttYNvMLn9/gPfIVBPv4QGi5mqPs4q+/8Y25JV
 2gTaLp2QqJRN/hi0nkJhilCrwKMbNibEqpx7B3X+wS55ZF8hm443oDwNxkl6NhihuwPr
 KHYL46wEAQwjEVScutoHAxtDmw4FnC27kRA+KRMlEi/4+Y8P6m3FwEQGOkRc8MyXsRHC
 E/Z+0EwubzLECFbdqCffP9WKw5VZ2YngyF+X+uAS7X5v7MMYH9CHL4ZeUDvDiJGqXx6y
 9/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777476409; x=1778081209;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Pdajlfqb0Mkqw7FfTkWcBSlkNtUxKMEiU4sOjeajLqA=;
 b=kI7drjSC6re7uyjPczGBOyVQScYZrPcTcWA1aYZwI1GTb25c3tmE99q7lcxY3aTTrV
 XsRTiRVPHLERoEZMPCS2TbIO55udHuQ/QyFqA2s+ZmUSC0/7N0XqaHR2SuhXM5MPGUv9
 WFjREUj1ySEzeMekKnkFQqhESec57LMmcXmG/ESq68Px0P4v+EEEPb0g97cpdIxiP9Fp
 zYXOJ5iHdsI/gJWDKa3MYEtzGYLvucXZhyjOw8yMvQN4OXUiwzlRoBnLgyVLFvUqbMZa
 swrUJFFLCJcPpJ93Yt3xcgNOxDSMWiOtzkWd266pRPjLOI3L37QPBnUqTbwpCN0EmwG2
 WvUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/XgsE0BNeh21wi4vpnl4nwYipEaH0vC80ZyA2EeEBrKPAmM1L9dp3Q8eHJgaKdbUXBvw5EBYnPiYk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx0iyOXjxjsdpfEZPKoGFyRsaHUJ5Nn+cXSZZ+VaH/GhGC8brpE
 r5V/TmJE/qRXR/dUaVX9IV4mtOCX0n3AMaCeHaDQOVXiFvWzJgMJ0SkD
X-Gm-Gg: AeBDiet/KcR6EfwIvQznu0qHv2MUOwYYXJ0vN+XX/ITO2vcGUrwL6oxckEshkMs8k9h
 uI3+wXatITowUvkaLZR5VHLd5R9K1zEa5lLDq+DsgxUcYodFvABa/TB6Yd8WT/+7fUh4gAWz/4l
 rArMaqVslC4BL8bx4qiJs7uzjqrzUwvGw0BeFbQNrJg2VkMZVPC9oKUqwRPj/vWJH3ArEPkAnjf
 t8DGBFValIedAT53LZVzHdR9T1HBqB/eDDkyMlIKQMnsd3DUM2BGhl1hpUwbz9V4DoNSvcDLPyW
 sojyY0ilM2uFWX/oiPjSTJ5mnJnOoycM8FpsRqvTH89kA7uglYp7zgiT/CbWNg1oKrltGMG3WLv
 UnOVvffBIZCqNId2sqpFAgm+DIGZcHeSkHMt+65CzX/o6UoFCIraIAs/PpOYU7Zw9zlzk/Hx3aE
 oKOIgDvkaGrl5Kt8J4eTGAzYX6kA8KTfwABRkYn4OjRWActRegT8ZHvuAyA1Z3sCZywnVgWdaBw
 vD3pq/CH4Dc6mftDDvkx24wjvXYzd2mYNwoATK+hMGp
X-Received: by 2002:a05:6000:2002:b0:43f:e9ee:5610 with SMTP id
 ffacd0b85a97d-44790d12be0mr7198547f8f.43.1777476408973; 
 Wed, 29 Apr 2026 08:26:48 -0700 (PDT)
Received: from 127.0.0.1localhost ([82.132.184.31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b76e5c22sm6382951f8f.28.2026.04.29.08.26.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 08:26:48 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org
Cc: asml.silence@gmail.com, Nitesh Shetty <nj.shetty@samsung.com>,
 Kanchan Joshi <joshi.k@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>,
 Tushar Gohad <tushar.gohad@intel.com>,
 William Power <william.power@intel.com>,
 Phil Cayton <phil.cayton@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 06/10] block: forward create_dmabuf_token to drivers
Date: Wed, 29 Apr 2026 16:25:52 +0100
Message-ID: <559756c5e22dcfa183080a979de039910d1b896d.1777475843.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1777475843.git.asml.silence@gmail.com>
References: <cover.1777475843.git.asml.silence@gmail.com>
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

Add a trivial implementation of the create_dmabuf_token call for
block devices that forwards the call to a new blk-mq callback if it's
available.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blk-mq.h |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 713a3ba3f457..3d8a48a7d645 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -951,6 +951,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_create_dmabuf_token(struct file *file,
+				      struct io_dmabuf_token *token)
+{
+	struct request_queue *q = bdev_get_queue(file_bdev(file));
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!q->mq_ops || !q->mq_ops->create_dmabuf_token)
+		return -EINVAL;
+
+	return q->mq_ops->create_dmabuf_token(q, token);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -969,6 +982,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.create_dmabuf_token = blkdev_create_dmabuf_token,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 18a2388ba581..ee31fb3ada10 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -15,6 +15,8 @@ struct blk_mq_tags;
 struct blk_flush_queue;
 struct io_comp_batch;
 
+struct io_dmabuf_token;
+
 #define BLKDEV_MIN_RQ	4
 #define BLKDEV_DEFAULT_RQ	128
 
@@ -684,6 +686,13 @@ struct blk_mq_ops {
 	 */
 	void (*show_rq)(struct seq_file *m, struct request *rq);
 #endif
+
+	/**
+	 * @create_dma_token: Create a dma token, which will be using to map
+	 * a dmabuf for IO requests.
+	 */
+	int (*create_dmabuf_token)(struct request_queue *,
+				   struct io_dmabuf_token *token);
 };
 
 /* Keep hctx_flag_name[] in sync with the definitions below */
-- 
2.53.0

