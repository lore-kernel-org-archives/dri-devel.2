Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94DD0CD8CAA
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2049110F5DE;
	Mon,  8 Jun 2026 15:27:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BnJCL8yr";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AD1B10E0C8
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 09:45:49 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84234c83142so1599782b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 08 Jun 2026 02:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780911949; x=1781516749; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YdQztf5+BODzQ2BKQCG0woCEoi72g1h/Yx/ZUsCJKos=;
 b=BnJCL8yr+dsogUZ3ibNlhTvU5iGaYc1ZtXDd8+Oa+oBEZyi1k2pPbFA80Yz0WS6D0G
 4t//vOXJcRyQI+2Pr+Bczs0xOVYkUoevho4XTitQiXoWQJ4bzmWjjb5/FQ7f4WYi0+GQ
 7NjwAeNWqDAr/su1ZYrdRa8tPH+MdFCnJd0TN+Wvu+6Z4qBb7B/ql2LUkq5ZAdnXNGpO
 2uMmFMPDtRq2x4Re0m3K1EKDscY1LW2RvEqzRQmAn9vksh9Vp1Y6W9IOoufgfSDod59e
 LZvr2Wvm+yfk3XtK0t3mrCvMf22Iw7QRd7mmpEhyykmVfa5uaxDb+0zikNSxyTyqeB3V
 YyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780911949; x=1781516749;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YdQztf5+BODzQ2BKQCG0woCEoi72g1h/Yx/ZUsCJKos=;
 b=E/RHyvjZBFBkknr131oCLhSz6+U1le2P7gMQw/MqRT3eS033zKlwgJOI7YvTWF8UaH
 88zWx/BmbSURHAR6Wji9c200lngEdf53ggbXC7c45+o15xXAMvh+NQTuuM56jT9xZ4G+
 /YRV9lN5LJ37x9Njyvm7yYh3PW/LmGq9XzDpk7KwFEzoyhsIqxUBg0TB/InH4IfvVIZ7
 AsbhkJYdq7XeY3dHghIlemFCIV7Y0f4dGzXxW4s27NXVh8MLZFLete1DK/9LgcLhxrVv
 MMvuomHUYLYsoRTBROSoIGkop5bZDeuSByTUg7haVSbOgOHhLkGMy/yh5TFXdf3nBuAG
 ZOPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+BV8i8ulSwsZee+amTtpruol38Qhs+t4Pqqu6ErrP1VZg8F6c7J4DcLz98Ys0LFPF68+kiMoiJQQ0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylJ5yTiJRAdWjD4n/w5Fu9LWkq489HobA+BiS2W97ifMgjfM9s
 Kl+8o9z/0U5BvW6CK15cBKnNYGwOYv4jWntnofGfZd+Ff3RnGLY7Z4Ud
X-Gm-Gg: Acq92OH9pOMj9eGvNk6UsGsqSiJfSrI/Md9jtjVhFB9FNfhArk5dcrvybsQ46dY339J
 iY805Z6Srv/tMmdw/kik1OtaWhCRScMeMCBtXalZxB+/LdfWHt3BRvEh2ekylhnni0Lexzuy9xZ
 t/8kEumGPEvgoEMQuZIHlCVIjmrmna0fB46SuX6gjI4wkrrU6baidtfkFXgAMnIKN+E3hsoQtBy
 9I0Mn0x61V4a8MRImoqg8X/daLxVxnEWEZPPs8/VSw5pTY+qyFs6zQrJKcA3J80uBSqbXwu0ry6
 3sJ2F/u6XBGAk/j6eaTB2DW73FaALp2VE2gyHjTxv/aZnyJR0Pe/ZZ5bD84DpEKn/iPFTbRs4b3
 EoHBEykjgEQBLVK6nMW0KSv2M+GmCnhGqThUBKTqKdzU0M1oP15vWrzi6OAXGTzb7FxVODb8o4L
 ++ZCsAWrPTKrC2zPc6DQ808K/1f6lcgkYxL5+BydK0d46+v+TLMHqFppCMEFnjppKsEddj3wcF4
 P7jRWYUeUICGzM=
X-Received: by 2002:a05:6a00:bc81:b0:842:2ae0:968d with SMTP id
 d2e1a72fcca58-842b0f6f508mr14352160b3a.32.1780911948844; 
 Mon, 08 Jun 2026 02:45:48 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8428235006dsm18133897b3a.13.2026.06.08.02.45.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jun 2026 02:45:48 -0700 (PDT)
Message-ID: <98eb7772-257f-4fa7-8e9b-51a635cb12dd@gmail.com>
Date: Mon, 8 Jun 2026 17:45:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] drm/verisilicon: introduce per-variant hardware
 ops table
To: Icenowy Zheng <zhengxingda@iscas.ac.cn>,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260608023237.305036-1-a0987203069@gmail.com>
 <20260608023237.305036-4-a0987203069@gmail.com>
 <399cd127b56b4a2fb3161865a681606e04e6b2c6.camel@iscas.ac.cn>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <399cd127b56b4a2fb3161865a681606e04e6b2c6.camel@iscas.ac.cn>
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


On 6/8/2026 2:24 PM, Icenowy Zheng wrote:
> 在 2026-06-08一的 10:32 +0800，Joey Lu写道：
>> The DC8200 and DCUltraLite share a broadly similar register layout
>> but
>> differ in how the bridge, CRTC, primary plane and IRQ paths are
>> driven.
>> Introduce a vs_dc_funcs vtable so each variant can supply its own
>> implementation without scattering conditionals across multiple files.
>>
>> Add enum vs_dc_generation (VSDC_GEN_DC8000 / VSDC_GEN_DC8200) to
>> vs_hwdb.h and a generation field to struct vs_chip_identity.
>> Annotate
>> all four existing DC8200 HWDB entries with VSDC_GEN_DC8200.
>>
>> Extract the DC8200-specific hardware ops into a new vs_dc8200.c:
>>    bridge_enable / bridge_disable - PANEL_CONFIG/START + CONFIG_EX
>> commit
>>    enable_vblank / disable_vblank - TOP_IRQ_EN VSYNC bit
>>    plane_enable_ex / disable_ex / update_ex - FB_CONFIG_EX path
>>    irq_handler - reads TOP_IRQ_ACK
>>
>> Update vs_bridge.c, vs_crtc.c, vs_primary_plane.c and vs_dc.c to
>> dispatch through dc->funcs instead of directly touching registers.
>> vs_crtc.c gains atomic_begin and atomic_flush hooks to allow variants
>> to gate per-frame commit cycles.
>>
>> No behaviour change for existing DC8200 platforms.
>>
>> Signed-off-by: Joey Lu <a0987203069@gmail.com>
>> ---
>>   drivers/gpu/drm/verisilicon/Makefile          |   2 +-
>>   drivers/gpu/drm/verisilicon/vs_bridge.c       |  20 +---
>>   drivers/gpu/drm/verisilicon/vs_crtc.c         |  38 ++++++-
>>   drivers/gpu/drm/verisilicon/vs_dc.c           |   6 +-
>>   drivers/gpu/drm/verisilicon/vs_dc.h           |  33 ++++++
>>   drivers/gpu/drm/verisilicon/vs_dc8200.c       | 107
>> ++++++++++++++++++
>>   drivers/gpu/drm/verisilicon/vs_hwdb.c         |   4 +
>>   drivers/gpu/drm/verisilicon/vs_hwdb.h         |   6 +
>>   .../gpu/drm/verisilicon/vs_primary_plane.c    |  32 +-----
>>   9 files changed, 197 insertions(+), 51 deletions(-)
>>   create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c
> ============ 8< ==================
>> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c
>> b/drivers/gpu/drm/verisilicon/vs_bridge.c
>> index 7a93049368db..6a9af10c64e6 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
>> @@ -162,15 +162,8 @@ static void vs_bridge_enable_common(struct
>> vs_crtc *crtc,
>>   			VSDC_DISP_PANEL_CONFIG_DE_EN |
>>   			VSDC_DISP_PANEL_CONFIG_DAT_EN |
>>   			VSDC_DISP_PANEL_CONFIG_CLK_EN);
>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG(output),
>> -			VSDC_DISP_PANEL_CONFIG_RUNNING);
>> -	regmap_clear_bits(dc->regs, VSDC_DISP_PANEL_START,
>> -			  VSDC_DISP_PANEL_START_MULTI_DISP_SYNC);
>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_START,
>> -			VSDC_DISP_PANEL_START_RUNNING(output));
>> -
>> -	regmap_set_bits(dc->regs, VSDC_DISP_PANEL_CONFIG_EX(crtc-
>>> id),
>> -			VSDC_DISP_PANEL_CONFIG_EX_COMMIT);
>> +
>> +	dc->funcs->bridge_enable(dc, output);
> The code here being called "bridge" is only internal to kernel. Naming
> it in such a way is okay, but maybe naming it "panel" is better
> (because they're configuring PANEL-named registers).
>
> And, as the common code setting common fields of DcregPanelConfig0 is
> still here, maybe the helper name should be named "panel_enable_ex" (or
> "bridge_enable_ex") ?
Understood. I will rename `bridge_enable`/`bridge_disable` to 
`panel_enable_ex`/`panel_disable_ex` throughout: in `vs_dc_funcs`, 
`vs_dc8200.c`, `vs_dc8000.c`, and the call sites in `vs_bridge.c`.
>>   }
>>   
>>   static const struct drm_bridge_funcs vs_dpi_bridge_funcs = {
> ====== 8< ==============
>> diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c
>> b/drivers/gpu/drm/verisilicon/vs_dc.c
>> index dad9967bc10b..c94957024189 100644
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
>> +	irqs = dc->funcs->irq_handler(dc);
> The IRQ isn't handled in this helper.
>
> So maybe call it "irq_ack"?
Understood. I will rename `irq_handler` to `irq_ack` in `vs_dc_funcs`, 
`vs_dc8200.c`, `vs_dc8000.c`, and the call site in `vs_dc.c`.
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
>> index ed1016f18758..d77d4a1babdf 100644
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
>> +	void (*bridge_enable)(struct vs_dc *dc, unsigned int
>> output);
>> +	void (*bridge_disable)(struct vs_dc *dc, unsigned int
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
>> +	void (*plane_enable_ex)(struct vs_dc *dc, unsigned int
>> output);
>> +	void (*plane_disable_ex)(struct vs_dc *dc, unsigned int
>> output);
>> +	void (*plane_update_ex)(struct vs_dc *dc, unsigned int
>> output,
>> +				struct drm_plane_state *state);
>> +
>> +	/* IRQ handler */
>> +	u32 (*irq_handler)(struct vs_dc *dc);
> See my comments elsewhere for the helper naming.
Understood. I will rename all vtable members per the comments above: 
`panel_enable_ex`, `panel_disable_ex`, `primary_plane_enable`, 
`primary_plane_disable`, `primary_plane_update`, `irq_ack`.
>> +};
>>   
>>   struct vs_dc {
>>   	struct regmap *regs;
> ============= 8< =================
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> index 2a0f7c59afa3..91524d16f778 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.c
>> @@ -94,6 +94,7 @@ static struct vs_chip_identity vs_chip_identities[]
>> = {
>>   		.revision = 0x5720,
>>   		.customer_id = ~0U,
>>   
>> +		.generation = VSDC_GEN_DC8200,
>>   		.display_count = 2,
>>   		.max_cursor_size = 64,
>>   		.formats = &vs_formats_no_yuv444,
>> @@ -103,6 +104,7 @@ static struct vs_chip_identity
>> vs_chip_identities[] = {
>>   		.revision = 0x5721,
>>   		.customer_id = 0x30B,
>>   
>> +		.generation = VSDC_GEN_DC8200,
>>   		.display_count = 2,
>>   		.max_cursor_size = 64,
>>   		.formats = &vs_formats_no_yuv444,
>> @@ -112,6 +114,7 @@ static struct vs_chip_identity
>> vs_chip_identities[] = {
>>   		.revision = 0x5720,
>>   		.customer_id = 0x310,
>>   
>> +		.generation = VSDC_GEN_DC8200,
>>   		.display_count = 2,
>>   		.max_cursor_size = 64,
>>   		.formats = &vs_formats_with_yuv444,
>> @@ -121,6 +124,7 @@ static struct vs_chip_identity
>> vs_chip_identities[] = {
>>   		.revision = 0x5720,
>>   		.customer_id = 0x311,
>>   
>> +		.generation = VSDC_GEN_DC8200,
>>   		.display_count = 2,
>>   		.max_cursor_size = 64,
>>   		.formats = &vs_formats_no_yuv444,
>> diff --git a/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> b/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> index 2065ecb73043..a15c8b565604 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> +++ b/drivers/gpu/drm/verisilicon/vs_hwdb.h
>> @@ -9,6 +9,11 @@
>>   #include <linux/regmap.h>
>>   #include <linux/types.h>
>>   
>> +enum vs_dc_generation {
>> +	VSDC_GEN_DC8000,
>> +	VSDC_GEN_DC8200,
>> +};
>> +
>>   struct vs_formats {
>>   	const u32 *array;
>>   	unsigned int num;
>> @@ -19,6 +24,7 @@ struct vs_chip_identity {
>>   	u32 revision;
>>   	u32 customer_id;
>>   
>> +	enum vs_dc_generation generation;
>>   	u32 display_count;
>>   	/*
>>   	 * The hardware only supports square cursor planes, so this
>> field
>> diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> index 1f2be41ae496..75bc36a078f7 100644
>> --- a/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> +++ b/drivers/gpu/drm/verisilicon/vs_primary_plane.c
>> @@ -53,12 +53,6 @@ static int vs_primary_plane_atomic_check(struct
>> drm_plane *plane,
>>   	return 0;
>>   }
>>   
>> -static void vs_primary_plane_commit(struct vs_dc *dc, unsigned int
>> output)
>> -{
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_COMMIT);
>> -}
>> -
>>   static void vs_primary_plane_atomic_enable(struct drm_plane *plane,
>>   					   struct drm_atomic_commit
>> *atomic_state)
>>   {
>> @@ -69,13 +63,8 @@ static void vs_primary_plane_atomic_enable(struct
>> drm_plane *plane,
>>   	unsigned int output = vcrtc->id;
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_FB_EN);
>> -	regmap_update_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID_MASK,
>> -			   VSDC_FB_CONFIG_EX_DISPLAY_ID(output));
>> -
>> -	vs_primary_plane_commit(dc, output);
>> +	if (dc->funcs->plane_enable_ex)
>> +		dc->funcs->plane_enable_ex(dc, output);
> Please note that all theae codes are for primary planes, maybe the
> helper should be named mentioning primary. Overlay planes will need a
> different codepath because they change different registers.
>
> Thanks,
> Icenowy
Understood. To avoid confusion, I will rename `plane_enable_ex`, 
`plane_disable_ex`, and `plane_update_ex` to `primary_plane_enable`, 
`primary_plane_disable`, and `primary_plane_update` in `vs_dc_funcs`, 
`vs_dc8200.c`, and `vs_primary_plane.c`.
>>   }
>>   
>>   static void vs_primary_plane_atomic_disable(struct drm_plane *plane,
>> @@ -88,10 +77,8 @@ static void vs_primary_plane_atomic_disable(struct
>> drm_plane *plane,
>>   	unsigned int output = vcrtc->id;
>>   	struct vs_dc *dc = vcrtc->dc;
>>   
>> -	regmap_set_bits(dc->regs, VSDC_FB_CONFIG_EX(output),
>> -			VSDC_FB_CONFIG_EX_FB_EN);
>> -
>> -	vs_primary_plane_commit(dc, output);
>> +	if (dc->funcs->plane_disable_ex)
>> +		dc->funcs->plane_disable_ex(dc, output);
>>   }
>>   
>>   static void vs_primary_plane_atomic_update(struct drm_plane *plane,
>> @@ -133,18 +120,11 @@ static void
>> vs_primary_plane_atomic_update(struct drm_plane *plane,
>>   	regmap_write(dc->regs, VSDC_FB_STRIDE(output),
>>   		     fb->pitches[0]);
>>   
>> -	regmap_write(dc->regs, VSDC_FB_TOP_LEFT(output),
>> -		     VSDC_MAKE_PLANE_POS(state->crtc_x, state-
>>> crtc_y));
>> -	regmap_write(dc->regs, VSDC_FB_BOTTOM_RIGHT(output),
>> -		     VSDC_MAKE_PLANE_POS(state->crtc_x + state-
>>> crtc_w,
>> -					 state->crtc_y + state-
>>> crtc_h));
>>   	regmap_write(dc->regs, VSDC_FB_SIZE(output),
>>   		     VSDC_MAKE_PLANE_SIZE(state->crtc_w, state-
>>> crtc_h));
>>   
>> -	regmap_write(dc->regs, VSDC_FB_BLEND_CONFIG(output),
>> -		     VSDC_FB_BLEND_CONFIG_BLEND_DISABLE);
>> -
>> -	vs_primary_plane_commit(dc, output);
>> +	if (dc->funcs->plane_update_ex)
>> +		dc->funcs->plane_update_ex(dc, output, state);
>>   }
>>   
>>   static const struct drm_plane_helper_funcs
>> vs_primary_plane_helper_funcs = {
