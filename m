Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70A46C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 09:33:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB11710E33E;
	Wed,  1 Jul 2026 09:33:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="KX/VdJNn";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9D32310E33E
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 09:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
 References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lm2Lg0hziBPY14rNCyh+OlmQO8mTF2pGDV9lHYkkkSw=; b=KX/VdJNnQ0IWoRI8RlRbfGpInE
 7aC6wxDtZNSnwF/1iEyDH21N5CMR/+Lpco0mzVAxxyAOBBdE8iw37SEydgRNK3oKLduLsALL/wxZx
 oHTBJvg+O10p1V9TRuSBA7NMUPmwJgA6zkVbvp7DuZuidR1m8qMMXz+/OwfnhJIbMXZtEpVCn6iwy
 IrmQCM5E73J5lqw4jBUcoWkNXxMbDZ3S6CohGeds2sYw4UUvMcKWMNHEbpzMnN7myb0wvoiBDa+Sy
 x+MiRQi9NWST2pKnShCfvcG0fANhBmcsoDQ4nmX3p6RrPRLzLvrdZXuPc3Leuc65SFLlqK6AwEUms
 LuOUNcgA==;
Received: from [90.240.106.137] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1werJM-007Udi-K1; Wed, 01 Jul 2026 11:32:52 +0200
Message-ID: <2c80b1d3-88f1-414d-a401-29ba56a6132b@igalia.com>
Date: Wed, 1 Jul 2026 10:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] dma-buf: remove dma_fence_is_signaled_locked()
To: christian.koenig@amd.com, phasta@kernel.org, simona@ffwll.ch,
 sumit.semwal@linaro.org, dakr@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260624122917.2483-1-christian.koenig@amd.com>
 <20260624122917.2483-8-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260624122917.2483-8-christian.koenig@amd.com>
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
> Finally remove one of the biggest trouble makers in the dma_fence
> handling.
> 
> The signaled callback is now consistently called without holding the
> dma_fence lock.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> ---
>   include/linux/dma-fence.h | 36 ------------------------------------
>   1 file changed, 36 deletions(-)
> 
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 803e10ca76e3..ad69acbea218 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -493,40 +493,6 @@ dma_fence_test_signaled_flag(struct dma_fence *fence)
>   	return test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags);
>   }
>   
> -/**
> - * dma_fence_is_signaled_locked - Return an indication if the fence
> - *                                is signaled yet.
> - * @fence: the fence to check
> - *
> - * Returns true if the fence was already signaled, false if not. Since this
> - * function doesn't enable signaling, it is not guaranteed to ever return
> - * true if dma_fence_add_callback(), dma_fence_wait() or
> - * dma_fence_enable_sw_signaling() haven't been called before.
> - *
> - * This function requires &dma_fence.lock to be held.
> - *
> - * See also dma_fence_is_signaled().
> - */
> -static inline bool
> -dma_fence_is_signaled_locked(struct dma_fence *fence)
> -{
> -	const struct dma_fence_ops *ops;
> -
> -	if (dma_fence_test_signaled_flag(fence))
> -		return true;
> -
> -	rcu_read_lock();
> -	ops = rcu_dereference(fence->ops);
> -	if (ops && ops->signaled && ops->signaled(fence)) {
> -		rcu_read_unlock();
> -		dma_fence_signal_locked(fence);
> -		return true;
> -	}
> -	rcu_read_unlock();
> -
> -	return false;
> -}
> -
>   /**
>    * dma_fence_is_signaled - Return an indication if the fence is signaled yet.
>    * @fence: the fence to check
> @@ -540,8 +506,6 @@ dma_fence_is_signaled_locked(struct dma_fence *fence)
>    * operation is complete, it makes it possible to prevent issues from
>    * wraparound between time of issue and time of use by checking the return
>    * value of this function before calling hardware-specific wait instructions.
> - *
> - * See also dma_fence_is_signaled_locked().
>    */
>   static inline bool
>   dma_fence_is_signaled(struct dma_fence *fence)

Assuming the rest of the series plays out to this point:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

