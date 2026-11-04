Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ECB606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 16:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=mzQiPlu0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3478110FD6C;
	Wed,  4 Nov 2026 16:51:30 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3845E10FD6F
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 16:51:24 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91358169C;
 Wed,  4 Nov 2026 08:51:20 -0800 (PST)
Received: from [10.57.59.2] (unknown [10.57.59.2])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8B0523F632;
 Wed,  4 Nov 2026 08:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1793811083; bh=n5h36dxyGLrknPLYVKXGvjTvlGJkL6Dj2TPNHZ50mQI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=mzQiPlu0Y8hROYYzXRqRBujYVpprfUFCi9Yvf2gwKlw5RuA9QyU6ly9mitM28MwzY
 h3WSp82G8DR7lhaSmBGqKEGQULh+0JumSyGFxvf0qgS/Ug6hUU61vSCbk4FS2Khmdb
 5tYR94Xwa6evlQNAi5yy1Bcj7cgZS0n2xNhiaPNk=
Message-ID: <2b3da819-79c4-4471-baee-19abb56bb30d@arm.com>
Date: Wed, 4 Nov 2026 16:51:19 +0000
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/panfrost: Enable cycle counting when perfcnt
 is enabled
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20261103-panfrost-reset-races-fixes-v2-0-454207b1d4e3@collabora.com>
 <20261103-panfrost-reset-races-fixes-v2-1-454207b1d4e3@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20261103-panfrost-reset-races-fixes-v2-1-454207b1d4e3@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 03/11/2026 20:36, Adrián Larumbe wrote:
> From: Boris Brezillon <boris.brezillon@collabora.com>
> 
> If we don't do that, we end up with invalid timestamps in the block
> headers.
> 
> We also need to avoid the warning on the cycle counter reference being
> other than 0 during device reset, because of perfcnt's lingering ref.
> 
> Ideally this would be dealt with by splitting the reset sequence into
> pre and post stages, so that a hypothetical panfrost_perfcnt_pre_reset()
> would release the cycle counter reference. In the absence thereof, we
> just make do.
> 
> Fixes: 7786fd108777 ("drm/panfrost: Expose performance counters through unstable ioctls")
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
> ---
>  drivers/gpu/drm/panfrost/panfrost_gpu.c     | 6 +++---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 3 +++
>  2 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_gpu.c b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> index 6081b27829e1..7d66b1b50968 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_gpu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_gpu.c
> @@ -94,10 +94,10 @@ int panfrost_gpu_soft_reset(struct panfrost_device *pfdev)
>  		  GPU_IRQ_CLEAN_CACHES_COMPLETED);
>  
>  	/*
> -	 * All in-flight jobs should have released their cycle
> -	 * counter references upon reset, but let us make sure
> +	 * Even though all in-flight jobs should have released their cycle counter
> +	 * references upon reset, perfcnt's might still hang about.
>  	 */
> -	if (drm_WARN_ON(&pfdev->base, atomic_read(&pfdev->cycle_counter.use_count) != 0))
> +	if (atomic_read(&pfdev->cycle_counter.use_count) != 0)
>  		atomic_set(&pfdev->cycle_counter.use_count, 0);

There's no point in doing the read - we might as well just
unconditionally do the atomic_set().

With that fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

>  
>  	return 0;
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index a9def452d5ef..b26da057a1a0 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -17,6 +17,7 @@
>  #include "panfrost_device.h"
>  #include "panfrost_features.h"
>  #include "panfrost_gem.h"
> +#include "panfrost_gpu.h"
>  #include "panfrost_issues.h"
>  #include "panfrost_job.h"
>  #include "panfrost_mmu.h"
> @@ -52,6 +53,7 @@ static void panfrost_perfcnt_hw_disable(struct panfrost_device *pfdev)
>  	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
>  
>  	if (perfcnt->owns_as_ref) {
> +		panfrost_cycle_counter_put(pfdev);
>  		panfrost_mmu_as_put(pfdev, perfcnt->mapping->mmu);
>  		perfcnt->owns_as_ref = false;
>  	}
> @@ -84,6 +86,7 @@ static int panfrost_perfcnt_hw_enable(struct panfrost_device *pfdev)
>  		return ret;
>  
>  	perfcnt->owns_as_ref = true;
> +	panfrost_cycle_counter_get(pfdev);
>  
>  	as = ret;
>  	cfg = GPU_PERFCNT_CFG_AS(as) |
> 

