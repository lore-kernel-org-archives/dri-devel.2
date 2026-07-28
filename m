Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCC5C54F52
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 21:30:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3611210EA16;
	Tue, 28 Jul 2026 21:30:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mt0ufCT1";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF8D410EA12
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 21:29:57 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47f633e6058so310635f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 14:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785274196; x=1785878996; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
 b=mt0ufCT1sK14+3GIB6DE+tQOVH40EGVvhx6dwzPf9IINTxn4f666UKuXWD8Z9cRF2+
 nKPeFkPrDI7475yAVJGdPMN/b442EddS8RfpP1XTAsGHgdjN5m+Cd+4CI1F9gghhfvCM
 mB1PKXZ3v/OS3ZYjLC5Qu03sKd+lU6MEDQhV+vZA7LQo3Fz3AqDu0hCGc0juleU/0heV
 UC46qVUnlHSK8jxIC5yvRUwkwX7SrTwMXApUBQ8lY3l3qgS92hCnK5KL9RGZCug1uUZo
 DVacqhV1y/i9KVLhm44yrfm3fUv9LfNRMIwjVb7mxQJ+lRuNBfGM197yjrj+ki5t5yYg
 7CZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785274196; x=1785878996;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zGURBnMw6fzU2CZK+DQfnrMi2Ya0rXE6R9ZmtmaHTkk=;
 b=H9VcEJizn42bxr9hRcInhxyXQ+0jiFq1Sf0xigdjQzkPL+mq5/wFQE0JN1h0QIG9vR
 ZN4igbMLVG7tfr5BzbS0xsYxhjbWYtK6i7+dEmv9Avr/xSCrp0s1u1U1aPpnYVx8XLnO
 xFvu1qV+ASSGZz+fjMYWoaI3tpqJgi2THHFOVea1F6eqiMBtIfM95bWLs94ZxoGDus/N
 /FWtw0VzJIGv5aNBgTEtOV2hQ4Vh7XDBcCOjIH7oXmO7qVgOz9ElIK49scuRqnvWFTDV
 UHrTIPOYqneB/gCWspIxaLqX80LwqBxcmNJ3IcGphCPWbF6E2nb4b9/pNMHuYztveC9x
 zxQQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpBw5Ay3Pf5htq/QCtY89AJwvbI0IsVb71oSkyxtBLgAoy/HH5AMvdcyUmFRd5tuJbfyzVs83lviDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxVESB0eY6wE9tINhmVOUCVT7KME1XA35cRs02ilp5ELOV/bb8W
 AUyewbBF92/LL0iOOFm60JqecNWrjJmc0R0rqJKr2C47Lgv67IVc9w8L
X-Gm-Gg: AR+sD13dL8b/p1SxM17Q+1Vy5A4bZwyOYc3QcSFmxtLGJDlzjJ/cQzZYuspX92BfL6u
 0ynemxVpeQ5z/LVbQutPyoueW3tf9JAfDLTksUY+KRo+GWOyaDx1uMGeiFVYseHZZH1HeUKr6nq
 CP3w2zTM8hnJHsQynceiPloDX9IiOkarvQLbZqKFccrzNBOinVO63BPdF92RxMgqNKeExi1Fsi6
 s2CELL/B/7Jq6mkhEq29NIxYF8dIfdUTRbSzaat9SyOEJMQngpe49a0ODVenTc7jRKEvLzQ+50l
 FM8gtNlcYqx93dQHnn6PifPR6U7tlMxQrv9XnsiItEpBYu/UGcE6u/4TJW/y+ZX/JUz9nUfcePz
 FQ67ErtjRLiCBGxtaWPqxkAl25iBiyUp2ymIjS5r7O8W2g30usYJCR2VwPfunlKTKOMqeI6CVze
 NBo3Bia9J0ABxNZ7N8EwnqLy0+WKnhM4vOq4Guv9UKwynTXaoLqyphsX49BnzfwhoPYOAqQOyVj
 be58T/T
X-Received: by 2002:a5d:5d09:0:b0:47f:94a8:d6db with SMTP id
 ffacd0b85a97d-47fb1f14a61mr4656094f8f.34.1785274196213; 
 Tue, 28 Jul 2026 14:29:56 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6ac44bcsm2245329f8f.11.2026.07.28.14.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 14:29:54 -0700 (PDT)
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
Subject: [PATCH v4 07/14] block: forward init_dma_buf_io_ctx to drivers
Date: Tue, 28 Jul 2026 22:29:19 +0100
Message-ID: <e0cc82a15419ba7b38eb0bb00ae34cf3d0c3a938.1785274111.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785274111.git.asml.silence@gmail.com>
References: <cover.1785274111.git.asml.silence@gmail.com>
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

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 14 ++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 16 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 37d491f45015..d83cdbab65a6 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -926,6 +926,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
 	return generic_file_mmap_prepare(desc);
 }
 
+static int blkdev_init_dma_buf_io_ctx(struct file *file,
+				      struct dma_buf_io_ctx *ctx)
+{
+	struct block_device *bdev = file_bdev(file);
+	struct gendisk *disk = bdev->bd_disk;
+
+	if (!(file->f_flags & O_DIRECT))
+		return -EINVAL;
+	if (!disk->fops->init_dma_buf_io_ctx)
+		return -EINVAL;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -944,6 +957,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9213a5716f95..9f4c92e51dc9 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1682,6 +1682,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

