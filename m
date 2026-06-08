Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B6CCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0F9910F5CE;
	Mon,  8 Jun 2026 15:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HOqBOP0h";
	dkim-atps=neutral
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com
 [209.85.216.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA4710F081
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:46:51 +0000 (UTC)
Received: by mail-pj1-f51.google.com with SMTP id
 98e67ed59e1d1-37474afe908so19763a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780912010; x=1781516810; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yRDBSHYpzFBzXnPKcrs7qf2EMqGEh7EqJYnV9Ezibaw=;
 b=HOqBOP0h/bhfERrx9R7RIwNL/EcXCJcjqyZiEPVsn6MWtj5GYr/oRxrvvV9bTfAkkD
 74MD5RtJ8R0CuiYD28WssPZ0ti3qz8uX3IrRm005e7fk0PK9t/lmf8Ju2nSeVfJdAAhk
 eotdix4V5u3ubYCqe6/puPLeza7ZY4a2hZRXr9Xg9yBdMAMrXMmASop3PD4itFqm3WEb
 jjSSBPIa3K5JIEgFAXHkkRzhfLY+TRZYA5b1VGeOa4tQF01rgaixYSc7bZEBC0D9fmql
 urlKbjhf5/zuca3HOzpqjCQy7QdMUkAx1+M86jA/LY9C1RPsEkHT5N+tsHYeFp6Dpgyb
 cwTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780912010; x=1781516810;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yRDBSHYpzFBzXnPKcrs7qf2EMqGEh7EqJYnV9Ezibaw=;
 b=pTEAzlcRPPcgd6Fq6JdU6gh8AN4ZKP+OdOlPSiMU+6CYAmJ7cGt7f3DsVtmcqhYge7
 0pUGhAE/fJj/iMkfoLttlzNO230C5AAdL4GaysURz8nWgCyyvzJyfXBYfZi4DVAKGV2/
 f/T2tHincArumPQdRwV6/YUbpLZSRNcYN66iVqVcsLXkudYuWC4IGfjy1LW+NE6Ao1UW
 rAhiyzBMYkbPoVA0OnCm3ld6ZSwjQuvkzGznBIaa64rFd4REseAjaIlv8Uj9k3HmE5Jo
 gDbhQbmX9kXtkLUMqq3xpCIlGCryhMhrmPrSzzNLs33fU+nuXq/K9cU7HY+2R2pMv28P
 3RIA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9mNFwI0Lx9a0HTnLs7jBLy8g2pvQdlEqY8zMG3IddKM5rPVMMb73VnL5sppwI2Une0q5Fc7G3SbZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy8Oel9ZwfjNjfoBJy0NMrkJQRqbC+RvtnMqVtDH+1X3a4CIYmR
 O+AQeoNjnmNwlx5eYHT3vCWDD91Ec7r3T5CdWncFASee2+GKf8a5JS9p
X-Gm-Gg: Acq92OHC4S0qrdWxqHbtkdfCPxOHxMtzTIQjL50dkWqy2Yfv38RA1OFHMrtGKUax/rb
 54lf8Sv0n7IXEKkdNir10GH+2Ux2VIdK49whMC4qGQPveWZQyWJXSl/QH+79X1hYqPghg0Lu9Oe
 CkZ060/A9CjeCQH/PRCT0+lSariYFmiUVdy6vbewyve1YwiCngmWkMTiedFkcQf2vYym8XFI31Z
 YJ0+tNCvR4J6TNOVHxYFX+mtvJ4KYdTN/L7HJ346vJCRJS1kjPdYbAXpFfJDxcmn7/72vQ+r1Ec
 57yqwfAcOzt8XSnWKx99WOCb0vfVOffvIv+oMOVhUjyplkRSQG6x2gOY6mrrTW9VFPqYHxgSxW/
 CNo9gct7KuGg0qT2qUjdwLRPPRCfUxBacdfnlOkYikLf3c0Pql/0VbtxyWEiOKDID+77LNp1vkq
 pJ6OXhRq3cr4Zd+stAzgpJaGB1wNJzV3kCGr/m/LTGw/9OR5iowSCEjvgAUwjJgj7CY8cEZFk8c
 jhg+8+4ShykGgY=
X-Received: by 2002:a17:90b:5787:b0:36b:e8b9:46a4 with SMTP id
 98e67ed59e1d1-370f0284a87mr15256643a91.14.1780912010481; 
 Mon, 08 Jun 2026 02:46:50 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84282221086sm17761731b3a.10.2026.06.08.02.46.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:46:50 -0700 (PDT)
Message-ID: <178c4511-a290-4526-9e80-2fe8291f6ed3@gmail.com>
Date: Mon, 8 Jun 2026 17:46:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/5] drm/verisilicon: add Nuvoton MA35D1 DCU Lite
 display controller support
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-5-a0987203069@gmail.com>
 <335c237d2636764948e629dbab0b5b747ac48fa5.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <335c237d2636764948e629dbab0b5b747ac48fa5.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 15:27:17 +0000
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


On 6/8/2026 2:26 PM, Icenowy Zheng wrote:
> 在 2026-06-08一的 10:32 +0800，Joey Lu写道：
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
>>     ahb_clk optional (devm_clk_get_optional_enabled) so DCUltraLite
>>     nodes without those clocks are handled gracefully.
>>
>> Add vs_dcu_lite.c implementing the vs_dc_funcs vtable for the above
> Nitpick: could you use vs_dc8000 to make things more aligned? (Although
> I must admit that DCUltraLite is the first revision to be supported in
> this codepath).
Understood. I will rename `vs_dcu_lite.c` to `vs_dc8000.c`, all internal 
functions from `vs_dcu_lite_*` to `vs_dc8000_*`, the exported symbol 
from `vs_dcu_lite_funcs` to `vs_dc8000_funcs`, and update the Makefile 
accordingly.
>> differences.  The probe now selects vs_dcu_lite_funcs when the
>> identified generation is VSDC_GEN_DC8000 (DCUltraLite reads model
>> 0x0,
>> revision 0x5560, customer_id 0x305).
>>
>> Extend Kconfig to allow building on ARCH_MA35 platforms.
> Maybe the Kconfig change could be in the last commit or a dedicated
> commit before current ones? Because it's only meaningful after the HWDB
> item is added.
>
> Thanks,
> Icenowy
Understood. The Kconfig change adding `ARCH_MA35` will be moved to a 
separate commit placed after the HWDB entry is added, or as the final 
commit in the series.
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Kconfig       |  2 +-
>>   drivers/gpu/drm/verisilicon/Makefile      |  2 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.c       |  9 ++-
>>   drivers/gpu/drm/verisilicon/vs_dcu_lite.c | 78
>> +++++++++++++++++++++++
>>   4 files changed, 86 insertions(+), 5 deletions(-)
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dcu_lite.c
>>
>> diff --git a/drivers/gpu/drm/verisilicon/Kconfig
>> b/drivers/gpu/drm/verisilicon/Kconfig
>> index 7cce86ec8603..295d246eb4b4 100644
>> --- a/drivers/gpu/drm/verisilicon/Kconfig
>> +++ b/drivers/gpu/drm/verisilicon/Kconfig
>> @@ -2,7 +2,7 @@
>>   config DRM_VERISILICON_DC
>>   	tristate "DRM Support for Verisilicon DC-series display
>> controllers"
>>   	depends on DRM && COMMON_CLK
>> -	depends on RISCV || COMPILE_TEST
>> +	depends on RISCV || ARCH_MA35 || COMPILE_TEST
>>   	select DRM_BRIDGE_CONNECTOR
>>   	select DRM_CLIENT_SELECTION
>>   	select DRM_DISPLAY_HELPER
>> diff --git a/drivers/gpu/drm/verisilicon/Makefile
>> b/drivers/gpu/drm/verisilicon/Makefile
>> index 9d4cd16452fa..960af0861dfa 100644
>> --- a/drivers/gpu/drm/verisilicon/Makefile
>> +++ b/drivers/gpu/drm/verisilicon/Makefile
>> @@ -1,6 +1,6 @@
>>   # SPDX-License-Identifier: GPL-2.0-only
>>   
>> -verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
>> vs_drm.o vs_hwdb.o \
>> +verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o
>> vs_dcu_lite.o vs_drm.o vs_hwdb.o \
>>   	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
>>   
>>   obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>> index c94957024189..81a8d9bf85bd 100644
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
>> +		dc->funcs = &vs_dcu_lite_funcs;
>>   
>>   	if (port_count > dc->identity.display_count) {
>>   		dev_err(dev, "too many downstream ports than HW
>> capability\n");
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
>> b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
>> new file mode 100644
>> index 000000000000..11ef57d5ebaa
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
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
>> +static void vs_dcu_lite_bridge_enable(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_RESET);
>> +}
>> +
>> +static void vs_dcu_lite_bridge_disable(struct vs_dc *dc, unsigned
>> int output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			  VSDC_FB_CONFIG_RESET);
>> +}
>> +
>> +static void vs_dcu_lite_crtc_begin(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_VALID);
>> +}
>> +
>> +static void vs_dcu_lite_crtc_flush(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			  VSDC_FB_CONFIG_VALID);
>> +}
>> +
>> +static void vs_dcu_lite_crtc_enable(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_ENABLE);
>> +}
>> +
>> +static void vs_dcu_lite_crtc_disable(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			  VSDC_FB_CONFIG_ENABLE);
>> +}
>> +
>> +static void vs_dcu_lite_enable_vblank(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_DISP_IRQ_EN,
>> +			VSDC_DISP_IRQ_VSYNC(output));
>> +}
>> +
>> +static void vs_dcu_lite_disable_vblank(struct vs_dc *dc, unsigned
>> int output)
>> +{
>> +	regmap_clear_bits(dc->regs, VSDC_DISP_IRQ_EN,
>> +			  VSDC_DISP_IRQ_VSYNC(output));
>> +}
>> +
>> +static u32 vs_dcu_lite_irq_handler(struct vs_dc *dc)
>> +{
>> +	u32 irqs;
>> +
>> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
>> +	return irqs;
>> +}
>> +
>> +const struct vs_dc_funcs vs_dcu_lite_funcs = {
>> +	.bridge_enable		= vs_dcu_lite_bridge_enable,
>> +	.bridge_disable		=
>> vs_dcu_lite_bridge_disable,
>> +	.crtc_begin		= vs_dcu_lite_crtc_begin,
>> +	.crtc_flush		= vs_dcu_lite_crtc_flush,
>> +	.crtc_enable		= vs_dcu_lite_crtc_enable,
>> +	.crtc_disable		= vs_dcu_lite_crtc_disable,
>> +	.enable_vblank		= vs_dcu_lite_enable_vblank,
>> +	.disable_vblank		=
>> vs_dcu_lite_disable_vblank,
>> +	.irq_handler		= vs_dcu_lite_irq_handler,
>> +};
