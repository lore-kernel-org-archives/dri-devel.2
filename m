Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24898CD4F3D
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 14:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6537310E19C;
	Wed, 20 May 2026 14:19:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ursulin.net header.i=@ursulin.net header.b="B4dXkSwi";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1602510E19C
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 14:19:15 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-45e8a834cc2so1698305f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ursulin.net; s=google; t=1779286753; x=1779891553; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tQD7vCF/AAogkfSUfkAhoWgZAchGIS/4X+2z2vWNOMk=;
 b=B4dXkSwiy08fmEuQ8IpUMH8Tf2GQixyPYhnz/JU+tqUnxq1pNo2NssNd3igwq2y0fa
 dUyMNUvT8bmkDU7XORoTJdqthm5ixjRfJiR5soSBXmMxFrCXQGLKv4qJBwqIo+sc02EX
 ne06eeBzX0jXmIWjQ1vzBeUifVcnc6eUReaU9EjS13iEVBUt3B2p4YYPlXglBSRzUcYH
 dqqgyyerYwL5TyJ00XKOIb1cWfSj9V9e/ad5I+QeF5nPRCyJT5Y45t5yfHRuyx/+iVNw
 1QKwMXvOSTudiUDuia+/+ON84s70gm8dLctFfAnkjc0IHp+tcIajvmu4cn2HCAlX5TPa
 y5hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286753; x=1779891553;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tQD7vCF/AAogkfSUfkAhoWgZAchGIS/4X+2z2vWNOMk=;
 b=rxVJPV1PFCUmq37x1Gs/djQZdLC935Th/M0x/YOdh/DVg552f/sbKNaiCSbjUFp9T3
 H0zQvVxT7yDzMMgqVwUuE09098VZO3BW9iPBcOTyW49H/Bt0zxm34TGdf9TCRY920tMa
 Zj1hn/XhdytmwEzxyWmmdXsBwSfcxCSVTUrEs46Y3G2ixM7daZdyZMfSho84bDxXPo+E
 Wu48UmxBO8Ikftpw0ozlaeWvQd9xPwrr0AZpn6bJgVu/2X7OtIoh7XjjJRgecbmLT5HK
 GRl/LXDRT3qFxjnk60VfJ9CyAQgd4e382N6W5KohV4x7UXI5jvlolRarhAleLDwy6Ibu
 0VHA==
X-Gm-Message-State: AOJu0Yw6bTUMOXY61aYNiRzzr6ilf5AVZduZ/x8KVc2vInS14JfVJ8nU
 Lu2r2L3AZ0kZ65KVNDH5T5A/ACvi47jytxcuQFAR/BG+9KODNqyTR716Cs1JJqKoIKM=
X-Gm-Gg: Acq92OEGkoFSG1+Eogvyd+ASPBlBPqjEBaU9vTyxQ1GRUeBVWf4wLGjtEZXnevE+5i2
 h6UGPxUG9L5EpYqL35NuNbOxfJOFdTQf4co+sGFrOH5ib8qKBvnFebPXFd0OpL26iWPcvxutvr2
 SU/HjEPUWTxM5dvDYDUrQGtxJwhTAjJamcvBCNa0AHG4VW4+AljMHYc9SuRZ885WqFD8C+RzG+Z
 kxoI6GfXM2fv8DluVaKhphqi8J9M3rDtHhWmBvgQl/keYiGbI+bOOa8PlMTPfjYYsIWafXW3JWj
 3XWKaeE4ln/XkQiABp6gXKMg1iBSPtT4ky0wEJBEys1hKvb+1/GH9o14iclcrQvXq9iNbWpwSAV
 4QUq6EH3NpYfybUIYvWX3lJxPE8m+5/EwKprNnb9tEpso9peoVNe9eJFlDNgko5T1iyvTEG00Ah
 Buyld6oUOACi+iT4ZK1OhbgiCZFRBGmxaa41SDueRY++PXghNMQtBBUBg=
X-Received: by 2002:a05:6000:2503:b0:43f:e43a:f4a6 with SMTP id
 ffacd0b85a97d-45e5c35e7bdmr38999826f8f.6.1779286753206; 
 Wed, 20 May 2026 07:19:13 -0700 (PDT)
Received: from [192.168.0.116] ([90.240.106.137])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0a17a22sm54932291f8f.22.2026.05.20.07.19.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 07:19:12 -0700 (PDT)
Message-ID: <7c7242b8-eb22-41b1-8f04-f7abda62bb28@ursulin.net>
Date: Wed, 20 May 2026 15:19:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] drm/fdinfo: Add "evicted" memory accounting
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-doc@vger.kernel.org
References: <20260520-panthor-bo-reclaim-observability-v4-0-a47ab61cb80d@collabora.com>
 <20260520-panthor-bo-reclaim-observability-v4-1-a47ab61cb80d@collabora.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tursulin@ursulin.net>
In-Reply-To: <20260520-panthor-bo-reclaim-observability-v4-1-a47ab61cb80d@collabora.com>
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


On 20/05/2026 14:04, Nicolas Frattaroli wrote:
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
> Reviewed-by: Steven Price <steven.price@arm.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> ---
>   Documentation/gpu/drm-usage-stats.rst | 6 ++++++
>   drivers/gpu/drm/drm_file.c            | 8 ++++++++
>   include/drm/drm_file.h                | 2 ++
>   include/drm/drm_gem.h                 | 2 ++
>   4 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 70b7cfcc194f..ac1dbf52d96d 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -202,6 +202,12 @@ One practical example of this could be the presence of unsignaled fences in a
>   GEM buffer reservation object. Therefore, the active category is a subset of the
>   resident category.
>   
> +- drm-evicted-<region>: <uint> [KiB|MiB]
> +
> +The total size of buffers that have been evicted and are no longer pinned by the
> +device. Only present if there are buffers that are currently evicted, and if the
> +driver implements reporting of this type of memory.

The semantics as tricky to make work in an obvious way.

On one hand the text above is almost exactly the semantics of 'total' - 
'resident'. Almost meaning it was resident at some point, but isn't any 
more. Whereas raw 'total' - 'resident' can also mean it never has been 
instantiated.

You could even have a "workaround" where you report a 'swap' memory 
region and then don't need to add anything new to the spec.

Next problem - on paper evicted could be useful to replace driver legacy 
keys such as 'amd-evicted-ram'. But that "evicted" is defined as "not in 
a the preferred placement". While your evicted is more like "no current 
placement" (as in, no GPU accessible backing storage).

Is it possible to find a definition of this new category which makes 
sense for different GPUs/drivers, be it integrated or discrete.

Or would simply going for 'drm-total-swap:' (or resident?) work for 
panthor? Advantage being it would also work unambiguously for discrete 
drivers.

Like the ones which support multiple TTM placements, for example VRAM + 
SYSTEM and then next step is swapping out so an extreme example on a 
16GiB GPU + 16GiB RAM machine with a 32GiB gfx workload could be like:

drm-total-vram:		32GiB
drm-resident-vram:	16GiB
drm-resident-system:	15GiB
drm-total-swap:		1GiB

Does this look clear enough? Whereas with the "evicted" category it 
would be:

drm-total-vram:		32GiB
drm-resident-vram:	16GiB
drm-evicted-vram:	16GiB # portion which got demoted to system RAM
drm-resident-system:	15GiB
drm-evicted-system:	1GiB  # portion which got demoted to swap

Where drm-evicted-vram is redundant to "total - resident". And it is 
overloaded semantics as it where does evicted go depending on the 
GPU/driver/region.

Thoughts, opinions?

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
> index 6ee70ad65e1f..7e4cb45a52c3 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -500,6 +500,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
>    * @resident: Total size of GEM objects backing pages
>    * @purgeable: Total size of GEM objects that can be purged (resident and not active)
>    * @active: Total size of GEM objects active on one or more engines
> + * @evicted: Total size of GEM objects that have been evicted
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
> index 86f5846154f7..799588a2762a 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -53,6 +53,7 @@ struct drm_gem_object;
>    * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
>    * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
>    * @DRM_GEM_OBJECT_ACTIVE: object is currently used by an active submission
> + * @DRM_GEM_OBJECT_EVICTED: object is evicted and no longer pinned by driver
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

