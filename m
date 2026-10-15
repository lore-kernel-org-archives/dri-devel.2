Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A458FCC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:35:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D814910EBFE;
	Thu, 15 Oct 2026 14:35:35 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 3601A10EC0B
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:35:29 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6EC921477
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:35:25 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 794003F871
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792074928; bh=j78ri2SnZyErlDFEtjIb1ablNh6mzrsPY7I0ctWwvMA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Iea3vDW3IdBI0V2R9/k9ARp/NnQLApLPC6abOtUGzrAeQxrBnBgBxt/MDa0IuQDaJ
 zonOwHpt6jD+5FmJdpvQ+fxGUkYz22WbzUbQaVnAgN7m10lloEzpP8O3GOW6v8zxpQ
 ukDPbyiszYkJ0YIylQl7rarTax1Hvn+xth9wEaKc=
Date: Thu, 15 Oct 2026 15:35:26 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Daniel Stone <daniels@collabora.com>
Cc: dri-devel@lists.freedesktop.org, boris.brezillon@collabora.com,
 laura.nao@collabora.com, adrian.larumbe@collabora.com,
 daniel.almeida@collabora.com
Subject: Re: [PATCH v2 1/2] drm/panthor: Add neural-engine presence and power
 bits for v14+
Message-ID: <atDkrgAJsLV6Je-M@e142607>
References: <20261015135116.713461-1-daniels@collabora.com>
 <20261015135116.713461-2-daniels@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015135116.713461-2-daniels@collabora.com>
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

On Thu, Oct 15, 2026 at 02:50:26PM +0100, Daniel Stone wrote:
> Mali v14+ can optionally feature a neural engine. This is not currently
> used by Panthor, but add the bare-minimum bits required to detect the
> engine's presence and control its power.
> 
> Signed-off-by: Daniel Stone <daniels@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h | 1 +
>  drivers/gpu/drm/panthor/panthor_hw.h       | 6 ++++++
>  drivers/gpu/drm/panthor/panthor_pwr_regs.h | 7 +++++++
>  3 files changed, 14 insertions(+)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 4c5b953796e4f..5340966caef37 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -67,6 +67,7 @@
>  
>  #define GPU_FEATURES					0x60
>  #define   GPU_FEATURES_RAY_INTERSECTION			BIT(2)
> +#define   GPU_FEATURES_NEURAL_ENGINE			BIT(4)
>  #define   GPU_FEATURES_RAY_TRAVERSAL			BIT(5)
>  
>  #define GPU_TIMESTAMP_OFFSET				0x88
> diff --git a/drivers/gpu/drm/panthor/panthor_hw.h b/drivers/gpu/drm/panthor/panthor_hw.h
> index f797663893b2d..924faea27061a 100644
> --- a/drivers/gpu/drm/panthor/panthor_hw.h
> +++ b/drivers/gpu/drm/panthor/panthor_hw.h
> @@ -61,4 +61,10 @@ static inline bool panthor_hw_has_pwr_ctrl(struct panthor_device *ptdev)
>  	return GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14;
>  }
>  
> +static inline bool panthor_hw_has_neural(struct panthor_device *ptdev)
> +{
> +	return (GPU_ARCH_MAJOR(ptdev->gpu_info.gpu_id) >= 14 &&
> +	        ptdev->gpu_info.gpu_features & GPU_FEATURES_NEURAL_ENGINE);
> +}
> +
>  #endif /* __PANTHOR_HW_H__ */
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr_regs.h b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> index 9cf7a715066f8..80d8e1e522298 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_pwr_regs.h
> @@ -20,12 +20,14 @@
>  #define   PWR_STATUS_ALLOW_L2				BIT_U64(0)
>  #define   PWR_STATUS_ALLOW_TILER			BIT_U64(1)
>  #define   PWR_STATUS_ALLOW_SHADER			BIT_U64(8)
> +#define   PWR_STATUS_ALLOW_NEURAL			BIT_U64(9)
>  #define   PWR_STATUS_ALLOW_BASE				BIT_U64(14)
>  #define   PWR_STATUS_ALLOW_STACK			BIT_U64(15)
>  #define   PWR_STATUS_DOMAIN_ALLOWED(x)			BIT_U64(x)
>  #define   PWR_STATUS_DELEGATED_L2			BIT_U64(16)
>  #define   PWR_STATUS_DELEGATED_TILER			BIT_U64(17)
>  #define   PWR_STATUS_DELEGATED_SHADER			BIT_U64(24)
> +#define   PWR_STATUS_DELEGATED_NEURAL			BIT_U64(25)
>  #define   PWR_STATUS_DELEGATED_BASE			BIT_U64(30)
>  #define   PWR_STATUS_DELEGATED_STACK			BIT_U64(31)
>  #define   PWR_STATUS_DELEGATED_SHIFT			16
> @@ -48,6 +50,7 @@
>  #define   PWR_COMMAND_DOMAIN_L2				0
>  #define   PWR_COMMAND_DOMAIN_TILER			1
>  #define   PWR_COMMAND_DOMAIN_SHADER			8
> +#define   PWR_COMMAND_DOMAIN_NEURAL			9
>  #define   PWR_COMMAND_DOMAIN_BASE			14
>  #define   PWR_COMMAND_DOMAIN_STACK			15
>  #define   PWR_COMMAND_SUBDOMAIN_RTU			BIT(0)
> @@ -68,6 +71,10 @@
>  #define PWR_SHADER_READY				0x208
>  #define PWR_SHADER_PWRTRANS				0x210
>  #define PWR_SHADER_PWRACTIVE				0x218
> +#define PWR_NEURAL_PRESENT				0x240
> +#define PWR_NEURAL_READY				0x248
> +#define PWR_NEURAL_PWRTRANS				0x250
> +#define PWR_NEURAL_PWRACTIVE				0x258
>  #define PWR_BASE_PRESENT				0x380
>  #define PWR_BASE_READY					0x388
>  #define PWR_BASE_PWRTRANS				0x390
> -- 
> 2.47.3
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
