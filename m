Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4D2AC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 17CDC10E806;
	Mon,  7 Sep 2026 13:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="k04dqhL4";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60B4C10E806
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 13:15:35 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 69DBE8FD;
 Mon,  7 Sep 2026 15:13:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788786839;
 bh=OEiccPmhUiPrwYCNpjGZUMA+7y1ZYynDuwh/jUysPXI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=k04dqhL4Bb+NAqJTuhffb4nfK89EFdjckkZ3+CRadtReB8sbKJ2/r96S9MBD62sE6
 fVAOm0nL6+hemUwA8WsOwHy9MDFDAtHoIbwn7yfokLDBOd4ZRWL8YSn1b3Ero/VjE7
 cVdKWoS3RJJo5Ike1x5XsmaYUT+cPzcjrWYOBijA=
Message-ID: <dc4f1e73-caff-4371-9463-9d4d4c4af442@ideasonboard.com>
Date: Mon, 7 Sep 2026 16:15:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/tidss: Fix synclost issue while disabling layer
 due to erratum i2097
To: Yashas D <y-d@ti.com>, u-kumar1@ti.com, devarsht@ti.com, s-jain1@ti.com,
 d-mittal@ti.com, b-padhi@ti.com, jyri.sarha@iki.fi
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260701063337.2165966-1-y-d@ti.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260701063337.2165966-1-y-d@ti.com>
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

Hi,

On 01/07/2026 09:33, Yashas D wrote:
> A gap beyond a frame duration for disabling the layer in overlay manager

I don't think that's right. The key is that the layer is disabled on 
frame N, and the GO bit is set on frame N+1. So the duration can be less 
than a frame, if the frame boundary is between disable and GO.

> and go bit setting on the corresponding video port may lead to SYNC_LOST.

I think it's quite guaranteed, not "may" =).

> Fix by moving the layer to the non-visible area and deferring the ENABLE=0
> write, immediately before the GO bit, guaranteeing both occur within the
> same frame window.

Maybe: "Fix by moving the layer outside the visible area, and deferring 
the ENABLE=0 write to happen just before the GO bit write, ..."

> Link: https://www.ti.com/lit/pdf/sprz530 # i2097
> 
> Signed-off-by: Yashas D <y-d@ti.com>
> ---
> 
> changelog v1->v2:
> - Flushed the pending layers in dispc_vp_disable to prevent hanging layers in hardware
>    when dispc_vp_go is not called in CRTC teardown and modeset paths.
> - Removed the AM62L switch case as its the same as the default case.
> 
> Link to v1: https://lore.kernel.org/all/20260630103802.1853564-1-y-d@ti.com/
> 
>   drivers/gpu/drm/tidss/tidss_dispc.c | 118 +++++++++++++++++++++++++++-
>   drivers/gpu/drm/tidss/tidss_dispc.h |   1 +
>   2 files changed, 118 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
> index 58d5eb033bdb..02a3cf50e0ce 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.c
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.c
> @@ -38,6 +38,8 @@
>   #include "tidss_dispc_regs.h"
>   #include "tidss_scale_coefs.h"
>   
> +#define OVR_LAYER_MAX_POS(mask)		FIELD_MAX(mask)

Maybe just use FIELD_MAX() in the code below.

> +
>   static const u16 tidss_k2g_common_regs[DISPC_COMMON_REG_TABLE_LEN] = {
>   	[DSS_REVISION_OFF] =                    0x00,
>   	[DSS_SYSCONFIG_OFF] =                   0x04,
> @@ -467,6 +469,8 @@ struct dispc_device {
>   
>   	struct clk *fclk;
>   
> +	unsigned long fclk_rate;
> +
>   	bool is_enabled;
>   
>   	struct dss_vp_data vp_data[TIDSS_MAX_PORTS];
> @@ -477,6 +481,9 @@ struct dispc_device {
>   	u32 memory_bandwidth_limit;
>   
>   	struct dispc_errata errata;
> +
> +	/* WA for erratum i2097: OVR Layer Disable May Cause Sync Lost. */
> +	u32 pending_disable_layers[TIDSS_MAX_PORTS];
>   };
>   
>   static void dispc_write(struct dispc_device *dispc, u16 reg, u32 val)
> @@ -1134,6 +1141,12 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
>   	bool align, onoff, rf, ieo, ipc, ihs, ivs;
>   	u32 hsw, hfp, hbp, vsw, vfp, vbp;
>   
> +	/*
> +	 * WA for erratum i2097: clear any stale layer disable tracking
> +	 * state left over from the previous VP enable/disable cycle.
> +	 */
> +	dispc->pending_disable_layers[hw_videoport] = 0;

When is such stale state left over?

> +
>   	fmt = dispc_vp_find_bus_fmt(dispc, hw_videoport, tstate->bus_format,
>   				    tstate->bus_flags);
>   
> @@ -1210,6 +1223,23 @@ void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
>   
>   void dispc_vp_disable(struct dispc_device *dispc, u32 hw_videoport)
>   {
> +	u32 layer;
> +
> +	/*
> +	 * WA for erratum i2097: flush any pending layer disables directly.
> +	 * dispc_vp_go() is not called in the CRTC teardown and modeset paths

I think "teardown" is what happens when e.g. one unloads the module. I 
assume you mean crtc disable here? Or what's "crtc teardown" and 
"modeset", exactly?

> +	 * so pending_disable_layers would otherwise never be consumed, leaving
> +	 * layers enabled in hardware. Sync lost does not matter here since the

What do you mean does not matter? If it causes sync lost error prints, 
it matters.

> +	 * VP is being disabled.
> +	 */
> +	for (layer = 0; layer < dispc->feat->num_vids; layer++) {
> +		if (dispc->pending_disable_layers[hw_videoport] & BIT(layer))
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					0, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
> +	}
> +	dispc->pending_disable_layers[hw_videoport] = 0;
> +
>   	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 0,
>   		       DISPC_VP_CONTROL_ENABLE_MASK);
>   }
> @@ -1233,6 +1263,38 @@ void dispc_vp_go(struct dispc_device *dispc, u32 hw_videoport)
>   {
>   	WARN_ON(VP_REG_GET(dispc, hw_videoport, DISPC_VP_CONTROL,
>   			   DISPC_VP_CONTROL_GOBIT_MASK));
> +
> +	if (dispc->errata.i2097 &&
> +	    dispc->pending_disable_layers[hw_videoport]) {
> +		u32 layer;
> +		u32 delay_ns;
> +
> +		/* WA for erratum i2097: set GO bit #1 to latch position

Start a comment block with "/*" line.

What do you mean with "set GO bit #1"? Do you just mean writing 1 to GO 
bit? If so, just "set GO bit to latch..." is enough.


> +		 * changes into the DSS pipeline, wait 10 DSS functional clock
> +		 * cycles, then write ENABLE=0.
> +		 */
> +		VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
> +			       DISPC_VP_CONTROL_GOBIT_MASK);
> +
> +		if (dispc->fclk_rate)
> +			delay_ns = DIV_ROUND_UP_ULL((u64)10 * NSEC_PER_SEC,
> +						    dispc->fclk_rate);
> +		else
> +			delay_ns = 500;

When do we not have fclk_rate? Shouldn't we always have it?

> +
> +		ndelay(delay_ns);
> +
> +		for (layer = 0; layer < dispc->feat->num_vids; layer++) {
> +			if (dispc->pending_disable_layers[hw_videoport] &
> +			    BIT(layer))
> +				OVR_REG_FLD_MOD(dispc, hw_videoport,
> +						DISPC_OVR_ATTRIBUTES(layer),
> +						0,
> +						DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
> +		}
> +		dispc->pending_disable_layers[hw_videoport] = 0;

My first thought was if this causes problems if vsync happens somewhere 
in the middle here, and tidss_crtc does pageflip handling. But I think 
that can't happen, as this is only called from tidss_crtc, inside a spin 
lock. If that's the case, I think a comment here somewhere would still 
be a good thing.

> +	}
> +
>   	VP_REG_FLD_MOD(dispc, hw_videoport, DISPC_VP_CONTROL, 1,
>   		       DISPC_VP_CONTROL_GOBIT_MASK);
>   }
> @@ -1503,6 +1565,53 @@ void dispc_ovr_enable_layer(struct dispc_device *dispc,
>   	if (dispc->feat->subrev == DISPC_K2G)
>   		return;
>   
> +	if (dispc->errata.i2097 && !enable) {
> +		/*
> +		 * WA for erratum i2097:
> +		 *
> +		 * Do not write ENABLE=0 directly. Instead move the layer to
> +		 * the non-visible area so it contributes no pixels.
> +		 *
> +		 * Position register layout differs per SoC:
> +		 *   J721E : DISPC_OVR_ATTRIBUTES2, X[13:0],  Y[29:16] (14-bit)
> +		 *   Others: DISPC_OVR_ATTRIBUTES,  X[17:6],  Y[30:19] (12-bit)
> +		 */
> +		switch (dispc->feat->subrev) {
> +		case DISPC_J721E:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES2(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES2_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES2_POSY_MASK);
> +			break;
> +		default:
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSX_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSX_MASK);
> +			OVR_REG_FLD_MOD(dispc, hw_videoport,
> +					DISPC_OVR_ATTRIBUTES(layer),
> +					OVR_LAYER_MAX_POS(DISPC_OVR_ATTRIBUTES_POSY_MASK),
> +					DISPC_OVR_ATTRIBUTES_POSY_MASK);
> +			break;
> +		}

You could probably use dispc_ovr_set_plane() here. It writes one extra 
register, but I don't see much harm in that, and gets rid of this 
duplication.

> +
> +		dispc->pending_disable_layers[hw_videoport] |= BIT(layer);
> +		return;
> +	}
> +
> +	if (dispc->errata.i2097 && enable) {
> +		/*
> +		 * Layer being re-enabled: cancel any pending disable so
> +		 * dispc_vp_go() does not write ENABLE=0 after we have
> +		 * just written ENABLE=1 here.
> +		 */
> +		dispc->pending_disable_layers[hw_videoport] &= ~BIT(layer);
> +	}
> +
>   	OVR_REG_FLD_MOD(dispc, hw_videoport, DISPC_OVR_ATTRIBUTES(layer),
>   			!!enable, DISPC_OVR_ATTRIBUTES_ENABLE_MASK);
>   }
> @@ -2871,6 +2980,12 @@ static void dispc_init_errata(struct dispc_device *dispc)
>   		dispc->errata.i2000 = true;
>   		dev_info(dispc->dev, "WA for erratum i2000: YUV formats disabled\n");
>   	}
> +
> +	if (dispc->feat->subrev != DISPC_K2G) {
> +		dispc->errata.i2097 = true;
> +		dev_info(dispc->dev,
> +			 "WA for erratum i2097: OVR layer disable uses non-visible area\n");

I don't think an dev_info print is required. The other WA info print is 
there as it's a rather big one, disabling YUV formats.

> +	}
>   }
>   
>   /*
> @@ -3059,7 +3174,8 @@ int dispc_init(struct tidss_device *tidss)
>   			__func__, PTR_ERR(dispc->fclk));
>   		return PTR_ERR(dispc->fclk);
>   	}
> -	dev_dbg(dev, "DSS fclk %lu Hz\n", clk_get_rate(dispc->fclk));
> +	dispc->fclk_rate = clk_get_rate(dispc->fclk);
> +	dev_dbg(dev, "DSS fclk %lu Hz\n", dispc->fclk_rate);
>   
>   	of_property_read_u32(dispc->dev->of_node, "max-memory-bandwidth",
>   			     &dispc->memory_bandwidth_limit);
> diff --git a/drivers/gpu/drm/tidss/tidss_dispc.h b/drivers/gpu/drm/tidss/tidss_dispc.h
> index 739d211d0018..e2ce9fdf1279 100644
> --- a/drivers/gpu/drm/tidss/tidss_dispc.h
> +++ b/drivers/gpu/drm/tidss/tidss_dispc.h
> @@ -57,6 +57,7 @@ struct dispc_vid_info {
>   
>   struct dispc_errata {
>   	bool i2000; /* DSS Does Not Support YUV Pixel Data Formats */
> +	bool i2097; /* OVR Layer Disable May Cause Sync Lost */
>   };
>   
>   enum dispc_vp_bus_type {

