Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5479C55172
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 15:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F4DD10E342;
	Sat,  1 Aug 2026 15:49:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="P940ybv/";
	dkim-atps=neutral
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE8F610E342
 for <dri-devel@lists.freedesktop.org>; Sat,  1 Aug 2026 15:49:41 +0000 (UTC)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2d01663d816so15299845ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 01 Aug 2026 08:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785599381; x=1786204181; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=;
 b=P940ybv/0hTCRLrJ/+FuqYStcGw7S02IY7h/o4QOpdLDN9NJ8jR4dPxWtZIrsYM4T9
 gkorYS8uJ1UyTx+6pUfukpG47wb4JoQ98LTW+hfL2ZDid2VNQ1wI8hNk9fg/MVKe6aTj
 I7CduiWhMp8tVTjGNOEpC2SyMWBEOYlvCmxrpxMHiahtkltyWnop9tWuLJUuXVN5UuhY
 bif0o1dRE3jS5W2LZ9jh/RLYRpM+bAcQdI9ePmGS4xIS3TIUuR6XmP8ZELZs+NKd1Ool
 W8CygW0D+9r3T//aBWb5QUFbU1ZIf0oaMKTXtV02Rpa634OXiNPsytRC3Ob3YJQw5Nbn
 UMow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785599381; x=1786204181;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XTGwQGVc0bqlcGV09Qbia8ah/Xj1ofLPkaifBOkmHiQ=;
 b=aMQZ2kd9vh/J+PxndXOvM6s0nvXhAYsytaVlNQGzGxBBeiqALvF00ZkiIHXHCH+pSC
 YsgxAap9gw2XUuzZizPsgNB+1hzxfYpz6SAjTi+1P7YB8KZoFnSf41TmToAGd47ha4/o
 5P8rbnASRTLz4QHTb3Ez8sOQSF2PC6azXZwds1Utjb8pTsudGCYc17GJb0RyYBTP/s3H
 kpalnJQ10D2cCiixNp6XUb0ZCt9k4ItQA5SDgv5DRUEmqXouqE53UXzoO+Otk2ysaJhD
 2bmuc0wcUpGqJoQJDe5I/XrbmdTMzY7U38k6ZdWGanqwAs1B5rBgW9Y7EoHhS0keJaqu
 ZEhw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roecm6gR2jQCVYbkwrzae1ZH5MUKzf2B7ZratKuDVa3w8gJMCvsiT0hz1UtXrXe8l9nDQCFFzfygr4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxd2ZzTpMdNMsBGySpMbtJb/dotW/up7BGmwQ8O9XPTYhAu8zHl
 /md8tAbBfF38re0ZZZ6eJstajXwlj8pr9zga0K+dEe9IkRSXbtjxAaek
X-Gm-Gg: AR+sD13X5fMC1/Uw4AqwXEq3Yt2Po4ozOO4aP1/DO9ucK8AUYHSCpHffLB+2qPETvxp
 Ft22ZzcIRyFjYmQqDKI3OjtTlBVfCR5YcY4sUazwy8ZCFTiiIR/qrhtQHKWUcZwnYCCAumz3Rin
 oVCfORmMY4AOSdcfsKxBI16ZBpsZJzNPUuUawA+7PZ6eQJwxnGrmYtT5JcAInt6cGS0xJr57shi
 HOTsHIx9mbgn7s5mTn5rjM7B+f2surQf9LXL3KS8SLvxm5PFYnCa93j6dvR6CFjJWTxNSfGg7yH
 Wv3w03rs4phS+kD3YVvqK1Weq8HojOZSauyK/DZHbsvCmEwQy4nCpsDXeaZ4r8+qqvcaorQr821
 CWH8MtjMj/t/JObEo28+xP2aWd7MdkOSIygmYA8vvsPPd+tjJi5FtcZqrtEi/t4ddDjTTCp+1OT
 j0XHJFrIi2UqI2qoM1kEGGH3Z4a3t8h5ka2G8o1keJihspSAj24uTAV+m/lrwsyIZBn8CKYjKRF
 fI9XTqTvt4j4kCddRRgwnOq17Gke+eZ6rrIhdGZskDpQO8=
X-Received: by 2002:a17:903:2450:b0:2cf:9347:f445 with SMTP id
 d9443c01a7336-2d05219f5c9mr36286255ad.10.1785599381195; 
 Sat, 01 Aug 2026 08:49:41 -0700 (PDT)
Received: from 127.net ([2620:10d:c092:600::1:61d0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d04b12202bsm18287605ad.66.2026.08.01.08.49.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 08:49:40 -0700 (PDT)
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
Subject: [PATCH v5 08/16] block: add dma-buf support for raw bdev
Date: Sat,  1 Aug 2026 16:46:20 +0100
Message-ID: <b32dd786296e1683378c9e037e2b9f26ec24fee8.1785596451.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785596451.git.asml.silence@gmail.com>
References: <cover.1785596451.git.asml.silence@gmail.com>
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
 block/fops.c           | 19 +++++++++++++++++++
 include/linux/blkdev.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/block/fops.c b/block/fops.c
index 56bbacf6e317..3c403afb0f64 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -767,6 +767,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -821,6 +824,8 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 		if (ret < 0 || !count)
 			goto reexpand;
 	}
+	if (unlikely(iov_iter_is_dmabuf_map(to)))
+		return -EOPNOTSUPP;
 
 	/*
 	 * Take i_rwsem and invalidate_lock to avoid racing with set_blocksize
@@ -924,6 +929,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -942,6 +960,7 @@ const struct file_operations def_blk_fops = {
 	.fallocate	= blkdev_fallocate,
 	.uring_cmd	= blkdev_uring_cmd,
 	.fop_flags	= FOP_BUFFER_RASYNC | FOP_DONTCACHE,
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

