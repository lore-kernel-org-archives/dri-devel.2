Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485960A2617
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=LsZ1fmjm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E19A511295B;
	Fri, 27 Nov 2026 09:58:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BB75112945;
 Fri, 27 Nov 2026 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=yXj7w+SlMaiRBUZsn6J/bqUjIs54ac3hp9HOdW3R43o=; t=1795773477; x=2111133477; 
 b=LsZ1fmjmxVVsNFhfcZNsBHpX4dJTFhJfPZY151y57DAqR1KO0Txqz+eDty8EPXjAQqi5pTIehOi
 wsc33slTwCxN98h7+BWix1VjdvcqPlOcRQNVc9rm2RPvKCvzr1wIorbHqE4dKgFgBnXio7ZxPBGaq
 AMAkC6UVrGwMPkRATT/Hm/cyv17FXQbw/wP8nMvYwwdgXlElrRUKY2lDBBBZHOwnWkDEuStvHd9Wg
 aNd4A/Gya8CMaxawWgYvjvL4DjVzXy75GRDldks7kOhN06lShYDNAQzT8XOOH/CQoTV28VMc8miAL
 9hwZP/GLAwUITFiRFVyOrAkQw+ZnEfyDkr1w==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWsiC-00000004jyl-3AGZ; Fri, 27 Nov 2026 10:57:48 +0100
Message-ID: <71b2506f-8534-468e-881d-1abf8f8224d9@igalia.com>
Date: Fri, 27 Nov 2026 09:57:47 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/amdgpu: Hot-fix timestamp misordering
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
 <20261126172046.2473303-5-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261126172046.2473303-5-phasta@kernel.org>
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
> dma_fence timestamps could so far be written and read without any memory
> ordering, a bug that presumably got overlooked because x86 is strongly
> ordered.
> 
> Hot-fix amdgpu's manual timestamp evaluation until we found a more
> suitable solution for mainline linux.
> 
> Cc: stable@vger.kernel.org
> Fixes: af0b54167009 ("drm/amdgpu: Convert to common fdinfo format v5")

Not sure the fixes target is strictly correct since timestamp access 
goes even further back, but I guess it is good enough for GPU stats.

Please just add some sort of an impact assessment and bug description to 
the commit text. With that:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> index 2f0349233695..415f23aa08a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
> @@ -177,11 +177,11 @@ static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
>   
>   	/* When the fence is not even scheduled it can't have spend time */
>   	s_fence = to_drm_sched_fence(fence);
> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
> +	if (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
>   		return ns_to_ktime(0);
>   
>   	/* When it is still running account how much already spend */
> -	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
> +	if (!test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
>   		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
>   
>   	return ktime_sub(s_fence->finished.timestamp,

