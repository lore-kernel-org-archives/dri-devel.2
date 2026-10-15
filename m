Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8495CC6B34
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 07:58:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4639B11218A;
	Thu, 15 Oct 2026 07:57:20 +0000 (UTC)
Received: from host3.o27bbn.ondsl.gr (host3.o27bbn.ondsl.gr [79.129.74.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0590210FFD1;
 Thu, 15 Oct 2026 00:37:34 +0000 (UTC)
Received: from mail.e-psn.eu (cluster-localnode [10.200.210.1])
 by mail.e-psn.eu (Postfix) with ESMTPA id 8F3173A537AA;
 Thu, 15 Oct 2026 00:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=e-psn.eu; s=default;
 t=1792024651; h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ingnB9AcWDf+xSzk/JYpaVyHALuYuvn8bSdf+q+dJRo=;
 b=ExdDwVWf3kjOzu1Sv0Gc27ZL7YUH8sgPj/EvPF1eEeE1KcxYQMaT0T5Y+zs4qQXb9b0Up6
 +lh11Kr724DOPQDjKaMOqjFfllPbE78DXNeajygFHNtvtDlFKhJwHTA5KxFdkq5hdT2UHl
 OhT+1taOwaz3L2EkxXsrRy8WWVNCwKA/cjf+1rsBmkTaeKJ/w6Mix7wQrgoowke9HCnzYq
 c7CrEfT7IhJDenNIP+wFSXBr32irsMTceqOt9M02E6cUKIfHyMk5zlvwRXA17X72hBSrPJ
 jnSiLU87Dansia8i1N4Oi/1OBkRw9UHAuy4OBETGNGDJt89s0ousKcAiRZuhtw==
MIME-Version: 1.0
Date: Thu, 15 Oct 2026 03:37:31 +0300
From: Constantinos Chalkias <cch@e-psn.eu>
To: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: =?UTF-8?Q?Bata_Roland_Kriszti=C3=A1n?= <batarolandkrisztian@gmail.com>,
 intel-xe@lists.freedesktop.org, matthew.brost@intel.com,
 thomas.hellstrom@linux.intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/xe/hwmon: refresh Battlemage thermal telemetry under
 force-wake
Mail-Reply-To: cch@e-psn.eu
In-Reply-To: <as_iOd6A_Yncj8Gt@intel.com>
References: <20261012104245.2108030-1-cch@e-psn.eu>
 <as_iOd6A_Yncj8Gt@intel.com>
Message-ID: <046ad11178ef5ab04364e14a0211a68c@e-psn.eu>
X-Sender: cch@e-psn.eu
Organization: E-PSN
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Flag-Threshold: 6
X-Mailman-Approved-At: Thu, 15 Oct 2026 07:57:13 +0000
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
Reply-To: cch@e-psn.eu
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Rodrigo,
Thanks for pointing this out. Yes, this appears to be the same issue, 
and I agree we should avoid parallel fixes.
My follow-up testing independently converged on a very similar result. I 
narrowed the workaround to CHANNEL_PKG only. A 500-1000 us GT force-wake 
interval was not reliable, while 3000-3500 us was.
In the most controlled test I disabled both hwmon pollers, stopped the 
inference workload, and the physical blower remained latched at high 
speed for more than five minutes while the GPU was otherwise idle. A 
single package-temperature read using XE_FW_GT with a 3000-3500 us 
interval immediately caused the blower to return to normal.
I also saw the later RFC follow-up showing that both GT-only and 
RENDER-only longer pulses could refresh the telemetry and were followed 
by fan slowdown, which seems consistent with this result.
I won't send a competing v2. I'm happy to contribute these measurements 
to the existing RFC effort and help test whatever implementation you 
prefer to converge on.
Thanks,
Constantinos

On 2026-10-14 23:12, Rodrigo Vivi wrote:
> On Mon, Oct 12, 2026 at 01:42:45PM +0300, Constantinos Chalkias wrote:
>> On Battlemage, thermal telemetry can remain stale after the GT returns
>> to RC6 following sustained workloads.
>> 
>> On an Intel Arc Pro B70, package and VRAM temperature telemetry may 
>> stop
>> refreshing after a long inference workload. Fan telemetry can also
>> become invalid while the physical blower remains elevated.
>> 
>> Acquire the GT force-wake domain around Battlemage thermal MMIO reads
>> and allow a short settling interval before reading the register. Route
>> package, VRAM and VRAM-channel availability reads through the helper.
>> 
>> Testing showed that an immediate read, as well as a 100-300 us delay,
>> could leave telemetry stale. A 500-1000 us delay recovered correctly
>> across repeated inference-to-idle cycles.
>> 
>> The change is restricted to Battlemage, where the behavior has been
>> reproduced and validated.
>> 
>> Signed-off-by: Constantinos Chalkias <cch@e-psn.eu>
> 
> Cc: Bata Roland Krisztián <batarolandkrisztian@gmail.com>
> 
> https://lore.kernel.org/intel-xe/179041811564.526373.13204522833274380927.b70-hwmon-rfc@gmail.com/
> 
> I believe you guys are facing the same dificulties and arriving to 
> similar
> conclusions.
> 
> If the consensus is that we need this forcewake, let's do it.
> 
> Let's just avoid duplication of efforts in here.
> 
> And thank you all for the contributions.
> 
>> ---
>>  drivers/gpu/drm/xe/xe_hwmon.c | 51 
>> ++++++++++++++++++++++++++++++-----
>>  1 file changed, 45 insertions(+), 6 deletions(-)
>> 
>> diff --git a/drivers/gpu/drm/xe/xe_hwmon.c 
>> b/drivers/gpu/drm/xe/xe_hwmon.c
>> index 5edeac961ec3..fee358ab9a6b 100644
>> --- a/drivers/gpu/drm/xe/xe_hwmon.c
>> +++ b/drivers/gpu/drm/xe/xe_hwmon.c
>> @@ -3,6 +3,7 @@
>>   * Copyright © 2023 Intel Corporation
>>   */
>> 
>> +#include <linux/delay.h>
>>  #include <linux/hwmon-sysfs.h>
>>  #include <linux/hwmon.h>
>>  #include <linux/jiffies.h>
>> @@ -14,6 +15,7 @@
>>  #include "regs/xe_mchbar_regs.h"
>>  #include "regs/xe_pcode_regs.h"
>>  #include "xe_device.h"
>> +#include "xe_force_wake.h"
>>  #include "xe_hwmon.h"
>>  #include "xe_mmio.h"
>>  #include "xe_pcode.h"
>> @@ -946,14 +948,43 @@ static void xe_hwmon_get_voltage(struct xe_hwmon 
>> *hwmon, int channel, long *valu
>>  	*value = DIV_ROUND_CLOSEST(REG_FIELD_GET(VOLTAGE_MASK, reg_val) * 
>> 2500, SF_VOLTAGE);
>>  }
>> 
>> -static inline bool is_vram_ch_available(struct xe_hwmon *hwmon, int 
>> channel)
>> +static int xe_hwmon_temp_mmio_read(struct xe_hwmon *hwmon,
>> +				   struct xe_reg reg, u32 *reg_val)
>>  {
>>  	struct xe_mmio *mmio = xe_root_tile_mmio(hwmon->xe);
>> +
>> +	if (hwmon->xe->info.platform == XE_BATTLEMAGE) {
>> +		struct xe_gt *gt = xe_root_mmio_gt(hwmon->xe);
>> +
>> +		CLASS(xe_force_wake, fw_ref)(gt_to_fw(gt), XE_FW_GT);
>> +
>> +		if (!xe_force_wake_ref_has_domain(fw_ref.domains, XE_FW_GT))
>> +			return -ETIMEDOUT;
>> +
>> +		/*
>> +		 * Allow thermal telemetry to refresh after leaving RC6
>> +		 * before reading the temperature register.
>> +		 */
>> +		usleep_range(500, 1000);
>> +
>> +		*reg_val = xe_mmio_read32(mmio, reg);
>> +		return 0;
>> +	}
>> +
>> +	*reg_val = xe_mmio_read32(mmio, reg);
>> +
>> +	return 0;
>> +}
>> +
>> +static inline bool is_vram_ch_available(struct xe_hwmon *hwmon, int 
>> channel)
>> +{
>>  	int vram_id = channel - CHANNEL_VRAM_N;
>>  	struct xe_reg vram_reg;
>> +	u32 reg_val;
>> 
>>  	vram_reg = xe_hwmon_get_reg(hwmon, REG_TEMP, channel);
>> -	if (!xe_reg_is_valid(vram_reg) || !xe_mmio_read32(mmio, vram_reg))
>> +	if (!xe_reg_is_valid(vram_reg) ||
>> +	    xe_hwmon_temp_mmio_read(hwmon, vram_reg, &reg_val) || !reg_val)
>>  		return false;
>> 
>>  	/* Create label only for available vram channel */
>> @@ -1025,15 +1056,19 @@ xe_hwmon_temp_is_visible(struct xe_hwmon 
>> *hwmon, u32 attr, int channel)
>>  static int
>>  xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 attr, int channel, 
>> long *val)
>>  {
>> -	struct xe_mmio *mmio = xe_root_tile_mmio(hwmon->xe);
>> -	u64 reg_val;
>> +	u32 reg_val;
>> +	int ret;
>> 
>>  	switch (attr) {
>>  	case hwmon_temp_input:
>>  		switch (channel) {
>>  		case CHANNEL_PKG:
>>  		case CHANNEL_VRAM:
>> -			reg_val = xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, 
>> channel));
>> +			ret = xe_hwmon_temp_mmio_read(hwmon,
>> +						      xe_hwmon_get_reg(hwmon, REG_TEMP, channel),
>> +						      &reg_val);
>> +			if (ret)
>> +				return ret;
>> 
>>  			/* HW register value is in degrees Celsius, convert to 
>> millidegrees. */
>>  			*val = REG_FIELD_GET(TEMP_MASK, reg_val) * MILLIDEGREE_PER_DEGREE;
>> @@ -1043,7 +1078,11 @@ xe_hwmon_temp_read(struct xe_hwmon *hwmon, u32 
>> attr, int channel, long *val)
>>  		case CHANNEL_PCIE:
>>  			return get_pcie_temp(hwmon, val);
>>  		case CHANNEL_VRAM_N...CHANNEL_VRAM_N_MAX:
>> -			reg_val = xe_mmio_read32(mmio, xe_hwmon_get_reg(hwmon, REG_TEMP, 
>> channel));
>> +			ret = xe_hwmon_temp_mmio_read(hwmon,
>> +						      xe_hwmon_get_reg(hwmon, REG_TEMP, channel),
>> +						      &reg_val);
>> +			if (ret)
>> +				return ret;
>>  			/*
>>  			 * This temperature format is 24 bit [31:8] signed integer and 8 
>> bit
>>  			 * [7:0] fraction.
>> --
>> 2.56.0
>> 
