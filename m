Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86365F99350
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 08:05:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6F2110E31F;
	Thu, 23 Apr 2026 08:05:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jlHySeo9";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A131010E31F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 08:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1776931534; x=1808467534;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=PqWsdTebn/2BbJjwuuNjkYaxABm7Z1Fh6/o4qtyPlOE=;
 b=jlHySeo9Zbr4tIlwMpqtvLrl5GXKIG2Kdzdky2yTSvSk+BxHG8ZnJPB9
 ph4va3eZiOU3HCOknObpE1QZCq2ar2GWj9XPrJh3Iwlm/7yWhjPL0gd/o
 Wji+H87CZ//6HIM8rFBc4DDw67w7m8pR5yQXith64OefRupoNqcRHevQ4
 5BCs+aLk4dt/XeYyxUYIWgOpKiBp6DdE4BwxmGYbCSivuLbCb1yTaipef
 Op335JZBhBmT0NmWOHoceuHCBGVe8bWA1e+XW3gwRqukQY6T9bgcHMtaT
 0K/6d4pLIl3ELb4W6dfGhaPLcVdTHFUtRNkXqW/W7AvCDC4M/24PjXSL3 g==;
X-CSE-ConnectionGUID: vt1TuZTUS2i/LT3sIkkgTw==
X-CSE-MsgGUID: i78SqXUGQ6y2WQ03wot+Bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11764"; a="81503273"
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="81503273"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 01:05:34 -0700
X-CSE-ConnectionGUID: nibtX5ntRWWltxg0uEyLsQ==
X-CSE-MsgGUID: 60iAdm/8Tn6S0j3f0YRqLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,194,1770624000"; d="scan'208";a="229926529"
Received: from unknown (HELO [10.102.88.27]) ([10.102.88.27])
 by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2026 01:05:31 -0700
Message-ID: <52f23fed-5be9-49f0-93dd-5c056ab2dbb1@linux.intel.com>
Date: Thu, 23 Apr 2026 10:05:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] accel/ivpu: Fix swapped register names in
 pwr_island_drive functions
To: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: oded.gabbay@gmail.com, jeff.hugo@oss.qualcomm.com,
 maciej.falkowski@linux.intel.com, lizhi.hou@amd.com
References: <20260421093907.37304-1-karol.wachowski@linux.intel.com>
 <9d9bd8af-c849-4de0-b6bf-800295a7355c@linux.intel.com>
Content-Language: en-US
From: Karol Wachowski <karol.wachowski@linux.intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <9d9bd8af-c849-4de0-b6bf-800295a7355c@linux.intel.com>
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

On 4/23/2026 9:55 AM, Andrzej Kacprowski wrote:
> On 21-Apr-26 11:39 AM, Karol Wachowski wrote:
>> pwr_island_drive_37xx and pwr_island_drive_40xx functions had incorrectly
>> swapped registers definitions. Bug is purely cosmetic as those registers
>> have exactly same offsets and layout in both 37XX and 40XX.
>>
>> Signed-off-by: Karol Wachowski <karol.wachowski@linux.intel.com>
>> ---
>>   drivers/accel/ivpu/ivpu_hw_ip.c | 16 ++++++++--------
>>   1 file changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/accel/ivpu/ivpu_hw_ip.c b/drivers/accel/ivpu/
>> ivpu_hw_ip.c
>> index 37f95a0551ed..81f0b1f8f5a6 100644
>> --- a/drivers/accel/ivpu/ivpu_hw_ip.c
>> +++ b/drivers/accel/ivpu/ivpu_hw_ip.c
>> @@ -308,26 +308,26 @@ static void pwr_island_trickle_drive_40xx(struct
>> ivpu_device *vdev, bool enable)
>>     static void pwr_island_drive_37xx(struct ivpu_device *vdev, bool
>> enable)
>>   {
>> -    u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0);
>> +    u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
>>         if (enable)
>> -        val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> CSS_CPU, val);
>> +        val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> MSS_CPU, val);
>>       else
>> -        val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> CSS_CPU, val);
>> +        val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> MSS_CPU, val);
>>   -    REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
>> +    REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
>>   }
>>     static void pwr_island_drive_40xx(struct ivpu_device *vdev, bool
>> enable)
>>   {
>> -    u32 val = REGV_RD32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0);
>> +    u32 val = REGV_RD32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0);
>>         if (enable)
>> -        val = REG_SET_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> MSS_CPU, val);
>> +        val = REG_SET_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> CSS_CPU, val);
>>       else
>> -        val = REG_CLR_FLD(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> MSS_CPU, val);
>> +        val = REG_CLR_FLD(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0,
>> CSS_CPU, val);
>>   -    REGV_WR32(VPU_37XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
>> +    REGV_WR32(VPU_40XX_HOST_SS_AON_PWR_ISLAND_EN0, val);
>>   }
>>     static void pwr_island_enable(struct ivpu_device *vdev)
> 
> Reviewed-by: Andrzej Kacprowski <andrzej.kacprowski@linux.intel.com>

Thank you, applied to drm-misc-next.

Karol
