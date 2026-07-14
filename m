Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BB7FC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB35510EC61;
	Tue, 14 Jul 2026 08:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="iMb1PBMM";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 724F710EC61
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784016816;
 bh=j0SI4YRtONPH0K9xM6ukMCwDrLUf3U7zNF0KhtJk7As=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iMb1PBMMF837bfEMQna4u7Y6ASqMFr/SL7NFmouS/Ju4iC4Nx6Tn2F//n26abYXzr
 ja6EJ+WBTCZ4WYQ/GBv1aVDTkWcHTXnc3/h/PNqIJ03DJ62y5AAB1ldRnX4aqX/wkB
 IHhWhaCnt1qW8Z3uI1nkQ9+pNTJDVRc1Q/7zjPvK/wp5hk5eszaElhPzROuxFJqNBE
 WYoaMV5dxI4MW0x559Fs55UxDpHlsO8zAjJTCTW87ao+wWlb451YdV2fFUuBI3qV+G
 8njOz4LJsil2xmzXip/pHie2UYb+FEKZXE6RNFmDIMJxX0HBo9JGrW1V9oFYoLPduj
 zF3+yyiWfHbPA==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DE50B17E0851;
 Tue, 14 Jul 2026 10:13:35 +0200 (CEST)
Message-ID: <d6f220e2-2416-405c-b866-77179fcd0ad4@collabora.com>
Date: Tue, 14 Jul 2026 10:13:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/10] drm/mediatek: mtk_dsi: Enable PM Runtime on probe
To: sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-9-angelogioacchino.delregno@collabora.com>
 <20260713144303.D147C1F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260713144303.D147C1F000E9@smtp.kernel.org>
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

On 7/13/26 16:43, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] Enabling PM runtime leaves the DSI hardware permanently suspended, resulting in system crashes during unpowered MMIO register accesses.
> - [High] The IRQ handler accesses hardware registers without verifying the device's PM runtime state.
> --
> 
> --- Patch [8]: [PATCH v4 08/10] drm/mediatek: mtk_dsi: Enable PM Runtime on probe ---
> commit 7ce79b5636ac6fccf8b21d5b0f6a67f31c6b10eb
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> drm/mediatek: mtk_dsi: Enable PM Runtime on probe
> 
> This commit enables PM runtime at the end of mtk_dsi_probe() to allow the
> power domains for the DSI IP to be turned on and off when necessary. The
> commit message assumes mtk_ddp_comp_power_on() will resume the device.
> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 93bc507d77e20..1726f5a2683cf 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -1731,6 +1731,10 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
>>   
>> +	ret = devm_pm_runtime_enable(dev);
>> +	if (ret)
>> +		return ret;
>> +
> 
> [Severity: High]
> The commit message states that mtk_ddp_comp_power_on() will resume the
> device. Is this assumption correct?
> 
> Looking at mtk_crtc_atomic_enable() in drivers/gpu/drm/mediatek/mtk_crtc.c,
> mtk_ddp_comp_power_on() is only called for the first component in the display
> pipeline (comp[0]), bypassing the DSI component entirely.
> 
> Furthermore, even if mtk_ddp_comp_power_on() iterated over all components, it
> executes after mtk_dsi_bridge_atomic_pre_enable(). The pre-enable hook calls
> mtk_dsi_poweron(), which directly accesses hardware registers:
> 
> drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_poweron() {
> 	...
> 	mtk_dsi_enable(dsi);
> 
> 	/* Bypass shadow and force commit only if the register is present */
> 	if (data->reg_adv[DSI_SHADOW_DEBUG])
> 		writel(FORCE_COMMIT | BYPASS_SHADOW,
> 		       dsi->regs + data->reg_adv[DSI_SHADOW_DEBUG]);
> 	...
> }
> 
> Since the PM domain is still powered off at this point, will these direct
> MMIO accesses cause a bus hang or system crash?
> 

Before the mediatek-drm restructuring, the power domains and clocks will be always
on because the poweron op will be called at startup time.

After the restructuring, power is OFF when DSI unused, and ON when DSI used.

The power domains will therefore be ON when needed in both cases.

> [Severity: High]
> Now that the device supports PM runtime, can the IRQ handler run while the
> device is in the RPM_SUSPENDED state?
> 
> The interrupt is unconditionally enabled in mtk_dsi_bind() and remains
> enabled at the IRQ controller level even when the device is suspended. If a
> spurious or delayed interrupt fires, mtk_dsi_irq() directly reads the
> hardware register:
> 
> drivers/gpu/drm/mediatek/mtk_dsi.c:mtk_dsi_irq() {
> 	...
> 	status = readl(dsi->regs + dsi->driver_data->reg_main[DSI_INTSTA]) & flag;
> 	...
> }
> 
> Should the IRQ handler use pm_runtime_get_if_active() before accessing
> hardware registers to avoid touching unpowered hardware?
> 

It's guaranteed to be powered. Anyway, even if it is, that will read zero and
will not crash.

>>   	ret = mipi_dsi_host_register(&dsi->host);
>>   	if (ret < 0)
>>   		return dev_err_probe(dev, ret, "Failed to register DSI host\n");
> 

