Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49343606A327
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 12:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ePgCL3vV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E57310E596;
	Tue, 24 Nov 2026 12:36:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0A40A10E596
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 12:36:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C83AD422AC;
 Tue, 24 Nov 2026 12:36:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828FB1F000E0;
 Tue, 24 Nov 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795523810;
 bh=esNlpMxpuPAwG0d5022Lct0R6Kw3yB/PYvCjsvFJisg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ePgCL3vV25FCG58AVFciiZIEBsud7pvCq23JB4v+w2m6cMwZ5PcSovlC1CXtOcQ9z
 V0mOKH39Pe9V22Pqdq6cuUw3jTVKtHP/sJ0eRuu7BkJL/X+nIUalNXZOJhjlCajD7q
 pnFJjNQzgNxPfCKuuY+ZXeX3j0s5uqQrzqhc4ah0cR5pY+IQusXYi11mE81P5QcvgI
 C+ubKGJNE4pIsaO1XJXmwcwUqeyQXCbjWgV1s/9AsTTMTTv5rVhMSKF1hkwd/gdzD8
 HDO52rx7eaAaDGluUvvkYhAO4Gk7zS49J34uzgJ+w+Ug78MaFn2LKToENRPJbJhV7f
 sQkWsNVofmaOg==
Message-ID: <sashiko-outbox-231156@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: fix fastrpc_user leak on abnormal
 process exit
To: =?utf-8?b?UmVuw6ogZGUgU291emEgUGludG8=?= <rene@renesp.com.br>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261124122011.2912030-1-rene@renesp.com.br>
References: <20261124122011.2912030-1-rene@renesp.com.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:36:50 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] misc: fastrpc: premature fastrpc_session_free() before
  fastrpc_user_free()
- [Low] misc: fastrpc: dead fl->pending cleanup loop left in
  fastrpc_user_free()
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] misc: fastrpc: memory leak of handle maps in
  fastrpc_context_free() [1]
--

commit de1f1f214d7656b3f51116b41f6e566209ceb0a7
Author: Ren=C3=AA de Souza Pinto <rene@renesp.com.br>

misc: fastrpc: fix fastrpc_user leak on abnormal process exit

This commit drains fl->pending in fastrpc_device_release() and drops each
pending invoke context's reference so that the reference cycle between
fastrpc_invoke_ctx and fastrpc_user is broken when a file descriptor is
closed.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 9e760f68bcaf2..05271beaf821c 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1734,7 +1734,9 @@ static int fastrpc_device_release(struct inode *ino=
de, struct file *file)
>  {
>  	struct fastrpc_user *fl =3D (struct fastrpc_user *)file->private_data;
>  	struct fastrpc_channel_ctx *cctx =3D fl->cctx;
> +	struct fastrpc_invoke_ctx *ctx, *n;
>  	unsigned long flags;
> +	LIST_HEAD(orphans);
> =20
>  	fastrpc_release_current_dsp_process(fl);
> =20
> @@ -1742,6 +1744,20 @@ static int fastrpc_device_release(struct inode *in=
ode, struct file *file)
>  	list_del(&fl->user);
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> =20
> +	/*
> +	 * Pending (interrupted or timed out) contexts can't be resumed anymore
> +	 * and each holds a reference on the user: release them here to avoid
> +	 * a cycle.
> +	 */
> +	spin_lock(&fl->lock);
> +	list_splice_init(&fl->pending, &orphans);
> +	spin_unlock(&fl->lock);
> +
> +	list_for_each_entry_safe(ctx, n, &orphans, node) {
> +		list_del_init(&ctx->node);
> +		fastrpc_context_put(ctx);
> +	}

[Severity: Low]
Now that fastrpc_device_release() drains fl->pending and every context on
fl->pending holds a reference on fl until fastrpc_context_free(),
fl->pending is always empty when fastrpc_user_free() runs.  Should the
duplicate fl->pending loop in fastrpc_user_free() and the forward
declaration of fastrpc_context_put() be removed?

[Severity: High]
This problem wasn't introduced by this patch, but can
fastrpc_context_free() leak handle maps [1] when an invocation fails
early or is aborted here before fastrpc_put_args() runs?

fastrpc_create_maps() populates ctx->maps up to ctx->nscalars, attaching
handle maps at indices ctx->nbufs through ctx->nscalars - 1 via
fastrpc_map_attach(), but fastrpc_context_free() only releases entries up
to ctx->nbufs:

drivers/misc/fastrpc.c:fastrpc_context_free() {
	...
	for (i =3D 0; i < ctx->nbufs; i++)
		fastrpc_map_put(ctx->maps[i]);
	...
}

When the invocation never reaches fastrpc_put_args(), those handle map
references and their pinned DMA buffers are never released.

> +
>  	fastrpc_session_free(cctx, fl->sctx);
>  	file->private_data =3D NULL;
>  	/* Release the reference taken in fastrpc_device_open */

[Severity: Medium]
Can calling fastrpc_session_free() here still hand the session and its
SMMU context bank to a new process before the old process's buffers are
unmapped?

When an orphaned context on fl->pending is still waiting for a DSP
response (or its ctx->put_work work item has not yet run),
fastrpc_context_get() taken in fastrpc_invoke_send() keeps ctx->refcount
above zero until fastrpc_context_put_wq() runs.  Because ctx holds a
reference on fl until fastrpc_context_free(), and commit e85eb5feca8e
("misc: fastrpc: fix use-after-free of fastrpc_user in workqueue context")
moved the teardown of fl->init_mem, fl->maps, and fl->mmaps into
fastrpc_user_free(), marking fl->sctx->used =3D false in
fastrpc_device_release() allows fastrpc_session_alloc() to reuse the
session while its IOVA space is still occupied by the exiting user's
mappings.  Should fastrpc_session_free() be called in fastrpc_user_free()
after the user's maps and buffers have been freed instead?

[1] https://sashiko.dev/#/bug/linux-9b1d78f7-f355-4424-acce-4fd9aa48eac5

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124122011.2912=
030-1-rene@renesp.com.br?part=3D1
