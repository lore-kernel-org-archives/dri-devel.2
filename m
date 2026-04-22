Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C408F94CDB
	for <dri-devel@archiver.kernel.org>; Wed, 22 Apr 2026 07:32:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF798994A;
	Wed, 22 Apr 2026 07:32:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Ha8ClyoB";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A27389664
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 07:32:12 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4891cd41959so31761935e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Apr 2026 00:32:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1776843131; x=1777447931; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FfMjYVt0OEJw9kTPbllj7wGPjeMaDQDeFyapIKBwi04=;
 b=Ha8ClyoBG+CrQo1TNJzizQHkPFovPYZLw8JQQb/AZInMU1AbaLGXNOqbL8WLej8iF6
 ZF0ozGP27ozQUpoeDUcWmqGjYoGhYiZHsngJ0/uxKvCpozYsnFfhSdpO7l/vFhl5li6Z
 s609OB0EXG6gGaxLGdk167NT1hEvjMcUUCJ/fOgyASput5OgumXDuJKG97jAFtMQg8pl
 X9gMbaw/zQJahDLVZruXEgo96SALlEBgXVE6C2YyP9XzfwXdn3qQjHiaL5OaEUVE+Idd
 +IW7Ae+iAWhsSxqW9rG0xXT4aaysa4yyC6QzB4s6txVcPmH+d7ibJb+3UUkFdu26kRCz
 uvNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776843131; x=1777447931;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FfMjYVt0OEJw9kTPbllj7wGPjeMaDQDeFyapIKBwi04=;
 b=JgavvuT0y1HEXPv8eBP2H6o0+jnfF+AfyB3OI3tLRzdfFSm3kzpGL6Jdxs9++TOgCz
 nT12eJzrNptt1z2EXswkOfUVe9oZ7f9T8LFxlNxC+phoFVOdTRafuDN7gDQA9fPtmC1v
 /hACNyc0s+6msQ6DEUfDW0NAqmFkbyORTVaah/PlH+9/aYa5pjpd6EbsdCz/M5bnfV0K
 62UCQE9Pz0iDxGbEQ1xz0ZyzE9K4ZDXRgoO5oL6wccB05kKvplJ/p5+vdgj6SU4lwV6f
 3B6+kNAVSL0noWAX0P8rkvsQz15PtzHceX02CLG+Bpr1KhkZJeCsd2q7vEctL1DTBtNy
 SANQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+LoQlRkcnO75goJ2TvLC1vmyFkCXt23J/VJrcuJZHesG8KMluPMHuK/BYJub8Vr5qVDpugWLW9su8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yweh33nOuz8ariUcdGWdKMFFfaX78V/KqyPCE2FeAuyTjpfYoPA
 jndmngI1/XNcD7NWeVm13du3qJigcx2odrfBAs5j2LJpFUHmD2rHFgEN/xow8We4PAM=
X-Gm-Gg: AeBDieudprdGcFVKZ9RYo0tu/Q7R6zEfxuMwUhMt3WEyQOHd0NJWaOg03AifdEgs9sE
 Wi/oZLgO9IHzk3oG05cLmkoKa16hulxajEhkL1A8HBlGCOou/NKEWODqeQXZ0XIGWx2wmk14rkw
 eYawceDmdk9c9g6nKgMKS6NFi++6goCARtaiVrp8y6Hoz5VFYb26dFaUtfGDYTAzAQDld+B0nUB
 bSbFbG6HvONEKFo/joNtEofSIqqKLo0E7m59ekYuy3VfbxwWtnA7vVUYaCgLaWscOwjR+kZhlwf
 6JtLGL/2noQ/lCbV+qrtT2SNh+6TdKpievjoMX6rPUBpAnipXBDtgjXOzaX0ph4LyDuhXr6QBbG
 atgzUz5nltIuBhNgvtXOAqONbGn9u8psHyx7fYUwIV6nkfmxa3iN4qjRcA+nfCOFTK/at+Ph2cI
 noIQWzD2NYiCEsbkCRfjl2DCXazVhO7FwcEDb4h4U8n9s4mMjFz+cm1c8=
X-Received: by 2002:a05:600c:c0cf:b0:489:1f3e:5f6f with SMTP id
 5b1f17b1804b1-4891f3e62a7mr113857145e9.12.1776843130310; 
 Wed, 22 Apr 2026 00:32:10 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb762f56sm133492965e9.15.2026.04.22.00.32.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Apr 2026 00:32:09 -0700 (PDT)
Message-ID: <30c84c41-192c-44ae-a614-2b9951c55727@ursulin.net>
Date: Wed, 22 Apr 2026 08:32:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] drm/ttm: Issue direct reclaim at beneficial_order
To: Matthew Brost <matthew.brost@intel.com>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Carlos Santa <carlos.santa@intel.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Daniel Colascione <dancol@dancol.org>
References: <20260421012608.1474950-1-matthew.brost@intel.com>
 <20260421012608.1474950-2-matthew.brost@intel.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260421012608.1474950-2-matthew.brost@intel.com>
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


On 21/04/2026 02:26, Matthew Brost wrote:
> Triggering kswap at an order higher than beneficial_order makes little
> sense, as the driver has already indicated the optimal order at which
> reclaim is effective. Similarly, issuing direct reclaim or triggering
> kswap at a lower order than beneficial_order is ineffective, since the
> driver does not benefit from reclaiming lower-order pages.
> 
> As a result, direct reclaim should only be issued with __GFP_NORETRY at
> exactly beneficial_order, or as a fallback, direct reclaim without
> __GFP_NORETRY at order 0 when failure is not an option.
> 
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Carlos Santa <carlos.santa@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Huang Rui <ray.huang@amd.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> CC: dri-devel@lists.freedesktop.org
> Cc: Daniel Colascione <dancol@dancol.org>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> ---
>   drivers/gpu/drm/ttm/ttm_pool.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 26a3689e5fd9..8425dbcc6c68 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -165,8 +165,8 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>   	 * Do not add latency to the allocation path for allocations orders
>   	 * device tolds us do not bring them additional performance gains.
>   	 */
> -	if (beneficial_order && order > beneficial_order)
> -		gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +	if (order && beneficial_order && order != beneficial_order)
> +		gfp_flags &= ~__GFP_RECLAIM;
>   
>   	if (!ttm_pool_uses_dma_alloc(pool)) {
>   		p = alloc_pages_node(pool->nid, gfp_flags, order);

I missed this conversation so don't know if this was discussed -
having less of 64k pages is not a concern? I mean slightly higher TLB 
pressure etc on hardware which supports this PTE size.

Also, does clearing __GFP_RECLAIM disable compaction completely and is 
that wanted?

Regards,

Tvrtko

