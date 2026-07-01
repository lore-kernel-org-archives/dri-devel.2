Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4204C43327
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:45:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00F6C10E32B;
	Wed,  1 Jul 2026 08:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CNK8dPCz";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104E310E315
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 08:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vcr9hDLfN5srlwZ5qfiqQl9LSdudUQDmJHBwn+BWzxc=; b=CNK8dPCzUY0KTxowYj9l/wPf5V
 Xq4Lh9DqMwr/uiu0tjxHrFyffPmPDpMlIQ0woTTCjARljDZaocyLZ/4bfNEMG+92YQ5X7QtBHGt+Z
 ekSNdDbXziQzudZ8pDOSDjkPJZUY0q5IDh2E+IYHn6NC6DwDs37HFtIvp4Jh9qobyZG6epO1SUSf+
 Fcku8rZcAme5wPNLexwQHBEiJQ3+C5KstkLiklRE1FKM5ySzcWTSrolioRughWoWWxl7l9QpFObQU
 ybpv9aBxSgoxOe8hSI5EZir4Ski7mJ6HmdHV18l/FPYq4njK14Xwe5mdPCi+qBiJhHhso+dTLbPU3
 Ut03HdTg==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1weqYt-007Tf1-I4; Wed, 01 Jul 2026 10:44:51 +0200
Message-ID: <d30b496e-2971-429d-b49d-4fe6e15a1830@igalia.com>
Date: Wed, 1 Jul 2026 09:44:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] dma-buf: use dma_fence_test_signaled_flag()
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch,
 sumit.semwal@linaro.org, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-3-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260624122917.2483-3-christian.koenig@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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


On 24/06/2026 12:13, Christian König wrote:
> Instead of dma_fence_is_signaled_locked() use
> dma_fence_test_signaled_flag().
> 
> The extra polling check seems unecessary for those use cases.

I echo the comment that better commit messages are needed in this 
series. Also, the patch affects two really different areas so should be 
split in two.

> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/dma-buf/sw_sync.c | 2 +-
>   include/linux/dma-fence.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/sw_sync.c b/drivers/dma-buf/sw_sync.c
> index 8df20b0218a9..243991bc1506 100644
> --- a/drivers/dma-buf/sw_sync.c
> +++ b/drivers/dma-buf/sw_sync.c
> @@ -262,7 +262,7 @@ static struct sync_pt *sync_pt_create(struct sync_timeline *obj,
>   	INIT_LIST_HEAD(&pt->link);
>   
>   	spin_lock_irq(&obj->lock);
> -	if (!dma_fence_is_signaled_locked(&pt->base)) {
> +	if (!dma_fence_test_signaled_flag(&pt->base)) {
>   		struct rb_node **p = &obj->pt_tree.rb_node;
>   		struct rb_node *parent = NULL;
>   

I am not familiar with the implementation but this looks safe to me. It 
appears the point is to just not allow userspace inserting past fences 
into the internal tracking structures.

> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 158cd609f103..803e10ca76e3 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -658,7 +658,7 @@ static inline struct dma_fence *dma_fence_later(struct dma_fence *f1,
>    */
>   static inline int dma_fence_get_status_locked(struct dma_fence *fence)
>   {
> -	if (dma_fence_is_signaled_locked(fence))
> +	if (dma_fence_test_signaled_flag(fence))
>   		return fence->error ?: 1;
>   	else
>   		return 0;

This one has more callers.

1. sync_fence - should be fine.
2. amdgpu - Smallish false positive race on reset? But possibly okay. 
Your call.
3. Selftests - single threaded so okay.
4. Nouveau - looks like some sort of a last gasp check for signaled 
status when wait expired. It's a 15 second timeout so I guess fine as well.

So in summary, changes look fine to me. But I would split sw_sync and 
get_status and improve the commit message for both.

Regards,

Tvrtko

