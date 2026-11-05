Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B99606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 08:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=D8hkm7cL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4814010E90B;
	Thu,  5 Nov 2026 08:59:27 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96FA010E92A
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 08:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793869160;
 bh=ZKaZFFHipOBBEL4aN3JZCurDbr471IQ5mAHx+yt6YDI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=D8hkm7cLJ7S+YmF4PZLUoJwECskt1Lx2wBGPwMxKGB7U+y+B1ib+bRRjrhTYsxFfw
 uIHzv5kGUcdqzY7GQvciwIRUnjE6E1bjhIAm02/rvqjKZ4cMuSbwVViK78+8ioi4mp
 eds24T+OXz4w10VRzgrjCm/MNXaYzxHaTm/CjNuYotXypSNeel73uJThZZWhRkrGHb
 zYQghiYqQPaW8FT/Oc+6gAA7+/0J7UQTy9aPUips21sAW2f9qfwXovX73eEfDlXyK2
 qEJkPV5RCAnKVk4ouAglPbYCYECNTQKSLvYyyHXgWUEYrEZ4891C0BvrPwQ6SfXsc0
 LF7orzWiVgBsQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 50DF617E05D6;
 Thu, 05 Nov 2026 09:59:19 +0100 (CET)
Message-ID: <bff71c8f-9ea0-45a9-96ed-e66fc0896f3f@collabora.com>
Date: Thu, 5 Nov 2026 09:59:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/13] drm/mediatek: Implement Display Stream
 Compression support
To: Roman Vivchar <rva333@protonmail.com>, chunkuang.hu@kernel.org
Cc: p.zabel@pengutronix.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, jitao.shi@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com
References: <8fcdd2fa-7c9c-4af5-a7b4-45fb881d88a8@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <8fcdd2fa-7c9c-4af5-a7b4-45fb881d88a8@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/4/26 19:51, Roman Vivchar wrote:
> Hi Angelo,
> 
> I have tested this series with my out-of-tree mt6595 (command mode
> panel) and mt6768 (video mode) DRM. There's no regressions, but I
> spotted an issue with kconfig.
> 
> On 9/16/26 14:08, AngeloGioacchino Del Regno wrote:
>> Add a real driver for the Display Stream Compression (DSC) Display
>> Controller IP, implementing support for DSC v1.1 to v1.2.
>>
>> In order to do this, it was necessary to remove the basic DSC IP
>> bypass setup from mtk_ddp_comp: this functionality is retained in
>> the new mtk_disp_dsc driver, which checks if DSC was actually
>> requested by other components (with the only one that currently
>> supports this being DSI) and, if not, it will set BYPASS mode in
>> the DSC IP.
>>
>> Like before, the BYPASS mode is set before starting the DSC IP,
>> but unlike before, this is being done in the component start
>> callback instead of the config one.
>> Notably, the config callback is called by mtk_crtc always
>> immediately before the calling start callback, so the order of
>> register writes is retained.
>> The only real difference is that now this is being done through
>> CPU writes instead of CMDQ, but since that's called only once
>> and since it's just three registers, the performance impact will
>> not be minimal and not even measurable.
>>
>> As anticipated, DSC handling was also introduced in the mtk_dsi
>> driver: when performing dsi_host_attach, the driver now checks
>> if the DSI panel adds the DSC configuration structure to the
>> mipi_dsi_device structure and, if it does, it will store a
>> pointer in the driver-local mtk_dsi structure's `dsc` member.
>>
>> The DSI driver will then check whether the DSC configuration
>> that comes from the panel is valid (in regard to MediaTek DSI)
>> and will call the DRM API's DSC helpers to calculate and set
>> all of the const and RC parameters for the actual DSC setup.
>>
>> For the time being, even though the latest MediaTek SoCs do
>> support DSC v1.2, only DSC v1.1 pre-scr support is implemented
>> as an initial contribution (which is rather big, and 1.2 would
>> make it even bigger - but that can anyway be implemented later).
>>
>> As a last step for validation of DSC parameters in DSI, a check
>> for the hdisplay against DSC slice sidth and one for vdisplay
>> against DSC slice height was added to the mode_valid callback,
>> making sure that H/V are, as expected, multiples of slice W/H.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> ...
> 
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -18,6 +18,8 @@
>>    #include <video/mipi_display.h>
>>    #include <video/videomode.h>
>>    
>> +#include <drm/display/drm_dsc.h>
>> +#include <drm/display/drm_dsc_helper.h>
> 
> ...
> 
>>    static void mtk_dsi_config_vdo_timing_per_frame_lp(struct mtk_dsi *dsi)
>> @@ -565,26 +610,68 @@ static void mtk_dsi_config_vdo_timing_per_line_lp(struct mtk_dsi *dsi)
>>    	writel(horizontal_frontporch_byte, dsi->regs + DSI_HFP_WC);
>>    }
>>    
>> -static void mtk_dsi_config_vdo_timing(struct mtk_dsi *dsi)
>> +static int mtk_dsi_set_dsc_params(struct mtk_dsi *dsi)
>> +{
>> +	struct drm_dsc_config *dsc = dsi->dsc;
>> +	struct device *dev = dsi->host.dev;
>> +	int ret;
>> +
>> +	if (dsc->bits_per_pixel & GENMASK(3, 0)) {
>> +		dev_err(dev, "Fractional bits_per_pixel not supported\n");
>> +		return -EINVAL;
>> +	}
>> +
>> +	if (dsc->bits_per_component != 8) {
>> +		dev_err(dev, "%u bits per component is not supported\n",
>> +			dsc->bits_per_component);
>> +		return -EINVAL;
>> +	}
>> +
>> +	dsc->simple_422 = false;
>> +	dsc->convert_rgb = true;
>> +	dsc->vbr_enable = false;
>> +
>> +	drm_dsc_set_const_params(dsc);
>> +	drm_dsc_set_rc_buf_thresh(dsc);
>> +
>> +	ret = drm_dsc_setup_rc_params(dsc, DRM_DSC_1_2_444);
> 
> If config doesn't have DRM_DISPLAY_DSC_HELPER (selected by few panels),
> linking will fail with "error: undefined symbol: drm_dsc_set_const_params".
> Should MediaTek DRM select it?
> 

Yes it should. I already spotted this a bit of time ago and fixed it locally, but
hey, thanks a lot for that.

Cheers,
Angelo
