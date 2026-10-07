Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C784DCA6007
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:43:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA88B10F447;
	Wed,  7 Oct 2026 01:43:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PaV9WMsR";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D195710F442
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:43:19 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so9192755e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 06 Oct 2026 18:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791337398; x=1791942198; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
 b=PaV9WMsRaiTHRqJIgleboSDxfATpGBIU4E5nG/u9c0Uv1/6JWWjgsfbF9veZQyKNvV
 QFkIHhNAU+jiy8mspOti5flhbaUWL+e1Xb2p9ecB8UJq0HdUfxFDpCVOPhfTBv4rEgWW
 hmJdmqdToTCEeE95oBeht/Kp9hhdZL9vxw+U3KPQs9GngZ76bll1aJjZlrBCNK4mzFRR
 tY084XH2cHQS3anPOgKcYyT+PQdNCh/ukhKSv2vtshT7bNqit76CTc5YhZybhUqJ/9IB
 wZwdiZeBO1eGD2HN0XAbuyzE8ITp/FrDZWJkcgPX3wh3m3wfNG/9TF3Bx3RnHDx9ewQG
 fzXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791337398; x=1791942198;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Nls4uSWUi3FtYOHw3kmfxrWIUNA1MBsyApDbzhyJZsE=;
 b=NcrUJwk4QqueSQmzYmXmjpzEWzhoUb5LdelGINMwiCarpb2PgVr2ZKdr3T0suyCi2N
 JarS192BKoGZp24FIVMxmlmTKz9ycc9MMSLChFnJKBkM32Ph5wolVfw+AS0o9Zg5eRAh
 SnE2+EXugB/IId7wNDxiQBJW7mQH1wx7k7i0CK4vW62FsMv92bbk45OYJosYs0Mm8F2l
 vvLWufd/oese2ZmzF3PhioAzho92RovX42QgKfMP3O4IEBRBxnR2nwObHdscnoX7bNQt
 xa7THJzff2xtkiA3GvU3kAfIs7vjmGqvoBDmieMYA3ytBwIhzHMgkBQrbMbWQLGjgC0C
 y8Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBydC4023lkGzTamA15moX7iZc41Kximu32D3tw+K9DZcOyF1+0dh69n2ToiT4YlALz4zIyPxSLxpsQ=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kxVkUZXp0g6ntSZDdSTvIKkimhzDmNOvNWsWrN8V79ngEeBFE+
 rUI10d+KsRo3wITKFT0TSIb1521qGS9R2BIY+4CKPBvCY65sZQhemgIt
X-Gm-Gg: AYBFou0iUfrH8opyHzdAswyavymEZz82ntkg8dSRMFpZv/uAuhu7wb5a2HbX5lUB4UK
 HQcswF0pVEkDsCGQ1tVVSeeFfj1joeTIV0DOIVzzh9mSWZmcoVLZmdjqyNkwQEBYlff2VP9bpFa
 ev7ZKMfhAySjUAL44ZZ61paxB0pyPATR/XE8Exfj3ggvU6u0tf0E2gqCCeIOkB5CjvCE32eFDWL
 YNY0DPpW3sg7hbPFb7zC+K/2p03ytwuuGrZIuQnRpvLj8gBmsPBAs1rFWkFcP3E23lUxmzQpjT2
 KyQSRDgvqO46n1EOaUS4q1rAzGz/ryx5glUaSmLJzUhH7fvAxcJFHVBtCNtGnmHLYohbL6ocUWD
 VrewMl3voh8pXX2luHLP4Mr3hGvBY4gdRaUSYgtRkvu0C81HbJDtjpNXCBkPC3iKAIxf5cNJdzD
 KgnAynfThDKfAwfYe7vpbQXa1vWNDuAEYYSwgN2TRBoOL5alVZnMsUI0ErKItdDjUaeJXIjz3rj
 rMDCQSe9eN+j1R3+YvPOmltmmY0pSiD53ksWVMqs2TpNR/ZUVlbP3R4Acioq6B4V5GUrW3WB+Ss
X-Received: by 2002:a05:600c:c16f:b0:4a0:2484:2800 with SMTP id
 5b1f17b1804b1-4a1800ca1c3mr7313145e9.3.1791337398229; 
 Tue, 06 Oct 2026 18:43:18 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a17f653d7csm26423895e9.14.2026.10.06.18.43.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 18:43:16 -0700 (PDT)
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
Subject: [PATCH v9 05/13] block: add dma-buf support for raw bdev
Date: Wed,  7 Oct 2026 02:42:48 +0100
Message-ID: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
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

