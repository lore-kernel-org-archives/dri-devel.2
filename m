Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18344CC6B2A
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6EF5F10FCE3;
	Wed, 14 Oct 2026 11:02:37 +0000 (UTC)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A19810FCE3
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:02:29 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4a1880e1bf1so7320425e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 04:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791975748; x=1792580548; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
 b=TcPVC72Xu5jrfXmXYY0G8unMlWefin9auFrMejpYb+w4x3tmfAEkPyPbepdLBdHT/S
 U/uxBJ3FECyO5rVGICvSiAkdb5OkCMMEsgwF8uhkJfhRyw6bNEPq8zaWFp1rQ1jD4/vU
 ygp60BvQfovU++LlbpAsGbQlaa0ZA3UxuPO6lLZoSatkr8P/6rYAxEmTw1sgXAkd2AN5
 sUjcLHMOp7HXdtTPxXO7d75y6SLT8j+vp+oGSwDSCnTz8g6vhIbeT48DAsBYZxcYBJwb
 hGW7wWKRnw1uDhLMhoSYZF/lQykvvYZu7H3AoJs3oTXsI6XHf73CzcZBWUYp5lENiZCD
 iKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791975748; x=1792580548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
 b=13kojISUVdV2+eyzwGA41nmRctoU09mFnCOQoe+XVxm8eWL54KNYCGTmfDJ6QPJ+v0
 Su5W8HCa3q6ZeyFvEWStx6nOg2RGfm4xEGa0qfl5uOZOYZ8/dWg9pEvrkP3/4nJEB6mH
 /gLovvLJIx3c/aKBkNxMZ/A6Kr0IO3FfVmYyU10YNOTfAF8oUZTNgN31wXHPThbX3uyH
 2x3DKMT0y3GK5li3yrQ94HGk2dibGiC58Es/vkXc5rxiMIiuT7V8Ushml4xU4H+7gKyg
 QDpJu0TnMV+bK994e6SIJ/ZxNrP4Qn+wJuFAdDYDxaEldmJIQLphDzck+2iuZGSfshhQ
 J/HQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZfvM3I1OzKVIp0xLB3Edddhf3M/vGmWb+088hsZeomCWk/1MpMX7+kRl5ZZnoQZs8wJIRLNa+5Uk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKyEf1uu71B/zH08dhWs7rZaHMZJknU7NPTp1o+kEMLhalWcLwo
 Eg1ftc1VWHEhnSBYQ9Rj3EmUJgA0a2f3lCLY7QiX/5s63XMM/pp7jJiq
X-Gm-Gg: AYBFou3Eo2H5leQ3sUY0Yj0l5ulKY2gokCQWWyDd0NtxJbunGX/HH+/1/PBM1ZwJcKW
 qQBrSK0HzXyRhVWW4yPo5+Ysg1Yeye1tZkWkhysBqzmZrIPjAsO0pOctwAnSAOXYWxd9gVd1YWI
 2j8jgDey4anxrLfgA/89O6alj2qhUDeP3T28ZfTAo/U8zsA3QGjSg4b5uKiDuZd69bN7jF7fZDh
 KciJ18l36FAaQ231ZMho4X9z1VH5K2mylXnFHu2z7KzCCZxTjYOX1trOXZDimajzw3wCuTzw0FL
 GM+Gga+o9rtwZrZQPUxNYlx32sH4gM2Y17zylgvLLAEhM3Y7K7uyJenrUBbm4/1daAhAfP0YR6g
 0CbZSCWRZ/CywfN85ZzPlpVgJF77Ps/YoNl1nPkxbOklZo/KPYaZeq7LQToh6cTwjqWBtjL7G5B
 c7HBWHjNT1TcDJGKXoBkjbEx3ngLKAnS/cjJnPzcpKh3TwZHb1cj+B+01XBqVoIWSwVYy1gtINH
 IUjNnWw0e5ZxqKicgjiXJPYdiHtjqW4I4qHK/1IKW5OX14glIPs8ph9bCUWrIKB8AFN+/6XAM/v
X-Received: by 2002:a05:600c:8716:b0:4a1:62b8:9aa1 with SMTP id
 5b1f17b1804b1-4a18e44885dmr316691205e9.2.1791975747413; 
 Wed, 14 Oct 2026 04:02:27 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1b45eb78csm38078845e9.2.2026.10.14.04.02.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:02:26 -0700 (PDT)
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
Subject: [PATCH v11 05/13] block: add dma-buf support for raw bdev
Date: Wed, 14 Oct 2026 12:02:03 +0100
Message-ID: <c01c4709dc55a12fb0f2fe1ec847b5f1f0c92789.1791975048.git.asml.silence@gmail.com>
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

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 24 ++++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..6c6700df943c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -730,6 +730,9 @@ blkdev_direct_write(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_buffered_write(struct kiocb *iocb, struct iov_iter *from)
 {
+	if (unlikely(iov_iter_is_dmabuf_map(from)))
+		return -EOPNOTSUPP;
+
 	return iomap_file_buffered_write(iocb, from, &blkdev_iomap_ops, NULL,
 			NULL);
 }
@@ -855,6 +858,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to))) {
+		if (!ret)
+			ret = -EOPNOTSUPP;
+		goto reexpand;
+	}
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -958,6 +966,21 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+		return -EOPNOTSUPP;
+	if (bdev_has_integrity_csum(bdev))
+		return -EOPNOTSUPP;
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -976,6 +999,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
+	.init_dma_buf_io_ctx = blkdev_init_dma_buf_io_ctx,
 };
 
 static __init int blkdev_init(void)
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d003a9d2d1f6..2d5c30823aab 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1599,6 +1599,8 @@ struct block_device_operations {
 	/* returns the length of the identifier or a negative errno: */
 	int (*get_unique_id)(struct gendisk *disk, u8 id[16],
 			enum blk_unique_id id_type);
+	int (*init_dma_buf_io_ctx)(struct block_device *,
+				   struct dma_buf_io_ctx *);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
 
-- 
2.54.0

