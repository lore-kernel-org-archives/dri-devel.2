Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F001ACD6E74
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 10:34:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6586311A718;
	Fri,  5 Jun 2026 10:34:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="p0oLrH/2";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id D2A4111A718
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 10:34:11 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6B53C16F8;
 Fri,  5 Jun 2026 03:34:06 -0700 (PDT)
Received: from [10.1.31.21] (e122027.cambridge.arm.com [10.1.31.21])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA9AA3F632;
 Fri,  5 Jun 2026 03:34:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1780655651; bh=xEPYML3bQHVkaAgQv/rHSlEndvNThEhJmUoIbyBTYZ0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=p0oLrH/2SIjA9pwdKOJP/a+/452xnqtmTGjZPxttUUqeE7nrbavU7U4oj2NYlscSm
 gIUdAxbxn5+cA/FlN8i3Am+gQvGqKetbBD9hU2k4X7pAgG4xMzSOkFa/+0o9p7cf6+
 doDKcCgwQPdg+PG9XHgo7aQL8bFTZ7AyGRpj9Y4I=
Message-ID: <31b7b0af-0521-4e72-a2a7-c4fd9b1fb66e@arm.com>
Date: Fri, 5 Jun 2026 11:34:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] drm/panfrost: Move perfcnt GPU disable sequence
 into a helper
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260604-claude-fixes-v2-0-57c6bd4c1655@collabora.com>
 <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260604-claude-fixes-v2-4-57c6bd4c1655@collabora.com>
Content-Type: text/plain; charset=UTF-8
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

On 04/06/2026 18:35, Adrián Larumbe wrote:
> Just for the sake of avoiding repetition.
> 
> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panfrost/panfrost_perfcnt.c | 31 ++++++++++++-----------------
>  1 file changed, 13 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> index 7020c0192e18..ad1156678e91 100644
> --- a/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_perfcnt.c
> @@ -35,6 +35,16 @@ struct panfrost_perfcnt {
>  	struct completion dump_comp;
>  };
>  
> +static void panfrost_perfcnt_gpu_disable(struct panfrost_device *pfdev)
> +{
> +	gpu_write(pfdev, GPU_PERFCNT_CFG,
> +		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> +	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +}
> +
>  void panfrost_perfcnt_clean_cache_done(struct panfrost_device *pfdev)
>  {
>  	complete(&pfdev->perfcnt->dump_comp);
> @@ -193,12 +203,7 @@ static int panfrost_perfcnt_disable_locked(struct panfrost_device *pfdev,
>  	if (user != perfcnt->user)
>  		return -EINVAL;
>  
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0x0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> +	panfrost_perfcnt_gpu_disable(pfdev);
>  
>  	perfcnt->user = NULL;
>  	drm_gem_vunmap(&perfcnt->mapping->obj->base.base, &map);
> @@ -327,12 +332,7 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
>  	perfcnt->bosize = size;
>  
>  	/* Start with everything disabled. */
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +	panfrost_perfcnt_gpu_disable(pfdev);
>  
>  	init_completion(&perfcnt->dump_comp);
>  	mutex_init(&perfcnt->lock);
> @@ -344,10 +344,5 @@ int panfrost_perfcnt_init(struct panfrost_device *pfdev)
>  void panfrost_perfcnt_fini(struct panfrost_device *pfdev)
>  {
>  	/* Disable everything before leaving. */
> -	gpu_write(pfdev, GPU_PERFCNT_CFG,
> -		  GPU_PERFCNT_CFG_MODE(GPU_PERFCNT_CFG_MODE_OFF));
> -	gpu_write(pfdev, GPU_PRFCNT_JM_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_SHADER_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_MMU_L2_EN, 0);
> -	gpu_write(pfdev, GPU_PRFCNT_TILER_EN, 0);
> +	panfrost_perfcnt_gpu_disable(pfdev);
>  }
> 

