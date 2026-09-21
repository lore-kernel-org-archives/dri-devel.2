Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70892C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:39:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73ECC10E765;
	Mon, 21 Sep 2026 13:39:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YtY2iFJ5";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A97FB10E765
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:39:38 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e721b5503so29858295e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 06:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789997977; x=1790602777; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=;
 b=YtY2iFJ5wHE4GUctoczWYLK5nw+P9hNeP9nlrRpZ+L2LcPiEDyRWmwOxJ7sfV2/FT8
 FHcivDDEPlWNiSZzYrJjMtXQshOY4IXR73eeY1Kw6IhLuJY7aQLFwkSMnXVN3wTSW2k2
 5cOrBQ8LVbKDxxWm0NX3M2iAhygs7mxUsaTb8ozvjiB9KoTd1X7t0Mt1HwvlUJ6gRcGc
 duuQLraDPTXfZ9ZdoxYb/kzaNNkhfx1ecR5Ku9DUCbGUgFJ8NfQH00lZt2hyRDkSV7ql
 ESo9mukq+fQSisMR91JbsSJCg0wRFmSyrumP/c/An+vhPxALlkmWgbPfdKfqrtKwDL+c
 Zr0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789997977; x=1790602777;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=LfiQtDTMXplRc+HRsAYVyvIssf+oWzUZ0qqIFwpPEw8=;
 b=UMier5w6Y4RaiazK0NvfjYysuBgHQ0yaS3ZksXrjKcMiWImi5FbQJ9sVD7m9aiD1oS
 TTxw/kZFSu1pfm0UluQLffRKAuxluprDqPplt2ayeOlwEWlvYpGHvPe79zfONUmLzYkB
 6YJSVVmoCmH4WZgQ6erHMGEvTyD+i5NyH0J5pkhDVSDj2mteYqEuVYjuUsUiOcBxonuC
 U0SRjFqlgtd0yqLezsVuinq5sr3StaATK+clbUWA3JqKcEUtb101DnwElWrYYX5Nx2MG
 eCP5iX9nwEAHhE1SpiDB7pO45oIcwd3+XvcL1u+0w2AcgV7AcIAsa95MtXMZSX1exN31
 sHgg==
X-Forwarded-Encrypted: i=1;
 AKwUvByCVVmY3SwPGnk5CfanTQdI6Liy/s5JaJ0H2+UN9QZE0J25SBsD9lkPrh0JuIF6gYHHWPC7p8hcm2U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mFskHMXta8HQXtUAnqSGpYsii/M8JJ+9RYeKWJDEBWF2/CFzl3
 gi98AvwMSp7pc6Vv2/o8Y5epKVaulG0f5KglFNf0mUg3RUdMpHruAklD
X-Gm-Gg: AYBFou2sJSRneQx9JC+L5B0CMg/47z5IuR+C7eCnuiPDiHN5aW3OWhOXrrOTU/kp/vH
 JexbHmq2FdEz56kC5szgGztAphd8JUveU2J95ZeoxwVK28jcWuuMhPCRLnemS+VpKFI7Sw7KKY+
 8JVg/hogyUnd7cSUgK8lEcNqGfbFUyc80ekd+eZKuCOt4E9+vq3jHhmldRob1u8K/2ctNvfWool
 FcfUsHfC+oZoy4h74jp264NhWRwvgFBmWU0CGcQcRySENw8caGNfj4UlsuIPg7MZ4lO4RFwiRgS
 Gzaa19Z1V3gYkVFLRadpFXdg+6SnToFJqEyLw1iuUf3K9UJ5qhmirrmk9vyRkm2h3fYo9b/+0oT
 L1ljztXviWlmDZejEhmPnL/4w8t9F3UOPiFAlE8kRtsQgkHRJawcE2fo9dhjXDQ4bkvXsR1wt5k
 hZ2Z5h0BHBi0XkbMwDfr0ZWuHacSK2MrnooXa0BL4MGNcv8Uy04dI+Yr5OsnwAU4dTg9ReefIFD
 Xy6DNUnvGcPWUInh8ZJ4r8y2U2UOOajNwWHN3KZuRiPMQ7IjpBLUD/hETgX7PvQaYWshjf0a9IG
 kHbAZ73bCdaDB4vx9LYbBG3EbfvZX9GiOQKH8KZc
X-Received: by 2002:a05:600c:c493:b0:49e:74b6:740f with SMTP id
 5b1f17b1804b1-49fc573603amr145209165e9.17.1789997977065; 
 Mon, 21 Sep 2026 06:39:37 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-213-26.dab.02.net. [82.132.213.26])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc585920fsm617171605e9.4.2026.09.21.06.39.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 06:39:35 -0700 (PDT)
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
Subject: [PATCH v6 05/13] block: add dma-buf support for raw bdev
Date: Mon, 21 Sep 2026 14:38:49 +0100
Message-ID: <eafcbbf7e75e75e98d0791b843fae0f2423a4ecd.1789997898.git.asml.silence@gmail.com>
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

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 22 +++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 09fa42f8d8fa..0252d26969a4 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -782,7 +782,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -795,6 +796,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -850,6 +854,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to)))
+		return -EOPNOTSUPP;
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -953,6 +959,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
+	return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
+}
+
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
 	.release	= blkdev_release,
@@ -971,6 +990,7 @@ const struct file_operations def_blk_fops = {
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

