Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81917C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 13:54:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A09AC10E665;
	Mon, 21 Sep 2026 13:54:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="X58QFdrd";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8136210E7EA
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 13:54:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 69F0F416AC;
 Mon, 21 Sep 2026 13:54:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 220561F000FF;
 Mon, 21 Sep 2026 13:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789998870;
 bh=H0+/Z/oUSTZncY0D9CvbXNmSZbKfpCjmCGVso72qRxA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=X58QFdrdNbVV354oJhiLv67E3qiYHgJ4SCmG3ZzF0laMTHAkYeDyrYIoHr378eKy9
 PWf+46kSxY+6Oi7rpOu2B9k8XoDoYW+6V9ghis4uq7dUkunNUl2PgQl0JrmSNt0Sux
 8rXCr1taC1v4Qn6/XdmnjndFcrWYwBXsO48cyBBrs3nOCDMRosIv6Lq+jM5HBgOxal
 fMVS5nkIAU0uhs0ER/uSrsUlxDp6DdWcoSc77/7Lf4I5DPiI8G4kElEbaefwyHu6B5
 yHgVqvtLQH0JCNpnFTD/1JXiiHHQod6MryJuXZQEKpYku7SdBKZ/nLtSopszUaHqb7
 YM4fVkfbomd5Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] io_uring/rsrc: add dmabuf backed registered
 buffers
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <0d82253d5e930981e6a21503e145a1ebd280f995.1789997898.git.asml.silence@gmail.com>
References: <cover.1789997898.git.asml.silence@gmail.com>
 <0d82253d5e930981e6a21503e145a1ebd280f995.1789997898.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 13:54:29 +0000
Message-Id: <20260921135430.220561F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] io_uring: memory leak of io_regbuf_dma in io_release_reg_dmabuf()
--

commit 9778a7461fd88cbd1c8b6991ebea933808628a8d
Author: Pavel Begunkov <asml.silence@gmail.com>

io_uring/rsrc: add dmabuf backed registered buffers

This commit implements dmabuf-backed registered buffers, allowing them to be
used with io_uring fixed read/write requests. It introduces a new buffer ty=
pe
IO_REGBUF_TYPE_DMABUF to set up a DMA map against a specific target file.

> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 79e3c686ecc15..cb7495df13b71 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c
[ ... ]
> +static void io_release_reg_dmabuf(void *priv)
> +{
> +	struct io_regbuf_dma *db =3D priv;
> +
> +	fput(db->target_file);
> +	dma_buf_io_ctx_release(db->ctx);

[Severity: Medium]
Does this code leak the io_regbuf_dma structure?

The db structure is dynamically allocated via kzalloc() in io_register_dmab=
uf()
and assigned to imu->priv. When a user unregisters a dmabuf-backed register=
ed
buffer, this release callback drops the file and context references, but do=
esn't
seem to free the db structure itself. Should this include a call to kfree(d=
b)?

> +}
> +
> +static struct io_rsrc_node *io_register_dmabuf(struct io_ring_ctx *ctx,
> +						struct io_uring_regbuf_desc *desc)
> +{
[ ... ]
> +	regbuf =3D kzalloc(sizeof(*regbuf), GFP_KERNEL);
> +	if (!regbuf)
> +		goto err;
[ ... ]
> +	imu->release =3D io_release_reg_dmabuf;
> +	imu->priv =3D regbuf;
> +	imu->flags =3D IO_REGBUF_F_DMABUF;
> +	imu->dir =3D IO_BUF_DEST | IO_BUF_SOURCE;
> +	refcount_set(&imu->refs, 1);
> +	node->buf =3D imu;
> +	dma_buf_put(dmabuf);
> +	return node;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1789997898.gi=
t.asml.silence@gmail.com?part=3D13
