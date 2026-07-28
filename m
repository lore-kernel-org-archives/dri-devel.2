Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70382C54F4C
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 08:01:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABC5C10E811;
	Tue, 28 Jul 2026 08:01:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mvTSpKmh";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B382210E80F
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 08:01:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AEA4F60A6D;
 Tue, 28 Jul 2026 08:01:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 446491F000E9;
 Tue, 28 Jul 2026 08:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785225677;
 bh=l6RxtgEM4rWFfyOwlOPYPvsobcdhvWOSpcB+XtBFxPE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mvTSpKmhje6rpS5ROeiJk5VAmehnKurCY+d+KnX7gTxsRshH2Sy9pAZ0ASzbMjbAg
 cLDEYOxGKBsGqnj6jAOh2xw0iRolsrU0MA+D21HhlXnQofnvThxC3LTlY8KqrQhkxi
 AxuYxiI7/Qml+Fx1mz+pnHxUqQhIyWptUsIGAh0d10hMhZdfS6L8fTdUX0lsuAPsc+
 iw7402cNd7Iy3Oi/ZPJzMwQ2H/0QJkC8P1DeqkYwUClMimHcaYMk8V4z3a15KbK/Ca
 f2itn99PjhO5T38jTHz6uMPos3ItzWKnxhgiM97lrrzowq0n/2joqX/PfmITENWqHa
 ThX+4szfeRmTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] misc: fastrpc: Drop unhandled DSP PD exit notification
To: "Shawn Guo" <shengchao.guo@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728073851.682023-1-shengchao.guo@oss.qualcomm.com>
References: <20260728073851.682023-1-shengchao.guo@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 08:01:16 +0000
Message-Id: <20260728080117.446491F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Use-After-Free in fastrpc_rpmsg_callback due to lockless conte=
xt access without reference increment.
- [High] Data race and list corruption when handling -ERESTARTSYS in fastrp=
c_internal_invoke.
--

--- Patch [1]: [PATCH v2] misc: fastrpc: Drop unhandled DSP PD exit notific=
ation ---
commit c653a512607ab348a2abca70e47797b728162a44
Author: Shawn Guo <shengchao.guo@oss.qualcomm.com>

misc: fastrpc: Drop unhandled DSP PD exit notification

Newer DSP firmware implements a PD (Protection Domain) notification
framework that sends PD state notifications upon request. This commit
drops the unhandled PD exit notification to prevent it from being=20
incorrectly matched against the context idr.

Link: https://lore.kernel.org/all/20260727130940.577721-1-shengchao.guo@oss=
.qualcomm.com/

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d1..a970d0995e2cb 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -2542,6 +2553,14 @@ static int fastrpc_rpmsg_callback(struct rpmsg_dev=
ice *rpdev, void *data,
>  	if (!cctx)
>  		return -ENODEV;
> =20
> +	/*
> +	 * A PD exit notification from the DSP PD notification framework carries
> +	 * this sentinel rather than a real context. Drop it: a real context is
> +	 * (idr_index << 4) | pd and can never collide with this value.
> +	 */
> +	if (rsp->ctx =3D=3D FASTRPC_DSP_PD_NOTIFY_CTX)
> +		return 0;
> +
>  	ctxid =3D ((rsp->ctx & FASTRPC_CTXID_MASK) >> 4);
> =20
>  	spin_lock_irqsave(&cctx->lock, flags);

[Severity: Critical]
This is a pre-existing issue, but does dropping the lock immediately after
this without incrementing the reference count of the context risk a
use-after-free?

drivers/misc/fastrpc.c:fastrpc_rpmsg_callback() {
...
	ctx =3D idr_find(&cctx->ctx_idr, ctxid);
	spin_unlock_irqrestore(&cctx->lock, flags);

	if (!ctx) {
		dev_err(&rpdev->dev, "No context ID matches response\n");
		return -ENOENT;
	}

	ctx->retval =3D rsp->retval;
	complete(&ctx->work);
...
}

If a response arrives exactly as the context is being freed by a concurrent
timeout or signal, couldn't the context be freed immediately after the lock
is dropped, causing the write to ctx->retval to corrupt memory?


I also noticed another pre-existing issue in the same file that might be
worth looking at:

drivers/misc/fastrpc.c:fastrpc_internal_invoke() {
...
	if (err =3D=3D -ERESTARTSYS) {
		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
			list_del(&buf->node);
			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
		}
	}
...
}

[Severity: High]
This is a pre-existing issue, but are these list operations safe to perform
locklessly here?

If multiple threads sharing the same file descriptor issue concurrent
ioctls, wait in fastrpc_internal_invoke(), and receive a signal like
SIGINT, they would all concurrently modify fl->mmaps and
fl->cctx->invoke_interrupted_mmaps.

Could this lead to list corruption since neither fl->lock nor cctx->lock
appears to be held?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728073851.6820=
23-1-shengchao.guo@oss.qualcomm.com?part=3D1
