Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78774CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 01:55:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAEF110F45C;
	Wed,  7 Oct 2026 01:55:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BOmvG/rX";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E86A010F45C
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 01:55:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4440A40614;
 Wed,  7 Oct 2026 01:55:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0BD71F0089B;
 Wed,  7 Oct 2026 01:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791338149;
 bh=hBuMQRzwG0StiTPeTBoDnGYaN7fXXnV4UOL36DBnbtQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BOmvG/rXfD956oYnYxszQhv9fGmlqq+evZOOlhj3y0WcVQzdfKXSa2+yOcOyTvUIG
 LGONRLpUxUW2O9xsgF0gae857HZ6QhyeQGbb0RJD7siHDca0PIflvx0KqRtad58OK9
 66vwq7znoRxsJgcYWmyZdQKg/GNFksBpHgMZQXFvrHhqaiSaYmRnZ839Bey6VI3cn6
 /r4SWZNbciK38tE31FVGbWbOrOjEpQ1a0RE6Ms2IEBN+Y0BKu7Vynm8u5aL0oz4qKy
 HYxcLrHyE8htRxQ3PNoVK/XtPIAuCxYdOSkohBMBIm0f1P83G3H2/FwQ14T0iwIgUI
 eTy0wY3xnPwKg==
Message-ID: <sashiko-outbox-162573@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 13/13] io_uring/rsrc: add dmabuf backed registered
 buffers
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <a71d400980af9de2724bcc5d201040a930eecaf4.1791336930.git.asml.silence@gmail.com>
References: <cover.1791336930.git.asml.silence@gmail.com>
 <a71d400980af9de2724bcc5d201040a930eecaf4.1791336930.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 01:55:48 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] io_uring/rw: dmabuf_map memory leak upon request reissue overwriti=
ng req->dmabuf_map
- [High] io_uring/rsrc: dmabuf_map leak via cloning dmabuf to IOPOLL ring b=
ypassing restrictions
--

commit 6cf565430e55d29c9af3badb73c4c8775d233005
Author: Pavel Begunkov <asml.silence@gmail.com>

    io_uring/rsrc: add dmabuf backed registered buffers
   =20
    Implement dmabuf backed registered buffers. To register them, the user
    should specify IO_REGBUF_TYPE_DMABUF for the regitration and pass the
    desired dmabuf fd and a file for which it should be registered.

> diff --git a/io_uring/dma-buf.c b/io_uring/dma-buf.c
> index 0000000000000..f40c9d87ed8aa
> --- /dev/null
> +++ b/io_uring/dma-buf.c
[ ... ]
> +int io_register_dmabuf(struct io_ring_ctx *ctx,
> +			struct io_uring_regbuf_desc *desc,
> +			struct io_mapped_ubuf *imu)
> +{
[ ... ]
> +	if (ctx->flags & IORING_SETUP_IOPOLL)
> +		return -EOPNOTSUPP;
[ ... ]
> +	bd->target_file =3D target_file;
> +	imu->len =3D dmabuf->size;
> +	imu->release =3D io_release_dmabuf;
> +	imu->priv =3D bd;
> +	imu->flags =3D IO_REGBUF_F_DMABUF;
> +	imu->dir =3D IO_BUF_DEST | IO_BUF_SOURCE;
> +	dma_buf_put(dmabuf);
> +	return 0;

[Severity: High]
Should IO_REGBUF_F_UNCLONEABLE be included in imu->flags here to prevent=20
IOPOLL rings from cloning this buffer?

While io_register_dmabuf() explicitly rejects rings with IORING_SETUP_IOPOL=
L=20
set during initial registration, omitting the uncloneable flag allows an=20
IOPOLL ring to bypass this restriction by cloning the dmabuf via=20
io_clone_buffers().

If the buffer is cloned to an IOPOLL ring, polled I/O requests will finish=
=20
via io_complete_rw_iopoll(), which does not call io_detach_dmabuf_map(req)=
=20
(unlike io_complete_rw). Does this result in a permanent leak of the=20
dma_buf_io_map reference for any async polled request?

> diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
> index 0000000000000..10d2efdd8c9f1
> --- /dev/null
> +++ b/io_uring/dma-buf.h
[ ... ]
> +static inline int io_attach_dmabuf_map(struct io_kiocb *req,
> +					struct iov_iter *iter,
> +					unsigned issue_flags)
> +{
[ ... ]
> +	bd =3D req->buf_node->buf->priv;
> +	map =3D dma_buf_io_get_map(bd->ctx, nowait);
> +	if (unlikely(IS_ERR(map)))
> +		return PTR_ERR(map);
> +	req->dmabuf_map =3D map;
> +	iter->dmabuf_map =3D map;
> +	return 0;
> +}

[Severity: High]
Could this overwrite and leak the previous req->dmabuf_map if the request=20
is reissued?

When a read or write request encounters a reissue condition, it returns=20
-EIOCBQUEUED. In io_read_fixed() and io_write_fixed(), this causes it to=20
skip calling io_detach_dmabuf_map().

When the request is subsequently reissued, it executes io_init_rw_fixed()=20
again, which unconditionally calls io_attach_dmabuf_map(). This fetches a=20
new map and overwrites req->dmabuf_map without dropping the previous=20
reference.

Would it make sense to check if req->dmabuf_map is already populated before=
=20
requesting and assigning a new map, or to ensure it is detached before=20
reassignment?

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 432820f862514..ba0e3e7de557d 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
[ ... ]
> @@ -363,13 +364,18 @@ static int io_init_rw_fixed(struct io_kiocb *req, u=
nsigned int issue_flags,
>  	struct io_async_rw *io =3D req->async_data;
>  	int ret;
> =20
> -	if (io->bytes_done)
> -		return 0;
> +	if (!io->bytes_done) {
> +		ret =3D __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
> +					  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
> +		if (ret)
> +			return ret;
> +		iov_iter_save_state(&io->iter, &io->iter_state);
> +	}
> =20
> -	ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
> -				issue_flags);
> -	iov_iter_save_state(&io->iter, &io->iter_state);
> -	return ret;
> +	ret =3D io_attach_dmabuf_map(req, &io->iter, issue_flags);
> +	if (ret)
> +		return ret;
> +	return 0;
>  }
[ ... ]
> @@ -1231,7 +1239,10 @@ int io_read_fixed(struct io_kiocb *req, unsigned i=
nt issue_flags)
>  	if (unlikely(ret))
>  		return ret;
> =20
> -	return io_read(req, issue_flags);
> +	ret =3D io_read(req, issue_flags);
> +	if (ret !=3D -EIOCBQUEUED)
> +		io_detach_dmabuf_map(req);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791336930.gi=
t.asml.silence@gmail.com?part=3D13
