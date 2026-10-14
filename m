Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A24CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:19:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D27710E36D;
	Wed, 14 Oct 2026 11:18:59 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE13710E36D
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 11:18:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8B11601F9;
 Wed, 14 Oct 2026 11:18:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C1DA1F000FF;
 Wed, 14 Oct 2026 11:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791976731;
 bh=liIrN1uwJuPUomyt2KZDkh4qqlX40hT3MzPS8I2CUUg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iiQMLR+qagnMXIm3t8OzNd+pETxb60lJCnoTgBA0dOzAtvuo9ANmjtFKXh1DTp5Eu
 sg23wf+RZ2crHNladw0MbU8UQ238URQ82N+ALhnXNrsCdKpJyAJgMWiSAboOnW2SuB
 DsYnJHKvxNv8Vt9HxrqPcbQKvxMV5p6XkY3WZG/9aaveUIWwxcvw6AW6IFw6CL6BTI
 o5LZEGhQqRSJoaglQAFUOSgfuB5YoI/sgOg5tPpQgPj4ccAaoTFF1qg+0AeQzROES3
 KSFYlAQGS0u2CA67NgY3ji8TtwBVa6ffyGHFcHEKYjD3bYl57ofYwrvkuGbl3tYhmh
 YEDCaQgLBAFPQ==
Message-ID: <sashiko-outbox-171190@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 13/13] io_uring/rsrc: add dmabuf backed registered
 buffers
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
References: <cover.1791975048.git.asml.silence@gmail.com>
 <4aa230df871ee275536f367087b44ebfebb88cc1.1791975048.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 14 Oct 2026 11:18:50 +0000
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
- [High] io_uring/rw: dmabuf_map leaked on page waitqueue retry and cancell=
ation
--

commit 671f0754c33400252fbbb2aab640bc25813b29e5
Author: Pavel Begunkov <asml.silence@gmail.com>

    io_uring/rsrc: add dmabuf backed registered buffers

    Implement dmabuf backed registered buffers. To register them, the user
    should specify IO_REGBUF_TYPE_DMABUF for the regitration and pass the
    desired dmabuf fd and a file for which it should be registered.

> diff --git a/io_uring/dma-buf.h b/io_uring/dma-buf.h
> new file mode 100644
> index 0000000000000..a876a9e5e272b
> --- /dev/null
> +++ b/io_uring/dma-buf.h
[ ... ]
> +static inline int io_attach_dmabuf_map(struct io_kiocb *req,
> +					struct iov_iter *iter,
> +					unsigned issue_flags)
> +{
> +	bool nowait =3D issue_flags & IO_URING_F_NONBLOCK;
> +	struct dma_buf_io_map *map;
> +	struct io_buf_dma *bd;
> +
> +	if (!IS_ENABLED(CONFIG_DMA_SHARED_BUFFER))
> +		return -EOPNOTSUPP;
> +	if (!(req->flags & REQ_F_DMABUF))
> +		return 0;
> +
> +	bd =3D req->buf_node->buf->priv;
> +	map =3D dma_buf_io_get_map(bd->ctx, nowait);
> +	if (unlikely(IS_ERR(map)))
> +		return PTR_ERR(map);
> +	req->dmabuf_map =3D map;

[Severity: High]
If a request is re-issued (for example, after returning -EIOCBQUEUED and be=
ing
woken up by the waitqueue), io_init_rw_fixed() is called again and=20
unconditionally invokes io_attach_dmabuf_map().=20

Does this overwrite req->dmabuf_map with a new reference without dropping t=
he
old one, causing a memory leak of the dma_buf_io_map reference?

> +	iter->dmabuf_map =3D map;
> +	return 0;
> +}
[ ... ]
> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 432820f862514..ba0e3e7de557d 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
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

[Severity: High]
When io_read() arms a page waitqueue (e.g., via io_rw_should_retry()) and
returns -EIOCBQUEUED, the dmabuf map reference is deliberately not dropped =
here.

If the request is later cancelled while on the waitqueue, does this cause a
memory leak? The cleanup handler invoked on cancellation via io_clean_op()
(which is io_readv_writev_cleanup() for IORING_OP_READ_FIXED) doesn't appear
to clean up req->dmabuf_map.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1791975048.gi=
t.asml.silence@gmail.com?part=3D13
