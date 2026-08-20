Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7687C5DF82
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14BD510EFEB;
	Thu, 20 Aug 2026 11:06:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="W9o1pduV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3580910EFEB
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 11:06:45 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53A91CDD
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:06:40 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 9F1BA3F763
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 04:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787224004; bh=jNfDdzqRV98RHfLele5yJdWBh5exPf2ix6GNhcE9czw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W9o1pduVwrd3jEaHnUjYfrkk9z2m0VSCITpx5dGhNfybBPChum82wKZhYHpnHZrRj
 tONKb1uctCybV63hbHZ/UAE+s4wfMS/N5ju/jVZA0GmGUhx1wti85fSYB2LuiCOYw6
 PVnw3plInZdKiDCcky/VFd/a4cut3yXHhyLIr+cY=
Date: Thu, 20 Aug 2026 12:06:32 +0100
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
Subject: Re: [PATCH v4 3/3] drm/panthor: Take reqs_lock in soft_reset for
 clearing pending_reqs
Message-ID: <aobfuJQGsyJbRSQC@e142607>
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
 <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260812-panthor-cache-flush-fix-v4-3-751e32901898@collabora.com>
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

On Wed, Aug 12, 2026 at 04:07:20PM +0200, Nicolas Frattaroli wrote:
> panthor_gpu_soft_reset() sets pending_reqs to 0 without taking the
> requisite reqs_lock.
> 
> Fix this by taking the lock for the duration of the modification.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

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
