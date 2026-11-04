Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D4606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OYgGxoOE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6D9CF10E561;
	Wed,  4 Nov 2026 00:33:17 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A984410E665
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:33:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C7BD860D79;
 Wed,  4 Nov 2026 00:33:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B351F000C1;
 Wed,  4 Nov 2026 00:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793752390;
 bh=6laDkGu/BKKry4ynJX/JXro0q7y1Z8AqY3UvxYjlaTA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OYgGxoOEazdVU+GAVt72YqwaN5Y7FhmlLjoCsY57d+XKgzsGhsI37iIKcDUPdRA3Z
 9Kiz3xNFbUUWRTvLn+l2DzgGK6uJFaZFfx481fjRA5esBZaywP40ub32h7Mr5M+tJy
 bzDEtKSs4cBQsF7Zo6r3S1vOioLvV+scOykfHUhfR2ll8ZlHZjWjbYHlJ0xHunU6LM
 /Duoyg8A+an1Xnw+v+FGGj0JtJ0NEt3ICNFX6e3cSCAfy6VDmibYyaLI8Kw2zdVg/o
 YGtcckklEJbjQcg7EljRt4bAJpnFbboLWTWCre7bHUEOV8+lVy2BAxjaY8p5dbL+fn
 JrryamnacFMXQ==
Message-ID: <sashiko-outbox-196315@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] block: set dma-buf-io tag to block files
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <91697f770aa09d1be8f358378f1e11e0143ebe5d.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
 <91697f770aa09d1be8f358378f1e11e0143ebe5d.1793751001.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:33:09 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] block: use-after-free of bdev in blkdev_open() when bdev_open() fa=
ils
- [High] block: unpinned gendisk pointer in f_dma_io_tag allows tag ABA reu=
se
--

commit 8ffc425965529fcad78b514404dc0182c1ca1bfb
Author: Pavel Begunkov <asml.silence@gmail.com>

block: set dma-buf-io tag to block files

This commit sets filp->f_dma_io_tag to bdev->bd_disk in blkdev_open() so th=
at
dma-buf-io contexts can be shared across files and partitions belonging to =
the
same block device.

> diff --git a/block/fops.c b/block/fops.c
> index e5c27cc35ca1f..2b10b835e99dc 100644
> --- a/block/fops.c
> +++ b/block/fops.c
> @@ -686,6 +686,7 @@ static int blkdev_open(struct inode *inode, struct fi=
le *filp)
>  	ret =3D bdev_open(bdev, mode, filp->private_data, NULL, filp);
>  	if (ret)
>  		blkdev_put_no_open(bdev);
> +	filp->f_dma_io_tag =3D (unsigned long)bdev->bd_disk;

[Severity: High]
Can this trigger a use-after-free of bdev when bdev_open() fails?

In blkdev_open(), blkdev_get_no_open() acquires a reference to
bdev->bd_device and drops the temporary blockdev_superblock inode reference.
If bdev_open() returns an error (for example, when racing with disk or
partition removal, or when bdev_disk_changed() drops partitions),
blkdev_put_no_open(bdev) calls put_device(&bdev->bd_device) and drops
blkdev_open()'s only reference to bdev:

block/fops.c:blkdev_open()
    bdev =3D blkdev_get_no_open(inode->i_rdev, true);
    ...
    ret =3D bdev_open(bdev, mode, filp->private_data, NULL, filp);
    if (ret)
        blkdev_put_no_open(bdev);
            put_device(&bdev->bd_device);
                disk_release() / part_release()
                    bdev_drop(bdev);
    filp->f_dma_io_tag =3D (unsigned long)bdev->bd_disk;

Dereferencing bdev->bd_disk unconditionally after blkdev_put_no_open(bdev)
reads from bdev after it may already have been freed. Should blkdev_open()
return early on error, or set f_dma_io_tag inside bdev_open() alongside the
other bdev_file fields?

[Severity: High]
Also, is it safe to use the raw bdev->bd_disk pointer as f_dma_io_tag witho=
ut
pinning the gendisk for the lifetime of the dma_buf_io_ctx?

When a dmabuf is registered via __io_register_dmabuf(),
dma_buf_io_ctx_create() stores file->f_dma_io_tag in ctx->importer_tag and
calls into the block layer:

dma_buf_io_ctx_create()
    ctx->importer_tag =3D file->f_dma_io_tag;
    blkdev_init_dma_buf_io_ctx()
        nvme_init_dma_buf_io_ctx()
            __nvme_init_dma_buf_io_ctx()
                nvme_init_io_ctx_locked()

nvme_init_io_ctx_locked() only takes a reference to struct nvme_ctrl via
nvme_get_ctrl(ctrl); neither blkdev_init_dma_buf_io_ctx() nor
nvme_init_dma_buf_io_ctx() pins bdev->bd_disk or struct nvme_ns.

Once the registration file is closed (or dropped in __io_register_dmabuf()),
if the NVMe namespace is removed while the controller stays live (such as v=
ia
nvme_ns_remove()), del_gendisk() and put_disk() can free the struct gendisk
while ctx remains active with ctx->is_dead still false.

If a new struct gendisk is later allocated at the same address for a
different NVMe controller or a non-NVMe block device, opening that device
will assign the same address to filp->f_dma_io_tag. Subsequent I/O using the
registered dmabuf will pass dma_buf_io_file_compatible() and dispatch a
REQ_DMABUF bio carrying nvme_dmabuf_map to the unrelated block device, where
a non-NVMe driver will interpret bio->bi_io_vec (aliased with
bio->bi_dmabuf_map) as a bio_vec array. Could this cause cross-device DMA or
type confusion?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793751001.gi=
t.asml.silence@gmail.com?part=3D2
