Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A43CA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:32:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3567510E401;
	Wed,  7 Oct 2026 01:32:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l4etyV57";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2576710E37B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:32:19 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4a02718da81so10886595e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791336737; x=1791941537; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
 b=l4etyV57F+a3GEozwzW6ayAl3IYd4ClUa+GGCm/pVgZTzHI0K8dXzNTTB/gTyFBZ1D
 W1BbuGmv3cE52m3q4q/n4dPMB4OGA3ue0dQIoUbcBG/HALCcr0McUTvpoCj1ynhc7CxS
 zMOmR0HKSBvY28am3EPy7Kw8+GaX/oHKRCeO1GEYNzxe6eUlkAVpWsNuZV6ChOFOy7+2
 UUkP+bNSA3WxscXjUbBi6Uko/jerWm9xpGWwnl7OHclZoE8sEOs+Tb48vvIjjmWHU4Qv
 E0nl0ukWMqFM85ST9bPm+F1VibMrfUtFSprX1wbeedn83yx+/eO2YCj29+mZz9UETcO/
 4Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791336737; x=1791941537;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
 b=Y7moJMhFQXNcPGUQOjuU3HcpxgkGXapUvkIWuFrf9x/Q34ABfJvDqLoLtVwKapveqc
 wPdtyVRSP52wEBgVwhZh0ZiA4lm714L7P0OPlTWAvMvMxfoqFxaZaUWlkgCvTXcbZx77
 Yq4R8XNgNGO/0eTO53q2NkLn+d5SVo6PJzb7rYthIkHnxHIhHOf1ScwRuI0ZIBOybYVR
 RraqmI8GSVkV5J3cVYtv6rNMO+3wgS8kCiRWNy2s7QnGXkvA1ASM4OxllAob2NaZPKVm
 AcJIvE1xRzzsw1jr6sby/YCONFsihcmmJ8XilQpB16yDj79tqZe+t9uNZzrdkQDzUajV
 b+DQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwTngh95ZQbqEFi0ivltW1KgXvw6XGG0XsbelcAw5PN1MZTo8V20LLLWj9pI9LKixp9i8BQaYbf8+8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mxjWvessD9mWNl5GXyveBl+HEMlET4ye2vUY7vgfXT93kKmJnu
 Fs6qd4HZu/0BkM1QvI6g3bIKaUPx8b01j++FkRSDFom1fQq1tF4BTdx2
X-Gm-Gg: AYBFou1cZLU9ao/64FyYlGqFkvfWQoYrpThcK3AWE9gkb9FpK1wz0URbELlb98hlAqV
 NuvPF1mfxgfnPkJ2VjLbVGtuf2NxzIX4nEQIfvuZIKmb23xNls/UTMVB/+RSJZD5y5z6mi1usb+
 5XbfDNjyrxAguQrMjtgbRpiwJ88n6DaCeb6rvrZUX9HNR9Wgh63wC2keP/IfboU//0NYMIMp/0C
 E6tXvWMSMXrtJkK/imbnZYZ3GKo1lqXwjXsfLyHNG/Vw2iRQojY9xGV8azss94CjYwwt8sYTR6+
 k9IE6BKBF9meGMf/r4DeXP6Xk6e6wOEmlddzylIkOZ/YPXdYKpY6Qpk4k2DOl4LiDr5nLiVDy2H
 QZVq770WpHyyoTNHUHjgsBWoOzADdfHOaHW/0kMFngkUkiRos3eovGzF7P6+cPxDpESGu3d43Qw
 +yea8HSjCvgDYPZK5P0BdVkf9ZPTnCw55+xszJzmyFvLkqf6ISMFwjo8Yk4dSz8pTj7exCTofHL
 Z6omvDq0OsR8ojaDP2GzaeQVDUxR+DIxl7OaQuUxKN/1PNefnDqXTYevWvIBOhb7SI5yInckOgw
X-Received: by 2002:a05:600c:820a:b0:49f:f9d1:e618 with SMTP id
 5b1f17b1804b1-4a180311281mr8069355e9.17.1791336737511; 
 Tue, 06 Oct 2026 18:32:17 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f6538b7sm21183615e9.13.2026.10.06.18.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:32:16 -0700 (PDT)
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
Subject: [PATCH v8 03/13] block: add dma-buf support for raw bdev
Date: Wed,  7 Oct 2026 02:31:46 +0100
Message-ID: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336002.git.asml.silence@gmail.com>
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

Add a simple proxy implementation of init_dma_buf_io_ctx() forwarding
the call to a new struct block_device_operations operation. Also reject
dma-buf backed iterators for buffered IO.

Reviewed-by: Christoph Hellwig <hch@lst.de>
[pavel: reject dma-buf without O_DIRECT]
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/fops.c           | 22 ++++++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 24 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 827dc9eecba7..e9da48ab73be 100644
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
@@ -958,6 +966,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -976,6 +997,7 @@ const struct file_operations def_blk_fops = {
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

