Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35578CA5FC4
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 09:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6794710E3DD;
	Fri,  2 Oct 2026 09:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VnSGRACq";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14B8F10E3DD
 for <dri-devel@lists.freedesktop.org>; Fri,  2 Oct 2026 09:13:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id ED85D60A70;
 Fri,  2 Oct 2026 09:13:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AF6E1F0089A;
 Fri,  2 Oct 2026 09:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932415;
 bh=mTM/uNwlQySIkOhOsg0k2aABtwwtHnfyJyo0WlGMcAU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VnSGRACqHkE3w5OgmrPWX3/mA+s9CXGStLpSFEcTouUQQrJTHv6oabrvihVyAUlkP
 t9mRMkHA1dlVkE/8LHEuRWkZ4kHiiFHtOu66bUMpJTPWIcvJfTNUKV+5Q91o4aHVkt
 5YZo8J8uwiI2Uk8Qbl9VEQzkMhH5vKGh+lR4HyHPRQSUdV1kSu1Ripa8EzP6VxIg0F
 5ucKgXfeKmPF3x6Z/Qh4pTEm7Nd7+wI2SsMjt4qaPTjIsHoIb7KWDqabYPUSEvpFx2
 KVdJwd32rnaG5Xrx1pP4Mrp6/7FBe0UvWb2PBKYu341BQFrqKakZtEDgZM4iAGVqFs
 bZ4YJN0lW1kSw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261002-anandu-fastrpc-interrupted-invoke-v3-v3-1-31e90439d2ba@oss.qualcomm.com>
References: <20261002-anandu-fastrpc-interrupted-invoke-v3-v3-1-31e90439d2ba@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:13:35 +0000
Message-Id: <20261002091335.7AF6E1F0089A@smtp.kernel.org>
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
- [High] fastrpc: missing 'sent' flag causes indefinite hang and UAF on ret=
ry
- [High] fastrpc: resumed context uses stale user-space pointers for DSP ou=
tput
- [High] fastrpc: Use-After-Free in fastrpc_rpmsg_callback due to concurren=
t teardown
- [Medium] fastrpc: memory leak of timed-out contexts on channel teardown
--

commit 6840686b144525cb6d359cfc50b159c177c03bae
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: fix context leak and hang on signal-interrupted invoke

fastrpc invokes work by sending an RPC message to the DSP and blocking
in wait_for_completion_interruptible() until the DSP responds. If a
signal arrives during this wait, the syscall returns -ERESTARTSYS and
the invoke context which holds the in-flight DMA buffers and
completion state is left stranded in fl->pending.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 5ac7b3e78ba7e..f51cb772e6831 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> @@ -1370,9 +1444,21 @@ static int fastrpc_internal_invoke(struct fastrpc_=
user *fl,  u32 kernel,
>  		return -EPERM;
>  	}
> =20
> -	ctx =3D fastrpc_context_alloc(fl, kernel, sc, args);
> -	if (IS_ERR(ctx))
> -		return PTR_ERR(ctx);
> +	if (!kernel)
> +		ctx =3D fastrpc_context_restore_interrupted(fl, handle, sc);
> +
> +	if (ctx) {
> +		/* ctx->args is already populated from before the interruption. */
> +		resumed =3D true;
> +	} else {
> +		ctx =3D fastrpc_context_alloc(fl, kernel, sc, args);
> +		if (IS_ERR(ctx))
> +			return PTR_ERR(ctx);
> +		ctx->handle =3D handle;
> +	}
> +

[Severity: High]
Does this code ignore the new args structure provided by the retrying user-=
space
caller?

The code appears to retain the stale pointers captured before the interrupt=
ion,
failing to update ctx->args with the retry's arguments. When the DSP respon=
ds,
fastrpc_put_args() might copy the output to the original, potentially freed=
 or
repurposed user-space addresses.

> +	if (resumed)
> +		goto wait;

[Severity: High]
Can skipping the message sending cause a thread to get permanently hung?

Because the missing 'sent' flag check fails to detect that the message wasn=
't
delivered initially, the resumed context may incorrectly skip sending the
message here.

> =20
>  	err =3D fastrpc_get_args(kernel, ctx);
>  	if (err)
[ ... ]
> @@ -1409,21 +1496,13 @@ static int fastrpc_internal_invoke(struct fastrpc=
_user *fl,  u32 kernel,
>  		goto bail;
> =20
>  bail:
> -	if (err !=3D -ERESTARTSYS && err !=3D -ETIMEDOUT) {
> -		/* We are done with this compute context */
> -		spin_lock(&fl->lock);
> -		list_del(&ctx->node);
> -		spin_unlock(&fl->lock);
> -		fastrpc_context_put(ctx);
> -	}
> -
>  	if (err =3D=3D -ERESTARTSYS) {
> +		fastrpc_context_save_interrupted(ctx);
> +	} else {

[Severity: High]
Is the context unconditionally parked as resumable without verifying if the
message was actually sent?

The commit message mentions this is handled via a 'sent' flag, but the flag
appears to be missing in the patch, which could park unsent contexts as
resumable.

>  		spin_lock(&fl->lock);
> -		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> -			list_del(&buf->node);
> -			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> -		}
> +		list_del_init(&ctx->node);
>  		spin_unlock(&fl->lock);
> +		fastrpc_context_put(ctx);
>  	}

[Severity: Medium]
When a context times out (err =3D=3D -ETIMEDOUT), does this code remove it =
from the
tracking lists?

This would make it unreachable for the fastrpc_notify_users() cleanup sweep,
potentially leaking the context and its DSP reference if the DSP never resp=
onds
and the channel is torn down.

[ ... ]
> @@ -2669,13 +2762,22 @@ static void fastrpc_notify_users(struct fastrpc_u=
ser *user)
>  		ctx->retval =3D -EPIPE;
>  		complete(&ctx->work);
>  	}
> +
> +	/* Drops only the worker ref; the invoker ref is released by fastrpc_us=
er_free(). */
> +	list_for_each_entry(ctx, &user->interrupted, node) {

[Severity: Medium]
Because the timed-out contexts are removed from fl->pending and fl->interru=
pted,
does this teardown routine miss cleaning them up when the DSP reference is =
still
held?

> +		ctx->retval =3D -EPIPE;
> +		complete(&ctx->work);
> +		if (!ctx->put_work_scheduled) {
> +			ctx->put_work_scheduled =3D true;
> +			schedule_work(&ctx->put_work);
> +		}
> +	}
>  	spin_unlock(&user->lock);
>  }
[ ... ]
> @@ -2778,9 +2877,11 @@ static int fastrpc_rpmsg_callback(struct rpmsg_dev=
ice *rpdev, void *data,
>  	/*
>  	 * The DMA buffer associated with the context cannot be freed in
>  	 * interrupt context so schedule it through a worker thread to
> -	 * avoid a kernel BUG.
> +	 * avoid a kernel BUG. fastrpc_context_schedule_put_work() guards
> +	 * against a concurrent fastrpc_notify_users() also scheduling this
> +	 * same work item for an interrupted context.
>  	 */
> -	schedule_work(&ctx->put_work);
> +	fastrpc_context_schedule_put_work(ctx);
> =20
>  	return 0;
>  }

[Severity: High]
Can a concurrent channel teardown or file descriptor closure cause a
use-after-free here?

Earlier in this function, the context is found in the IDR and the cctx->loc=
k is
dropped without elevating the refcount. Concurrent teardown paths can drop =
both
the invoker and DSP references, freeing the context before the callback rea=
ds
ctx->ctxid or accesses it here.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-anandu-fas=
trpc-interrupted-invoke-v3-v3-1-31e90439d2ba@oss.qualcomm.com?part=3D1
