Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76930CDB479
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 19:41:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D868710E113;
	Wed, 24 Jun 2026 19:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="KuBAXaPH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5EB4310E113
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 19:41:45 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 40FA64344E;
 Wed, 24 Jun 2026 19:41:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8BA1F000E9;
 Wed, 24 Jun 2026 19:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782330105;
 bh=7yi7XI59lRX15qkAkHVLyZVtGvK11tC4a9efwSlKIfA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=KuBAXaPH5zRE/0k75QUyeSAGWZw4/UzwB9Iom91XSprco1eJVlkR0b0bZ7w56L8fh
 ItZ5AwR79AEmTFRYutpzug4d8RBRIC3uuyr2MqAHJGTFM2Hez6UpyFeAGCO2yUnWCB
 PXLrSt+dENM/ar6naEn6zvjzYR/Y5/iWqt1ZkIf4Fez/klLYzZYOgfzQ2MJL+krp9m
 kq9MlG/NnWwpe4eSD8sKt3u63vnR3jOAB6CBBStzqHyAvn7Gunrm9DIkWtK82oWpag
 e5lnd/9LbMe8zIIW2+S6/COwX3nmZNUbPgKHe3S1N4eyWI+S5WMXWiBVllW8HB+t8k
 clpN7crTs/KvQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] misc: fastrpc: release pending invoke refs on rpmsg
 removal
To: "Yousef Alhouseen" <alhouseenyousef@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624192700.5388-1-alhouseenyousef@gmail.com>
References: <20260624192700.5388-1-alhouseenyousef@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 19:41:44 +0000
Message-Id: <20260624194145.0E8BA1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [Critical] Blind asynchronous `put_work` scheduling on 0-refcount context=
s causes a Use-After-Free and Double Free.
- [Critical] Premature drop of the send reference breaks callback lifecycle=
 assumptions, leading to a Use-After-Free.
- [High] The patch introduces a build failure by using undefined struct fie=
lds, and its logic is broken because the normal callback path does not inte=
ract with the new fields.

Pre-existing issues:
- [Critical] A compromised DSP can trigger a Use-After-Free by sending dupl=
icate replies for the same context.
- [High] TOCTOU race condition causing a NULL pointer dereference of `cctx-=
>rpdev` during concurrent endpoint removal.
- [High] Timed-out or interrupted invocations permanently leak contexts due=
 to a circular reference.
--

commit 560fa1b03e675a7c5d337410e599f919e4a647ef
Author: Yousef Alhouseen <alhouseenyousef@gmail.com>

misc: fastrpc: release pending invoke refs on rpmsg removal

fastrpc_rpmsg_remove() wakes pending invoke waiters when the rpmsg device
is removed, but it does not release the send references taken before each
request was submitted. Those references normally disappear only when a DSP
reply arrives, which cannot be relied on after endpoint removal.

Walk the channel IDR during removal, mark in-flight contexts completed,
and schedule the send-reference put while waking waiters with -EPIPE. This
prevents disconnected channels from pinning invoke contexts indefinitely.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..95e727fa09cc6 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2484,30 +2484,31 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
>  	return err;
>  }
> =20
> -static void fastrpc_notify_users(struct fastrpc_user *user)
> +static int fastrpc_notify_context(int id, void *ptr, void *data)
>  {
> -	struct fastrpc_invoke_ctx *ctx;
> +	struct fastrpc_invoke_ctx *ctx =3D ptr;
> =20
> -	spin_lock(&user->lock);
> -	list_for_each_entry(ctx, &user->pending, node) {
> -		ctx->retval =3D -EPIPE;
> -		complete(&ctx->work);
> +	if (ctx->sent && !ctx->completed) {

[Severity: High]
Does this patch fail to compile?  Looking at struct fastrpc_invoke_ctx, the
fields sent and completed do not appear to exist.

If these fields were manually added to fix the build, does this logic still
introduce a refcount underflow?  If fastrpc_rpmsg_callback() receives a nor=
mal
reply, it does not seem to set ctx->completed =3D true.  Would a concurrent
execution of fastrpc_notify_context() see !ctx->completed and schedule
put_work concurrently with the callback, causing double execution of
fastrpc_context_put()?

> +		ctx->completed =3D true;
> +		schedule_work(&ctx->put_work);

[Severity: Critical]
Can this schedule put_work on a context that has already reached a refcount
of zero?

When a context's refcount drops to zero, fastrpc_context_free() is executed:

fastrpc_context_free() {
    ...
    spin_lock_irqsave(&cctx->lock, flags);
    idr_remove(&cctx->ctx_idr, ctx->ctxid >> 4);
    spin_unlock_irqrestore(&cctx->lock, flags);
    ...
}

If fastrpc_rpmsg_remove() acquires cctx->lock first, could idr_for_each() p=
ass
the zero-refcount context to fastrpc_notify_context() before it is removed
from the IDR?  Since schedule_work() is called without using
kref_get_unless_zero(), wouldn't put_work execute fastrpc_context_put() on a
dying object, underflowing the refcount and executing fastrpc_context_free()
again?

[Severity: Critical]
Does prematurely dropping the send reference break the lifecycle assumptions
of the callback?

Looking at fastrpc_rpmsg_callback():

fastrpc_rpmsg_callback() {
    ...
    spin_unlock_irqrestore(&cctx->lock, flags);

    if (!ctx) {
        ...
    }
    ctx->retval =3D rsp->retval;
    complete(&ctx->work);
    ...
}

The callback drops cctx->lock and relies on the send reference to keep the
context alive while it writes to ctx->retval.

If fastrpc_rpmsg_remove() runs concurrently and schedules put_work, could t=
he
send reference be dropped and the waiter awakened?  If the waiter then drops
its own reference, the context could be freed before fastrpc_rpmsg_callback=
()
resumes to write to ctx->retval, potentially causing a use-after-free?

[Severity: Critical]
This is a pre-existing issue, but can a compromised DSP trigger a
use-after-free by sending duplicate replies?

Looking at fastrpc_rpmsg_callback(), it looks up a context via ctxid and ca=
lls
schedule_work(&ctx->put_work) without verifying if it was already processed.

Since the context is only removed from the IDR when its refcount hits zero,
could duplicate replies from the DSP queue the work item again before the
final reference is dropped, causing an extra fastrpc_context_put() and
underflowing the refcount?

>  	}
> -	spin_unlock(&user->lock);
> +
> +	ctx->retval =3D -EPIPE;
> +	complete(&ctx->work);
> +
> +	return 0;
>  }
> =20
>  static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  {
>  	struct fastrpc_channel_ctx *cctx =3D dev_get_drvdata(&rpdev->dev);
>  	struct fastrpc_buf *buf, *b;
> -	struct fastrpc_user *user;
>  	unsigned long flags;
> =20
>  	/* No invocations past this point */
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	cctx->rpdev =3D NULL;

[Severity: High]
This is a pre-existing issue, but does setting cctx->rpdev to NULL here
introduce a TOCTOU race condition that can result in a NULL pointer
dereference?

In fastrpc_internal_invoke(), there is a lockless check for !fl->cctx->rpde=
v.

If fastrpc_rpmsg_remove() acquires cctx->lock and sets cctx->rpdev =3D NULL
concurrently, could fastrpc_invoke_send() later unconditionally dereference
cctx->rpdev->ept without acquiring cctx->lock or re-validating the pointer?

fastrpc_invoke_send() {
    ...
    ret =3D rpmsg_send(cctx->rpdev->ept, (void *)msg, sizeof(*msg));
    ...
}

> -	list_for_each_entry(user, &cctx->users, user)
> -		fastrpc_notify_users(user);
> +	idr_for_each(&cctx->ctx_idr, fastrpc_notify_context, NULL);
>  	spin_unlock_irqrestore(&cctx->lock, flags);

[Severity: High]
This is a pre-existing issue, but do timed-out or interrupted invocations
permanently leak contexts?

Looking at fastrpc_internal_invoke():

fastrpc_internal_invoke() {
    ...
    if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
        /* We are done with this compute context */
        spin_lock(&fl->lock);
        list_del(&ctx->node);
        spin_unlock(&fl->lock);
        fastrpc_context_put(ctx);
    }
    ...
}

If the invocation is interrupted or times out, it skips calling
fastrpc_context_put(), leaving the context on fl->pending with its first
reference held.

Since the context holds a reference to the fastrpc_user (fl) via
fastrpc_user_get(), would the user's refcount never reach zero, preventing
fastrpc_user_free() from ever running and permanently leaking the context?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624192700.5388=
-1-alhouseenyousef@gmail.com?part=3D1
