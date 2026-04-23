Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45A15F99344
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 07:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8C6410E028;
	Thu, 23 Apr 2026 07:55:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mGAvep7+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C84ED10E028
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 07:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776930924; x=1808466924;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=QkyccbBv0oySBfpY0mLjYZrYpjrfx7hKgcBkSFDfafE=;
 b=mGAvep7+lYIUEuCfH0q++ujLVx6kmBC4gcmHvvbwNUQktdQZofm9HXgy
 TbkhViXOL89Uy4/Y7qHslEmlPkeJZ6sDgCCXSkd4XIDeqF8k/pKyaiiOU
 t6gzIvBuYJJxHt7P8IQrfzV7J6mLBweOv+bAgkCpFF+zKfr24SdY8v65l
 7O71pknNXAUiUnVSK14ep+zZ9wMFm//bSNCWpaatbL+t3xxrH7JjrSVWD
 Xr/FjiFkxkHbxz8EjA9EZS+0yPSukmP9T4y0IW36pk5RiucZLvrKf0Ors
 PSrNn/qguQduKApHs8TGEGvxFbvLuxzV3Uq9KdM1A6QwnHBj5FxxRmymf Q==;
X-CSE-ConnectionGUID: YLNWzKkURK6PnsvN5HYQKQ==
X-CSE-MsgGUID: WAph6fzMQsG88vCk/YhLPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="77910986"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="77910986"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 00:55:22 -0700
X-CSE-ConnectionGUID: sUo9s0I/SdCVwuWgqJ/t6g==
X-CSE-MsgGUID: Dl8uwvBqR32t+wUeqbnKCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="237570971"
Received: from soc-5cg43972ff.clients.intel.com (HELO [10.102.88.146])
 ([10.102.88.146])
 by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 00:55:18 -0700
Message-ID: <9d9bd8af-c849-4de0-b6bf-800295a7355c@linux.intel.com>
Date: Thu, 23 Apr 2026 09:55:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix swapped register names in
 pwr_island_drive functions
To: Karol Wachowski <karol.wachowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, lizhi.hou@amd.com
References: <20260421093907.37304-1-karol.wachowski@linux.intel.com>
Content-Language: en-US
From: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
In-Reply-To: <20260421093907.37304-1-karol.wachowski@linux.intel.com>
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

On 21-Apr-26 11:39 AM, Karol Wachowski wrote:
> pwr_island_drive_37xx and pwr_island_drive_40xx functions had incorrectly
> swapped registers definitions. Bug is purely cosmetic as those registers
> have exactly same offsets and layout in both 37XX and 40XX.
> 
> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
> ---
>   drivers/accel/ivpu/ivpu_hw_ip.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/ivpu_hw_ip.c
> index 37f95a0551ed..81f0b1f8f5a6 100644
> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
> @@ -308,26 +308,26 @@ static void pwr_island_trickle_drive_40xx(struct ivpu_device *vdev, bool enable)
>   
>   static void pwr_island_drive_37xx(struct ivpu_device *vdev, bool enable)
>   {
> -	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0);
> +	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
>   
>   	if (enable)
> -		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
> +		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
>   	else
> -		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
> +		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
>   
> -	REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
> +	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
>   }
>   
>   static void pwr_island_drive_40xx(struct ivpu_device *vdev, bool enable)
>   {
> -	u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
> +	u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0);
>   
>   	if (enable)
> -		val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
> +		val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
>   	else
> -		val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, MSS_CPU, val);
> +		val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, CSS_CPU, val);
>   
> -	REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
> +	REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
>   }
>   
>   static void pwr_island_enable(struct ivpu_device *vdev)

Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>
