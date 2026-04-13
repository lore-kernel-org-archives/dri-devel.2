Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 704CFF34C51
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:09:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B9B6310E356;
	Mon, 13 Apr 2026 13:09:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jT41lC8D";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DF0810E356
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:09:47 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8762760180;
 Mon, 13 Apr 2026 13:09:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C03C2BCAF;
 Mon, 13 Apr 2026 13:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776085786;
 bh=QH4op4dHbe6CRQlnjS84cCg4rHaeQIrs68CfPk8Sve0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=jT41lC8DISD2F4dGfcj6RIGhv7q20V0phG9qjWx36XlwfbVdlOypTzNaIpOQ8Q2ii
 UtSLRsvtJnn5JVqyZ8HYZS2NVu11vGe8lHEJnqPp/GzxhH/Ux/XlKSJVViP9xlifWc
 RjGaBUSF/RR8yrW63l0DUgzdPM8MF8vv8wsozHSU25f4xdhWT2eDEuAckKWRMKkU4g
 bRX2w/1ItePkQrGI8ZU39ySEBmDNvtcRmK28gJNPoS7jOUnIT6SBWuWGtKOrQh7WAC
 ydicU1JytMrgmTLxCQDMdXz5gfTHK4DS5W6W4vpzEKLri9AW9xE9Q/yG2uGGNiQjea
 Hzb1wWQyG9MTw==
Message-ID: <c0506a61-c5fb-4962-8bf1-6715178860b2@kernel.org>
Date: Mon, 13 Apr 2026 13:09:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] misc: fastrpc: Add reference counting for fastrpc_user
 structure
To: Anandu Krishnan E <anandu.e@oss.qualcomm.com>, srini@kernel.org,
 linux-arm-msm@vger.kernel.org
Cc: gregkh@linuxfoundation.org, quic_bkumar@quicinc.com,
 linux-kernel@vger.kernel.org, quic_chennak@quicinc.com,
 dri-devel@lists.freedesktop.org, arnd@arndb.de,
 ekansh.gupta@oss.qualcomm.com, stable@kernel.org
References: <20260226151121.818852-1-anandu.e@oss.qualcomm.com>
Content-Language: en-US
From: Srinivas Kandagatla <srini@kernel.org>
In-Reply-To: <20260226151121.818852-1-anandu.e@oss.qualcomm.com>
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



On 2/26/26 3:11 PM, Anandu Krishnan E wrote:
> Add reference counting using kref to the fastrpc_user structure to
> prevent use-after-free issues when contexts are freed from workqueue
> after device release.
> 
> The issue occurs when fastrpc_device_release() frees the user structure
> while invoke contexts are still pending in the workqueue. When the
> workqueue later calls fastrpc_context_free(), it attempts to access
> buf->fl->cctx in fastrpc_buf_free(), leading to a use-after-free:

I guess these are some of the pending invoke requests that are still
processing and receive callback after user closes the device.

> 
>   pc : fastrpc_buf_free+0x38/0x80 [fastrpc]
>   lr : fastrpc_context_free+0xa8/0x1b0 [fastrpc]
>   ...
>   fastrpc_context_free+0xa8/0x1b0 [fastrpc]
>   fastrpc_context_put_wq+0x78/0xa0 [fastrpc]
>   process_one_work+0x180/0x450
>   worker_thread+0x26c/0x388
> 
> Implement proper reference counting to fix this:
> - Initialize kref in fastrpc_device_open()
> - Take a reference in fastrpc_context_alloc() for each context
> - Release the reference in fastrpc_context_free() when context is freed
> - Release the initial reference in fastrpc_device_release()
> 
> This ensures the user structure remains valid as long as there are
> contexts holding references to it, preventing the race condition.
> 
> Fixes: 6cffd79504ce ("misc: fastrpc: Add support for dmabuf exporter")
> Cc: stable@kernel.org
> Signed-off-by: Anandu Krishnan E <anandu.e@oss.qualcomm.com>
> ---
>  drivers/misc/fastrpc.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index 47356a5d5804..3ababcf327d7 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -310,6 +310,8 @@ struct fastrpc_user {
>  	spinlock_t lock;
>  	/* lock for allocations */
>  	struct mutex mutex;
> +	/* Reference count */
> +	struct kref refcount;
>  };
>  
>  /* Extract SMMU PA from consolidated IOVA */
> @@ -497,15 +499,36 @@ static void fastrpc_channel_ctx_put(struct fastrpc_channel_ctx *cctx)
>  	kref_put(&cctx->refcount, fastrpc_channel_ctx_free);
>  }
>  
> +static void fastrpc_user_free(struct kref *ref)
> +{
> +	struct fastrpc_user *fl = container_of(ref, struct fastrpc_user, refcount);
> +
> +	fastrpc_channel_ctx_put(fl->cctx);
> +	mutex_destroy(&fl->mutex);
> +	kfree(fl);
> +}
> +
> +static void fastrpc_user_get(struct fastrpc_user *fl)
> +{
> +	kref_get(&fl->refcount);
> +}
> +
> +static void fastrpc_user_put(struct fastrpc_user *fl)
> +{
> +	kref_put(&fl->refcount, fastrpc_user_free);
> +}
> +
>  static void fastrpc_context_free(struct kref *ref)
>  {
>  	struct fastrpc_invoke_ctx *ctx;
>  	struct fastrpc_channel_ctx *cctx;
> +	struct fastrpc_user *fl;
>  	unsigned long flags;
>  	int i;
>  
>  	ctx = container_of(ref, struct fastrpc_invoke_ctx, refcount);
>  	cctx = ctx->cctx;
> +	fl = ctx->fl;
>  
>  	for (i = 0; i < ctx->nbufs; i++)
>  		fastrpc_map_put(ctx->maps[i]);
> @@ -521,6 +544,8 @@ static void fastrpc_context_free(struct kref *ref)
>  	kfree(ctx->olaps);
>  	kfree(ctx);
>  
> +	/* Release the reference taken in fastrpc_context_alloc() */
> +	fastrpc_user_put(fl);
>  	fastrpc_channel_ctx_put(cctx);
>  }
>  
> @@ -628,6 +653,8 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  
>  	/* Released in fastrpc_context_put() */
>  	fastrpc_channel_ctx_get(cctx);
> +	/* Take a reference to user, released in fastrpc_context_free() */
> +	fastrpc_user_get(user);
>  
>  	ctx->sc = sc;
>  	ctx->retval = -1;
> @@ -658,6 +685,7 @@ static struct fastrpc_invoke_ctx *fastrpc_context_alloc(
>  	spin_lock(&user->lock);
>  	list_del(&ctx->node);
>  	spin_unlock(&user->lock);
> +	fastrpc_user_put(user);
>  	fastrpc_channel_ctx_put(cctx);
>  	kfree(ctx->maps);
>  	kfree(ctx->olaps);
> @@ -1606,11 +1634,9 @@ static int fastrpc_device_release(struct inode *inode, struct file *file)
>  	}
>  
>  	fastrpc_session_free(cctx, fl->sctx);
> -	fastrpc_channel_ctx_put(cctx);
> -
> -	mutex_destroy(&fl->mutex);
> -	kfree(fl);
>  	file->private_data = NULL;
> +	/* Release the reference taken in fastrpc_device_open */
> +	fastrpc_user_put(fl);

Now that we are trying to handle(wait) for the cases where wq will get
callbacks after the fd is closed, how are we making sure that memory
associated with these invoke, init memory and mmaps are not released?



Also now that we have a refcount for the fastrpc_user, is it possible to
 remove the refcount on the context, as this seems redundant now, we
could just use the user refcount instead. May be other patch..


--srini
>  
>  	return 0;
>  }
> @@ -1654,6 +1680,7 @@ static int fastrpc_device_open(struct inode *inode, struct file *filp)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	list_add_tail(&fl->user, &cctx->users);
>  	spin_unlock_irqrestore(&cctx->lock, flags);
> +	kref_init(&fl->refcount);
>  
>  	return 0;
>  }

