Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15FEA606A681
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 09:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.a=rsa-sha256 header.s=20170329 header.b=m6NcUAM/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA123112940;
	Fri, 27 Nov 2026 09:55:33 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3441911292C;
 Fri, 27 Nov 2026 09:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=dTrW+ugQeCUDhYN5x3PZPy/j2Ws0a4l3FCniePr73/o=; t=1795773319; x=2111133319; 
 b=m6NcUAM/UpttU7W6UGMLYYIWsYRB5s7UNClUZfAijvvFCaygqijj5REXyavQGoWDAn/jxlGyFL2
 BtvDXdvqzKU1yMOquhGZ0z7l96HYc2eq9c8qn1TQyI5lwQGCeA3Pp6vbVq2jzdVNkEqWXyNiCDQcY
 vOTqVeIX4ySsbbxAsm4BIePWfJOD61pXIU6dnTUEWDIhBMj6872QopkSjk0Ph2F0YIrRFwLn8deeS
 l8olOaBnAxz8crWMkUKyZU+k0g8aqLthTOGzJQSpP4e0+DJ11Jl8Men7oG2SzdQoCLi36/1zv1EOC
 sb4pQfqjLb9xAjUs1BQR/OfDlaWkYE68AxTg==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1xWsfd-00000004jsI-2PMn; Fri, 27 Nov 2026 10:55:09 +0100
Message-ID: <50bf27a3-5475-4bc4-83ee-37312c7e4e1e@igalia.com>
Date: Fri, 27 Nov 2026 09:55:08 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] drm/sched: Hot-fix timestamp misordering
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
 <20261126172046.2473303-4-phasta@kernel.org>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20261126172046.2473303-4-phasta@kernel.org>
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

Perhaps say that this particular patch fixes the store ordering of the 
timestamp overwrite. IIUC at least.

> Hot-fix the scheduler's manual timestamp evaluation until we found a
> more suitable solution for mainline linux.
> 
> Cc: stable@vger.kernel.org
> Fixes: f7fe64ad0f22 ("drm/sched: Split free_job into own work item")
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>   drivers/gpu/drm/scheduler/sched_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> index 99252674e266..3d26a48ff1c3 100644
> --- a/drivers/gpu/drm/scheduler/sched_main.c
> +++ b/drivers/gpu/drm/scheduler/sched_main.c
> @@ -928,8 +928,16 @@ drm_sched_get_finished_job(struct drm_gpu_scheduler *sched)
>   		next = list_first_entry_or_null(&sched->pending_list,
>   						typeof(*next), list);
>   		if (next) {
> -			/* make the scheduled timestamp more accurate */
> -			if (test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT,
> +			/* Make the scheduled timestamp more accurate.
> +			 *
> +			 * TODO
> +			 * The test_bit_acquire() is a hotfix against timestamp
> +			 * misordering. Replace it with something better.
> +			 *
> +			 * The counter-part of the barrier is located in
> +			 * dma_fence_signal_timestamp_locked().

Instead of more or less duplicating the TODO perhaps putting a link to 
dma_fence_timestamp_locked somehow would be better. Up to you.

> +			 */
> +			if (test_bit_acquire(DMA_FENCE_FLAG_TIMESTAMP_BIT,
>   				     &next->s_fence->scheduled.flags))
>   				next->s_fence->scheduled.timestamp =
>   					dma_fence_timestamp(&job->s_fence->finished);

With the improved commit message:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Regards,

Tvrtko

