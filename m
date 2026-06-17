Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48B61CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A7ED110F1A2;
	Thu, 18 Jun 2026 07:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tOZ3XW4l";
	dkim-atps=neutral
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com
 [209.85.216.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D38189FD4
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:35:47 +0000 (UTC)
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-36d5b11201aso3858510a91.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781692547; x=1782297347; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6Ftmopsn3f2abpL48mO0RyoBfFBPSuZonc7xIqzYUpY=;
 b=tOZ3XW4lGXS4jOT5ZKjw9/oaT8pcIkoRjT5PiLa/ATvhErM7ijerwx0kHsxfnxdD9k
 BJKe0hepfGtVIPOlV9kmRewmLSBXc4cQfaFqhF+3nCgdMEI6R1wrpVS34eqbm/eYu3/I
 72GL2eVWH6PLMzS/V2QM5DfLIueYOD6e7lSAbcHNmNWh4FMjfI0tzus1ahLe1xZGQhud
 wUKsKlA51dTIba2DRzY1LPSpNpZlViONjbNUbk0Iv9Ahazvkb0uXvaGyJgIgBWNeicbA
 MeQnkwkvQ0FDRVjJXD4GZC7Kn4maKmm9wzDqmeovmdpA0lurkMb70MyNQbZJQJe1cJSd
 xjCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781692547; x=1782297347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6Ftmopsn3f2abpL48mO0RyoBfFBPSuZonc7xIqzYUpY=;
 b=ig5QO5LKUj3w4g7k8AU/B1pj5R1ejEXIOwqIB/HYxpf6xkUY9+9mo5z9+7CveoU6/1
 7Owf9vgvzyPdlpNRVfJzZfW3TKMQZNWf4FRLwH0S/QvVR1OctgAB5/dsvfe5dSKuqArN
 6bstbLCczXBgd98gNoAjkpW3X4epLRFu5oP54Yn/x5AJjskCHw7IDonvrRfJx4Lr77xW
 84a/DoenWinxEm2BZUnKFMtaMmNo+A6ou/eGPK3yZPLz3cdQBeyYVJ6hl2j7p/OjWQ7v
 FdjlGoWjh+82b3W8PRrFGuqC5cIehFDAVcs6dlIo+Sb6o3jxN9kmd15Ok417lwdrgMqO
 aWcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MZqQt64tAETwML4yHmOKThVy0n9cqrOhoIO50T09VgflDdb0ZUWyMmA1sl1KPgQN4Z3+rS4GebzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzydM3Uk05S5hzRm9a7OvwHW/MtGDEyljN39Ay1paO72VgPKHN6
 kH00UMY4OavIvoV8KOc2zgTL6ZhEptSOyE5t6/U971KCBZzFU37Uo6sWdI+mGw==
X-Gm-Gg: AfdE7cklEJfrzEBDi/Gf7bBCpCuzeIUAnpp5kWTwv3LPmose4cuvZ1QbcUAIOsmX5Fe
 mH90yo5kiYGz3jVz7EmCG8m/oT7eu4HpbVQawAQ86oeIYmB1wiREiM70cD3xC2nfyCgHUXNVyh8
 5g1OoadAeiS3jDUVKjSzjcP+mEzG/NNOM0KGF7vd8ZIV9W8LdlEIX7lQGDDUwVFmBtWbS4IB3Sa
 yMO0oIdr5pXrftJfu0hMe7ryyL4chNNFC6X+hRJDcpHEV+JGpKJCBHk4oDpH9ZN8kp2duTf9n4/
 mpMp/YeRkXqw2RVDkKp8tvAMFbOXEPka3HyXcXDAx5HYg87pB/u+f5EWotAJ27cMutSgswfeqkn
 ifgtuCzwwrXiSDmaO5tQDYEy745iEgR/ddBBSU9F17HoYw8rOQlwHi2HZo+u5HgomckvsK3GfUa
 efhQ3ORnnyYmfYeYHk8nqiRyiwJHiIhxhx1Va0w4z6a/b1VzzxrORA8Ri7H35C6M8yZw==
X-Received: by 2002:a17:90b:2e0b:b0:368:b724:6d53 with SMTP id
 98e67ed59e1d1-37c9330947cmr3320760a91.4.1781692546953; 
 Wed, 17 Jun 2026 03:35:46 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c5228ebadsm5485446a91.10.2026.06.17.03.35.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 03:35:46 -0700 (PDT)
Message-ID: <df7363be-0e3f-4459-be4a-43ffb0a5366c@gmail.com>
Date: Wed, 17 Jun 2026 18:35:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/verisilicon: add DC8000 (DCUltraLite) display
 controller support
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-5-a0987203069@gmail.com>
 <d5df0e9df3a9a68aae982f2fce830a4b10468476.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <d5df0e9df3a9a68aae982f2fce830a4b10468476.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Jun 2026 07:12:07 +0000
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


On 6/15/2026 4:51 PM, Icenowy Zheng wrote:
> 在 2026-06-15一的 14:50 +0800，Joey Lu写道：
>> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite display
>> controller whose register layout differs from the DC8200 in several
>> important ways:
>>
>> 1. No CONFIG_EX commit path: framebuffer updates use the enable (bit
>> 0)
>>     and reset (bit 4) bits in FB_CONFIG instead of the DC8200 staging
>>     registers (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT,
>>     FB_BLEND_CONFIG, PANEL_CONFIG_EX).
>>
>> 2. No PANEL_START register: panel output starts when
>>     PANEL_CONFIG.RUNNING is set; there is no multi-display sync start
>>     register.
>>
>> 3. Different IRQ registers: DCUltraLite uses DISP_IRQ_STA (0x147C) /
>>     DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (0x0010) /
>>     TOP_IRQ_EN (0x0014).
>>
>> 4. Per-frame commit cycle: DCUltraLite requires the VALID bit in
>>     FB_CONFIG to be set at the start of each atomic commit
>> (crtc_begin)
>>     and cleared after (crtc_flush).
>>
>> 5. Simpler clock topology: only 'core' (bus gate) and 'pix0' (pixel
>>     divider) clocks; no axi or ahb clocks required.  Make axi_clk and
>>     ahb_clk optional (devm_clk_get_optional_enabled) so DC8000 nodes
>>     without those clocks are handled gracefully.
>>
>> Add vs_dc8000.c implementing the vs_dc_funcs vtable for the above
>> differences.  The probe now selects vs_dc8000_funcs when the
>> identified
>> generation is VSDC_GEN_DC8000 (DCUltraLite reads model 0x0,
>> revision 0x5560, customer_id 0x305).
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Makefile    |  2 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.c     |  9 ++-
>>   drivers/gpu/drm/verisilicon/vs_dc.h     |  1 +
>>   drivers/gpu/drm/verisilicon/vs_dc8000.c | 78
>> +++++++++++++++++++++++++
>>   4 files changed, 86 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
>>
>> diff --git a/drivers/gpu/drm/verisilicon/Makefile
>> b/drivers/gpu/drm/verisilicon/Makefile
>> index 9d4cd16452fa..d2fd8e4dff24 100644
>> --- a/drivers/gpu/drm/verisilicon/Makefile
>> +++ b/drivers/gpu/drm/verisilicon/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   
>> -verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
>> vs_drm.o vs_hwdb.o \
>> +verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
>> vs_dc8000.o vs_drm.o vs_hwdb.o \
>>   	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
>>   
>>   obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>> index 9729b693d360..9499fffbca58 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
>> @@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   		return PTR_ERR(dc->core_clk);
>>   	}
>>   
>> -	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
>> +	dc->axi_clk = devm_clk_get_optional_enabled(dev, "axi");
>>   	if (IS_ERR(dc->axi_clk)) {
>>   		dev_err(dev, "can't get axi clock\n");
>>   		return PTR_ERR(dc->axi_clk);
>>   	}
>>   
>> -	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
>> +	dc->ahb_clk = devm_clk_get_optional_enabled(dev, "ahb");
> Please make the clock change a separated patch for atomicity.
>
> BTW the MA35D1 manual's clock tree shows that DCUltra appears on AXI2
> ACLK, AHB_HCLK2, behind a mux of SYS-PLL/EPLL-DIV2 (which seems to be
> the core clock), and behind a divider (which seems to be the pixel
> clock).
>
> However it's weird that only one DCUltra Clock Enable Bit exists
> despite both bus clocks have "ICG" (I think it means "Integrated Clock
> Gating"). In addition the linux clk-ma35d1 driver assigns "dcu_gate" as
> a downstream of "dcu_mux", although the Figure 6.5-2 in the TRM shows
> no ICG after the "Display core CLK" mux.
>
> Is the two bus clocks controlled by a single gate bit, and is the bit
> also gating DC core clock?
>
> Thanks,
> Icenowy
I will split the axi/ahb optional-clock change into its own patch in v5 
for atomicity.
Regarding the MA35D1 clock tree: from the TRM, the single "dcu_gate" bit 
gates both bus clocks (AXI ACLK and AHB HCLK) together with the display 
core clock through the same ICG cell. The clk-ma35d1 driver exposes only 
"dcu_gate" (downstream of "dcu_mux") and does not provide separate 
axi/ahb clock entries. Therefore the MA35D1 DT binding will use only two 
clocks ("core" and "pix0"); making axi and ahb optional in the driver is 
the correct approach, and this will be stated clearly in the split-out 
patch.
>>   	if (IS_ERR(dc->ahb_clk)) {
>>   		dev_err(dev, "can't get ahb clock\n");
>>   		return PTR_ERR(dc->ahb_clk);
>> @@ -134,7 +134,10 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
>>> identity.model,
>>   		 dc->identity.revision, dc->identity.customer_id);
>>   
>> -	dc->funcs = &vs_dc8200_funcs;
>> +	if (dc->identity.generation == VSDC_GEN_DC8200)
>> +		dc->funcs = &vs_dc8200_funcs;
>> +	else
>> +		dc->funcs = &vs_dc8000_funcs;
>>   
>>   	if (port_count > dc->identity.display_count) {
>>   		dev_err(dev, "too many downstream ports than HW
>> capability\n");
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h
>> b/drivers/gpu/drm/verisilicon/vs_dc.h
>> index 544e1a37065b..5218e8cf63e2 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
>> @@ -66,5 +66,6 @@ struct vs_dc {
>>   };
>>   
>>   extern const struct vs_dc_funcs vs_dc8200_funcs;
>> +extern const struct vs_dc_funcs vs_dc8000_funcs;
>>   
>>   #endif /* _VS_DC_H_ */
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc8000.c
>> b/drivers/gpu/drm/verisilicon/vs_dc8000.c
>> new file mode 100644
>> index 000000000000..be0c0d7baf52
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
>> @@ -0,0 +1,78 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2026 Joey Lu <yclu4@nuvoton.com>
>> + */
>> +
>> +#include <linux/regmap.h>
>> +
>> +#include "vs_crtc_regs.h"
>> +#include "vs_dc.h"
>> +#include "vs_primary_plane_regs.h"
>> +
>> +static void vs_dc8000_panel_enable_ex(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_RESET);
>> +}
>> +
>> +static void vs_dc8000_panel_disable_ex(struct vs_dc *dc, unsigned
>> int output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			  VSDC_FB_CONFIG_RESET);
>> +}
>> +
>> +static void vs_dc8000_crtc_begin(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_VALID);
>> +}
>> +
>> +static void vs_dc8000_crtc_flush(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			  VSDC_FB_CONFIG_VALID);
>> +}
>> +
>> +static void vs_dc8000_crtc_enable(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_ENABLE);
>> +}
>> +
>> +static void vs_dc8000_crtc_disable(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			  VSDC_FB_CONFIG_ENABLE);
>> +}
>> +
>> +static void vs_dc8000_enable_vblank(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_DISP_IRQ_EN,
>> +			VSDC_DISP_IRQ_VSYNC(output));
>> +}
>> +
>> +static void vs_dc8000_disable_vblank(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_DISP_IRQ_EN,
>> +			  VSDC_DISP_IRQ_VSYNC(output));
>> +}
>> +
>> +static u32 vs_dc8000_irq_ack(struct vs_dc *dc)
>> +{
>> +	u32 irqs;
>> +
>> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
>> +	return irqs;
>> +}
>> +
>> +const struct vs_dc_funcs vs_dc8000_funcs = {
>> +	.panel_enable_ex	= vs_dc8000_panel_enable_ex,
>> +	.panel_disable_ex	= vs_dc8000_panel_disable_ex,
>> +	.crtc_begin		= vs_dc8000_crtc_begin,
>> +	.crtc_flush		= vs_dc8000_crtc_flush,
>> +	.crtc_enable		= vs_dc8000_crtc_enable,
>> +	.crtc_disable		= vs_dc8000_crtc_disable,
>> +	.enable_vblank		= vs_dc8000_enable_vblank,
>> +	.disable_vblank		= vs_dc8000_disable_vblank,
>> +	.irq_ack		= vs_dc8000_irq_ack,
>> +};
