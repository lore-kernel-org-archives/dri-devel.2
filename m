Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F4F606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=TezH2T42
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B06E1128DD;
	Fri, 27 Nov 2026 09:44:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 485BE10E8DD;
 Fri, 27 Nov 2026 09:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=YS6RQcF5xRu5MqtlX1y7izCl88BcWh1ymA2UFCjdAF0=; t=1795772652; x=2111132652; 
 b=TezH2T42/uSF0bzZxbsOCN0cl0zwX5WYDR5DiPHZZqT8HloX/3maBjeGHy3P6vrPWEXq0PYxfNB
 BURI71NYo9WHZgFj0TaBQUt1J4U7Fx2alIqT51bkSw/FXvMV/AZElSw7z8KSkcvQokF+942Q1qNZj
 NYrd6OsmTNoBr894/US9IHZKDAyVAxxMVF4cWLgpdX0/I2IqjAAWQf/aig/BfuvQ3vvp1marp2jiw
 1sj48ILsY1MFf4Ir3QJydCMB/4tgOSjtRm8qEgLP704B59L/OlyirFzKKHtncy8F8EuGC1HPqCtAd
 rF6FCQ9QQZbpTntrU9GoKLWGTFl3xsZB3Kyw==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWsUo-00000004jhB-2KyE; Fri, 27 Nov 2026 10:43:58 +0100
Message-ID: <d01bbab4-9741-462a-bf98-0d4eacec48e8@igalia.com>
Date: Fri, 27 Nov 2026 09:43:56 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dma-buf: dma-fence: Hot-fix timestamp misordering
To: Philipp Stanner <phasta@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthew Brost <matthew.brost@intel.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Gustavo Padovan <gustavo.padovan@collabora.com>,
 Chris Wilson <chris@chris-wilson.co.uk>, Luben Tuikov <ltuikov89@gmail.com>,
 Shashank Sharma <shashank.sharma@amd.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, Gary Guo <gary@garyguo.net>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 stable@vger.kernel.org
References: <20261126172046.2473303-2-phasta@kernel.org>
 <20261126172046.2473303-3-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261126172046.2473303-3-phasta@kernel.org>
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
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 26/11/2026 17:20, Philipp Stanner wrote:
> fence timestamps can be written and read without any memory ordering
> since, presumably, forever. This can cause real bugs, other than false
> accounting, for parties whose algorithms depend on the timestamp.
> 
> Hot-fix the problem for now so that it can be backported until we found
> a suitable way forward for mainline.
> 
> Cc: stable@vger.kernel.org
> Fixes: 76250f2b743b ("dma-buf/fence: Avoid use of uninitialised timestamp")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/dma-buf/dma-fence.c | 9 +++++++++
>   include/linux/dma-fence.h   | 8 ++++++--
>   2 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
> index bd58688b81a7..8a842fc8168f 100644
> --- a/drivers/dma-buf/dma-fence.c
> +++ b/drivers/dma-buf/dma-fence.c
> @@ -378,6 +378,15 @@ void dma_fence_signal_timestamp_locked(struct dma_fence *fence,
>   	list_replace(&fence->cb_list, &cb_list);
>   
>   	fence->timestamp = timestamp;
> +	/*
> +	 * TODO:
> +	 * This is a temporary hotfix to prevent misordering until we
> +	 * can completely remove the TIMESTAMP bit.
> +	 *
> +	 * The counterpart of this barrier are the test_bit_acquire()s in
> +	 * dma_fence_timestamp().
> +	 */
> +	smp_mb__before_atomic();
>   	set_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags);
>   
>   	list_for_each_entry_safe(cur, tmp, &cb_list, node) {
> diff --git a/include/linux/dma-fence.h b/include/linux/dma-fence.h
> index 64330bf52561..6b16095e8521 100644
> --- a/include/linux/dma-fence.h
> +++ b/include/linux/dma-fence.h
> @@ -715,10 +715,14 @@ static inline void dma_fence_set_error(struct dma_fence *fence,
>    */
>   static inline ktime_t dma_fence_timestamp(struct dma_fence *fence)
>   {
> -	if (WARN_ON(!test_bit(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
> +	/*
> +	 * The test_bit_acquire() calls order against the
> +	 * smp_mb__before_atomic() in dma_fence_signal_timestamp_locked().
> +	 */
> +	if (WARN_ON(!test_bit_acquire(DMA_FENCE_FLAG_SIGNALED_BIT, &fence->flags)))
>   		return ktime_get();

This one I think could stay as is since there is no point to have two 
barriers in sequence.

>   
> -	while (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
> +	while (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &fence->flags))
>   		cpu_relax();
>   
>   	return fence->timestamp;

The rest looks good to me.

I would also probably expand the commit message to actually explain what 
practical bugs and races the patch on its own fixes. Which would be all 
callers of dma_fence_timestamp, right? AFAIU they are all vulnerable to 
observing missing/torn timestamp on weakly ordered architectures.

Regards,

Tvrtko

