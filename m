Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B751CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:33:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BF4F10EA55;
	Mon, 28 Sep 2026 13:33:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g4ZBk6G2";
	dkim-atps=neutral
Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com
 [74.125.225.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97F3F10EA55
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 13:32:53 +0000 (UTC)
Received: by mail-wr2-f35.google.com with SMTP id
 ffacd0b85a97d-4887d06c669so2343463f8f.3
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 06:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790602372; x=1791207172; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
 b=g4ZBk6G2h78TI2rW65hmVACcb+TxMFeriQZuWWy9Dz5GJ09dwsPWYakGYFHXJ2K5Ic
 1gFZ/wRS/kQ4MoaNgyaF00P6Vgfvp1EoQRmFAgvYymZV2AtC3NK4KKBsbgdHawGE0XYT
 AEm0bXkqfsg427WNttD5Cb4zFkIBWIVIJFOSScnOYBegVxlzst3TC4VBQ+QJVVOyNRR3
 uPAL24ltgGDe7bnp6JXNoveoMsAXVsffvBvnEP/T4b893YDhzjwEi/Q/LlLN1TDkc/Bi
 86Odfc1CfKeS7Zybcp6ntXZd8Z3wn3TvrpzVkIRNkGzVrxST1Ozb/XjaBf4LLIssECUl
 MIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790602372; x=1791207172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zNN8LK2yF6e2Er4Otjr5e2ZaUKzvWbebPH7D4oJybmc=;
 b=VpEUIPJqGjJlMakEaneXM6f3bsjeRrmmwBpo7yAqAtWWpOr08O0qH/yvCs9VXnPn3V
 EjK7+FK5Ws2TgPlr+MI8naATXny01iXw7HvAdANgVj4djWB274DA3XqCEbov46G4cPV5
 OdHmfDpgST27gS1KyELYw7DqC/8Prr9nmHLRHp9leaYkPQ+deXgLYgReSgyvzXkwdBFj
 EQp07pqeDc9I/uJAVP6OzJXbnAMVdMybmMK2fiKsfem16iGRvfJQLv2FlQSahbWoEbs3
 IDfluNZPtthjpNV9TdLnqQJ2TFAcoP5P91nDMrTvxZ+5wONoYuZ8nMAsIICn2X07YMqZ
 TV6A==
X-Forwarded-Encrypted: i=1;
 AKwUvBxlfzBxETxnz1Ya/B6B4w+tUjzHdinbJdGbSo8FcGq4euMTgGOYxLjdrh5AOVACFxgrJt6+e1q2CO4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKU9Qkmm01JPw9aXwkC93DO8UpBEVCdgZuIlHPVZGdjKai0+7mn
 qXby2YmGEhuA/mnou23JZi2NM3p26Yc/Uf3nebPoSPUWA8DMxqB/Kp3p
X-Gm-Gg: AYBFou2tasg1Wo3VP8jzc0iPHDdV4loHm4AlBtUO+RVluDiVBYZlJWE474A1ekvsq2b
 LXzx1uw95AOyeVoa+2DQRlD14/7LhaoS87wPNHbX4f+6Jk3WvTpATqjPIw1DQ1ld+PhHjDkNdZJ
 IEntMScIg4uOM0IZvgJtw+jUEibJljd8XlHbVIBwQDTvrsZRn8rUcuGKCKopdNdnoxEc+mWy75r
 onZbA5j7m8Xkiq0C4OjaelSIXkKz5kwOQRUHJKJDRJwy38x8BDq8aYCYfSqU5ymT5N+j03yBtt5
 YRsOgSWEix7ui/O6/hdsTgCkW6Sh3+GuWxmiBjtUJWaNVJ492wah/fcilDo8XC8zJTMPew7WnnO
 XadFHXFZv4rKhXG9hSFeVFn9Ys3AVj7doIQ8Hn3haxvdUV2YeebmiMIDCv+9ASrDiBoWqZCaFLj
 rQy93nC1a4QQLJXcyhnjtTjZMSoaJ924ksnYHFzTZVF5Dxu8on2xC6lNlVhMidxWAJX5jbAbLTM
 DSBw7r0tXZLG0w4wBlIK1kVgv/cBCNCV8q4EL9EUC0LeKZ00EAJbQ87jrxVSuupVnCPHUQbCxhV
X-Received: by 2002:a05:6000:4911:b0:486:f99f:8236 with SMTP id
 ffacd0b85a97d-48872ac74e0mr24072487f8f.44.1790602371877; 
 Mon, 28 Sep 2026 06:32:51 -0700 (PDT)
Received: from 127.mynet ([2a01:4b00:bd21:4f00:7cc6:d3ca:494:116c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a349731sm28090164f8f.12.2026.09.28.06.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 06:32:50 -0700 (PDT)
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
Subject: [PATCH v7 05/13] block: add dma-buf support for raw bdev
Date: Mon, 28 Sep 2026 14:32:21 +0100
Message-ID: <a6b81e65b1f09b6ed1f71f294e5a94896ea1ead7.1790602223.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
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
 block/fops.c           | 25 ++++++++++++++++++++++++-
 include/linux/blkdev.h |  2 ++
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/block/fops.c b/block/fops.c
index 641621db700f..d05a78d0919a 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -783,7 +783,8 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	if (iocb->ki_flags & IOCB_DIRECT) {
 		ret = blkdev_direct_write(iocb, from);
-		if (ret >= 0 && iov_iter_count(from)) {
+		if (ret >= 0 && iov_iter_count(from) &&
+		    !iov_iter_is_dmabuf_map(from)) {
 			ret = direct_write_fallback(iocb, from, ret,
 					blkdev_buffered_write(iocb, from));
 			need_sync = true;
@@ -796,6 +797,9 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			need_sync = true;
 		}
 	} else {
+		if (unlikely(iov_iter_is_dmabuf_map(from)))
+			return -EOPNOTSUPP;
+
 		/*
 		 * Take i_rwsem and invalidate_lock to avoid racing with
 		 * set_blocksize changing i_blkbits/folio order and punching
@@ -851,6 +855,11 @@ static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
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
@@ -954,6 +963,19 @@ static int blkdev_mmap_prepare(struct vm_area_desc *desc)
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
@@ -972,6 +994,7 @@ const struct file_operations def_blk_fops = {
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

