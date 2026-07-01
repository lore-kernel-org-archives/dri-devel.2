Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84994C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:27:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C017510E31F;
	Wed,  1 Jul 2026 08:27:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CBRCSlNZ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0059110E31F
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:27:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 27040601D6;
 Wed,  1 Jul 2026 08:27:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81181F000E9;
 Wed,  1 Jul 2026 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782894441;
 bh=RBqZcjs0WFd9ef8CrHYyq1tsx/TW6JOX/70eK7kKtEo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CBRCSlNZbWQrsGupXHzS9cRZ/ss380YJV1qt/o+pjET4TK2R50GNtq2DpHX1D39N+
 v+PonYKBPhHyrdtCJtLJ6wQqhHQyFELM2X5yYB8kz7//GXf91tRyTqmC79CaHC0YnB
 mtCDHD4E6DCjLC4an2L2S8CHU7KA+TsjvEGZxSM/Ni4hFIqGFFR/oACJIgpWa37kpa
 PbDiJnEgRXjhKzRolgKdmznCZWrcUgZkPXkdaCR3xLZ/6Iz6ZF2lRNZS/vLQYwu9ue
 nXijPuAH1p7k4GH73Phln6SDqcAw5m7hAQFafetejWvBo8v3Jl4JZnMq5PbyseASww
 ssZEvvA9TSJlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
References: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 08:27:21 +0000
Message-Id: <20260701082721.A81181F000E9@smtp.kernel.org>
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
- [Critical] Restoring an interrupted context fails to increment its refere=
nce count, leading to a Use-After-Free and Double Free when the syscall com=
pletes.
- [Critical] Retrying an interrupted fastrpc invocation with a newly alloca=
ted arguments structure forces the kernel to blindly write output data to o=
ld, potentially invalidated buffer addresses.
- [High] If a thread's fastrpc call is interrupted and it subsequently atte=
mpts a completely different fastrpc call, it will be permanently blocked fr=
om using the device.
- [High] Double-scheduling `ctx->put_work` in `fastrpc_notify_users()` caus=
es list corruption and a Use-After-Free if the async worker is already exec=
uting.
--

commit d067e3f966edecc9e2338c8eea087bb05365a462
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: fix context leak and hang on signal-interrupted invoke

This commit aims to fix a context leak and hang when a fastrpc invocation is
interrupted by a signal. It saves the interrupted context to a new list and
restores it on the next syscall attempt.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..c0859a5016179 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -594,6 +605,42 @@ static void fastrpc_context_put_wq(struct work_struc=
t *work)
>  	fastrpc_context_put(ctx);
>  }
> =20
> +static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *=
ctx)
> +{
> +	spin_lock(&ctx->fl->lock);
> +	list_del(&ctx->node);
> +	list_add_tail(&ctx->node, &ctx->fl->interrupted);
> +	spin_unlock(&ctx->fl->lock);
> +	/*
> +	 * invoke_send bumped the kref to 2; the bail path skips the put
> +	 * for ERESTARTSYS.  Drop it here so the worker's put reaches 0
> +	 * and triggers context_free.
> +	 */
> +	fastrpc_context_put(ctx);
> +}
> +
> +static struct fastrpc_invoke_ctx *fastrpc_context_restore_interrupted(
> +			struct fastrpc_user *fl, u32 sc)
> +{
> +	struct fastrpc_invoke_ctx *ctx =3D NULL, *ictx, *n;
> +
> +	spin_lock(&fl->lock);
> +	list_for_each_entry_safe(ictx, n, &fl->interrupted, node) {
> +		if (ictx->pid !=3D current->pid)
> +			continue;
> +		if (ictx->sc !=3D sc || ictx->fl !=3D fl) {
> +			spin_unlock(&fl->lock);
> +			return ERR_PTR(-EINVAL);

[Severity: High]
If a thread gets interrupted and attempts a new fastrpc call with a differe=
nt
sc, this returns -EINVAL but leaves the old context on fl->interrupted.

Will every subsequent fastrpc call by this thread with a different sc hit t=
his
same mismatch and instantly fail with -EINVAL, effectively wedging the thre=
ad?

> +		}
> +		ctx =3D ictx;
> +		list_del(&ctx->node);
> +		list_add_tail(&ctx->node, &fl->pending);
> +		break;

[Severity: Critical]
Does restoring the context here require incrementing its reference count via
fastrpc_context_get()?

Since the invoker's reference is intentionally dropped in
fastrpc_context_save_interrupted(), if the async worker completes the work =
and
drops its reference, could the user thread wake up and unconditionally call
fastrpc_context_put() in the bail path on freed memory?

> +	}
> +	spin_unlock(&fl->lock);
> +	return ctx;
> +}
> +
[ ... ]
> @@ -1258,6 +1303,14 @@ static int fastrpc_internal_invoke(struct fastrpc_=
user *fl,  u32 kernel,
>  		return -EPERM;
>  	}
> =20
> +	if (!kernel) {
> +		ctx =3D fastrpc_context_restore_interrupted(fl, sc);
> +		if (IS_ERR(ctx))
> +			return PTR_ERR(ctx);
> +		if (ctx)
> +			goto wait;

[Severity: Critical]
By jumping directly to wait, does this bypass argument extraction for retri=
es?

If a user thread unwinds its stack after a signal and initiates a completely
different call that happens to have the same sc, it seems the output data
might be copied directly to the old buffer addresses stored in ctx->args,
which could now contain other sensitive data.

> +	}
> +
>  	ctx =3D fastrpc_context_alloc(fl, kernel, sc, args);
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
[ ... ]
> @@ -2493,13 +2549,23 @@ static void fastrpc_notify_users(struct fastrpc_u=
ser *user)
>  		ctx->retval =3D -EPIPE;
>  		complete(&ctx->work);
>  	}
> +	/*
> +	 * Interrupted contexts hold two refs: one for the invoker and one
> +	 * for the async worker from fastrpc_invoke_send.  Complete them so
> +	 * any blocked retry wakes, and schedule put_wq to drop the worker
> +	 * ref -- the invoker ref is released by fastrpc_user_free().
> +	 */
> +	list_for_each_entry(ctx, &user->interrupted, node) {
> +		ctx->retval =3D -EPIPE;
> +		complete(&ctx->work);
> +		schedule_work(&ctx->put_work);

[Severity: High]
Is it safe to unconditionally schedule ctx->put_work here?

If a DSP response arrives concurrently and the async worker has already sta=
rted
executing fastrpc_context_put_wq(), its WORK_STRUCT_PENDING flag would be
clear.=20

Could this allow the work to be queued a second time, triggering a
use-after-free in the workqueue core once the first execution frees the
context?

> +	}
>  	spin_unlock(&user->lock);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701-master-v2-=
1-566bf8b7bd16@oss.qualcomm.com?part=3D1
