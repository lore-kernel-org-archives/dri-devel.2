Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272F7CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 13:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A2FA10E106;
	Wed, 27 May 2026 13:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XudC6/aA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B775110E106;
 Wed, 27 May 2026 13:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779890011; x=1811426011;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=HMhVZCDTnX1vcdC4g6fRFUA+elHTRzFClqwaPTSmEdQ=;
 b=XudC6/aA0QgJ8FfbzOQRSybHSdWUpwCYgD5z9XhQPxSy5YyPIE5+lihc
 GCeiR6SA2dkTKBLdsNUdl+73s7egms0B34JznDwHO7vO4JexE+aIueTs7
 rPH+V4drnY4itv5Lq3HiPVcNyezNFx47qVqzTjWamCZfxbaA0qyaTzOQS
 yg70jKmf2X16wILJtDSWjHXsOoe8FAPW4l/pcKdPYyuoskcbSYGMHmXEI
 DAxcVsoEVgbmJ0hdHRZMO3UPD/2LQRaPSAqpovxY4jL4j08JGyOVCk5uF
 xGIzHxNZ9qzUwi7D3l/km4COhJo5LER1ubkcGvV1Q9r280ysB3u1LMpRQ g==;
X-CSE-ConnectionGUID: 0GXnbBM1S/mlRr0/f6aKrw==
X-CSE-MsgGUID: N6vWJWcDSiSgoLfRJENLaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11799"; a="80569526"
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="80569526"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 06:53:30 -0700
X-CSE-ConnectionGUID: ClUl9v0NRwCmss1aMoDyCg==
X-CSE-MsgGUID: aMYHQDb4Rm6/7z5Vn6cH3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,171,1774335600"; d="scan'208";a="246527783"
Received: from black.igk.intel.com ([10.91.253.5])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 May 2026 06:53:27 -0700
Date: Wed, 27 May 2026 15:53:24 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Zhan Wei <zhanwei919@gmail.com>
Cc: Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Andi Shyti <andi.shyti@linux.intel.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guenter Roeck <linux@roeck-us.net>, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-hwmon@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] drm/xe/hwmon: report a single fan for DG2 instead of
 two
Message-ID: <ahb3VMRCQpofblbW@black.igk.intel.com>
References: <20260527115311.13398-1-zhanwei919@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260527115311.13398-1-zhanwei919@gmail.com>
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

On Wed, May 27, 2026 at 07:53:11PM +0800, Zhan Wei wrote:
> xe_hwmon_pcode_read_fan_control() currently hardcodes *uval = 2 when
> queried with FSC_READ_NUM_FANS on DG2. This causes fan2_input to be
> exposed via sysfs, but on the tested Arc A750 LE (DG2 G10, PCI ID
> 0x56a1) fan2_input reads 0 RPM permanently while fan1_input correctly
> reports ~800 RPM with both physical fan physically spinning.
> 
> The RPM is calculated delta-based from a tach pulse counter:
> 
>     rotations = (reg_val - fi->reg_val_prev) / 2;
> 
> so a constant-zero RPM means the register at offset 0x138170
> (BMG_FAN_2_SPEED) simply does not accumulate pulses on DG2 silicon.
> The i915 driver does not expose fan2 on DG2 at all -- it only maps
> PCU_PWM_FAN_SPEED (0x138140, identical to BMG_FAN_1_SPEED), consistent
> with the observation that only one fan tach register is wired on DG2.

i915 is for legacy cards (like DG1) which only has a single channel
in hardware. I just happen to extend the support to DG2 for the folks
that might be using it.

> Report a single fan for DG2 to keep the phantom fan2_input out of
> sysfs.  Battlemage paths are unchanged.
> 
> Tested on Arc A750 LE (DG2 G10): with this patch applied, fan2_input
> no longer appears in /sys/class/hwmon/hwmonX/ and `sensors xe-pci-0300`
> shows fan1 only.
> 
> Fixes: 28f79ac609de ("drm/xe/hwmon: expose fan speed")
> Signed-off-by: Zhan Wei <zhanwei919@gmail.com>
> ---
> Open questions for reviewers: this is verified only on DG2 G10. Owners
> of G11 (e.g. ASRock Challenger A750) and G12 (e.g. Sparkle Titan A750
> with three physical fans) -- does fan2_input or fan3_input ever read
> non-zero in your setup? If so, the right fix is a per-subplatform
> table rather than a flat 1.

There's no straight answer here :)

root@DUT2147DG2FRD:/home/gta# cat /sys/class/drm/card0/device/device
0x56a1

root@DUT2147DG2FRD:/home/gta# sensors xe-pci-0300
xe-pci-0300
Adapter: PCI adapter
pkg:         758.00 mV
fan1:         636 RPM
fan2:         652 RPM
pkg:          +47.0°C
vram:         +50.0°C
pkg:              N/A  (max = 190.00 W)
pkg:          14.37 kJ


The way this works is upto the OEMs how they design their cards. Some reuse
a single channel for multiple physical fans while some use 1:1 mapped multiple
channels for each fan.

This is unfortunately not possible to figure out from the driver without
FSC_READ_NUM_FANS command (which has been found to be not working on some
cards and hence the hardcoded value).

Raag

>  drivers/gpu/drm/xe/xe_hwmon.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_hwmon.c b/drivers/gpu/drm/xe/xe_hwmon.c
> index de3f2aeffc3f..2a60a76b1971 100644
> --- a/drivers/gpu/drm/xe/xe_hwmon.c
> +++ b/drivers/gpu/drm/xe/xe_hwmon.c
> @@ -860,9 +860,15 @@ static int xe_hwmon_pcode_read_fan_control(const struct xe_hwmon *hwmon, u32 sub
>  {
>  	struct xe_tile *root_tile = xe_device_get_root_tile(hwmon->xe);
>  
> -	/* Platforms that don't return correct value */
> +	/*
> +	 * The PCODE FAN_SPEED_CONTROL subcommands return an error on DG2, so we
> +	 * answer the FSC_READ_NUM_FANS query here. DG2 only wires a single fan
> +	 * tachometer register (BMG_FAN_1_SPEED == 0x138140, shared with i915's
> +	 * PCU_PWM_FAN_SPEED); BMG_FAN_2/3_SPEED read 0 on DG2 silicon. Reporting
> +	 * one fan keeps a phantom fan2_input that always reads 0 out of sysfs.
> +	 */
>  	if (hwmon->xe->info.platform == XE_DG2 && subcmd == FSC_READ_NUM_FANS) {
> -		*uval = 2;
> +		*uval = 1;
>  		return 0;
>  	}
>  
> -- 
> 2.43.0
> 
