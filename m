Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB46BCD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 07:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E645810F1AE;
	Thu, 18 Jun 2026 07:12:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CMZJlAhr";
	dkim-atps=neutral
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com
 [209.85.214.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D05410EF8C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 10:31:00 +0000 (UTC)
Received: by mail-pl1-f179.google.com with SMTP id
 d9443c01a7336-2bf125989f2so41851265ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 03:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781692260; x=1782297060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=afZH9eP+KoE3Ta3oJntXN/TPimtdYin4QgRicypPySg=;
 b=CMZJlAhrHxtyFGdAJn5JIUG87QHiMA/8crBpK08QLKBxvTmHSR7Glowk+wD+UVBrJE
 P7h4/ATUfjkI4jaGVOs47f+kG4piTXPgWg74/1pUIl9Ct0gC7ymLijFC521hOlDDp6z/
 8iqfz+MmR5CuWZnBCoHpWFrzWUwrgbzC1ysiPbG2+D7uNK1+NeHqVBgTSChsrgwIxGKY
 JwEaLWZAeMQ17UZJV1gi34T386ep6I345g2UtK1Q6xOZH0k7byH66Or6dxg06eL6j21s
 RfNGtGHuFkAFJMcvnmHa7dlBVsIb+6LJnUQ3vnFjk6+0BwYgEG+VoQ9BBrwBNehW5NBW
 fhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781692260; x=1782297060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=afZH9eP+KoE3Ta3oJntXN/TPimtdYin4QgRicypPySg=;
 b=CVd/CUUNR64HfPnDjSVNL/QsDPGQLN7NU6E5QjwDM42JVu0WQcwUErn4r2Hq4h1K8D
 goUA4GV8Bt7Jse9LWEY7RRouZxv+YACq97StOhO7IPqi6HFe+2hYJrCOr+tI5zNuc+It
 qxtqu5xqqPcUI34dlK/IiStO1ujhevd9/c6+u9WCAsrlGL59eO4L6DODG/Khn8OmkkYX
 SxF9VmqDOGq3f/wRmilMO+OX2YbZprwhLeMkenaIs/p/g9E1vlp2pNwTgy2IXjhuIjlB
 zPI7RC18/U42dmdWI1LC5x8o2P9KI8ivuhVXWBkA2dQokxxpbfwHqmuZpCFyKqXgyNgG
 pojw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/7xn0T+cR+NqAs4Yiumb8MaB2XCGPmwQdHmKVQe/FhsGU8x1x1x3P0WvXab16d6WG/KRlHgzO+HJ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwjMS4g5MtQCHpwIcGhX7CiAZm0NEkj2AvvVkFkm6KDIbHVVstJ
 R7cRnbJpac2+MwzzZHnwIdKkGEEI+ot1Q+6iezpEMWl87lD1jzSo9oHl
X-Gm-Gg: AfdE7ckRgNetCVlBgNYyhR7Te2Cx0k87xZFEFbyvA62aXM55JI29sLMgCMCJYH7ydSA
 Y++PY/5e736MDnDenwCjc8HJ+nWUs2syFg9GVTTIGaylbLBUqqU2TQER1xToR7LsFSiBZMbIpss
 envq20eD1gUx7YRmP3Rlz9mV4C1l6Or34D0KNPD8YqGIy5/DsyWB2it+SHjXBP7ljQK1LXvOJQw
 vRp0w02otrUHUUGMsdYyAzjVF7hiK3beykz1XY4iZMcpZ17TkDllFnlXAo1q5zqOUAyTUW+XneL
 Hkiqmnq2pPAEiT+i/fQBtDHlwDEJORPTE8nrQlJPhtpn5N0K/C+5hWA+xhxDvP0IEVKUnWx36K9
 JuZFp1qAmGaGriJEvq8WkN1Y0LFB2LD/s7mHh0wczUeuoP7r5AU/NfYQfSloKwHpcl3ceHUvME7
 xBRvW3yqFjMfk7qNSx8KmpDWjK7yr0bDYlAALB/PWBAeD74cag2jJXftOlpIWca52vyQ==
X-Received: by 2002:a17:902:ce91:b0:2bc:b80f:677e with SMTP id
 d9443c01a7336-2c6bc23de79mr28853095ad.25.1781692259833; 
 Wed, 17 Jun 2026 03:30:59 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c4328a47f8sm150830775ad.47.2026.06.17.03.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 03:30:59 -0700 (PDT)
Message-ID: <4414042f-56e2-495a-81c3-0040c8e1b01f@gmail.com>
Date: Wed, 17 Jun 2026 18:30:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/6] drm/verisilicon: introduce per-variant hardware
 ops table
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260615065003.76661-1-a0987203069@gmail.com>
 <20260615065003.76661-4-a0987203069@gmail.com>
 <38d07e3b3c841d380c987800d8ef85065be94e79.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <38d07e3b3c841d380c987800d8ef85065be94e79.camel@iscas.ac.cn>
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


On 6/15/2026 4:37 PM, Icenowy Zheng wrote:
> 在 2026-06-15一的 14:50 +0800，Joey Lu写道：
>
>> +
>>   	drm_crtc_vblank_on(crtc);
>>   }
>>   
>> @@ -119,7 +148,8 @@ static bool vs_crtc_mode_fixup(struct drm_crtc
>> *crtc,
>>   }
>>   
>>   static const struct drm_crtc_helper_funcs vs_crtc_helper_funcs = {
>> -	.atomic_flush	= drm_crtc_vblank_atomic_flush,
>> +	.atomic_begin	= vs_crtc_atomic_begin,
>> +	.atomic_flush	= vs_crtc_atomic_flush,
>>   	.atomic_enable	= vs_crtc_atomic_enable,
>>   	.atomic_disable	= vs_crtc_atomic_disable,
>>   	.mode_set_nofb	= vs_crtc_mode_set_nofb,
>> @@ -132,7 +162,7 @@ static int vs_crtc_enable_vblank(struct drm_crtc
>> *crtc)
>>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_set_bits(dc->regs, VSDC_TOP_IRQ_EN,
>> VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>> +	dc->funcs->enable_vblank(dc, vcrtc->id);
>>   
>>   	return 0;
>>   }
>> @@ -142,7 +172,7 @@ static void vs_crtc_disable_vblank(struct
>> drm_crtc *crtc)
>>   	struct vs_crtc *vcrtc = drm_crtc_to_vs_crtc(crtc);
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_clear_bits(dc->regs, VSDC_TOP_IRQ_EN,
>> VSDC_TOP_IRQ_VSYNC(vcrtc->id));
>> +	dc->funcs->disable_vblank(dc, vcrtc->id);
>>   }
>>   
>>   static const struct drm_crtc_funcs vs_crtc_funcs = {
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>> index dad9967bc10b..9729b693d360 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.c
>> @@ -8,9 +8,7 @@
>>   #include <linux/of.h>
>>   #include <linux/of_graph.h>
>>   
>> -#include "vs_crtc.h"
>>   #include "vs_dc.h"
>> -#include "vs_dc_top_regs.h"
>>   #include "vs_drm.h"
>>   #include "vs_hwdb.h"
>>   
>> @@ -33,7 +31,7 @@ static irqreturn_t vs_dc_irq_handler(int irq, void
>> *private)
>>   	struct vs_dc *dc = private;
>>   	u32 irqs;
>>   
>> -	regmap_read(dc->regs, VSDC_TOP_IRQ_ACK, &irqs);
>> +	irqs = dc->funcs->irq_ack(dc);
> The definition of bits in 0x0010 seems to be different to ones in
> 0x147C, although the first 2 bits are the same. (e.g. `BIT(2)` is
> "cursor interrupt" in DC8000 0x147C but "secure reset done" in DC8200
> 0x0010).
>
> Should some kind of translation be done in `irq_ack` ? (and add a
> unified interrupt definition that aims to be the translation target).
>
> Thanks,
> Icenowy
I will add a set of unified IRQ bit definitions (e.g. 
`VSDC_IRQ_VSYNC(n)`) in a shared header. Each `irq_ack` implementation 
will translate its hardware-specific register bits into those unified 
bits before returning, so `vs_drm_handle_irq` can use the unified 
definitions without knowing which register layout was used. Currently 
the VSYNC bits (BIT(0)/BIT(1)) coincide between DC8200 0x0010 and DC8000 
0x147C, so the translation is trivial; this change will prevent future 
confusion from diverging bit meanings (such as BIT(2)).
>>   
>>   	vs_drm_handle_irq(dc, irqs);
>>   
>> @@ -136,6 +134,8 @@ static int vs_dc_probe(struct platform_device
>> *pdev)
>>   	dev_info(dev, "Found DC%x rev %x customer %x\n", dc-
>>> identity.model,
>>   		 dc->identity.revision, dc->identity.customer_id);
>>   
>> +	dc->funcs = &vs_dc8200_funcs;
>> +
>>   	if (port_count > dc->identity.display_count) {
>>   		dev_err(dev, "too many downstream ports than HW
>> capability\n");
>>   		ret = -EINVAL;
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h
>> b/drivers/gpu/drm/verisilicon/vs_dc.h
>> index ed1016f18758..544e1a37065b 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_dc.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_dc.h
>> @@ -14,6 +14,7 @@
>>   #include <linux/reset.h>
>>   
>>   #include <drm/drm_device.h>
>> +#include <drm/drm_plane.h>
>>   
>>   #include "vs_hwdb.h"
>>   
>> @@ -22,6 +23,34 @@
>>   
>>   struct vs_drm_dev;
>>   struct vs_crtc;
>> +struct vs_dc;
>> +
>> +struct vs_dc_funcs {
>> +	/* Bridge: atomic_enable, atomic_disable */
>> +	void (*panel_enable_ex)(struct vs_dc *dc, unsigned int
>> output);
>> +	void (*panel_disable_ex)(struct vs_dc *dc, unsigned int
>> output);
>> +
>> +	/* CRTC: atomic_begin, atomic_flush */
>> +	void (*crtc_begin)(struct vs_dc *dc, unsigned int output);
>> +	void (*crtc_flush)(struct vs_dc *dc, unsigned int output);
>> +
>> +	/* CRTC: atomic_enable, atomic_disable */
>> +	void (*crtc_enable)(struct vs_dc *dc, unsigned int output);
>> +	void (*crtc_disable)(struct vs_dc *dc, unsigned int output);
>> +
>> +	/* CRTC: enable_vblank, disable_vblank */
>> +	void (*enable_vblank)(struct vs_dc *dc, unsigned int
>> output);
>> +	void (*disable_vblank)(struct vs_dc *dc, unsigned int
>> output);
>> +
>> +	/* Primary plane: atomic_enable, atomic_disable,
>> atomic_update */
>> +	void (*primary_plane_enable_ex)(struct vs_dc *dc, unsigned
>> int output);
>> +	void (*primary_plane_disable_ex)(struct vs_dc *dc, unsigned
>> int output);
>> +	void (*primary_plane_update_ex)(struct vs_dc *dc, unsigned
>> int output,
>> +					struct drm_plane_state
>> *state);
>> +
>> +	/* IRQ acknowledge */
>> +	u32 (*irq_ack)(struct vs_dc *dc);
>> +};
>>   
>>   struct vs_dc {
>>   	struct regmap *regs;
>> @@ -33,6 +62,9 @@ struct vs_dc {
>>   
>>   	struct vs_drm_dev *drm_dev;
>>   	struct vs_chip_identity identity;
>> +	const struct vs_dc_funcs *funcs;
>>   };
>>   
>> +extern const struct vs_dc_funcs vs_dc8200_funcs;
>> +
>>   #endif /* _VS_DC_H_ */
>>
>>
