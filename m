Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81977CC6B15
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 20:55:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9B9210F9E0;
	Tue, 13 Oct 2026 20:55:34 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AB8210F9CD
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 20:55:28 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48b042c0728so782186f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 13:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791924927; x=1792529727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
 b=gmXwbTuwSrv0XUuCbkEW9f7cWCvQhSMEssHUQOOZAx2oA0vQRs7dU+/GKkVOChekRO
 l/bq1U/JQu/QLNli1Odxj4P113+V097IOc4xIq8VaHZkZ/nTRjTiVBb+s0gPrub89Ph8
 yC8FWwCPiOk1OpsfXcKIJEdzmvM5mHnhh6b32/20AURukNBQVoTjOCqHuWQBEIs2aSJS
 BPG/iJnkYOe5rVxlogEsOm00KCHuMsT5mo2ci36xy9r91viQnGClPCNOa5zHk+R0BdDC
 DOHAgfe7VXkkCbRhA1M9ZRwMJZPFKZKcy8v59GSt3NG+Qax3t/tpWwQ+cy/gPdvq/6jI
 2j6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791924927; x=1792529727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=sjQY12JZJkEEoHUMGZ5pLsy3Pmh4yJs101KM8nm2S/U=;
 b=FbRGQRrHgWC4QYHDRWFORVBTqfO02SO4Ml7vGvzi8aKDoszPyBn6wlY5mWvnZdWD9i
 czn1BtWyjRILqpRA3tlI8gUo7mr0W3CznRVSTYqG96pKLxoc/zY7tmo9q730Z5kVoJzC
 8WxXngCg4Xodlfo9A34AO8WCsTygnZIoDIadfTb3oVtwOLoCvGJAirUR6shxcU8Kw6R0
 bLPCWntZi2zFuNGVbs0y8y8nG9EhAXvRtRmWAtCRciHJvsPf46R0pN+Y4XqVd6VMpQYa
 SRhvGWqz+nuSj3+idwrFESRJalw0+tKnL8UOKAmNBHMQmf8vjIOLbSNUceZuzmkuLzLD
 Q4CQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwsaCYk/EUOnZi20zqW50bCtxvqFJuGP8wEFT8/REA5IytEvD6gfm3NofT80b5cxvTo+kX0suW8WrI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI3cTrNgfjv5cjZvz42TLkByaIzIVEipLbV8H7KgfCGoO2YI4Y1
 N9XYXKS253UTZvNbV09slk2zZ1FUTfR6fKrJ+BXg1H1tIOSyFnmZiV5/
X-Gm-Gg: AYBFou0S2fbdormGCBm+X8n62UcKsb0Kjk1BMGLW4HGbNiCnZ5v4WKNgnJjn5l5nioe
 SdtIlmrwplo6qjN04xoCW7dlDQUlcgnBPxM2BKQBXRNDgK5DwTT54J+TZI+1scYANubaFcAvWh6
 FyC2ZHQJwgw6tPjuEu5OxsS+J5rFOQGGzzBrV9hbavfncbVNMbkvWhJGtLbH1fI3mq6KSBjcjE8
 MkwA2zO7in3a4BolYd0fgwhWJeGLGihbYt3KANlnNyi5EgR33JqdanvXoM7KJ3Iex9tbYg6oCrM
 p8Gnsr31AAAD4vnBoP5K+njeoGzMq+mlsNHz6USia9zHG+nYtS/dFC4fSQMkw3EcH5vVJ2nsnSa
 shzMalqhtrPyL/uWVPYWDD0M0RoUwLn4bi+qNUyFWo763WBjyFXhH2XUMhmTQxJeCnyNIvCy8Wa
 IT6hGRGRXIOk+NhABN8TteB1X94ibyCHVrlfuwKNTKY+9m7L4a/30p5FRpd90sdzsdvcP9fo7gc
 WfH5rKIbIXTo6DHOcKJBpQQaUCMKeddXsmAjkNtdeAAp9t5FqYesDfG+TuqG7zVeZKEq/aqYRbG
X-Received: by 2002:a5d:5d09:0:b0:482:fd9c:3740 with SMTP id
 ffacd0b85a97d-48dbaae8af0mr23656771f8f.22.1791924926558; 
 Tue, 13 Oct 2026 13:55:26 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de7273a0esm2380730f8f.29.2026.10.13.13.55.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 13:55:24 -0700 (PDT)
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
Subject: [PATCH v10 05/13] block: add dma-buf support for raw bdev
Date: Tue, 13 Oct 2026 21:54:49 +0100
Message-ID: <78b3f2bb6e3ce576ee99252b88f0af8602b436d1.1791924581.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791924581.git.asml.silence@gmail.com>
References: <cover.1791924581.git.asml.silence@gmail.com>
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

