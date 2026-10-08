Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD0CCA5FED
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 07:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058FE10FF03;
	Fri,  9 Oct 2026 07:17:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="tdC5+MT+";
	dkim-atps=neutral
X-Greylist: delayed 523 seconds by postgrey-1.36 at gabe;
 Thu, 08 Oct 2026 12:36:38 UTC
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4368010E81D
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 12:36:38 +0000 (UTC)
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20261008122753epoutp0409727d7948ea7aacfb04d06dc5cbbfd1~cjaC-yAa92381723817epoutp042
 for <dri-devel@lists.freedesktop.org>; Thu,  8 Oct 2026 12:27:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20261008122753epoutp0409727d7948ea7aacfb04d06dc5cbbfd1~cjaC-yAa92381723817epoutp042
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1791462473;
 bh=y3JROMvSkErlghFufMEpz2e3fgBQWeAkOo4JhswqA7k=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=tdC5+MT+GmAi5muBRq1BT1yN1ZKyFBL9HVTHiJoMUk9qir3KHpRlhz35ERD8YB6Bl
 i1eJ514gd7g1gNeb0KlrladiC9kKg0NHCB+yBiTYgiBHVNFGcUFtxIU50PqOf5+JRY
 f9jIGFX133rc42c6pXTmJz1rl62OYAb4OJmJKBEI=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas5p3.samsung.com (KnoxPortal) with ESMTPS id
 20261008122752epcas5p3d0e2b9158c0268ad04675e87ce26f1a2~cjaCjkMAU1506315063epcas5p3z;
 Thu,  8 Oct 2026 12:27:52 +0000 (GMT)
Received: from epcas5p1.samsung.com (unknown [182.195.38.93]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4j0q5M5zGqz3hhT3; Thu,  8 Oct
 2026 12:27:51 +0000 (GMT)
Received: from epsmtip1.samsung.com (unknown [182.195.34.30]) by
 epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
 20261008122751epcas5p1c1717e88968c87ac8cd3f6f7cd53fd94~cjaBJv_6d1842018420epcas5p1H;
 Thu,  8 Oct 2026 12:27:51 +0000 (GMT)
Received: from [107.122.10.194] (unknown [107.122.10.194]) by
 epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261008122747epsmtip1643989c6f636e89fda3b56fc37de2645~cjZ9_NBhB1436814368epsmtip1X;
 Thu,  8 Oct 2026 12:27:47 +0000 (GMT)
Message-ID: <bbb87d6b-b7a3-487a-8be4-27f3f9ce4a1b@samsung.com>
Date: Thu, 8 Oct 2026 17:57:47 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/13] block: add dma-buf support for raw bdev
To: Pavel Begunkov <asml.silence@gmail.com>, linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, Christoph Hellwig <hch@lst.de>, Sumit Semwal
 <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>, Keith Busch <kbusch@kernel.org>, Sagi Grimberg
 <sagi@grimberg.me>, Alexander Viro <viro@zeniv.linux.org.uk>, Christian
 Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Jens Axboe <axboe@kernel.dk>, Nitesh Shetty
 <nj.shetty@samsung.com>, Kanchan Joshi <joshi.k@samsung.com>, Mike Snitzer
 <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Benjamin
 Marzinski <bmarzins@redhat.com>, dm-devel@lists.linux.dev
Content-Language: en-US
From: Anuj Gupta/Anuj Gupta <anuj20.g@samsung.com>
In-Reply-To: <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261008122751epcas5p1c1717e88968c87ac8cd3f6f7cd53fd94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
cpgsPolicy: CPGSC10-542,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261007014324epcas5p2a7f3b03f118c9a1d1c633fe839ed1e46
References: <cover.1791336930.git.asml.silence@gmail.com>
 <CGME20261007014324epcas5p2a7f3b03f118c9a1d1c633fe839ed1e46@epcas5p2.samsung.com>
 <af2b48a490186edf38f1d4a5dfd9513574f7a350.1791336930.git.asml.silence@gmail.com>
X-Mailman-Approved-At: Fri, 09 Oct 2026 07:17:38 +0000
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

On 10/7/2026 7:12 AM, Pavel Begunkov wrote:
> +static int blkdev_init_dma_buf_io_ctx(struct file *file,
> +				      struct dma_buf_io_ctx *ctx)
> +{
> +	struct block_device *bdev = file_bdev(file);
> +	struct gendisk *disk = bdev->bd_disk;
> +
> +	if (!(file->f_flags & O_DIRECT))
> +		return -EINVAL;
> +	if (!disk->fops->init_dma_buf_io_ctx)
> +		return -EOPNOTSUPP;

dma-buf doesn't work with PI: bi_dmabuf_map aliases bi_io_vec, and 
blk_integrity_iterate() walks it as bvecs to generate/verify the 
checksum. rw-dmabuf liburing test hangs on a PI enabled NVMe. Something 
like below is needed:

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e929f94b25c7..1b7f8cbbda8b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3150,6 +3150,12 @@ void blk_mq_submit_bio(struct bio *bio)
                 goto queue_exit;
         }

+       if (unlikely(op_is_dmabuf(bio->bi_opf) &&
+               bdev_has_integrity_csum(bio->bi_bdev))) {
+               bio_endio_status(bio, BLK_STS_NOTSUPP);
+               goto queue_exit;
+       }
+
         if ((bio->bi_opf & REQ_POLLED) && !blk_mq_can_poll(q)) {
                 bio_endio_status(bio, BLK_STS_NOTSUPP);
                 goto queue_exit;
diff --git a/block/fops.c b/block/fops.c
index e9da48ab73be..6c6700df943c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -976,6 +976,8 @@ static int blkdev_init_dma_buf_io_ctx(struct file *file,
                 return -EINVAL;
         if (!disk->fops->init_dma_buf_io_ctx)
                 return -EOPNOTSUPP;
+       if (bdev_has_integrity_csum(bdev))
+               return -EOPNOTSUPP;
         return disk->fops->init_dma_buf_io_ctx(bdev, ctx);
  }

