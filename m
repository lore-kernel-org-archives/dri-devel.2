Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B50BFC531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 11:20:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9A8110F377;
	Fri, 24 Jul 2026 11:20:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IUPsUUZY";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D2910F372
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Jul 2026 11:20:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 43EFF40BE3;
 Fri, 24 Jul 2026 11:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E03B71F000E9;
 Fri, 24 Jul 2026 11:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784892025;
 bh=jD9jX3+Wk2O1/peDNwAQtv6BxC4dDJGxHjIwOz7Rdx0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=IUPsUUZYtkF/b023RLp/rHDSgFjCxU83YfGO/x4srwBpb2uraVfiMh7tMYARy9KEQ
 FOkhpEpgOKA4F+Ao2+UTkiUmCJcOKIRv6kQ+zHzH3UXAoFcuymLyXBGuP/uDmCfijM
 VBOjq+OJRA7yGdr5INA4VoI4ay9upZ3IrXhnLLiqkJJJwEZ9JcQ6C36TqD4Rn2cl8X
 jD2RScODGan780x54c5ARPh2IRoadGZjut1FyH7hNl1TZfmGmPqRIqOULZPI7nPDcP
 OFkGol49lwLO3JBQ98Inxc6gFm/39ejBW4IG5GPCrv/MbKFeYn9tEQuWnpmvmFHYwe
 luzV2vCV3JHSQ==
Message-ID: <c0218d64-3b31-4d21-b8c9-e03a4b5a7f91@kernel.org>
Date: Fri, 24 Jul 2026 12:20:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] misc: fastrpc: fix context leak and hang on
 signal-interrupted invoke
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>,
 Srinivas Kandagatla <srini@kernel.org>,
 Amol Maheshwari <amahesh@qti.qualcomm.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jorge Ramirez-Ortiz <jorge.ramirez@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, stable@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
References: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260701-master-v2-1-566bf8b7bd16@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>



On 7/1/26 9:11 AM, Anandu Krishnan E wrote:
> fastrpc invokes work by sending an RPC message to the DSP and blocking
> in wait_for_completion_interruptible() until the DSP responds. If a
> signal arrives during this wait, the syscall returns -ERESTARTSYS and
> the invoke context which holds the in-flight DMA buffers and
> completion state is left stranded in fl->pending.
> 
> On the next syscall attempt (either auto-restarted by the kernel via
> SA_RESTART or manually retried by user-space after EINTR), a fresh
> context is allocated and the RPC message is re-sent to the DSP. This
> has two consequences:
> 
>   - The original context leaks in fl->pending until the file is closed.
>   - The DSP receives a duplicate invocation. If the DSP was mid-way
>     through processing the first request and had issued a reverse RPC
>     call back to the host, the retry sends a new forward request
>     instead of the expected reverse-RPC response. The DSP thread
>     waiting for that response is never woken, causing a hang.
> 
> Fix this by saving the interrupted context to a new fl->interrupted
> list on -ERESTARTSYS. When the same thread retries the invoke with a
> matching sc, restore the context and jump directly to the wait,
> skipping context allocation and message re-send.
> 
> Three additional bugs are also fixed:
> 
> 1. fastrpc_context_save_interrupted() did not drop the extra kref that
>    fastrpc_invoke_send() took, so the worker's put only reached 1 and
>    the context was never freed.  Drop the reference in save_interrupted()
>    so the worker's put reaches 0 and triggers context_free.
> 
> 2. The bail path skipped context cleanup on -ETIMEDOUT, leaking the
>    context.  Remove the -ETIMEDOUT exception so timed-out contexts are
>    freed like any other error path.
> 
> 3. fastrpc_context_free() did not remove the context from fl->interrupted
>    before freeing it.  A context freed via a racing channel removal left
>    a dangling node in the list.  Add list_del_init() guarded by fl->lock
>    before releasing resources.
> 
> Also drain fl->interrupted on process exit, complete any sleeping
> contexts with -EPIPE and schedule put_wq to drop the worker ref when
> the rpmsg channel is removed, and add dev_warn() on TIMEOUT and
> ERESTARTSYS to aid post-mortem debugging.
> 
> Remove the obsolete invoke_interrupted_mmaps mechanism from
> fastrpc_channel_ctx; context resources are now kept alive through the
> context refcount rather than by migrating mmaps to a channel-level list.
> 
> Fixes: 387f625585d1 ("misc: fastrpc: handle interrupted contexts")
> Cc: stable@kernel.org
> Co-developed-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---

Does not apply to linux-next.

Can you rebase and resend.

--srini

> This patch fixes a context leak and DSP hang that occur when a
> fastrpc invoke syscall is interrupted by a signal, along with three
> follow-on bugs found during review.
> 
> Changes in v2:
> - Fix kref imbalance: fastrpc_context_save_interrupted() now drops the
>   extra reference taken by fastrpc_invoke_send(), so the worker's put
>   correctly reaches 0 and triggers context_free.
> - Fix -ETIMEDOUT context leak: remove the ETIMEDOUT exception from the
>   bail path so timed-out kernel invocations go through the same
>   list_del_init + context_put cleanup as all other error paths.
> - Fix dangling node: fastrpc_context_free() now calls list_del_init()
>   under fl->lock before releasing resources, preventing a dangling node
>   in fl->interrupted if a racing channel removal fires put_wq.
> - fastrpc_notify_users() now calls schedule_work(&ctx->put_work) for
>   interrupted contexts to drop the worker ref on channel removal.
> - Add dev_warn() on TIMEOUT and ERESTARTSYS for post-mortem debugging.
> - Use list_del_init() instead of list_del() in the bail path.
> 
> Link to v1: https://lore.kernel.org/all/20260525124222.3082420-1-anandu.e@oss.qualcomm.com/
> ---
>  drivers/misc/fastrpc.c | 101 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 82 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index f3a49384586d..c0859a501617 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -280,7 +280,6 @@ struct fastrpc_channel_ctx {
>  	struct fastrpc_device *secure_fdevice;
>  	struct fastrpc_device *fdevice;
>  	struct fastrpc_buf *remote_heap;
> -	struct list_head invoke_interrupted_mmaps;
>  	bool secure;
>  	bool unsigned_support;
>  	u64 dma_mask;
> @@ -297,6 +296,7 @@ struct fastrpc_user {
>  	struct list_head user;
>  	struct list_head maps;
>  	struct list_head pending;
> +	struct list_head interrupted;
>  	struct list_head mmaps;
>  
>  	struct fastrpc_channel_ctx *cctx;
> @@ -522,6 +522,11 @@ static void fastrpc_user_free(struct kref *ref)
>  		fastrpc_context_put(ctx);
>  	}
>  
> +	list_for_each_entry_safe(ctx, n, &fl->interrupted, node) {
> +		list_del(&ctx->node);
> +		fastrpc_context_put(ctx);
> +	}
> +
>  	list_for_each_entry_safe(map, m, &fl->maps, node)
>  		fastrpc_map_put(map);
>  
> @@ -557,6 +562,12 @@ static void fastrpc_context_free(struct kref *ref)
>  	cctx = ctx->cctx;
>  	fl = ctx->fl;
>  
> +	/* Remove from fl->interrupted if present; no-op for normal paths. */
> +	spin_lock(&fl->lock);
> +	if (!list_empty(&ctx->node))
> +		list_del_init(&ctx->node);
> +	spin_unlock(&fl->lock);
> +
>  	for (i = 0; i < ctx->nbufs; i++)
>  		fastrpc_map_put(ctx->maps[i]);
>  
> @@ -594,6 +605,42 @@ static void fastrpc_context_put_wq(struct work_struct *work)
>  	fastrpc_context_put(ctx);
>  }
>  
> +static void fastrpc_context_save_interrupted(struct fastrpc_invoke_ctx *ctx)
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
> +	struct fastrpc_invoke_ctx *ctx = NULL, *ictx, *n;
> +
> +	spin_lock(&fl->lock);
> +	list_for_each_entry_safe(ictx, n, &fl->interrupted, node) {
> +		if (ictx->pid != current->pid)
> +			continue;
> +		if (ictx->sc != sc || ictx->fl != fl) {
> +			spin_unlock(&fl->lock);
> +			return ERR_PTR(-EINVAL);
> +		}
> +		ctx = ictx;
> +		list_del(&ctx->node);
> +		list_add_tail(&ctx->node, &fl->pending);
> +		break;
> +	}
> +	spin_unlock(&fl->lock);
> +	return ctx;
> +}
> +
>  #define CMP(aa, bb) ((aa) == (bb) ? 0 : (aa) < (bb) ? -1 : 1)
>  static int olaps_cmp(const void *a, const void *b)
>  {
> @@ -1243,8 +1290,6 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  				   struct fastrpc_invoke_args *args)
>  {
>  	struct fastrpc_invoke_ctx *ctx = NULL;
> -	struct fastrpc_buf *buf, *b;
> -
>  	int err = 0;
>  
>  	if (!fl->sctx)
> @@ -1258,6 +1303,14 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  		return -EPERM;
>  	}
>  
> +	if (!kernel) {
> +		ctx = fastrpc_context_restore_interrupted(fl, sc);
> +		if (IS_ERR(ctx))
> +			return PTR_ERR(ctx);
> +		if (ctx)
> +			goto wait;
> +	}
> +
>  	ctx = fastrpc_context_alloc(fl, kernel, sc, args);
>  	if (IS_ERR(ctx))
>  		return PTR_ERR(ctx);
> @@ -1273,11 +1326,20 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  	if (err)
>  		goto bail;
>  
> +wait:
>  	if (kernel) {
> -		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ))
> +		if (!wait_for_completion_timeout(&ctx->work, 10 * HZ)) {
>  			err = -ETIMEDOUT;
> +			dev_warn(fl->sctx->dev,
> +				"fastrpc_invoke: TIMEOUT ctxid=0x%llx handle=0x%x nscalars=%d\n",
> +				ctx->ctxid, handle, ctx->nscalars);
> +		}
>  	} else {
>  		err = wait_for_completion_interruptible(&ctx->work);
> +		if (err == -ERESTARTSYS)
> +			dev_warn(fl->sctx->dev,
> +				"fastrpc_invoke: INTERRUPTED ctxid=0x%llx handle=0x%x nscalars=%d\n",
> +				ctx->ctxid, handle, ctx->nscalars);
>  	}
>  
>  	if (err)
> @@ -1296,21 +1358,15 @@ static int fastrpc_internal_invoke(struct fastrpc_user *fl,  u32 kernel,
>  		goto bail;
>  
>  bail:
> -	if (err != -ERESTARTSYS && err != -ETIMEDOUT) {
> -		/* We are done with this compute context */
> +	if (ctx && err == -ERESTARTSYS) {
> +		fastrpc_context_save_interrupted(ctx);
> +	} else if (ctx) {
>  		spin_lock(&fl->lock);
> -		list_del(&ctx->node);
> +		list_del_init(&ctx->node);
>  		spin_unlock(&fl->lock);
>  		fastrpc_context_put(ctx);
>  	}
>  
> -	if (err == -ERESTARTSYS) {
> -		list_for_each_entry_safe(buf, b, &fl->mmaps, node) {
> -			list_del(&buf->node);
> -			list_add_tail(&buf->node, &fl->cctx->invoke_interrupted_mmaps);
> -		}
> -	}
> -
>  	if (err)
>  		dev_dbg(fl->sctx->dev, "Error: Invoke Failed %d\n", err);
>  
> @@ -1662,6 +1718,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
>  	spin_lock_init(&fl->lock);
>  	mutex_init(&fl->mutex);
>  	INIT_LIST_HEAD(&fl->pending);
> +	INIT_LIST_HEAD(&fl->interrupted);
>  	INIT_LIST_HEAD(&fl->maps);
>  	INIT_LIST_HEAD(&fl->mmaps);
>  	INIT_LIST_HEAD(&fl->user);
> @@ -2460,7 +2517,6 @@ static int fastrpc_rpmsg_probe(struct rpmsg_device *rpdev)
>  	rdev->dma_mask = &data->dma_mask;
>  	dma_set_mask_and_coherent(rdev, DMA_BIT_MASK(32));
>  	INIT_LIST_HEAD(&data->users);
> -	INIT_LIST_HEAD(&data->invoke_interrupted_mmaps);
>  	spin_lock_init(&data->lock);
>  	idr_init(&data->ctx_idr);
>  	data->domain_id = domain_id;
> @@ -2493,13 +2549,23 @@ static void fastrpc_notify_users(struct fastrpc_user *user)
>  		ctx->retval = -EPIPE;
>  		complete(&ctx->work);
>  	}
> +	/*
> +	 * Interrupted contexts hold two refs: one for the invoker and one
> +	 * for the async worker from fastrpc_invoke_send.  Complete them so
> +	 * any blocked retry wakes, and schedule put_wq to drop the worker
> +	 * ref -- the invoker ref is released by fastrpc_user_free().
> +	 */
> +	list_for_each_entry(ctx, &user->interrupted, node) {
> +		ctx->retval = -EPIPE;
> +		complete(&ctx->work);
> +		schedule_work(&ctx->put_work);
> +	}
>  	spin_unlock(&user->lock);
>  }
>  
>  static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  {
>  	struct fastrpc_channel_ctx *cctx = dev_get_drvdata(&rpdev->dev);
> -	struct fastrpc_buf *buf, *b;
>  	struct fastrpc_user *user;
>  	unsigned long flags;
>  
> @@ -2516,9 +2582,6 @@ static void fastrpc_rpmsg_remove(struct rpmsg_device *rpdev)
>  	if (cctx->secure_fdevice)
>  		misc_deregister(&cctx->secure_fdevice->miscdev);
>  
> -	list_for_each_entry_safe(buf, b, &cctx->invoke_interrupted_mmaps, node)
> -		list_del(&buf->node);
> -
>  	if (cctx->remote_heap)
>  		fastrpc_buf_free(cctx->remote_heap);
>  
> 
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260701-master-2ba6246f29d1
> 
> Best regards,
> --  
> Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> 

