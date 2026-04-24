Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B70FED3E4
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 15:19:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67C8C10F5EE;
	Fri, 24 Apr 2026 15:19:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ZgOSxhNR";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 785CD10F5EE
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:19:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D9CE1BB2;
 Fri, 24 Apr 2026 08:19:04 -0700 (PDT)
Received: from [10.1.26.15] (e122027.cambridge.arm.com [10.1.26.15])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDC363F7B4;
 Fri, 24 Apr 2026 08:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777043949; bh=38HZnkF49GgvZX+AquY+zMX+HOu8oPVpHVWQCi1dfno=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZgOSxhNRWDomjPidKTJbJirA9pvNd8ZF/01IoIl8eZ23xGienv7PyL2UJPkjAPzVH
 sxNpa00THjMiv/r8eB/hHcOOg/7TTgedzuW03SW0DjufRPsdqSoaZAyMBQAMlkXZbq
 R9Ps7ae8xgU2TvXbENtWAgmI1mAWXAHq0hCnax5A=
Message-ID: <2da968e4-96b0-481c-b51b-44d546c9315f@arm.com>
Date: Fri, 24 Apr 2026 16:19:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] drm/fdinfo: Add "evicted" memory accounting
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 kernel@collabora.com, linux-doc@vger.kernel.org
References: <20260423-panthor-bo-reclaim-observability-v3-0-60af32164a4f@collabora.com>
 <20260423-panthor-bo-reclaim-observability-v3-1-60af32164a4f@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260423-panthor-bo-reclaim-observability-v3-1-60af32164a4f@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

One NIT below, but either way:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  Documentation/gpu/drm-usage-stats.rst | 6 ++++++
>  drivers/gpu/drm/drm_file.c            | 8 ++++++++
>  include/drm/drm_file.h                | 2 ++
>  include/drm/drm_gem.h                 | 2 ++
>  4 files changed, 18 insertions(+)
> 
> diff --git a/Documentation/gpu/drm-usage-stats.rst b/Documentation/gpu/drm-usage-stats.rst
> index 24d3012ca7a6..11570976095e 100644
> --- a/Documentation/gpu/drm-usage-stats.rst
> +++ b/Documentation/gpu/drm-usage-stats.rst
> @@ -200,6 +200,12 @@ One practical example of this could be the presence of unsignaled fences in a
>  GEM buffer reservation object. Therefore, the active category is a subset of the
>  resident category.
>  
> +- drm-evicted-<region>: <uint> [KiB|MiB]
> +
> +The total size of buffers that have been evicted and are currently in swap
> +space. Only present if there are buffers that are currently swapped out, and the

NIT: Technically the memory may not be swapped out. Evicted memory is
memory which has been unpinned by the driver, whether the swap
infrastructure has actually moved it to swap is another matter.

Thanks,

Steve

> +driver implements reporting of this type of memory.
> +
>  Implementation Details
>  ======================
>  
> diff --git a/drivers/gpu/drm/drm_file.c b/drivers/gpu/drm/drm_file.c
> index ec820686b302..5078172976c0 100644
> --- a/drivers/gpu/drm/drm_file.c
> +++ b/drivers/gpu/drm/drm_file.c
> @@ -868,6 +868,7 @@ int drm_memory_stats_is_zero(const struct drm_memory_stats *stats)
>  		stats->private == 0 &&
>  		stats->resident == 0 &&
>  		stats->purgeable == 0 &&
> +		stats->evicted == 0 &&
>  		stats->active == 0);
>  }
>  EXPORT_SYMBOL(drm_memory_stats_is_zero);
> @@ -901,6 +902,10 @@ void drm_print_memory_stats(struct drm_printer *p,
>  	if (supported_status & DRM_GEM_OBJECT_PURGEABLE)
>  		drm_fdinfo_print_size(p, prefix, "purgeable", region,
>  				      stats->purgeable);
> +
> +	if (supported_status & DRM_GEM_OBJECT_EVICTED)
> +		drm_fdinfo_print_size(p, prefix, "evicted", region,
> +				      stats->evicted);
>  }
>  EXPORT_SYMBOL(drm_print_memory_stats);
>  
> @@ -954,6 +959,9 @@ void drm_show_memory_stats(struct drm_printer *p, struct drm_file *file)
>  
>  		if (s & DRM_GEM_OBJECT_PURGEABLE)
>  			status.purgeable += add_size;
> +
> +		if (s & DRM_GEM_OBJECT_EVICTED)
> +			status.evicted += add_size;
>  	}
>  	spin_unlock(&file->table_lock);
>  
> diff --git a/include/drm/drm_file.h b/include/drm/drm_file.h
> index 6ee70ad65e1f..213dfecac342 100644
> --- a/include/drm/drm_file.h
> +++ b/include/drm/drm_file.h
> @@ -500,6 +500,7 @@ void drm_send_event_timestamp_locked(struct drm_device *dev,
>   * @resident: Total size of GEM objects backing pages
>   * @purgeable: Total size of GEM objects that can be purged (resident and not active)
>   * @active: Total size of GEM objects active on one or more engines
> + * @evicted: Total size of GEM objects that have been evicted to swap
>   *
>   * Used by drm_print_memory_stats()
>   */
> @@ -509,6 +510,7 @@ struct drm_memory_stats {
>  	u64 resident;
>  	u64 purgeable;
>  	u64 active;
> +	u64 evicted;
>  };
>  
>  enum drm_gem_object_status;
> diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> index 86f5846154f7..b42ea2e582cf 100644
> --- a/include/drm/drm_gem.h
> +++ b/include/drm/drm_gem.h
> @@ -53,6 +53,7 @@ struct drm_gem_object;
>   * @DRM_GEM_OBJECT_RESIDENT: object is resident in memory (ie. not unpinned)
>   * @DRM_GEM_OBJECT_PURGEABLE: object marked as purgeable by userspace
>   * @DRM_GEM_OBJECT_ACTIVE: object is currently used by an active submission
> + * @DRM_GEM_OBJECT_EVICTED: object is evicted to swap
>   *
>   * Bitmask of status used for fdinfo memory stats, see &drm_gem_object_funcs.status
>   * and drm_show_fdinfo().  Note that an object can report DRM_GEM_OBJECT_PURGEABLE
> @@ -67,6 +68,7 @@ enum drm_gem_object_status {
>  	DRM_GEM_OBJECT_RESIDENT  = BIT(0),
>  	DRM_GEM_OBJECT_PURGEABLE = BIT(1),
>  	DRM_GEM_OBJECT_ACTIVE    = BIT(2),
> +	DRM_GEM_OBJECT_EVICTED   = BIT(3),
>  };
>  
>  /**
> 

