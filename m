Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D561DCA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27ACD10E36F;
	Thu,  1 Oct 2026 14:34:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="aXYJxOXL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FF010E72A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:34:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790865262; x=1822401262;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=EIuX57TOjnN152QdDTN8FB4KoDGQwEZXSFYcvxX7ltw=;
 b=aXYJxOXLBfmJ4uzIKI1rhQ7bV8MCTLGET04fbaDEW9UtFB9i/7t/KhDQ
 SGevrxNg6yepSaMoNTzVbz3tNnbA5OKQ5n1WrEfCNOYZhOVQOgypAhLkh
 H9kyAhSfX50OpUtmNBHpOpBEeWlfbLObQqWryZABW9OQX3uvVc/EPY+rv
 A2dQbSCCbO2JHqrTkQG+SHEJttNwWXsuNFNfaYiQRsfRbJA03tn5fV3DW
 nJi+sbCHRrXE1xt5ezdyZCUKv2eR1rU9k2/RKtXPXRUt4iBlGY1YG29YA
 s+wJHTabo3CUGDEp+KxB0LtmoIUAg4BzrcX1b/9lMFObzE4jnYDnPnPpo A==;
X-CSE-ConnectionGUID: GX8BqvNdT+WVFNOASsmMUQ==
X-CSE-MsgGUID: cJFsEHikQ6CNq4uakXYWbw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="91722654"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="91722654"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:34:21 -0700
X-CSE-ConnectionGUID: 1d7XeBUpStepc75Q+4JqGQ==
X-CSE-MsgGUID: 1DhvuAGMRo2bIDh+6rtBaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="305502991"
Received: from acagidia-mobl1.ger.corp.intel.com (HELO [10.94.248.197])
 ([10.94.248.197])
 by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 07:34:20 -0700
Message-ID: <6d7ecb52-8e0d-4319-b9c2-58b9136a474f@linux.intel.com>
Date: Thu, 1 Oct 2026 16:34:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] accel/ivpu: Split HW IP generation dispatch into
 helpers
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: karol.wachowski@linux.intel.com
References: <20261001110401.2866557-1-dawid.osuchowski@linux.intel.com>
 <20261001110401.2866557-4-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20261001110401.2866557-4-dawid.osuchowski@linux.intel.com>
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

On 01-Oct-26 1:04 PM, Dawid Osuchowski wrote:
> From: Karol Wachowski <karol.wachowski@linux.intel.com>
> 
> ivpu_hw_ip_soc_cpu_boot() and pwr_island_delay_set() keep the result of
> their per-generation switch in locals that are left uninitialized on the
> path past the last case. Building with -Wmaybe-uninitialized reports ret,
> post, post2 and status; Kbuild disables that warning for GCC, so it does
> not show up in a normal build.
> 
> Let every case return directly instead, so no local is needed.
> ivpu_hw_ip_soc_cpu_boot() now dispatches on its own, with the debug
> message moved ahead of the switch so that the boot mode is logged before
> the boot registers are written, and the power island delay values move
> into per-generation helpers. Neither switch has a default: label, so
> -Wswitch reports any enum vpu_hw_ip value added later that is not
> handled, and the path past the switch returns -EINVAL.
> 
> Build the power island delay values from zero instead of reading the
> registers first. POST_DLY, POST1_DLY and POST2_DLY together span every
> writable bit of PWR_ISLAND_EN_POST_DLY, and STATUS_DLY spans every
> writable bit of PWR_ISLAND_STATUS_DLY, so the read-modify-write only
> fetched bits that are immediately overwritten.
> 
> The boot mode is now logged even when the boot fails; no other functional
> changes.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_hw_ip.c | 64 ++++++++++++++++-----------------
>   1 file changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
> index bd6bb3fa49ff..36730f4338f0 100644
> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
> @@ -265,21 +265,35 @@ void ivpu_hw_ip_idle_gen_disable(struct ivpu_device *vdev)
>   }
>   
>   static void
> -pwr_island_delay_set_50xx(struct ivpu_device *vdev, u32 post, u32 post1, u32 post2, u32 status)
> +pwr_island_delay_write(struct ivpu_device *vdev, u32 post, u32 post1, u32 post2, u32 status)
>   {
>   	u32 val;
>   
> -	val = REGV_RD32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY);
> -	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST_DLY, post, val);
> +	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST_DLY, post, 0);
>   	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST1_DLY, post1, val);
>   	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, POST2_DLY, post2, val);
>   	REGV_WR32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_EN_POST_DLY, val);
>   
> -	val = REGV_RD32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY);
> -	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY, STATUS_DLY, status, val);
> +	val = REG_SET_FLD_NUM(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY, STATUS_DLY, status, 0);
>   	REGV_WR32(VPU_50XX_HOST_SS_AON_PWR_ISLAND_STATUS_DLY, val);
>   }
>   
> +static void pwr_island_delay_set_50xx(struct ivpu_device *vdev)
> +{
> +	if (vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH)
> +		pwr_island_delay_write(vdev, 18, 0, 0, 46);
> +	else
> +		pwr_island_delay_write(vdev, 0, 0, 0, 3);
> +}
> +
> +static void pwr_island_delay_set_60xx(struct ivpu_device *vdev)
> +{
> +	if (vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH)
> +		pwr_island_delay_write(vdev, 198, 0, 198, 0);
> +	else
> +		pwr_island_delay_write(vdev, 17, 0, 17, 0);
> +}
> +
>   static void pwr_island_trickle_drive_37xx(struct ivpu_device *vdev, bool enable)
>   {
>   	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_TRICKLE_EN0);
> @@ -675,27 +689,19 @@ static void dpu_active_drive_37xx(struct ivpu_device *vdev, bool enable)
>   
>   static void pwr_island_delay_set(struct ivpu_device *vdev)
>   {
> -	bool high = vdev->hw->pll.profiling_freq == PLL_PROFILING_FREQ_HIGH;
> -	u32 post, post1, post2, status;
> -
>   	switch (ivpu_hw_ip_gen(vdev)) {
>   	case IVPU_HW_IP_37XX:
>   	case IVPU_HW_IP_40XX:
>   		return;
> +
>   	case IVPU_HW_IP_50XX:
> -		post = high ? 18 : 0;
> -		post1 = 0;
> -		post2 = 0;
> -		status = high ? 46 : 3;
> -		break;
> +		pwr_island_delay_set_50xx(vdev);
> +		return;
> +
>   	case IVPU_HW_IP_60XX:
> -		post = high ? 198 : 17;
> -		post1 = 0;
> -		post2 = high ? 198 : 17;
> -		status = 0;
> +		pwr_island_delay_set_60xx(vdev);
> +		return;
>   	}
> -
> -	pwr_island_delay_set_50xx(vdev, post, post1, post2, status);
>   }
>   
>   int ivpu_hw_ip_pwr_domain_enable(struct ivpu_device *vdev)
> @@ -933,30 +939,22 @@ static int soc_cpu_boot_60xx(struct ivpu_device *vdev)
>   
>   int ivpu_hw_ip_soc_cpu_boot(struct ivpu_device *vdev)
>   {
> -	int ret;
> +	ivpu_dbg(vdev, PM, "Booting firmware, mode: %s\n",
> +		 ivpu_fw_is_warm_boot(vdev) ? "warm boot" : "cold boot");
>   
>   	switch (ivpu_hw_ip_gen(vdev)) {
>   	case IVPU_HW_IP_37XX:
> -		ret = soc_cpu_boot_37xx(vdev);
> -		break;
> +		return soc_cpu_boot_37xx(vdev);
>   
>   	case IVPU_HW_IP_40XX:
>   	case IVPU_HW_IP_50XX:
> -		ret = soc_cpu_boot_40xx(vdev);
> -		break;
> +		return soc_cpu_boot_40xx(vdev);
>   
>   	case IVPU_HW_IP_60XX:
> -		ret = soc_cpu_boot_60xx(vdev);
> -		break;
> +		return soc_cpu_boot_60xx(vdev);
>   	}
>   
> -	if (ret)
> -		return ret;
> -
> -	ivpu_dbg(vdev, PM, "Booting firmware, mode: %s\n",
> -		 ivpu_fw_is_warm_boot(vdev) ? "warm boot" : "cold boot");
> -
> -	return 0;
> +	return -EINVAL;
>   }
>   
>   static void wdt_disable_37xx(struct ivpu_device *vdev)
Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
