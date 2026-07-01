Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB85C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:14:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141F910EE7F;
	Wed,  1 Jul 2026 09:14:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="DsTVFV9J";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D311410EE80
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1TYMgFbsZk3C4VsIV6cOCwS3sYW9gqVKz0hDjm9HJmM=; b=DsTVFV9JoWtCweWr6kX9IAi8At
 PwNORQnTyasxMakqw37DYc/UVQ78O17cKXNxZ78IJt58z4QiyS+D7s8qeiICGF/rV/U3sjRAitSk7
 9X6TxB4wf3rOtAEoHXcXYVDtq3RBpjRxQfIfyJ2qXMhyCu40vQL23TqECUXg6F7pIE6KsFz9gpNW5
 IeG225lYq2xAtjbZXpVKALwhGO6x+Go/V3cMnbAWcTONjC6CL72iB4Gohkcwl/+jLpbKEvzMh9lmc
 +zqeRXiFunlgCIalJED+qTMcV8VJm4GlbsCHSQRmAbsMn2DQpAN6g0nIrTkcS1LULjrvKYOjkYqbz
 E+jl5jLA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1wer1C-007UF9-1h; Wed, 01 Jul 2026 11:14:06 +0200
Message-ID: <6f4a8e96-db41-4609-8c84-54d847911857@igalia.com>
Date: Wed, 1 Jul 2026 10:14:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/amdgpu: use dma_fence_test_signaled_flag()
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch,
 sumit.semwal@linaro.org, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-4-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260624122917.2483-4-christian.koenig@amd.com>
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
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c       | 8 ++++----
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c        | 2 +-
>   drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c | 2 +-
>   3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index ea69b1bac7c6..1192b9800ff2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -652,7 +652,7 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
>   
>   		fence = rcu_dereference_protected(drv->fences[i],
>   						  lockdep_is_held(&drv->lock));
> -		if (fence && !dma_fence_is_signaled_locked(fence))
> +		if (fence && !dma_fence_test_signaled_flag(fence))
>   			dma_fence_set_error(fence, error);
>   	}
>   	spin_unlock_irqrestore(&drv->lock, flags);
> @@ -677,7 +677,7 @@ void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring,
>   
>   		fence = rcu_dereference_protected(drv->fences[i],
>   						  lockdep_is_held(&drv->lock));
> -		if (fence && !dma_fence_is_signaled_locked(fence)) {
> +		if (fence && !dma_fence_test_signaled_flag(fence)) {
>   			if (fence == timedout_fence)
>   				dma_fence_set_error(fence, -ETIME);
>   			else
> @@ -738,7 +738,7 @@ void amdgpu_ring_set_fence_errors_and_reemit(struct amdgpu_ring *ring,
>   		rcu_read_lock();
>   		unprocessed = rcu_dereference(*ptr);
>   
> -		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
> +		if (unprocessed && !dma_fence_test_signaled_flag(unprocessed)) {
>   			fence = container_of(unprocessed, struct amdgpu_fence, base);
>   			is_guilty_fence = fence == guilty_fence;
>   			is_guilty_context = fence->context == guilty_fence->context;
> @@ -802,7 +802,7 @@ void amdgpu_ring_backup_unprocessed_commands(struct amdgpu_ring *ring,
>   		rcu_read_lock();
>   		unprocessed = rcu_dereference(*ptr);
>   
> -		if (unprocessed && !dma_fence_is_signaled(unprocessed)) {
> +		if (unprocessed && !dma_fence_test_signaled_flag(unprocessed)) {
>   			fence = container_of(unprocessed, struct amdgpu_fence, base);
>   
>   			amdgpu_ring_backup_unprocessed_command(ring, fence);

No fence->ops->signaled so all good.

> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> index d6bee5c30073..ae9d6a2eefab 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
> @@ -460,7 +460,7 @@ bool amdgpu_ring_soft_recovery(struct amdgpu_ring *ring, unsigned int vmid,
>   		return false;
>   
>   	dma_fence_lock_irqsave(fence, flags);
> -	if (!dma_fence_is_signaled_locked(fence))
> +	if (!dma_fence_test_signaled_flag(fence))
>   		dma_fence_set_error(fence, -ENODATA);
>   	dma_fence_unlock_irqrestore(fence, flags);

A bit of an odd function? With this change it becomes:

	dma_fence_lock_irqsave(fence, flags);
	if (!dma_fence_test_signaled_flag(fence))
		dma_fence_set_error(fence, -ENODATA);
	dma_fence_unlock_irqrestore(fence, flags);

	while (!dma_fence_is_signaled(fence) &&
	       ktime_to_ns(ktime_sub(deadline, ktime_get())) > 0)
		ring->funcs->soft_recovery(ring, vmid);

	ret = dma_fence_is_signaled(fence);

Does this flow make sense?

>   
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> index a41fb72dba94..2cc6552a6399 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
> @@ -426,7 +426,7 @@ amdgpu_userq_fence_driver_set_error(struct amdgpu_userq_fence *fence,
>   
>   	f = rcu_dereference_protected(&fence->base,
>   				      lockdep_is_held(&fence_drv->fence_list_lock));
> -	if (f && !dma_fence_is_signaled_locked(f))
> +	if (f && !dma_fence_test_signaled_flag(f))
>   		dma_fence_set_error(f, error);
>   	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
>   }

amdgpu_userq_fence_signaled does exists so is there any scope for this 
to open a false positive window?

Regards,

Tvrtko

