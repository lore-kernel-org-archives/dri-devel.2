Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3E5CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E43D910E179;
	Wed,  7 Oct 2026 08:57:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="e/uvN36L";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC1710E179
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 08:57:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3E063438AB;
 Wed,  7 Oct 2026 08:57:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA7E31F0089B;
 Wed,  7 Oct 2026 08:57:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791363449;
 bh=G8wJj6PpFoyCMnP7Xrc4LxnvQSKftWT9LkrDs6SeMZQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=e/uvN36LsH8T64FrM/VHNId++VIL9PwtWPKtrnzAD25oB1KjR+gKL1vpEdyBmuY4u
 aSnKe3tsUeTF4DvK4uJ4p8keNeJpVWxHkkQI8FL6WgEKOn3+TUWN3/sHu0ojqoMh22
 c4FAe3N1PUrWb/9gtBwhhBJkWxXzVS61l5Si0r8FtgT3Ono2WFp14sguV72YwhvBfv
 qpjSrszsTDevtP9xbKMschUDh5M/rnhBRETl7YzK/MwERF4+x9NNah8nY54eJ1x2xQ
 FOc4qHL5Kiem8on6IYjKx2g5oeSmVsVXGV6aZIEyqDmlJURMBQwBXKZu0B0b33o8DQ
 sGyT1Rt4jovPg==
Message-ID: <sashiko-outbox-162762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 2/3] misc: fastrpc: wake poll-mode waiters on SSR
To: "Jianping Li" <jianping.li@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261007084447.922-3-jianping.li@oss.qualcomm.com>
References: <20261007084447.922-1-jianping.li@oss.qualcomm.com>
 <20261007084447.922-3-jianping.li@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 07 Oct 2026 08:57:28 +0000
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
- [Medium] misc/fastrpc: missing memory barrier and data race on ctx->is_wo=
rk_done allows stale error codes
--

commit ec0bf5065c708ee8356d5c1feae24849edc520bd
Author: Jianping Li <jianping.li@oss.qualcomm.com>

misc: fastrpc: wake poll-mode waiters on SSR

This commit updates fastrpc_notify_users() to set ctx->is_work_done along
with ctx->retval. This ensures that threads spinning in polling mode will
observe the termination and exit, instead of waiting for a timeout when the
DSP goes down.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 05b2e7e4ad3b7..c54c450cb5714 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2663,6 +2663,7 @@ static void fastrpc_notify_users(struct fastrpc_use=
r *user)
>  	spin_lock(&user->lock);
>  	list_for_each_entry(ctx, &user->pending, node) {
>  		ctx->retval =3D -EPIPE;
> +		ctx->is_work_done =3D true;

[Severity: Medium]
Is there a missing write memory barrier here?

If the stores to ctx->retval and ctx->is_work_done are reordered by the
compiler or the CPU, a concurrent thread executing poll_for_remote_response=
()
might read ctx->is_work_done as true but read a stale value for ctx->retval,
such as the initialization value -1 or -EPERM.

In poll_for_remote_response(), a concurrent thread evaluates this locklessl=
y:

        ...
        (val =3D=3D FASTRPC_POLL_RESPONSE) || ctx->is_work_done

Even if the polling thread uses dma_rmb() before reading ctx->retval, that
only ensures read-read hardware ordering. It does not prevent this writer
thread from reordering the stores. Would it be safer to use
smp_store_release() for ctx->is_work_done here and smp_load_acquire() in the
polling loop?

Additionally, does this introduce a plain C data race?

poll_for_remote_response() appears to locklessly write to ctx->is_work_done
on DSP polling completion. This could cause undefined behavior when racing
with the lockless reads and this new write in fastrpc_notify_users().

>  		complete(&ctx->work);
>  	}
>  	spin_unlock(&user->lock);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007084447.922-=
1-jianping.li@oss.qualcomm.com?part=3D2
