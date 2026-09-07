Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2453C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:54:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0575410E73D;
	Mon,  7 Sep 2026 09:54:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="Jf8ZnWNU";
	dkim-atps=neutral
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com
 [209.85.218.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96B6310E73D
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:54:21 +0000 (UTC)
Received: by mail-ej1-f43.google.com with SMTP id
 a640c23a62f3a-c2637dd37c1so186868266b.0
 for <dri-devel@lists.freedesktop.org>; Mon, 07 Sep 2026 02:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1788774860; x=1789379660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BgnlZVhlCEMT9ZJriynmZJUUk5Ix+RJKVKHSp62UhtI=;
 b=Jf8ZnWNUIXoxdeVWV10AFJcje0r6ZXn0pVLgJorZtVaqLNOIfYUfpSah4gING3BGxI
 nNn2jahPAn+KsATjkLcS5DWWaVpj77KXB4F0MiJy44tyfF5zDffRh+vMFruwRmdf+TrN
 bd/KiLE2PwFKTsd6UJk9Aifzi5EhxRtY678HtEfi7VFFfa3e1zIIYs2T6uRuGjFQ8P9n
 T9Ke9ZNDmpCguQULmyJK5ctRTGxOdWVQn8VhwyX89nxneG1/sfZbmnsCxHIocOIP5x7Y
 HnroqdgfqabbCC4by0nBMFggtvFuHYpNMRHJ6QsUE9qGEZWGPvSNUCttXWLkx65YpQ4b
 CvRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788774860; x=1789379660;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BgnlZVhlCEMT9ZJriynmZJUUk5Ix+RJKVKHSp62UhtI=;
 b=im0wYADkA5w4bIs8oodBZirhU3BcvnEkT+hoioDISbxajyO9twEwCgNRS0AvLOEtdj
 UkyMTcGgRV/xRVB7NAvQsmJexp+ks9znYaPJRDNdjY15LcjOji/2SAxvy0nVC82LXBtF
 4nH1BynvSne4BPLxGei6RlR1dzkjMiBIYrjySoi+G4pkDU+hu2sGIcDy+0TBmmUhMvUA
 qhdPNTifDaB0vwFHmJYCOcFNdvttSaiAiVz+xik+RtXFzX41eOIoSXHTA1ADwSpt+X+9
 OpEghRbS/CDO+LuE6FBw1SruodKURqGuKNvKn6Czkzt9JwqJl9conShAV0WXapfLzZeK
 /4Jw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw9sAdhaeUwS+RJ06KUnsdUR+PvvlfS6yad/A/zGim4gICFJHSetec05cLC0NLn37t+P9LfWTneQak=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nuME8eX0S2EU+lS7tv0Hw5aOHWreTSybi2r3qkPoNbyMFYNOuE
 YKZNktB1DNoC5BMdJ8LuZt0w+sHx8X+vxb3eQDh3w0098IiqjshH/oxtNfdhm7TEMuA=
X-Gm-Gg: AYBFou1n9CFhRanzgJFjkEHu2Dk5txKwWZhJ1uoEfHeZQ6x3d3ewSt3AJ7xihufk1Cb
 epJlMfZFoM4p8qxYrzzLaaRnNXnqSqm5AxsaN34W99AQ53zIbf/71kjhpczGCTTOhSHWrjxi/4G
 Ns6j91/vLpulD2E61ZV7gRzOnxJIysE9d8yLo9QMq0GqHN0mANkK3UYK0wt5qzIus5k5eGcwugJ
 WtZWJOgPr+lUydYs3DR4SEL4MFeMM96Ae+yebW7uDR7ZTgnwXctjAsAYA407iFe1EkkOcAHZqZz
 hG9H7bbsO3OgkGGQEg882IeUXUb5s7Qvflw8Czy5uWsOmWddGyzHLkwSZoHND77nb0jr4PwqDag
 O2i6Xb/bZ7OYiDu8feiInZa6k1HVJaY6a343NVqjtPufB6NeuZmZr52T+WuekEeNb8n3egU+8oZ
 Nspl9OlDBI79TQUtqJw2ckUxJYUurfG8IFu6QSuUdekG7VZ8gYPYwah1u+J9wsGQiSx6+cR2GYg
 AH4
X-Received: by 2002:a17:907:9815:b0:c26:1649:47b2 with SMTP id
 a640c23a62f3a-c2616495665mr666155066b.40.1788774859903; 
 Mon, 07 Sep 2026 02:54:19 -0700 (PDT)
Received: from [192.168.0.116] ([81.79.79.1]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c260d53c37csm434533766b.32.2026.09.07.02.54.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Sep 2026 02:54:19 -0700 (PDT)
Message-ID: <30c0848e-e8f6-4bb7-8505-89316158c49e@ursulin.net>
Date: Mon, 7 Sep 2026 10:54:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/i915: fix incorrect RCU teardown order
To: christian.koenig@amd.com, jani.nikula@linux.intel.com,
 joonas.lahtinen@linux.intel.com, rodrigo.vivi@intel.com
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260903113621.54660-1-christian.koenig@amd.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260903113621.54660-1-christian.koenig@amd.com>
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


On 03/09/2026 12:36, Christian König wrote:
> i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
> over the fences in an GEM object without holding a reference but only
> the RCU read side lock.
> 
> What can happen here is that the GEM object is destroyed concurrently
> while i915_gem_busy_ioctl is still running. This won't free the GEM
> objects memory, but still drops all the dma_fence references.
> 
> Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
> assumes that a new fence list was installed and re-starts the loop.
> 
> But in the case of a destroyed GEM object a new fence list is never
> installed, only the old one freed and therefore the iteration never
> finishes resulting in an endless loop.

Only i915_busy can get into this failure mode? None of the other users 
of the iterator?

Also, the reference counting series makes the fix irrelevant?

Regards,

Tvrtko

> 
> The solution is to drop the fence references only after the RCU grace
> period.
> 
> The fixes tag is not necessary the patch introducing the problem, but the
> one making it so worse that we need to address it.
> 
> This problem was pointed out by Sashiko-bot.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>
> Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
> CC: stable@vger.kernel.org
> ---
>   drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> index 5172d3982654..9e01f8b2079a 100644
> --- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
> +++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
> @@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
>   
>   void i915_gem_object_free(struct drm_i915_gem_object *obj)
>   {
> +	dma_resv_fini(&obj->base._resv);
>   	return kmem_cache_free(slab_objects, obj);
>   }
>   
> @@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
>   {
>   	mutex_destroy(&obj->mm.get_page.lock);
>   	mutex_destroy(&obj->mm.get_dma_page.lock);
> -	dma_resv_fini(&obj->base._resv);
>   }
>   
>   /**

