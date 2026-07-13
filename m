Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994EEC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 05:38:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFECE10E553;
	Mon, 13 Jul 2026 05:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oFsbthy6";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 44E7610E553
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:38:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BC16E60018;
 Mon, 13 Jul 2026 05:38:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 495411F000E9;
 Mon, 13 Jul 2026 05:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783921089;
 bh=So5vOdwfZiPYHFRCBdq2LX/u6yyMLyzRPNU+f3j6W10=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oFsbthy66taQdBxqgLKGdKOUim/skLHbPM314q0c68UNFR+dJBDOOlviPPomLGObD
 HnkKFYuaXTUyxIFW4dG4apafad9tw1n+SEq9QyH85d1Q8WlNfBOmifnRDw2EZ1SuR/
 bzdGiUSu0RRxjhWVob5255AMDpyGTIFneoI4/eX/VUyUntZV5zljR2pLAFMhqRDEow
 8ge7QfotfyRSQt4oB/WAPkRt5P70W3g+j6aqIuete1xk8LCwVKrANB3quvqImS9wth
 /DrBkysGxGy0LSyJUDvDNyM/t7skvJkAHpLKl4Ta1uMnHDycju6dfxzc+H3LL20dhZ
 WMnUU4FsKFV2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 4/4] misc: fastrpc: Add polling mode support for
 fastRPC driver
To: "Ekansh Gupta" <ekansh.gupta@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260713052236.3033744-5-ekansh.gupta@oss.qualcomm.com>
References: <20260713052236.3033744-1-ekansh.gupta@oss.qualcomm.com>
 <20260713052236.3033744-5-ekansh.gupta@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 05:38:08 +0000
Message-Id: <20260713053809.495411F000E9@smtp.kernel.org>
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
- [Critical] Unprivileged Denial of Service via IDR slot exhaustion and mem=
ory leaks in polling mode.
- [High] Data race on `ctx->is_work_done` and `ctx->retval` due to missing =
memory barriers.

Pre-existing issues:
- [Critical] Duplicate Glink completion responses bypass sequence validatio=
n and cause a Use-After-Free.
- [High] Accessing `ctx->ctxid` outside the IDR lock leads to a Use-After-F=
ree.
--

--- Patch [4]: [PATCH v13 4/4] misc: fastrpc: Add polling mode support for =
fastRPC driver ---
commit d9afeb4ebcb604d7e06c0448d2aa66154de980d6
Author: Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>

misc: fastrpc: Add polling mode support for fastRPC driver

This commit adds polling mode support for the fastRPC driver to avoid
CPU wakeup and scheduling overhead during glink responses. It polls a
shared memory location for completion after sending the invocation.
It also embeds a sequence number in the context ID to prevent recycling
issues.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
[ ... ]
> +static int poll_for_remote_response(struct fastrpc_invoke_ctx *ctx)
> +{
> +	u32 val;
> +	int ret;
> +
> +	/*
> +	 * Poll until DSP writes FASTRPC_POLL_RESPONSE into *ctx->poll_addr
> +	 * or until another path marks the work done.
> +	 */
> +	ret =3D read_poll_timeout_atomic(fastrpc_read_poll_addr, val,
> +				       (val =3D=3D FASTRPC_POLL_RESPONSE) || ctx->is_work_done, 1,

[Severity: High]
Are there missing memory barriers when updating these fields?

When the Glink response arrives, fastrpc_rpmsg_callback() updates ctx->retv=
al
and then sets ctx->is_work_done =3D true. Because there are no write memory
barriers, the CPU or compiler can reorder these stores.

Concurrently, poll_for_remote_response() spins reading ctx->is_work_done
without a read barrier. If the polling thread observes is_work_done =3D=3D =
true
before the retval update is visible, could it break the loop and read the
stale initial value of ctx->retval (-1), causing the invocation to incorrec=
tly
fail?

[ ... ]
> +static int fastrpc_wait_for_completion(struct fastrpc_invoke_ctx *ctx,
> +				       u32 kernel)
> +{
> +	int err;
> +
> +	if (ctx->is_polled) {
> +		err =3D poll_for_remote_response(ctx);
> +		if (!err)
> +			return 0;

[Severity: Critical]
Does returning early on polling success lead to IDR slot exhaustion and mem=
ory
leaks?

If a userspace process invokes a DSP module in polling mode, the DSP updates
the poll memory but might maliciously omit the Glink completion response. T=
he
CPU thread completes the polling successfully, returns to userspace, and
deletes the context from user->pending in fastrpc_internal_invoke().

Because the Glink callback never runs, the context's reference count never
reaches zero, and it appears to be permanently abandoned in the IDR. Could =
an
unprivileged process loop this to quickly exhaust the 256 FASTRPC_CTX_MAX I=
DR
slots?

[ ... ]
> @@ -2559,7 +2719,25 @@ static int fastrpc_rpmsg_callback(struct rpmsg_dev=
ice *rpdev, void *data,
>  		return -ENOENT;
>  	}
> =20
> +	/*
> +	 * Validate the sequence number embedded in the upper bits of the
> +	 * context ID.  Under high concurrency the IDR slot can be recycled
> +	 * for a new request before a late (or duplicate) glink COMPLETE
> +	 * response for the previous request arrives.  Without this check the
> +	 * driver would call complete() on the wrong context, waking a thread
> +	 * whose buffers are still being accessed by the DSP.
> +	 */
> +	if (FIELD_GET(FASTRPC_CTXID_SEQ_MASK, rsp->ctx) !=3D
> +	    FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid)) {

[Severity: High]
This isn't a bug introduced by this patch, but does accessing ctx->ctxid
outside the IDR lock lead to a use-after-free?

Looking at fastrpc_rpmsg_callback(), idr_find() is called to retrieve the
context, but the spinlock (cctx->lock) is released immediately after without
incrementing the context's reference count.

If another thread drops the final reference to this context concurrently (s=
uch
as a timeout or worker thread), fastrpc_context_free() will remove it from =
the
IDR and free the memory. Can fastrpc_rpmsg_callback() then access freed mem=
ory
when checking ctx->ctxid?

[Severity: Critical]
This is a pre-existing issue, but do duplicate Glink completion responses
bypass the sequence validation and cause a use-after-free?

The sequence number check mitigates responses intended for a recycled IDR s=
lot,
but it does not protect against a malicious DSP sending multiple Glink
completion responses for the currently active request.

If a duplicate response is sent, the sequence number matches, and
fastrpc_rpmsg_callback() blindly calls schedule_work(&ctx->put_work) again.=
 If
the first scheduled work has already completed, will the duplicate response
successfully queue it a second time, erroneously dropping the reference cou=
nt
to zero and freeing the context while the CPU thread is still using it?

> +		dev_dbg(&rpdev->dev,
> +			"Stale glink response ctx 0x%llx (expected seq 0x%llx), dropping\n",
> +			rsp->ctx,
> +			FIELD_GET(FASTRPC_CTXID_SEQ_MASK, ctx->ctxid));
> +		return 0;
> +	}
> +
>  	ctx->retval =3D rsp->retval;
> +	ctx->is_work_done =3D true;
>  	complete(&ctx->work);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713052236.3033=
744-1-ekansh.gupta@oss.qualcomm.com?part=3D4
