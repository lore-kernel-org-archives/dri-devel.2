Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0795606A327
	for <dri-devel@archiver.kernel.org>; Sun,  1 Nov 2026 14:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=minlexx.ru header.i=@minlexx.ru header.a=rsa-sha256 header.s=dkim header.b=GZ9afh1O
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06A5510E417;
	Sun,  1 Nov 2026 14:03:38 +0000 (UTC)
Received: from sm24.hosting.reg.ru (sm24.hosting.reg.ru [31.31.198.150])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD16010E3F0;
 Sun,  1 Nov 2026 14:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=minlexx.ru; 
 s=dkim;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:
 Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lMdQIiIkk0TkrTOjfGcf0XDpdmUjXKfpMYJ8odQqD50=; b=GZ9afh1OjLVWhw1FYnm9AB5BRA
 4dSd9SXZrzpPXbz7WKxuww0fe0FzoOnRbJcn4DtLT1cl/u9viXRy3SUaIDEQ6/9EKmKVkuf2KVAXN
 6ocaRPTdvjCDHKOTTqEbWNIsJoqs9gmaMxaUzkwoCRsNZomV+SZIpV3+y+0peQOd9nVU=;
Received: by sm24.hosting.reg.ru with esmtpsa (TLS1.3) tls
 TLS_AES_128_GCM_SHA256 (envelope-from <alexeymin@minlexx.ru>)
 id 1xNW9b-0000000BG97-0Quz; Sun, 01 Nov 2026 17:03:23 +0300
Message-ID: <995af7df-35dd-4169-911d-e9aed81f18d3@minlexx.ru>
Date: Sun, 1 Nov 2026 17:03:22 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/msm/a5xx: Write CP_RB_WPTR under the ring's
 preempt_lock
To: fabricioakio@gmail.com, Rob Clark <robin.clark@oss.qualcomm.com>,
 Sean Paul <sean@poorly.run>, Konrad Dybcio <konradybcio@kernel.org>,
 Akhil P Oommen <akhilpo@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>, Abhinav Kumar
 <abhinav.kumar@linux.dev>, Jessica Zhang <jesszhan0024@gmail.com>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jordan Crouse <jordan@cosmicpenguin.net>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261031-a5xx-wptr-lock-v1-1-fa7d7b9a7fbe@gmail.com>
Content-Language: en-US
From: Alexey Minnekhanov <alexeymin@minlexx.ru>
In-Reply-To: <20261031-a5xx-wptr-lock-v1-1-fa7d7b9a7fbe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-20.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 01.11.2026 05:30, Fabricio Akio via B4 Relay wrote:
> From: Fabricio Akio <fabricioakio@gmail.com>
> 
> CP_RB_WPTR tells the CP how far the ring has been filled. Two functions
> write it: a5xx_flush(), after a submit is added to the ring, and
> update_wptr(), which a5xx_preempt_trigger() calls from the IRQ handler
> each time a submit completes, whenever there is more than one ring,
> even when no ring switch follows. Both read the ring's wptr holding
> ring->preempt_lock, but write the register after releasing it, so the
> two writes can land in the wrong order:
> 
>    CPU A, IRQ:   update_wptr() reads wptr N
>    CPU B, flush: a5xx_flush() reads wptr N+1, writes N+1
>    CPU A, IRQ:   update_wptr() writes N
> 
> CP_RB_WPTR then points behind the last submit. If the CP has already
> read past N, it treats the ring as nearly full and executes the
> commands left over from its previous pass through the ring. This shows
> up as CP opcode errors, and the old submits write old fences, so the
> fence in memptrs goes backwards. Recovery then finds no submit to
> blame and does not reset the GPU, which stays hung until reboot.
> 
> Write the register before releasing the lock in both places, so the
> last value written is always the newest, as a6xx_flush() does.
> 
> Fixes: b1fc2839d2f9 ("drm/msm: Implement preemption for A5XX targets")
> Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
> ---
> Tested on A508 (SDM630), with piglit's texelfetch tests run in
> parallel: CP opcode errors in each of seven one-minute runs, the
> seventh ending in a hang that never recovers; with this, none in 25.
> 
> The downstream driver writes the register holding the ring's
> preempt_lock in both of its places:
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno_ringbuffer.c#L104
> https://github.com/LineageOS/android_kernel_motorola_msm8998/blob/ce9ea8f125c7302ae9b2fec84f23a69271e957c3/drivers/gpu/msm/adreno_a5xx_preempt.c#L25
> ---
>   drivers/gpu/drm/msm/adreno/a5xx_gpu.c     | 10 +++++++---
>   drivers/gpu/drm/msm/adreno/a5xx_preempt.c |  3 +--
>   2 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> index 16c7335c4b1f..63b313328979 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_gpu.c
> @@ -53,14 +53,18 @@ void a5xx_flush(struct msm_gpu *gpu, struct msm_ringbuffer *ring,
>   	/* Make sure to wrap wptr if we need to */
>   	wptr = get_wptr(ring);
>   
> -	spin_unlock_irqrestore(&ring->preempt_lock, flags);
> -
>   	/* Make sure everything is posted before making a decision */
>   	mb();
>   
> -	/* Update HW if this is the current ring and we are not in preempt */
> +	/*
> +	 * Update HW if this is the current ring and we are not in preempt.
> +	 * Under the lock, so that update_wptr() cannot write an older wptr
> +	 * after this one.
> +	 */
>   	if (a5xx_gpu->cur_ring == ring && !a5xx_in_preempt(a5xx_gpu))
>   		gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
> +
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>   }
>   
>   static void a5xx_submit_in_rb(struct msm_gpu *gpu, struct msm_gem_submit *submit)
> diff --git a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
> index e4924b5e1c48..0deac58bc22e 100644
> --- a/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
> +++ b/drivers/gpu/drm/msm/adreno/a5xx_preempt.c
> @@ -47,9 +47,8 @@ static inline void update_wptr(struct msm_gpu *gpu, struct msm_ringbuffer *ring)
>   
>   	spin_lock_irqsave(&ring->preempt_lock, flags);
>   	wptr = get_wptr(ring);
> -	spin_unlock_irqrestore(&ring->preempt_lock, flags);
> -
>   	gpu_write(gpu, REG_A5XX_CP_RB_WPTR, wptr);
> +	spin_unlock_irqrestore(&ring->preempt_lock, flags);
>   }
>   
>   /* Return the highest priority ringbuffer with something in it */
> 
> ---
> base-commit: a39c950806213f6861d00f90729acaaa21f2d95a
> change-id: 20261031-a5xx-wptr-lock-55b151332fcf
> 
> Best regards,
> --
> Fabricio Akio <fabricioakio@gmail.com>

I've been using this patch for a few days on various sdm630/636/660
devices with a508/509/512 and so far haven't seen any GPU hangs.

It's hard to prove definitively that hangs are gone, due to the
random nature of the hang, but at least it didn't make anything
worse.

Tested-by: Alexey Minnekhanov <alexeymin@minlexx.ru>

--
Regards,
Alexey Minnekhanov
