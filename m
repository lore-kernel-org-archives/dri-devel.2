Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA87CA5FA2
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 14:04:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9A510E0C6;
	Mon, 28 Sep 2026 14:04:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GVB9k1zh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 131D610E0C6
 for <dri-devel@lists.freedesktop.org>; Mon, 28 Sep 2026 14:04:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D050E4183F;
 Mon, 28 Sep 2026 14:03:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 884F61F000FF;
 Mon, 28 Sep 2026 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790604239;
 bh=/WeJzN1uvcicAm7yj+fD8dy8nhPbclteUW1I7r2fMAY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GVB9k1zhWWDxLCa5/5bQUJcDNa9tZu3XJINUHNCfa30bEi0pSf1aIlXrCGvPEh03v
 fVf1vgSSg7BuUBJhywg+ApevisO9jNJl5JtPV4f8OsKINTYaA8UkMYb8Za7959Gs8u
 N+4I5yHSgFCEz0GCZi55OEFEYiJl0Fi4NVpeAJ4T3YZP6EoXSvFWreXDr+0lHQ3fbH
 pWTXCbYdWrBHPDGK8EFZImTwqb5g/N+4yAlV7AHNaDnKfSGvJUd2evqATZwhisEelv
 33lPaZnadNiXwn6h/4WNjg7yw+yudb0HLKXoP9lARnxkij0U6vO1gohtA19qKQ1eZe
 ZmvrU7ycjInmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/13] io_uring/rsrc: add dmabuf backed registered
 buffers
To: "Pavel Begunkov" <asml.silence@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <f51f95d2e5e2f8c0c4fe0e17364b2b333b6e6cd6.1790602223.git.asml.silence@gmail.com>
References: <cover.1790602223.git.asml.silence@gmail.com>
 <f51f95d2e5e2f8c0c4fe0e17364b2b333b6e6cd6.1790602223.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Sep 2026 14:03:59 +0000
Message-Id: <20260928140359.884F61F000FF@smtp.kernel.org>
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
- [High] io_uring: UAF of dmabuf map on async I/O reissue with partial prog=
ress
- [High] io_uring: UAF of driver module due to fput() race in io_release_re=
g_dmabuf()
--

commit 72563100c98fb5b83c9261811926c28b98fe4b8b
Author: Pavel Begunkov <asml.silence@gmail.com>

io_uring/rsrc: add dmabuf backed registered buffers

This commit introduces support for dmabuf-backed registered buffers, allowi=
ng
users to register a dmabuf file descriptor and a target file. Direct I/O
requests can then be issued against the target file using standard io_uring
fixed read/write opcodes.

> diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
> index 6e4fe70b316f0..535cc94a1421f 100644
> --- a/io_uring/rsrc.c
> +++ b/io_uring/rsrc.c

[ ... ]

> +static void io_release_reg_dmabuf(void *priv)
> +{
> +	struct io_regbuf_dma *db =3D priv;
> +
> +	fput(db->target_file);
> +	dma_buf_io_ctx_release(db->ctx);

[Severity: High]
Could this sequence create a race condition with module unloading?

If fput() is called during process exit (PF_EXITING), it might schedule
delayed_fput_work on the system workqueue. A concurrent worker thread could
execute __fput(), dropping the final module reference of
target_file->f_op->owner.

If that happens, and the original thread then proceeds to call
dma_buf_io_ctx_release(db->ctx) which invokes ctx->dev_ops->release(ctx),
would this execute unmapped memory if the target module is unloaded in the
interim?

> +	kfree(db);
> +}

[ ... ]

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index 755166e90746e..9867ae2905e31 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -367,8 +367,8 @@ static int io_init_rw_fixed(struct io_kiocb *req, uns=
igned int issue_flags,
>  	if (io->bytes_done)
>  		return 0;

[Severity: High]
Does this early return leave a dangling pointer in the iterator if the
request is being reissued after partial progress?

If an async I/O request on a dmabuf-backed fixed buffer makes partial
progress (io->bytes_done > 0) but then completes asynchronously with
-EAGAIN, it appears io_complete_rw() unconditionally calls
io_req_drop_dmabuf(), dropping the map reference.

When the request is caught and requeued to io-wq (because
__io_complete_rw_common() marks it with REQ_F_REISSUE), returning
early here bypasses io_import_dmabuf(). Would the iterator then retain
a dangling pointer to the previously freed map, leading to a
use-after-free when the block layer processes the remaining bytes?

> =20
> -	ret =3D io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
> -				issue_flags);
> +	ret =3D __io_import_reg_buf(req, &io->iter, rw->addr, rw->len, ddir,
> +				  issue_flags, IO_REGBUF_IMPORT_ALLOW_DMABUF);
>  	iov_iter_save_state(&io->iter, &io->iter_state);
>  	return ret;
>  }

[ ... ]

> @@ -583,6 +583,8 @@ static void io_complete_rw(struct kiocb *kiocb, long =
res)
>  	struct io_rw *rw =3D container_of(kiocb, struct io_rw, kiocb);
>  	struct io_kiocb *req =3D cmd_to_io_kiocb(rw);
> =20
> +	io_req_drop_dmabuf(req);

[Severity: High]
Is it safe to unconditionally drop the dmabuf map here before checking if
the request will be reissued?

If this request made partial progress but completes with -EAGAIN,
__io_complete_rw_common() will see the result and set REQ_F_REISSUE.
Since io_req_drop_dmabuf() has already dropped the map, would the
reissued request in io-wq end up with a dangling map reference if
io_init_rw_fixed() skips re-importing it?

> +
>  	/* ring owner may block in freeze_super() before task_work runs */
>  	if (kiocb->ki_flags & IOCB_WRITE)
>  		io_req_end_write(req);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790602223.gi=
t.asml.silence@gmail.com?part=3D13
