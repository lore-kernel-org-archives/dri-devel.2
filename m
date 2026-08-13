Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DEFC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:30:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F64D10F3AD;
	Thu, 13 Aug 2026 15:30:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ElxG8y9B";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 64A5F10F3AD
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:30:33 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0A91D1756
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:30:29 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 B17073F632
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786635032; bh=fZHXHlUpDEgX8tHOpg8oqwQHGXxEPEgltzKhWJGUvts=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ElxG8y9BvYBE4jwbh30s4Uhd98+K2OV7PfUIO5WRASk/+3ULzhVtIjsxcrhbeNxBU
 JlcMxrsLqhka5RuGtnpX5+5OIbAvz0xYPjd3dj5vuDh/EzKqs1J597JHBUJVHsjx6H
 yOmVeVkb+CLcyoYnjanOI3ulmvckhTR1CLP64Rwo=
Date: Thu, 13 Aug 2026 16:30:19 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3 3/3] drm/panthor: Take reqs_lock in soft_reset for
 clearing pending_reqs
Message-ID: <an3jCwAFslFkwUDc@e142607>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
 <20260811-panthor-cache-flush-fix-v3-3-47d2c1bb1dab@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-cache-flush-fix-v3-3-47d2c1bb1dab@collabora.com>
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

On Tue, Aug 11, 2026 at 04:08:33PM +0200, Nicolas Frattaroli wrote:
> panthor_gpu_soft_reset() sets pending_reqs to 0 without taking the
> requisite reqs_lock.
> 
> Fix this by taking the lock for the duration of the modification.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index cb5319d1c5de..12e7e29b35b5 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -405,7 +405,10 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
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
> -- 
> 2.55.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
