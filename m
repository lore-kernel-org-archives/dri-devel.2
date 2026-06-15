Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE6BCD98C7
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 11:11:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EF0510E358;
	Mon, 15 Jun 2026 11:11:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="LK9Id9nZ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EF5E10E3AB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 11:11:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J8z5/sBeVOpFzThk6XKqFMnyqBylHs8OOOz6fH6jtSs=; b=LK9Id9nZVRTEVSssYLvokciwVF
 BmeDksX8NLhe6ZIf2XcuE5640CK+bd7DozUbOoclTOnIMy/E7RtjBLksHWEwKowsr0OXn/mx3UQWn
 /sXmgIHX8zEGm0rSR6zWLotak07zwZlXZqFtiFZKVXZUDztW7jW5ypzi48CCaGqc3wF0s9AFjNGqi
 ITQZNMvwSKWU7xPYtRxWprhCMCatddtamFprgedV+58N5pWrYF5idbvJKBAbRScjJGJWxMBTbQygV
 0EzVoUXb/1znnnaTM+vCRqekQQ6vH2NAlF4gcSlMlJvo2gqnDqOcFjcp81BfpZfQ6k7bKbzbsyOmz
 kOpUkZBQ==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wZ5EA-000CQq-Qf; Mon, 15 Jun 2026 13:11:38 +0200
Message-ID: <3834b1d6-c78f-45b8-aa12-d464a770747c@igalia.com>
Date: Mon, 15 Jun 2026 12:11:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] dma-buf/dma_fence: Make races for
 dma_fence_is_signaled() less likely
To: Philipp Stanner <phasta@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 "Paul E . McKenney" <paulmck@kernel.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260612104251.2264707-2-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260612104251.2264707-2-phasta@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 12/06/2026 11:42, Philipp Stanner wrote:
> dma_fence_is_signaled() returns whether a fence has been signaled
> already. That function contains a fast path opportunistic check which is
> not guarded by the lock and, according to Christian, cannot be guarded
> by the lock without causing a massive performance regression.
> 
> This now means that dma_fence_is_signaled() can return true WHILE the
> fence callbacks are still being executed. This is razy and has lead to
> at least one bug solved in:
> 
> commit c8a5d5ea3ba6 ("nouveau: fix client work fence deletion race")
> 
> Make this race impossible, by simply setting the bit only once the
> callbacks are actually completed.

My 2c is that I would be wary of trying to turn around the semantics of 
the callbacks. They are not "run these to make the fence signaled" but 
instead "let me know please when fence is signaled". I do not see a good 
justification for the change.

The bugs such as above quoted c8a5d5ea3ba6 are in fact more about 
nouveau itself pulling data underneath fences with callbacks and not a 
bug in dma-fence. With the opportunistic cleanup it is doing in 
nouveau_cli_work() perhaps it would want to use 
dma_fence_remove_callback() to appear somewhat sensible, although that 
too may be racy, I did not think about it. Anyway, I've sent a patch to 
make that one clearer and more documented, even faster for the 
unsignaled case.

Regards,

Tvrtko

> 
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/dma-buf/dma-fence.c | 18 ++++++++++++++++--
>   1 file changed, 16 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index c7ea1e75d38a..2416cc86ce93 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -359,8 +359,19 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>   
>   	dma_fence_assert_held(fence);
>   
> -	if (unlikely(test_and_set_bit(DMA_FENCE_FLAG_SIGNALED_BIT,
> -				      &fence->flags)))
> +	/*
> +	 * First test the bit, so we don't signal an already signaled fence again.
> +	 * The lock protects against multiple parties setting the bit. The bit
> +	 * is then set at the end of the function.
> +	 *
> +	 * The background is that there is a fast path check in
> +	 * dma_fence_is_signaled() which does not use lock protection and can
> +	 * return true *while* the fence callbacks are still executing.
> +	 *
> +	 * This fast path check supposedly cannot be guarded by the lock because
> +	 * of significant performance regressions.
> +	 */
> +	if (unlikely(test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>   		return;
>   
>   	trace_dma_fence_signaled(fence);
> @@ -384,6 +395,9 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>   		INIT_LIST_HEAD(&cur->node);
>   		cur->func(fence, cur);
>   	}
> +
> +	// TODO: we need some barrier here, don't we?
> +	set_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>   }
>   EXPORT_SYMBOL(dma_fence_signal_timestamp_locked);
>   

