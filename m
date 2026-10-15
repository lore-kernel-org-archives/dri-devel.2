Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08FECC6B33
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 14:37:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E70D9112385;
	Thu, 15 Oct 2026 14:36:59 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 1DF251123A9
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 14:36:54 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CD011516
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:36:50 -0700 (PDT)
Received: from [10.2.11.34] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 71CB23F871
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 07:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1792075013; bh=+Gv+gS16yWKsfQ0Jwq4z8Et7i5MjsA1AzO/CuYkrYyg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JsSGAK06hY8EnQlSgLre4dIPqGL93miENNBUZZnWaInpvbCkhdGMny9AVAuVAEYk+
 duCAqAZXzKcVR5SH0jlzEp7BUGu425yWqzVqdKjfrpf5fKHb6BeUSMmK24MamT3zw3
 QH4MdgPJ2wLttY9l15MpT0YapbUhAtGqeXFbo6yg=
Date: Thu, 15 Oct 2026 15:36:51 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Daniel Stone <daniels@collabora.com>
Cc: dri-devel@lists.freedesktop.org, boris.brezillon@collabora.com,
 laura.nao@collabora.com, adrian.larumbe@collabora.com,
 daniel.almeida@collabora.com
Subject: Re: [PATCH v2 2/2] drm/panthor: Delegate neural power domain to CSF
 when present
Message-ID: <atDlA2NwITs69_p3@e142607>
References: <20261015135116.713461-1-daniels@collabora.com>
 <20261015135116.713461-3-daniels@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261015135116.713461-3-daniels@collabora.com>
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

On Thu, Oct 15, 2026 at 02:50:27PM +0100, Daniel Stone wrote:
> As the neural power domain is a child of the L2 power domain, control
> over the L2 domain cannot be delegated to CSF unless the neural domain
> has first been delegated. Given that we delegate all power control on
> v14+, this eventually causes a hard lock-up and/or firmware OOPS when we
> try to power on anything due to the inconsistent delegation state.
> 
> Fixes: ee4f9af07933 ("drm/panthor: Implement L2 power on/off via PWR_CONTROL")
> Signed-off-by: Daniel Stone <daniels@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_pwr.c | 28 ++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index dd7b6ef8ea209..7a841cfa86fd5 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -146,6 +146,8 @@ static const char *get_domain_name(u8 domain)
>  		return "Base";
>  	case PWR_COMMAND_DOMAIN_STACK:
>  		return "Stack";
> +	case PWR_COMMAND_DOMAIN_NEURAL:
> +		return "Neural";
>  	}
>  	return "Unknown";
>  }
> @@ -163,6 +165,8 @@ static u32 get_domain_base(u8 domain)
>  		return PWR_BASE_PRESENT;
>  	case PWR_COMMAND_DOMAIN_STACK:
>  		return PWR_STACK_PRESENT;
> +	case PWR_COMMAND_DOMAIN_NEURAL:
> +		return PWR_NEURAL_PRESENT;
>  	}
>  	return 0;
>  }
> @@ -229,6 +233,15 @@ static void panthor_pwr_debug_info_show(struct panthor_device *ptdev)
>  	drm_info(&ptdev->base, "SHADER_PRESENT:  0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PRESENT));
>  	drm_info(&ptdev->base, "SHADER_PWRTRANS: 0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_PWRTRANS));
>  	drm_info(&ptdev->base, "SHADER_READY:    0x%016llx", gpu_read64(pwr->iomem, PWR_SHADER_READY));
> +
> +	if (panthor_hw_has_neural(ptdev)) {
> +		drm_info(&ptdev->base, "NEURAL_PRESENT:  0x%016llx",
> +			 gpu_read64(pwr->iomem, PWR_NEURAL_PRESENT));
> +		drm_info(&ptdev->base, "NEURAL_PWRTRANS: 0x%016llx",
> +			 gpu_read64(pwr->iomem, PWR_NEURAL_PWRTRANS));
> +		drm_info(&ptdev->base, "NEURAL_READY:    0x%016llx",
> +			 gpu_read64(pwr->iomem, PWR_NEURAL_READY));
> +	}
>  }
>  
>  static int panthor_pwr_domain_transition(struct panthor_device *ptdev, u32 cmd, u32 domain,
> @@ -405,9 +418,15 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
>  	if (!ptdev->pwr)
>  		return 0;
>  
> +	if (panthor_hw_has_neural(ptdev)) {
> +		ret = delegate_domain(ptdev, PWR_COMMAND_DOMAIN_NEURAL);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	ret = delegate_domain(ptdev, PWR_COMMAND_DOMAIN_SHADER);
>  	if (ret)
> -		return ret;
> +		goto err_retract_neural;
>  
>  	ret = delegate_domain(ptdev, PWR_COMMAND_DOMAIN_TILER);
>  	if (ret)
> @@ -415,6 +434,8 @@ static int panthor_pwr_delegate_domains(struct panthor_device *ptdev)
>  
>  	return 0;
>  
> +err_retract_neural:
> +	retract_domain(ptdev, PWR_COMMAND_DOMAIN_NEURAL);
>  err_retract_shader:
>  	retract_domain(ptdev, PWR_COMMAND_DOMAIN_SHADER);
>  
> @@ -517,6 +538,7 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
>  	struct panthor_pwr *pwr = ptdev->pwr;
>  	const u64 l2_allow_mask = PWR_STATUS_DOMAIN_ALLOWED(PWR_COMMAND_DOMAIN_L2);
>  	const u64 pwr_status = gpu_read64(pwr->iomem, PWR_STATUS);
> +	const bool has_neural = panthor_hw_has_neural(ptdev);
>  
>  	/* Abort if L2 power off constraints are not satisfied */
>  	if (!(pwr_status & l2_allow_mask)) {
> @@ -530,6 +552,10 @@ void panthor_pwr_l2_power_off(struct panthor_device *ptdev)
>  	 * host control to be powered down in the right order before powering
>  	 * down the L2.
>  	 */
> +	if (has_neural &&
> +	    panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_NEURAL))
> +		return;
> +
>  	if (panthor_pwr_domain_force_off(ptdev, PWR_COMMAND_DOMAIN_TILER))
>  		return;
>  
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
