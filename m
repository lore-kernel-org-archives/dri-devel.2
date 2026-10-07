Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A126CA5FFF
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:53:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF24910E557;
	Wed,  7 Oct 2026 08:53:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JwO1JHjj";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1427B10E557
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:53:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 37099600C8;
 Wed,  7 Oct 2026 08:53:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FB41F0089B;
 Wed,  7 Oct 2026 08:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791363180;
 bh=fFG2XpmqSpYfvwIADxPKBE1s/1LweMS3qYuyVZ/Dlto=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JwO1JHjjZdLxuOyLORQQjoGevMZLrQUXZpFrn66ycDkkUAe89AE5HYtCJxKVg5/3r
 3e0OOWWggMHFhcWDYKZV+jyq6Kmy8tP23L448B0VA9ZLgUkZRv7BRNYm+qNZVLYGdT
 83UVYRWjCRbaI78Axha5nzaUDd3Zd65vexwTXrfoCdbSOh8mlq5WDsmpo+giiI6hl7
 UfbP4p1a6VfJ80Rg1SkDvckKh9/PUv3fzTDf1APC8BhSTf9UqRimS2Zgu0LFX5jW+u
 p0mGCJsAl4zXkd7gp8UvRz8fUOhKNiJUkZWTPp3R7V6tI0kOP7msHyNpm3WXowsDZ8
 VLD7IVhK4xlpg==
Message-ID: <sashiko-outbox-162759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/3] misc: fastrpc: drain in-flight invokes before
 tearing down context banks
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007084447.922-4-jianping.li@oss.qualcomm.com>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-4-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 08:53:00 +0000
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
- [High] fastrpc: deadlock in fastrpc_rpmsg_remove() due to TOCTOU race wit=
h context allocation
--

commit cc1c8d918750aea3d9a92e77f3c2258f941ddc99
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: drain in-flight invokes before tearing down context banks

This commit introduces a synchronization mechanism to drain in-flight invok=
es
before tearing down context banks. It adds a teardown flag and an invoke co=
unter
to wait until all active invokes complete during rpmsg removal. It also sig=
nals
pending invokes with -EPIPE to wake them up.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index c54c450cb5714..3036925632d04 100644
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

[Severity: High]
Does this create a critical race window? If the thread is preempted right a=
fter
unlocking here, it has incremented invoke_cnt but hasn't yet called
fastrpc_context_alloc() to add its context to the user->pending list.

> =20
>  	if (handle =3D=3D FASTRPC_INIT_HANDLE && !kernel) {
>  		dev_warn_ratelimited(fl->sctx->dev, "user app trying to send a kernel =
RPC message (%d)\n",  handle);
> -		return -EPERM;
> +		err =3D -EPERM;
> +		goto out;
>  	}
> =20
>  	ctx =3D fastrpc_context_alloc(fl, kernel, sc, args);

[Severity: High]
Could fastrpc_rpmsg_remove() run concurrently while the first thread is
preempted? If so, when fastrpc_context_alloc() is finally called, it seems =
it
is too late to receive the teardown notification since fastrpc_rpmsg_remove=
()
has already swept the pending list.

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

[Severity: High]
Does this notify loop miss the context that is still suspended between the
counter increment and allocation? fastrpc_notify_users() only iterates over
the user->pending list, which the preempted thread has not yet reached.

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

[Severity: High]
Will this wait forever? The preempted context missed the explicit abort swe=
ep,
so it will block indefinitely in fastrpc_wait_for_completion(). Because the=
 DSP
is tearing down, it will never reply, meaning invoke_cnt never drops to 0, =
which
would permanently deadlock the removal thread.

> +		spin_lock_irqsave(&cctx->lock, flags);
> +	}
> +	cctx->rpdev =3D NULL;
> +	spin_unlock_irqrestore(&cctx->lock, flags);
> +
>  	if (cctx->fdevice)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007084447.922-=
1-jianping.li@oss.qualcomm.com?part=3D3
