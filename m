Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5518DC43602
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:08:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E65710E709;
	Mon, 29 Jun 2026 07:08:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cHSU6kZk";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFF910E002
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 03:54:08 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2c9ed0c7fc7so3432855ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 20:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782705248; x=1783310048; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LFFcFveTYAjTv+ZdiJ5NifJ7wIuGpllPfX6b0xg96Fk=;
 b=cHSU6kZktQ1lGVRUQuPiFT/HotyfpcJdCQ+37so1OLw0oa2tUqF+E6mol/BIw5f/o4
 UvUC/g0grSrhS+K/gdnErljBtb5rOrRmK6uQy+KuexFLrtBWaQ6NDjDRvQ4IpIP5In0O
 MdMwi6i0Jor+xlB2eOFBBrq1nfVYQYumJd04zQGln6YnqRJ1dL2Rb7vN1M2Zhj7nLniP
 H9ULRudUBBnZtKg5Z1CjkFndYCbbRTJ4/HKX0WNM+VYOxtbHOCi1uDxtBzEWPtErzo/g
 lLYBBAqO66fLbaKysDnClk4WDeZuKkcrUR63Z72JKJZTnBInckMTmWHuDlMT0SFl1SF3
 jNhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782705248; x=1783310048;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFFcFveTYAjTv+ZdiJ5NifJ7wIuGpllPfX6b0xg96Fk=;
 b=ngpuQvkFfI3QVud/B6EEaDLkbLVWd3WUW6UjBKTHc3u8dRoe45zHcA8Ljj7Xp9MMUn
 hZckUBImN1oJFv1HVMPgdYsr7rKy0YRwZtcusRK+0LanVxg+QJAEF+mpWy5Ij6ZCgymk
 uJXHekN9f5O5HdK6uDgNOt5eP+QLSUULKwrKoBTi07StnxuqVJMVIzAMJ15zvTAk3xww
 k8t1DmWmmQo66iSzt25QNKYYtGJ5zCj/qqPQdcA9Hkq1QzbQUoHPb6fzkIxEVLUNRRPJ
 7DJV8alQqhQL3UYa4az86NPH2G+dxU/rdRpN/HZyTZMtebePgKUaM8XLj9f7VoriNW3H
 JpyQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpiG7+E7lLTBLD8i4mVAkY5jOYglqg0yCnSetwgk4v4lj9tJrJw/BslvCAzitz1sHiMVmxCebXiOns=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw8RnMkv0qn0kX3cQGjVC3cqHNcCByVwzQs0jjPMSwFnJyvKzNH
 RpHHCA2HwTm4INLwPXoR2GK9mhmlk8aLMmx7hoaMYP0qjmyiVjKSvo2f
X-Gm-Gg: AfdE7cnCgQdOcytEHUFz3/f+UGxifrFEKwOUGvP+V2sozE6pX4Ea8Y0K18/Gp9J6RVB
 /j1jBVTsYsWNE8cSEiDONyr8bKLwimpN1lBIhXNvqvFOKIOJVKSqE0ryPZ1w6oGm+dYXAcOYvIz
 OwMF+xZ8QfJJJyRH0nd9OfF8FWG4tsawjWRYJVe46iABVOzArW1dVAYGGK7hOgKSFmYB3QRE++3
 XHeGJW+2wMvWzByGYryZRZqLcIsCBhuvm/JGP3cka0KOdOmyjm7yMDK6G8UbNBO5F4b5iCT432U
 mKTa6zKznXd1CnIOt2kYDc2POjDLeBuPJUCd0tfRUEglUjRBR0YiKEGzq4Mplkaeii/ffkkVmRB
 pHoWaxT9+86i0RJ4tKR+3V6fv3HBbRrA4o3eWJyo7jtAwjmpeohQ46eaSvh4KtMdD/LyeBqb8A/
 6RmMYRMCWcs6pLMFRj60Tuj8MDBhf7i3ap4cHsZTMKMMC9ggUIWCPiXuuPoUV3kFk/l9Byi7CWD
 4kK
X-Received: by 2002:a17:903:244f:b0:2ca:b8d:e65f with SMTP id
 d9443c01a7336-2ca0b8de994mr9096045ad.1.1782705248120; 
 Sun, 28 Jun 2026 20:54:08 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c9b1b02f8esm36341435ad.71.2026.06.28.20.54.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Jun 2026 20:54:07 -0700 (PDT)
Message-ID: <abe52380-dbb9-49e1-b93b-ab4aca9105b6@gmail.com>
Date: Mon, 29 Jun 2026 11:54:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/verisilicon: add DC8000 (DCUltraLite) display
 controller support
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260625094449.708386-1-a0987203069@gmail.com>
 <20260625094449.708386-6-a0987203069@gmail.com>
 <39e7d0426d1690ccfc8dbcfc77e7440bc5c9a725.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <39e7d0426d1690ccfc8dbcfc77e7440bc5c9a725.camel@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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


On 6/26/2026 4:03 PM, Icenowy Zheng wrote:
> 在 2026-06-25四的 17:44 +0800，Joey Lu写道：
>> The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite display
>> controller (DC8000 generation) whose register layout differs from
>> the DC8200 in several important ways:
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
>> 4. Simpler clock topology: only 'core' (bus gate) and 'pix0' (pixel
>>     divider) clocks; no axi or ahb clocks required.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Makefile    |  2 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.c     |  5 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.h     |  1 +
>>   drivers/gpu/drm/verisilicon/vs_dc8000.c | 86
>> +++++++++++++++++++++++++
>>   4 files changed, 92 insertions(+), 2 deletions(-)
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
>> index fd1f5fe67a68..9499fffbca58 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
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
>> index 825f5dd6bf17..ac96ad701199 100644
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
>> index 000000000000..fbe0fa516cac
>> --- /dev/null
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
>> @@ -0,0 +1,86 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +/*
>> + * Copyright (C) 2026 Joey Lu <yclu4@nuvoton.com>
>> + */
>> +
>> +#include <linux/regmap.h>
>> +
>> +#include "vs_crtc_regs.h"
>> +#include "vs_dc.h"
>> +#include "vs_drm.h"
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
>> +static void vs_dc8000_crtc_enable_ex(struct vs_dc *dc, unsigned int
>> output)
>> +{
>> +	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
>> +			VSDC_FB_CONFIG_ENABLE);
>> +}
>> +
>> +static void vs_dc8000_crtc_disable_ex(struct vs_dc *dc, unsigned int
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
>> +	u32 hw_irqs, unified = 0;
>> +	unsigned int i;
>> +
>> +	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &hw_irqs);
>> +
>> +	for (i = 0; i < VSDC_MAX_OUTPUTS; i++) {
>> +		if (hw_irqs & VSDC_DISP_IRQ_VSYNC(i))
>> +			unified |= VSDC_IRQ_VSYNC(i);
>> +	}
> Maybe a warning for unknown IRQ bits should be added here.
>
> Thanks,
> Icenowy
I will add the same `drm_WARN_ONCE` pattern in `vs_dc8000_irq_ack` for
unknown `VSDC_DISP_IRQ_STA` bits.
>> +
>> +	return unified;
>> +}
>> +
>> +const struct vs_dc_funcs vs_dc8000_funcs = {
>> +	.panel_enable_ex	= vs_dc8000_panel_enable_ex,
>> +	.panel_disable_ex	= vs_dc8000_panel_disable_ex,
>> +	.crtc_begin		= vs_dc8000_crtc_begin,
>> +	.crtc_flush		= vs_dc8000_crtc_flush,
>> +	.crtc_enable_ex		= vs_dc8000_crtc_enable_ex,
>> +	.crtc_disable_ex	= vs_dc8000_crtc_disable_ex,
>> +	.enable_vblank		= vs_dc8000_enable_vblank,
>> +	.disable_vblank		= vs_dc8000_disable_vblank,
>> +	.irq_ack		= vs_dc8000_irq_ack,
>> +};
