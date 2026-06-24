Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC49ECDB47F
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:10:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22A7F10E122;
	Wed, 24 Jun 2026 19:10:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c2xJfCAc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B95810E122
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:10:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8EE4C60018;
 Wed, 24 Jun 2026 19:10:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F46B1F000E9;
 Wed, 24 Jun 2026 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782328213;
 bh=Tuy4xXgYf99GgjxbMRH9mgPLPQEOS+b6fFbopiPGeKk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c2xJfCAcq7jRUy58vYwM2hD/xBH6U8eIygxeauRmA/MsPpjQVAKpfdPEXCwkK3fn+
 juJbwNfJdhpBHYoJ5lQbtjfisy97/4WxoP30JDwuSP02z08p2q827j8myjToNFvhey
 yB7+PKPYnFX068jqZRjMhkx+0hyIlzcfWx53zaolf/7Yv/3C+lLg49ZUZ1hDV91LYv
 Z7ikGI4zXaa8TH4ubKJnp+uAmewwR5C+k1K7tepbrGauOUIUdn0hvBLMUmJnPtyrvi
 YKz2MpKl91/91IhtbOlZSbK4qXWEkYgvvVqiOaYQ/XMU5vtwvRLqmXiGAa3kfJNvON
 I0xcNGMuMiqmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: initialize invoke refcount before publish
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624185427.1451-1-alhouseenyousef@gmail.com>
References: <20260624185427.1451-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:10:12 +0000
Message-Id: <20260624191013.2F46B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

New issues:
- [Critical] The patch transforms a refcount underflow warning into an expl=
oitable Use-After-Free (UAF) and list corruption by prematurely freeing the=
 context on an early DSP response.

Pre-existing issues:
- [Critical] `fastrpc_rpmsg_callback()` is vulnerable to duplicate or late =
DSP responses, leading to Use-After-Free vulnerabilities.
- [High] If `fastrpc_internal_invoke()` is interrupted by a signal or times=
 out, the `fastrpc_invoke_ctx` and its associated `fastrpc_user` are perman=
ently leaked, leading to local DoS.
- [High] When the DSP crashes or is removed, pending `fastrpc_invoke_ctx` o=
bjects are permanently leaked.
--

commit 285340b375fb7017cf7735f77379c860ac74a67c
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: initialize invoke refcount before publish

fastrpc_context_alloc() adds a new invoke context to the pending list
and the channel IDR before initializing its refcount. Initialize the
refcount before publishing the context to prevent a racing DSP
response from dropping a reference before kref_init() has run.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..9f2929cb39d93 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -690,6 +690,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_all=
oc(
>  	ctx->cctx =3D cctx;
>  	init_completion(&ctx->work);
>  	INIT_WORK(&ctx->put_work, fastrpc_context_put_wq);
> +	kref_init(&ctx->refcount);
> =20
>  	spin_lock(&user->lock);
>  	list_add_tail(&ctx->node, &user->pending);
> @@ -705,8 +706,6 @@ static struct fastrpc_invoke_ctx *fastrpc_context_all=
oc(
>  	ctx->ctxid =3D ret << 4;

[Severity: Critical]
By moving kref_init() before idr_alloc_cyclic(), does this introduce a
Use-After-Free?

If a delayed or duplicate DSP response arrives immediately after
idr_alloc_cyclic() returns, fastrpc_rpmsg_callback() can find the context
in the IDR and schedule put_work. This would drop the refcount to 0,
prematurely freeing the context while the allocating thread continues execu=
tion:

drivers/misc/fastrpc.c:fastrpc_context_alloc() {
    ...
    kref_init(&ctx->refcount);
    ...
    ret =3D idr_alloc_cyclic(&cctx->ctx_idr, ctx, ...);
   =20
    // DSP response arrives here, drops the only reference, freeing ctx
   =20
    ctx->ctxid =3D ret << 4; // Use-After-Free
}

Prior to this change, the uninitialized refcount prevented the free.

>  	spin_unlock_irqrestore(&cctx->lock, flags);
> =20
> -	kref_init(&ctx->refcount);
> -
>  	return ctx;

[Severity: Critical]
This is a pre-existing issue, but is fastrpc_rpmsg_callback() vulnerable to
duplicate or late DSP responses?

When a response arrives, it looks up the context and blindly schedules put_=
work
without checking if a response is expected or removing the context from the=
 IDR:

drivers/misc/fastrpc.c:fastrpc_rpmsg_callback() {
    ...
    ctx =3D idr_find(&cctx->ctx_idr, ctxid);
    ...
    schedule_work(&ctx->put_work);
}

If a faulty DSP sends multiple responses for the same ID, could this schedu=
le
put_work multiple times and lead to a Use-After-Free?


[Severity: High]
This isn't a bug introduced by this patch, but does fastrpc_internal_invoke=
()
leak the context on signals or timeouts?

If wait_for_completion_interruptible() returns -ERESTARTSYS or -ETIMEDOUT, =
the
error path intentionally bypasses dropping the context reference:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
    ...
    if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
        spin_lock(&fl->lock);
        list_del(&ctx->node);
        spin_unlock(&fl->lock);
        fastrpc_context_put(ctx);
    }
}

Since fastrpc_context_alloc() takes a reference on fastrpc_user, does this
create a permanent reference cycle that prevents fastrpc_user_free() from e=
ver
being called, potentially allowing an unprivileged user to exhaust IDR slot=
s?


[Severity: High]
This is a pre-existing issue, but are pending contexts permanently leaked w=
hen
the DSP crashes or is removed?

fastrpc_invoke_send() takes a reference on the context on behalf of the DSP:

drivers/misc/fastrpc.c:fastrpc_invoke_send() {
    ...
    fastrpc_context_get(ctx);
    ret =3D rpmsg_send(...);
}

When the DSP is removed, fastrpc_rpmsg_remove() notifies users but doesn't
appear to drop this extra reference:

drivers/misc/fastrpc.c:fastrpc_rpmsg_remove() {
    ...
    list_for_each_entry(user, &cctx->users, user)
        fastrpc_notify_users(user);
}

Since the DSP will never respond, does this leave the in-flight contexts and
their parent structures permanently leaked?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624185427.1451=
-1-alhouseenyousef@gmail.com?part=3D1
