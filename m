Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AE0CFED3EF
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 16:01:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D5BCC10E365;
	Fri, 24 Apr 2026 16:01:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="emQLkciN";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C402810E365
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 16:01:14 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so74769905e9.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 09:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1777046473; x=1777651273; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qARNYk1xmAI7/1amvsRMfp//VfnZGwb0pgC/2wWQOCc=;
 b=emQLkciNOiJivmTop/VZqtVHOIa7HJmUnML8/R71Sh3S6QIKTKp1OrftLey1INZAIh
 uq5KGBo3VRrWfl2qDOrvMunGUbkLYTcWAAYsxlfBeaDuWJ1mXfLs4ATn2GHBu5ncFjux
 NqWKMMwf1Uxuk/qGz1HAGY4Qui+g93dIiOIVgoPLVD+PqaUY2Ohnvx85Ek9GG+18LTbL
 M0/yLGYZlWm0ngpv9KpeIYSREhqDJu3SL28Iysy8nBgvQ0skiKNrMY2EthLRcqd6pzjB
 dXXa9gvOOMvTjwnaYNj1TjsonLijLB3YX9ewQmVXw7mUVaDem3/DZby/Xz6Amh0dxcpR
 ku+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777046473; x=1777651273;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qARNYk1xmAI7/1amvsRMfp//VfnZGwb0pgC/2wWQOCc=;
 b=DMtrPspQD/9Dp2qzmIGfHyhiLlmIbOTKfDOkXaFDiUToIEZmQCZbyfV1rNm96/9+YE
 Wvz7tzRkzhOA68se+oRWdmszyIXX+lDFpnlTVUllYyfZQDUwZegHBF997lotq+3SmYmH
 AOTad84sXKi9QT4Wy3UhpJv3RisHLJTKJVR6JRj6Vcu/Dz9IlvCY41BP+MYzylwT5fD5
 YifNp4WIMMaNmGOfWBNBPnklkF6+Di9JSUEhF9MwPn99yrZJP24k83nHYdECuWkHpc12
 ztu6n756+/zNL2BxYA8bGpk36pvl7CNa7jfC0wC4+FrYI30tK3XURWUpZhhtym+zY22O
 Z2/A==
X-Gm-Message-State: AOJu0YzAPVXc5Fz2i92cqJS//BwPQZhnGffiV5k8mH0Pq8gCHn4I9ZRk
 lWqXVrng+YevCZZl4EYTbLb9HgByKX8RJ7U8vm0ScZxXWSnSLGDj438OjcEBsBpDpYY=
X-Gm-Gg: AeBDievyXJwg+oQve6lh3CRB9LxwmaI+tbiiaI+Ye2Fn2w1NIf7iTVLzcW0cShnqUpy
 RfaKPgK1KNAZe214hSH3zl5pgdLrKJtvKUIWsifYVymQnh2FWtR9PW68uc8P/1JScxFFByCcpC3
 jxK4ArybwTwlb2ZNisBedRVC44b6FTknCay/ztbbqYBXmdKk/px923QcaunA3j0MnTU4vAXP2qS
 Jzc3xIJJsMBM/oBn01BFCPVKwUwwyGf5hJvOSU1tro0ICIJH2L1LeP83lSlco1VyjPu0di6cn3C
 340QMMcWBzcF3z2WX6Goxdf7I2gfx+dMy0IUwzVE3pPvC2K9HIV4sUkk8YIUZ9Hsmdbbhcc8I73
 XWTiq50bUhtUkpUDnFZahZMw7dC9p1sbNU1ARDR+BGbQCYXEbzrvy3HYM2qc0L/e50ndUhHbM4b
 W9e0zu6bOFVfsfESGgjp6ujOu7KHxMS8weCrc9FJC3b28J/3GOFEMw8SgqMULpMBUsNQ==
X-Received: by 2002:a05:600c:c0d6:b0:489:ecee:c4ef with SMTP id
 5b1f17b1804b1-489eceec9e3mr227124215e9.13.1777046472224; 
 Fri, 24 Apr 2026 09:01:12 -0700 (PDT)
Received: from [192.168.0.101] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm154555995e9.2.2026.04.24.09.01.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Apr 2026 09:01:11 -0700 (PDT)
Message-ID: <85d22f7e-af44-4a6e-911f-54830c91e339@ursulin.net>
Date: Fri, 24 Apr 2026 17:01:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/fdinfo: Add "evicted" memory accounting
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-doc@vger.kernel.org
References: <20260423-panthor-bo-reclaim-observability-v3-0-60af32164a4f@collabora.com>
 <20260423-panthor-bo-reclaim-observability-v3-1-60af32164a4f@collabora.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260423-panthor-bo-reclaim-observability-v3-1-60af32164a4f@collabora.com>
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


On 23/04/2026 13:33, Nicolas Frattaroli wrote:
> Currently, there's no way to know for certain how much GPU memory was
> swapped out. The difference between total and resident memory would
> include newly allocated pages, which are not resident, but also aren't
> swapped out.
> 
> Add a new drm_gem_object_status so drivers can signal when an object has
> been evicted to swap, and add a new "evicted" counter to
> drm_memory_stats.
> 
> Due to how the supported_flags bitmask is determined, the "evicted"
> count won't be printed to fdinfo if there's no swapped out pages.
> 
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   Documentation/gpu/drm-usage-stats.rst | 6 ++++++
>   drivers/gpu/drm/drm_file.c            | 8 ++++++++
>   include/drm/drm_file.h                | 2 ++
>   include/drm/drm_gem.h                 | 2 ++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 24d3012ca7a6..11570976095e 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -200,6 +200,12 @@ One practical example of this could be the presence of unsignaled fences in a
>   GEM buffer reservation object. Therefore, the active category is a subset of the
>   resident category.
>   
> +- drm-evicted-<region>: <uint> [KiB|MiB]
> +
> +The total size of buffers that have been evicted and are currently in swap
> +space. Only present if there are buffers that are currently swapped out, and the
> +driver implements reporting of this type of memory.

Please hold off merging this for a few days, I just noticed it and would 
like to set aside some time next week to think about the semantics, how 
it applies to discrete GPUs where evicted != swapped and some other 
questions.

Regards,

Tvrtko

> +
>   Implementation Details
>   ======================
>   
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ec820686b302..5078172976c0 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -868,6 +868,7 @@ int drm_memory_stats_is_zero(const struct drm_memory_stats *stats)
>   		stats->private == 0 &&
>   		stats->resident == 0 &&
>   		stats->purgeable == 0 &&
> +		stats->evicted == 0 &&
>   		stats->active == 0);
>   }
>   EXPORT_SYMBOL(drm_memory_stats_is_zero);
> @@ -901,6 +902,10 @@ void drm_print_memory_stats(struct drm_printer *p,
>   	if (supported_status & DRM_GEM_OBJECT_PURGEABLE)
>   		drm_fdinfo_print_size(p, prefix, "purgeable", region,
>   				      stats->purgeable);
> +
> +	if (supported_status & DRM_GEM_OBJECT_EVICTED)
> +		drm_fdinfo_print_size(p, prefix, "evicted", region,
> +				      stats->evicted);
>   }
>   EXPORT_SYMBOL(drm_print_memory_stats);
>   
> @@ -954,6 +959,9 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>   
>   		if (s & DRM_GEM_OBJECT_PURGEABLE)
>   			status.purgeable += add_size;
> +
> +		if (s & DRM_GEM_OBJECT_EVICTED)
> +			status.evicted += add_size;
>   	}
>   	spin_unlock(&file->table_lock);
>   
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 6ee70ad65e1f..213dfecac342 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -500,6 +500,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
>    * @resident: Total size of GEM objects backing pages
>    * @purgeable: Total size of GEM objects that can be purged (resident and not active)
>    * @active: Total size of GEM objects active on one or more engines
> + * @evicted: Total size of GEM objects that have been evicted to swap
>    *
>    * Used by drm_print_memory_stats()
>    */
> @@ -509,6 +510,7 @@ struct drm_memory_stats {
>   	u64 resident;
>   	u64 purgeable;
>   	u64 active;
> +	u64 evicted;
>   };
>   
>   enum drm_gem_object_status;
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 86f5846154f7..b42ea2e582cf 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -53,6 +53,7 @@ struct drm_gem_object;
>    * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
>    * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
>    * @DRM_GEM_OBJECT_ACTIVE: object is currently used by an active submission
> + * @DRM_GEM_OBJECT_EVICTED: object is evicted to swap
>    *
>    * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
>    * and drm_show_fdinfo().  Note that an object can report DRM_GEM_OBJECT_PURGEABLE
> @@ -67,6 +68,7 @@ enum drm_gem_object_status {
>   	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
>   	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
>   	DRM_GEM_OBJECT_ACTIVE    = BIT(2),
> +	DRM_GEM_OBJECT_EVICTED   = BIT(3),
>   };
>   
>   /**
> 

