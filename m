Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A15B606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QJrBMz4K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABFA510E665;
	Wed,  4 Nov 2026 00:34:33 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B232D10F8E6
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 00:34:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F280960AB0;
 Wed,  4 Nov 2026 00:34:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78EF41F000C1;
 Wed,  4 Nov 2026 00:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793752466;
 bh=M4LuJgvmj+ttjqAkccMrTqWlYKDi2CnreyerihN7U0g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QJrBMz4KyCepQI9nupbd6MenXmy0VHNFgVOMU1BIxIh4/qOA+JkmBtK26H9LsxhCQ
 WSgVNwSMFbwRAUCB2JoWWRniB+KzBPkVoDvY6AP2h0Yv0aSFhatomnBkfRcUtgy0MV
 5J+CpigFSa7NhS61n3a7xHwxed3leI7xQZ/toar/bARicGEJHeW1ipywI5wHRhe+TU
 lCGkkvny9jBY58ywDUA20EPh3iXsyRIAxrPqPfgZyJVM7CDyR+zACIVsThuLipQOQK
 9aCZ5fiAd/+wXMZrvY9bx2FiRylsUrbhZrT7ss2SivYaMkhUi7ssZYTuUfEeDIBLwg
 HrtaAlPY5c3sg==
Message-ID: <sashiko-outbox-196316@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] io_uring/dma-buf: switch to tag file filtering
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <7165ab453cc680276b88f47f9ae89bc4967543cd.1793751001.git.asml.silence@gmail.com>
References: <cover.1793751001.git.asml.silence@gmail.com>
 <7165ab453cc680276b88f47f9ae89bc4967543cd.1793751001.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 00:34:26 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] io_uring/dma-buf: unpinned gendisk tag after fput() in __io_re=
gister_dmabuf()
- [Critical] io_uring/dma-buf: uninitialized f_dma_io_tag in init_file() al=
lows stale match
- [High] block: use-after-free of bdev in blkdev_open() after blkdev_put_no=
_open()
--

commit f539898d6b6343a21d00edd1090b62db7611212c
Author: Pavel Begunkov <asml.silence@gmail.com>

io_uring/dma-buf: switch to tag file filtering

This commit switches io_uring registered dma-buf buffers from matching the
exact registered target_file pointer to checking file compatibility via
dma_buf_io_file_compatible(), and drops target_file immediately upon
registration.

> diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
> index 6f1d21c0f558f..f25749f7da22b 100644
> --- a/io_uring/dma-buf.c
> +++ b/io_uring/dma-buf.c
> @@ -4,7 +4,6 @@ static inline void io_release_dmabuf(void *priv)
>  {
>  	struct io_buf_dma *bd =3D io_priv_to_dmabuf(priv);
> =20
> -	fput(bd->target_file);
>  	dma_buf_io_ctx_release(bd->ctx);
>  	kfree(bd);
>  }
> @@ -52,13 +51,13 @@ int __io_register_dmabuf(struct io_ring_ctx *ctx,
>  	if (ret)
>  		goto err;
> =20
> -	bd->target_file =3D target_file;
>  	imu->len =3D dmabuf->size;
>  	imu->release =3D io_release_dmabuf;
>  	imu->priv =3D bd;
>  	imu->flags =3D IO_REGBUF_F_DMABUF;
>  	imu->dir =3D IO_BUF_DEST | IO_BUF_SOURCE;
>  	dma_buf_put(dmabuf);
> +	fput(target_file);

[Severity: Critical]
Does dropping target_file in __io_register_dmabuf() instead of holding it
until io_release_dmabuf() leave the struct gendisk pointer stored in
ctx->importer_tag unpinned, allowing ABA tag aliasing if the disk is freed?

When a block device is opened, blkdev_open() sets filp->f_dma_io_tag to the
raw struct gendisk pointer:

block/fops.c:blkdev_open() {
	...
	filp->f_dma_io_tag =3D (unsigned long)bdev->bd_disk;
}

During registration, dma_buf_io_ctx_create() saves target_file->f_dma_io_tag
into ctx->importer_tag, while nvme_init_dma_buf_io_ctx() ->
nvme_init_io_ctx_locked() only calls nvme_get_ctrl(ctrl) without taking a
reference on target_file, bdev, struct gendisk, or struct nvme_ns:

drivers/nvme/host/pci-dmabuf.c:nvme_init_io_ctx_locked() {
	...
	nvme_get_ctrl(ctrl);
	list_add(&nvme_ctx->list, &buf_list->ctxs);
}

Previously, keeping bd->target_file until io_release_dmabuf() pinned bdev a=
nd
bdev->bd_disk for the lifetime of the registered buffer. With fput(target_f=
ile)
called immediately in __io_register_dmabuf(), closing target_fd and removing
the namespace (via nvme_ns_remove() -> del_gendisk() -> nvme_put_ns() ->
nvme_free_ns() -> put_disk(ns->disk)) can free the struct gendisk while
bd->ctx remains active.

If a new struct gendisk is later allocated at the same address for a
different block device (such as another NVMe controller/IOMMU domain or a
non-NVMe driver like loop, scsi, virtio_blk, or dm), opening that device wi=
ll
assign the same f_dma_io_tag address. Subsequent IORING_OP_READ_FIXED or
IORING_OP_WRITE_FIXED requests on the new file will then pass
dma_buf_io_file_compatible() in io_import_dmabuf_map() and submit REQ_DMABUF
bios (where bio->bi_dmabuf_map aliases bio->bi_io_vec with bi_max_vecs =3D=
=3D 0)
to an incompatible device or driver.

> diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
> index a97412ebbb3fb..9bd7c8c643976 100644
> --- a/io_uring/dma-buf.h
> +++ b/io_uring/dma-buf.h

[ ... ]

> @@ -63,11 +62,10 @@ static inline int io_import_dmabuf_map(struct io_kioc=
b *req,
>  				struct io_mapped_ubuf *imu,
>  				size_t len, size_t offset)
>  {
> -	struct io_buf_dma *bd =3D io_buf_to_dmabuf(imu);
> -
>  	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
>  		return -EOPNOTSUPP;
> -	if (req->file !=3D bd->target_file)
> +	if (unlikely(!dma_buf_io_file_compatible(io_buf_to_dmabuf(imu)->ctx,
> +						 req->file)))
>  		return -EBADF;

[Severity: Critical]
Can dma_buf_io_file_compatible() in io_import_dmabuf_map() match unrelated
files due to uninitialized f_dma_io_tag in init_file()?

In fs/file_table.c, alloc_empty_file() and alloc_empty_file_noaccount()
allocate struct file objects from filp_cache (which uses SLAB_TYPESAFE_BY_R=
CU
without __GFP_ZERO or a slab constructor), and init_file() initializes fiel=
ds
individually without clearing f->f_dma_io_tag:

fs/file_table.c:init_file() {
	...
	f->f_iocb_flags =3D 0;
	f->f_pos	=3D 0;
	f->f_wb_err	=3D 0;
	f->f_sb_err	=3D 0;

	file_ref_init(&f->f_ref, 1);
	return 0;
}

When a block device file is closed (including target_file after
__io_register_dmabuf() calls fput(target_file)), its struct file is returned
to filp_cache still holding its stale f_dma_io_tag value. If that struct fi=
le
is recycled for a non-block file (for example, an O_DIRECT regular file on a
filesystem backed by loop, scsi, virtio_blk, dm, or another NVMe controller=
),
req->file->f_dma_io_tag will still equal ctx->importer_tag.

Wouldn't dma_buf_io_file_compatible() then return true in
io_import_dmabuf_map(), allowing ITER_DMABUF_MAP / REQ_DMABUF bios (with
bio->bi_io_vec aliased to struct dma_buf_io_map *) to be submitted to
incompatible filesystems and block drivers?

[Severity: High]
Also related to how f_dma_io_tag is populated for dma_buf_io_file_compatibl=
e()
in this series, in block/fops.c:blkdev_open():

block/fops.c:blkdev_open() {
	...
	ret =3D bdev_open(bdev, mode, filp->private_data, NULL, filp);
	if (ret)
		blkdev_put_no_open(bdev);
	filp->f_dma_io_tag =3D (unsigned long)bdev->bd_disk;
	return ret;
}

When bdev_open() fails, blkdev_put_no_open(bdev) drops the reference on bdev
acquired by blkdev_get_no_open(). Doesn't setting filp->f_dma_io_tag =3D
(unsigned long)bdev->bd_disk right after blkdev_put_no_open(bdev) cause a
use-after-free read of bdev?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793751001.gi=
t.asml.silence@gmail.com?part=3D4
