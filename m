Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330A860A2620
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=TppvuxtR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9299E10E83D;
	Thu, 19 Nov 2026 09:48:06 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 2152610E83D
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 09:48:00 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9A6A31575
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:47:56 -0800 (PST)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 5861D3F882
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 01:47:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1795081679; bh=pc2AKAjzdVqoK2Jc7Nq7Y1VxQXYoLYZk9Ke7OpUrCLc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=TppvuxtRX6vNjvnZR+jGkj1lyRbc/pPeVgFIw82nwelbZyqw2G3K8w7evWZJHfIfb
 DJIjWPHq4VM3ykdhHwkQOPez+dUh8ojGr5SrZ6ZjrTar+h/1x1UuwuWBUACQBxjcgQ
 nE95JUeUX3bmp9eCjF+UN5sbMB7kEDeiCBol6foY=
Date: Thu, 19 Nov 2026 09:47:58 +0000
From: Liviu Dudau <liviu.dudau@arm.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, linux-kernel@vger.kernel.org,
 Akash Goel <akash.goel@arm.com>, Lukas Zapolskas <lukas.zapolskas@arm.com>,
 Chris Diamand <chris.diamand@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Subject: Re: [PATCH v3 02/10] drm/panthor: Rename neural accelerator feature
 macro to NX
Message-ID: <av7FzqjoPGxrPN5O@e142607>
References: <20261118175332.519657-1-karunika.choo@arm.com>
 <20261118175332.519657-3-karunika.choo@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261118175332.519657-3-karunika.choo@arm.com>
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
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Nov 18, 2026 at 05:53:18PM +0000, Karunika Choo wrote:
> Rename GPU_FEATURES_NEURAL_ENGINE to GPU_FEATURES_NX.
> Update the panthor_hw helper to use the new name.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h | 2 +-
>  drivers/gpu/drm/panthor/panthor_hw.h       | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 5340966caef37..c7581b6d4c5be 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -67,7 +67,7 @@
>  
>  #define GPU_FEATURES					0x60
>  #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
> -#define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
> +#define   GPU_FEATURES_NX				BIT(4)
>  #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>  
>  #define GPU_TIMESTAMP_OFFSET				0x88
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index eeca936f44bae..f770dc40e6216 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -64,7 +64,7 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>  static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
>  {
>  	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
> -		ptdev->gpu_info.gpu_features & GPU_FEATURES_NEURAL_ENGINE);
> +		ptdev->gpu_info.gpu_features & GPU_FEATURES_NX);
>  }
>  
>  #endif /* __PANTHOR_HW_H__ */
> -- 
> 2.43.0
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
