Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F15606A323
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 10:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5skHIsz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D088910E424;
	Tue, 17 Nov 2026 10:05:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A18D810E424
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Nov 2026 10:05:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 59F3645E68;
 Tue, 17 Nov 2026 10:05:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 231491F000C5;
 Tue, 17 Nov 2026 10:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794909947;
 bh=40FB+AJ4c0dk8GAh5/cp7H+aJg3OYARP48fwIDHNdEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Y5skHIszSPJEbXRCGY9y2cp9byYj6dMbyFeFi4E6204h+G4HaPl1f7ypwXt09vvBw
 /3VZDaxRSgyFKhA1JSmyqvTAGvvToer4y5aBMwXe4SDhJ19vSBY6GiElA1Xrek13qI
 xniv3Ij7KL4Bynr4qYukLycXtyYkeP8+ZkytxXWrwczkYnv671WU4Z8TruxO4wEnFb
 gBaww3mGlxKNflSbXIQWkOY9mf6ncP7N49Vm5cDPaDQjrv3eh7B9mFcsc+NO/1qgTD
 Bey/jzLApRRkvo4vGKlcGa1OXue4Nqt2jdH0PXuE3TOncPWaaEZ8h3wlNcJl08qNuD
 Rn9nGNbm13Vng==
Message-ID: <sashiko-outbox-218568@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
To: "Anandu Krishnan E" <anandu.e@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261117-interrupted-invoke-v4-v4-3-2320a8a7eda2@oss.qualcomm.com>
References: <20261117-interrupted-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com>
 <20261117-interrupted-invoke-v4-v4-3-2320a8a7eda2@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 17 Nov 2026 10:05:46 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] misc: fastrpc: recursive fl->lock deadlock in
  fastrpc_notify_users()
- [High] misc: fastrpc: hardirq-to-process fl->lock inversion in rpmsg
  callback
- [High] misc: fastrpc: use-after-free of ctx in
  fastrpc_rpmsg_callback()
- [High] misc: fastrpc: stale ctx->args reuse in
  fastrpc_context_restore_interrupted()
- [High] misc: fastrpc: DSP retval -ERESTARTSYS mishandled as signal in
  bail path
- [High] misc: fastrpc: premature ctx put in fastrpc_notify_users()
  before send
- [Medium] misc: fastrpc: leaked timed-out contexts and unreclaimed SSR
  contexts
- [Medium] misc: fastrpc: ctx_idr exhaustion blocks
  fastrpc_device_release()
--

commit 13c73e8b92c7260a0858f27cc1ca5b1e031ffdf3
Author: Anandu Krishnan E <anandu.e@oss.qualcomm.com>

misc: fastrpc: fix context leak and hang on signal-interrupted invoke

This commit parks signal-interrupted FastRPC invoke contexts on a per-user
fl->interrupted list so they can be resumed on retry without resending the
RPC message to the DSP, and updates teardown paths to drain parked
contexts.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index c5c3679f87f6f..dd4d3c88e9b97 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c

[ ... ]

> @@ -644,6 +661,54 @@ static void fastrpc_context_put_wq(struct work_struc=
t *work)
>  	fastrpc_context_put(ctx);
>  }
> =20
> +/* Schedules put_work at most once per ctx; racing callers may both try.=
 */
> +static void fastrpc_context_schedule_put_work(struct fastrpc_invoke_ctx =
*ctx)
> +{
> +	bool do_schedule;
> +
> +	spin_lock(&ctx->fl->lock);
> +	do_schedule =3D !ctx->put_work_scheduled;
> +	ctx->put_work_scheduled =3D true;
> +	spin_unlock(&ctx->fl->lock);
> +
> +	if (do_schedule)
> +		schedule_work(&ctx->put_work);
> +}

[Severity: High]
Can calling fastrpc_context_schedule_put_work() from
fastrpc_rpmsg_callback() deadlock on fl->lock?

On Qualcomm GLINK and SMD transports, the endpoint callback
fastrpc_rpmsg_callback() runs in hardirq context, while process and
workqueue paths acquire fl->lock with plain spin_lock() and local
interrupts enabled:

fastrpc_context_free()
  spin_lock(&fl->lock)
  <hardirq>
    fastrpc_rpmsg_callback()
      fastrpc_context_schedule_put_work()
        spin_lock(&ctx->fl->lock)  <-- spins forever

> +
> +/* References held by ctx are left intact; only list membership changes.=
 */
> +static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *=
ctx)
> +{
> +	spin_lock(&ctx->fl->lock);
> +	list_move_tail(&ctx->node, &ctx->fl->interrupted);
> +	spin_unlock(&ctx->fl->lock);
> +}
> +
> +/* Matches on handle+sc, not sc alone, to avoid resuming an unrelated ca=
ll. */
> +static struct fastrpc_invoke_ctx *fastrpc_context_restore_interrupted(st=
ruct fastrpc_user *fl,
> +								      u32 handle, u32 sc)
> +{
> +	struct fastrpc_invoke_ctx *ctx =3D NULL, *ictx;
> +
> +	spin_lock(&fl->lock);
> +	list_for_each_entry(ictx, &fl->interrupted, node) {
> +		if (ictx->pid =3D=3D current->pid && ictx->handle =3D=3D handle &&
> +		    ictx->sc =3D=3D sc) {
> +			/* May already be mid-teardown; don't resurrect it. */
> +			if (kref_get_unless_zero(&ictx->refcount)) {
> +				ctx =3D ictx;
> +				list_move_tail(&ctx->node, &fl->pending);
> +			}
> +			break;
> +		}
> +	}
> +	spin_unlock(&fl->lock);
> +
> +	if (ctx)
> +		fastrpc_context_put(ctx);
> +
> +	return ctx;
> +}

[Severity: High]
What happens if a signal without SA_RESTART interrupts an invoke (returning
-EINTR to user space) and the thread later calls the same (handle, sc)
method with different buffers?

fastrpc_context_restore_interrupted() matches only on pid, handle, and sc,
and fastrpc_internal_invoke() jumps straight to wait: without checking or
updating ctx->args.  The new input buffers are ignored, and when the
original DSP call finishes, fastrpc_put_args() copies output buffers via
copy_to_user() to the stale ctx->args[i].ptr addresses from the earlier
interrupted call, corrupting user-space stack or heap memory.  In addition,
if user space does not retry after -EINTR, the parked context and its DMA
buffers and ctx_idr slot remain pinned on fl->interrupted until the file
descriptor is closed.

[ ... ]

> @@ -1373,7 +1446,13 @@ static int fastrpc_internal_invoke(struct fastrpc_=
user *fl,  u32 kernel,
>  		return -EPERM;
>  	}
> =20
> -	ctx =3D fastrpc_context_alloc(fl, kernel, sc, args);
> +	/* Resume an interrupted invoke instead of resending to the DSP. */
> +	if (!kernel)
> +		ctx =3D fastrpc_context_restore_interrupted(fl, handle, sc);
> +	if (ctx)
> +		goto wait;
> +
> +	ctx =3D fastrpc_context_alloc(fl, kernel, handle, sc, args);
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
> =20
> @@ -1385,8 +1464,15 @@ static int fastrpc_internal_invoke(struct fastrpc_=
user *fl,  u32 kernel,
>  	dma_wmb();
>  	/* Send invoke buffer to remote dsp */
>  	err =3D fastrpc_invoke_send(fl->sctx, ctx, kernel, handle);
> -	if (err)
> -		goto bail;
> +	if (err) {
> +		/* Never sent, so not safe to park and resume like bail: does. */
> +		spin_lock(&fl->lock);
> +		list_del_init(&ctx->node);
> +		spin_unlock(&fl->lock);
> +		fastrpc_context_put(ctx);
> +		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
> +		return err;
> +	}
> =20
>  	/*
>  	 * Set message context as polled if the call is for a user PD
> @@ -1395,7 +1481,16 @@ static int fastrpc_internal_invoke(struct fastrpc_=
user *fl,  u32 kernel,
>  	if (handle > FASTRPC_MAX_STATIC_HANDLE && fl->pd =3D=3D USER_PD && fl->=
poll_mode)
>  		ctx->is_polled =3D true;
> =20
> +wait:
>  	err =3D fastrpc_wait_for_completion(ctx, kernel);
> +	if (err =3D=3D -ETIMEDOUT)
> +		dev_warn(fl->sctx->dev,
> +			 "fastrpc_invoke: TIMEOUT ctxid=3D0x%llx handle=3D0x%x nscalars=3D%d\=
n",
> +			 ctx->ctxid, handle, ctx->nscalars);
> +	else if (err =3D=3D -ERESTARTSYS)
> +		dev_dbg(fl->sctx->dev,
> +			"fastrpc_invoke: INTERRUPTED ctxid=3D0x%llx handle=3D0x%x nscalars=3D=
%d\n",
> +			ctx->ctxid, handle, ctx->nscalars);
>  	if (err)
>  		goto bail;
> =20
> @@ -1412,21 +1507,16 @@ static int fastrpc_internal_invoke(struct fastrpc=
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

[Severity: High]
What happens if the DSP completes an invocation with ctx->retval =3D=3D -512
(-ERESTARTSYS)?

After fastrpc_wait_for_completion() and fastrpc_put_args() have already
completed, err =3D ctx->retval jumps to bail:, which treats -ERESTARTSYS as=
 a
signal interruption and parks the completed context on fl->interrupted
without dropping the invoker reference.  When the syscall restarts and
reclaims ctx, a non-polled call hangs waiting on the already-consumed
ctx->work completion, while a polled call with ctx->is_work_done =3D=3D true
repeatedly re-runs fastrpc_put_args() and drops map references in
ctx->fdlist again, underflowing mmap->refcount into a use-after-free:

drivers/misc/fastrpc.c:fastrpc_put_args() {
    ...
	/* Clean up fdlist which is updated by DSP */
	for (i =3D 0; i < FASTRPC_MAX_FDLIST; i++) {
		if (!fdlist[i])
			break;
		if (!fastrpc_map_lookup(fl, (int)fdlist[i], &mmap, false))
			fastrpc_map_put(mmap);
	}
    ...
}

> +	} else if (err =3D=3D -ETIMEDOUT) {
> +		/* Leave linked: a late DSP answer or notify_users() still needs to re=
ach it. */
> +		fastrpc_context_put(ctx);
> +	} else {
>  		spin_lock(&fl->lock);
> -		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> -			list_del(&buf->node);
> -			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> -		}
> +		list_del_init(&ctx->node);
>  		spin_unlock(&fl->lock);
> +		fastrpc_context_put(ctx);
>  	}
> =20
>  	if (err)
> @@ -1728,13 +1818,28 @@ static int fastrpc_device_release(struct inode *i=
node, struct file *file)
>  {
>  	struct fastrpc_user *fl =3D (struct fastrpc_user *)file->private_data;
>  	struct fastrpc_channel_ctx *cctx =3D fl->cctx;
> -	unsigned long flags;
> +	struct fastrpc_invoke_ctx *ctx, *n;
> +	int release_err;
> =20
> -	fastrpc_release_current_dsp_process(fl);
> +	release_err =3D fastrpc_release_current_dsp_process(fl);
> =20
> -	spin_lock_irqsave(&cctx->lock, flags);
> -	list_del(&fl->user);
> -	spin_unlock_irqrestore(&cctx->lock, flags);
> +	/*
> +	 * Drop the invoker ref unconditionally: no retry can arrive once the
> +	 * fd is closed. Drop the worker ref only if the DSP confirmed it is
> +	 * done with the process; otherwise leave ctx linked so a real answer
> +	 * or a later SSR can still release it.
> +	 */
> +	spin_lock(&fl->lock);
> +	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
> +		ctx->retval =3D -EPIPE;
> +		complete(&ctx->work);
> +		spin_unlock(&fl->lock);
> +		if (!release_err)
> +			fastrpc_context_schedule_put_work(ctx);
> +		fastrpc_context_put(ctx);
> +		spin_lock(&fl->lock);
> +	}
> +	spin_unlock(&fl->lock);

[Severity: Medium]
Does fastrpc_device_release() leak timed-out contexts that were left on
fl->pending?

When a kernel invoke times out (-ETIMEDOUT), bail: drops only the invoker
reference and leaves ctx linked on fl->pending holding its worker reference
and its reference on fl.  If the file descriptor is then closed and
fastrpc_release_current_dsp_process() succeeds, the DSP process is torn
down so no late reply will arrive, but fastrpc_device_release() only drains
fl->interrupted and never drops the worker reference on contexts in
fl->pending, leaking ctx and fl until the rpmsg channel is removed.
Similarly, if an interrupted invoke is retried after SSR sets cctx->rpdev
to NULL, fastrpc_internal_invoke() returns -EPIPE before calling
fastrpc_context_restore_interrupted(), leaving the parked context
unreclaimed until fd close.

[Severity: Medium]
Can parked contexts on fl->interrupted exhaust cctx->ctx_idr and prevent
fastrpc_release_current_dsp_process() from running?

Each parked context holds one of the 255 slots in cctx->ctx_idr until
fastrpc_context_free() runs, even after the DSP has already answered and
dropped the worker reference.  If 255 interrupted contexts accumulate
across the channel before fd close, fastrpc_release_current_dsp_process()
runs before fl->interrupted is drained and fails in fastrpc_context_alloc()
with -ENOSPC, so the DSP is never told to release the process and
fastrpc_device_release() skips scheduling put_work for any unanswered
contexts on fl->interrupted.

[ ... ]

> @@ -2835,13 +2940,16 @@ static void fastrpc_notify_users(struct fastrpc_u=
ser *user)
>  	list_for_each_entry(ctx, &user->pending, node) {
>  		ctx->retval =3D -EPIPE;
>  		complete(&ctx->work);
> -		/*
> -		 * fastrpc_invoke_send() took a second reference for the
> -		 * DSP response that will now never arrive since the
> -		 * channel is gone; schedule the matching put the same
> -		 * way a real response would via fastrpc_rpmsg_callback().
> -		 */
> -		schedule_work(&ctx->put_work);
> +		fastrpc_context_schedule_put_work(ctx);
> +	}
> +	/*
> +	 * Invoker ref for a parked context is released by fastrpc_user_free()
> +	 * or fastrpc_device_release(); this only drops the worker ref.
> +	 */
> +	list_for_each_entry(ctx, &user->interrupted, node) {
> +		ctx->retval =3D -EPIPE;
> +		complete(&ctx->work);
> +		fastrpc_context_schedule_put_work(ctx);
>  	}
>  	spin_unlock(&user->lock);
>  }

[Severity: High]
Does fastrpc_notify_users() deadlock on user->lock when any context is on
user->pending or user->interrupted?

fastrpc_notify_users() holds spin_lock(&user->lock) while calling
fastrpc_context_schedule_put_work(ctx), which immediately calls
spin_lock(&ctx->fl->lock) on the same spinlock (ctx->fl =3D=3D user).

[Severity: High]
Can fastrpc_notify_users() drop a worker reference that was never taken for
a context on user->pending?

fastrpc_context_alloc() links ctx onto user->pending with refcount =3D=3D 1
before fastrpc_get_args() and fastrpc_invoke_send() run, and
fastrpc_invoke_send() only keeps the second reference if rpmsg_send()
succeeds:

CPU0                              CPU1
fastrpc_internal_invoke()
  fastrpc_context_alloc()
    list_add_tail(..., &user->pending)
    kref_init(&ctx->refcount)
  fastrpc_get_args()
                                  fastrpc_rpmsg_remove()
                                    fastrpc_notify_users()
                                      fastrpc_context_schedule_put_work(ctx)
                                  fastrpc_context_put_wq()
                                    fastrpc_context_put(ctx)
                                      fastrpc_context_free(ctx)
  fastrpc_invoke_send()  <-- use-after-free

Because ctx is on user->pending before a successful rpmsg_send(),
put_work drops the invoker's sole reference and frees ctx while
fastrpc_internal_invoke() is still using it.

[ ... ]

> @@ -2932,11 +3036,11 @@ static int fastrpc_rpmsg_callback(struct rpmsg_de=
vice *rpdev, void *data,
>  	complete(&ctx->work);
> =20
>  	/*
> -	 * The DMA buffer associated with the context cannot be freed in
> -	 * interrupt context so schedule it through a worker thread to
> -	 * avoid a kernel BUG.
> +	 * Can't free the DMA buffer in interrupt context; defer to a
> +	 * worker. Guarded: notify_users()/device_release() may also be
> +	 * racing to schedule this for the same ctx.
>  	 */
> -	schedule_work(&ctx->put_work);
> +	fastrpc_context_schedule_put_work(ctx);
> =20
>  	return 0;
>  }

[Severity: High]
Can fastrpc_rpmsg_callback() dereference ctx and ctx->fl after they have
been freed by a concurrent drain?

fastrpc_rpmsg_callback() looks up ctx with idr_find(&cctx->ctx_idr, ctxid)
and drops cctx->lock without taking a reference on ctx, while
fastrpc_device_release() can now drop both the worker and invoker
references on an interrupted context (and fastrpc_context_free() leaves ctx
in cctx->ctx_idr while freeing its maps and DMA buffer):

CPU0                              CPU1
fastrpc_rpmsg_callback()
  spin_lock_irqsave(&cctx->lock)
  ctx =3D idr_find(&cctx->ctx_idr, ...)
  spin_unlock_irqrestore(&cctx->lock)
                                  fastrpc_device_release()
                                    fastrpc_context_schedule_put_work(ctx)
                                    fastrpc_context_put(ctx)
                                  fastrpc_context_put_wq()
                                    fastrpc_context_free()
                                      kfree(ctx)
                                      fastrpc_user_put(fl)
                                        kfree(fl)
  ctx->retval =3D rsp->retval;  <-- use-after-free
  complete(&ctx->work);
  fastrpc_context_schedule_put_work(ctx)
    spin_lock(&ctx->fl->lock);  <-- use-after-free

Even for a context on fl->pending whose put_work already ran from a
teardown path, calling complete(&ctx->work) lets the woken waiter drop the
last reference and free ctx and fl before fastrpc_rpmsg_callback() calls
fastrpc_context_schedule_put_work(ctx).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261117-interrupte=
d-invoke-v4-v4-0-2320a8a7eda2@oss.qualcomm.com?part=3D3
