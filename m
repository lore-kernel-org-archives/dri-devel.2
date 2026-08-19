Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 659FEC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDCA710EB66;
	Wed, 19 Aug 2026 15:37:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ooIYAFVC";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id B149C10EB87
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:37:41 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6FCA41BD0;
 Wed, 19 Aug 2026 08:37:37 -0700 (PDT)
Received: from [10.57.6.96] (unknown [10.57.6.96])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B18B23FA32;
 Wed, 19 Aug 2026 08:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787153861; bh=dFOTYzU+Dh/Eh5CmfmlJmdUu1Oji+nDK1VoZLT2xPXo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ooIYAFVClXgw1Gz5f5bvggB4E5wB1vi8ZRS89qMH4WaLHWAyoZd14Tb3OtaTy2wTU
 XRMqlf997n5UhK0OGyQNH9v7cnVxOqsfP0RT7HEqxD1Mxpsyt9C3v5SZ9OlmBmSNYE
 zR61eT6TH+FsH9s5TPr1t6XA6VX37dHEWtn4p1HU=
Message-ID: <c9f5989f-332e-45a5-8939-f9f9ee5154da@arm.com>
Date: Wed, 19 Aug 2026 16:37:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] drm/panthor: Take reqs_lock in soft_reset for
 clearing pending_reqs
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
 <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
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

On 12/08/2026 15:07, Nicolas Frattaroli wrote:
> panthor_gpu_soft_reset() sets pending_reqs to 0 without taking the
> requisite reqs_lock.
> 
> Fix this by taking the lock for the duration of the modification.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 55e33f145b40..fb2702e1e0a2 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -424,7 +424,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  		return -ETIMEDOUT;
>  	}
>  
> -	ptdev->gpu->pending_reqs = 0;
> +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +		ptdev->gpu->pending_reqs = 0;
> +	}
> +
>  	return 0;
>  }
>  
> 

