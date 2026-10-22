Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F36606A31A
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 02:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aXUbzyKB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9915510E09F;
	Thu, 22 Oct 2026 02:53:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3784D10E09F
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 02:53:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4635D60A98;
 Thu, 22 Oct 2026 02:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8BAB1F000C1;
 Thu, 22 Oct 2026 02:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792637618;
 bh=Th+Q6rKTuH125Z1zCn2ylXxpfwXJBHCG4rNfTsaueA0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aXUbzyKB3aGcbs/tzHLiz6/h488bn/aXHj6cnVNa5RdhLwHtCYyjC56u1eNkwQBYu
 xc9+0QfsODiPwSnUZQLtCgIHh7k8THooeGsp/wRDSkmY1Yn+BiHm7tPEzU8K4uF2xS
 RI63n/+qKbOZzjkV5+uDahBML1Gtkn4nzttTPzo/mi+wHZW9QlNZDhz1WzYsSCX6QZ
 y+9SOg8xY8sNlx1FzYCE9h1spnWUf3MCATPb84sXYNcZ4Ks2VB6nSIDb/vrDMMWyPB
 FH/KftfoM1+VS0PjtFtIO6Mw2r/7zVQOuHi98OGjo0CyKLloc/dKLKtYnQEGtMHHpO
 E3bcQ8IzWe2ww==
Message-ID: <sashiko-outbox-180889@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] misc: fastrpc: drain in-flight invokes before
 tearing down context banks
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261022023531.465-3-jianping.li@oss.qualcomm.com>
References: <20261022023531.465-1-jianping.li@oss.qualcomm.com>
 <20261022023531.465-3-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 02:53:37 +0000
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
- [High] misc: fastrpc: teardown hang when invoke misses fastrpc_notify_use=
rs()
- [High] misc: fastrpc: fastrpc_rpmsg_remove() fails to drain all context-b=
ank frees
--

commit 5c02fd01b12d73075ac0b237229b9d3b84e331dc
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: drain in-flight invokes before tearing down context banks

This commit adds a teardown flag, an in-flight invoke counter, and a wait
queue to fastrpc_channel_ctx so that fastrpc_rpmsg_remove() blocks new
invocations and waits for active fastrpc_internal_invoke() calls to finish
before clearing rpdev and depopulating context bank devices.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d201f26d8e463..cffe96a181a2b 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -1365,14 +1385,25 @@ static int fastrpc_internal_invoke(struct fastrpc=
_user *fl,  u32 kernel,
>  	if (!fl->cctx->rpdev)
>  		return -EPIPE;
> =20
> +	spin_lock_irqsave(&fl->cctx->lock, flags);
> +	if (atomic_read(&fl->cctx->teardown)) {
> +		spin_unlock_irqrestore(&fl->cctx->lock, flags);
> +		return -EPIPE;
> +	}
> +	fastrpc_channel_update_invoke_cnt(fl->cctx, true);
> +	spin_unlock_irqrestore(&fl->cctx->lock, flags);
> +
>  	if (handle =3D=3D FASTRPC_INIT_HANDLE && !kernel) {
>  		dev_warn_ratelimited(fl->sctx->dev, "user app trying to send a kernel =
RPC message (%d)\n",  handle);
> -		return -EPERM;
> +		err =3D -EPERM;
> +		goto out;
>  	}
> =20
>  	ctx =3D fastrpc_context_alloc(fl, kernel, sc, args);
> -	if (IS_ERR(ctx))
> -		return PTR_ERR(ctx);
> +	if (IS_ERR(ctx)) {
> +		err =3D PTR_ERR(ctx);
> +		goto out;
> +	}

[Severity: High]
Can fastrpc_rpmsg_remove() hang in wait_event() if it runs after
fastrpc_internal_invoke() increments cctx->invoke_cnt, but before
fastrpc_context_alloc() adds ctx->node to user->pending?

In drivers/misc/fastrpc.c, fastrpc_internal_invoke() checks cctx->teardown,
increments cctx->invoke_cnt, and drops fl->cctx->lock before calling
fastrpc_context_alloc():

drivers/misc/fastrpc.c:fastrpc_context_alloc() {
	...
	ctx =3D kzalloc_obj(*ctx);
	...
	init_completion(&ctx->work);
	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);

	spin_lock(&user->lock);
	list_add_tail(&ctx->node, &user->pending);
	spin_unlock(&user->lock);
	...
}

If fastrpc_rpmsg_remove() runs on another CPU during that window (for examp=
le
while fastrpc_context_alloc() sleeps in kzalloc_obj()), it sets
cctx->teardown to 1, calls fastrpc_notify_users() once across cctx->users,
and then blocks in wait_event(cctx->ssr_wait_queue, cctx->invoke_cnt =3D=3D=
 0)
with cctx->rpdev still valid.

Because ctx->node was not on user->pending when fastrpc_notify_users() ran,
ctx->work is never completed with -EPIPE. The invoke thread then finishes
fastrpc_context_alloc(), runs fastrpc_get_args(), and calls
fastrpc_invoke_send() -> rpmsg_send() without re-checking cctx->teardown.

When rpmsg_send() succeeds (such as on a remote channel close, driver unbin=
d,
module unload, or when a glink rx intent is cached),
fastrpc_wait_for_completion() -> fastrpc_wait_for_response() enters
wait_for_completion_interruptible(&ctx->work) for user invokes and sleeps
waiting for a remote reply that will never arrive, preventing
cctx->invoke_cnt from reaching 0 and leaving fastrpc_rpmsg_remove() stuck in
wait_event().

For kernel invokes (or signal-interrupted user invokes),
fastrpc_wait_for_completion() returns -ETIMEDOUT after 10 seconds (or
-ERESTARTSYS), which skips fastrpc_context_put(ctx) at the bail label while
the out label decrements cctx->invoke_cnt to 0, allowing
fastrpc_rpmsg_remove() to proceed to of_platform_depopulate() with ctx->buf
still allocated on the context bank device.

> =20
>  	err =3D fastrpc_get_args(kernel, ctx);
>  	if (err)
> @@ -1428,6 +1459,10 @@ static int fastrpc_internal_invoke(struct fastrpc_=
user *fl,  u32 kernel,
> =20
>  	if (err)
>  		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
> +out:
> +	spin_lock_irqsave(&fl->cctx->lock, flags);
> +	fastrpc_channel_update_invoke_cnt(fl->cctx, false);
> +	spin_unlock_irqrestore(&fl->cctx->lock, flags);
> =20
>  	return err;
>  }

[ ... ]

> @@ -2678,11 +2716,25 @@ static void fastrpc_rpmsg_remove(struct rpmsg_dev=
ice *rpdev)
> =20
>  	/* No invocations past this point */
>  	spin_lock_irqsave(&cctx->lock, flags);
> -	cctx->rpdev =3D NULL;
> +	atomic_set(&cctx->teardown, 1);
>  	list_for_each_entry(user, &cctx->users, user)
>  		fastrpc_notify_users(user);
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> =20
> +	/*
> +	 * Wait for every invoke that was already past the gate to finish.
> +	 * They have all just been woken with -EPIPE, and no new one can be
> +	 * counted, so this is guaranteed to make progress.
> +	 */
> +	spin_lock_irqsave(&cctx->lock, flags);
> +	while (cctx->invoke_cnt > 0) {
> +		spin_unlock_irqrestore(&cctx->lock, flags);
> +		wait_event(cctx->ssr_wait_queue, cctx->invoke_cnt =3D=3D 0);
> +		spin_lock_irqsave(&cctx->lock, flags);
> +	}
> +	cctx->rpdev =3D NULL;
> +	spin_unlock_irqrestore(&cctx->lock, flags);

[Severity: High]
Does waiting only for cctx->invoke_cnt =3D=3D 0 in fastrpc_rpmsg_remove() s=
till
leave context-bank buffers being freed concurrently with or after
of_platform_depopulate(&rpdev->dev), or leaked when woken with -EPIPE?

There appear to be three paths in drivers/misc/fastrpc.c where ctx->buf or
other fastrpc_buf allocations on fl->sctx->dev outlive cctx->invoke_cnt:

1. In fastrpc_invoke_send(), fastrpc_context_get(ctx) takes a second
reference on ctx before calling rpmsg_send():

drivers/misc/fastrpc.c:fastrpc_invoke_send() {
	...
	fastrpc_context_get(ctx);

	ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));

	if (ret)
		fastrpc_context_put(ctx);
	...
}

If fastrpc_rpmsg_callback() runs just before teardown, it completes ctx->wo=
rk
and calls schedule_work(&ctx->put_work) to drop that second reference via
fastrpc_context_put_wq(). The woken invoke thread drops its own reference at
the bail label and decrements cctx->invoke_cnt to 0 at the out label,
allowing fastrpc_rpmsg_remove() to call of_platform_depopulate(&rpdev->dev)
while fastrpc_context_put_wq() is still running fastrpc_context_put() ->
fastrpc_context_free() -> fastrpc_buf_free(ctx->buf) -> dma_free_coherent()
against the unbound context bank.

Conversely, if rpmsg_send() succeeded and fastrpc_notify_users() wakes the
waiter with -EPIPE before fastrpc_rpmsg_callback() runs, nothing drops the
extra reference taken by fastrpc_invoke_send(). At the bail label,
list_del(&ctx->node) unlinks ctx from fl->pending and
fastrpc_context_put(ctx) only decrements ctx->refcount from 2 to 1, leaking
ctx, ctx->buf, ctx->maps, fl, and cctx.

2. If fastrpc_wait_for_completion() returns -ERESTARTSYS or -ETIMEDOUT, the
bail label skips fastrpc_context_put(ctx):

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
	...
bail:
	if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
		/* We are done with this compute context */
		spin_lock(&fl->lock);
		list_del(&ctx->node);
		spin_unlock(&fl->lock);
		fastrpc_context_put(ctx);
	}
	...
}

The out label then decrements cctx->invoke_cnt to 0 while ctx remains on
fl->pending to be freed later by fastrpc_device_release() ->
fastrpc_user_put() -> fastrpc_user_free() after of_platform_depopulate().

3. Callers of fastrpc_internal_invoke() allocate or free buffers on
fl->sctx->dev outside the cctx->invoke_cnt gate:
  - fastrpc_init_create_process() and fastrpc_req_mmap() call
    fastrpc_buf_free() on their error paths after fastrpc_internal_invoke()
    has already decremented cctx->invoke_cnt to 0 and returned -EPIPE.
  - fastrpc_device_release() calls fastrpc_release_current_dsp_process(fl)
    (which exits fastrpc_internal_invoke() and drops cctx->invoke_cnt to 0)
    and only afterwards calls fastrpc_user_put(fl) -> fastrpc_user_free(),
    which frees fl->init_mem, fl->pending, fl->maps, and fl->mmaps on
    fl->sctx->dev without blocking fastrpc_rpmsg_remove().

> +
>  	if (cctx->fdevice)
>  		misc_deregister(&cctx->fdevice->miscdev);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022023531.465-=
1-jianping.li@oss.qualcomm.com?part=3D2
