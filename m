Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DD0DC43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 08:17:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A14C010EC64;
	Tue, 14 Jul 2026 08:17:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VfJe61hn";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9673210EC64
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 08:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1784017070;
 bh=lmLRA1j6bU4TZIADuvEfELdVnzXyMHW+4VvSLzBy1ag=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VfJe61hn68YfPm/X1p7KJ/Zi8jTfMN+t01Jd0U/6ibLN1YAJNARz232fpKx6HHdPw
 6IKRlmv4xqg0EyynMbUoFGm6XN01PiW4Gp/eT77LMiejeOCkXgMDw5tENPQxn23cUv
 EYb+/i2NvC0bQeAzCu6rQJ8nTY0SgvWmko+An7B7Vna6ll9LdxFyfh7hzPJU4Y8/lZ
 SGmARv/n51CFJLhodu6RfmPYS+w44dUC2lqbMvT6WJdzj9q0bew0F1HonK5WOLN6pr
 6VUNL6cCTpWmRllYuDhm13QZJ+5on02doB5RWg1Go5g09KToesJT7xogsWY6UZC+ag
 Jo2HIamzBEffg==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id DDDB417E01AC;
 Tue, 14 Jul 2026 10:17:49 +0200 (CEST)
Message-ID: <64f479f6-af9c-4bda-8a6c-ddbabc839f10@collabora.com>
Date: Tue, 14 Jul 2026 10:17:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/10] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
References: <20260713142746.40259-1-angelogioacchino.delregno@collabora.com>
 <20260713142746.40259-5-angelogioacchino.delregno@collabora.com>
 <20260713144340.736B11F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260713144340.736B11F000E9@smtp.kernel.org>
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
> 
> Pre-existing issues:
> - [High] Missing cleanup of DRM encoder when device_reset_optional() fails in mtk_dsi_bind().
> - [High] Read-modify-write data race on `dsi->irq_data` between process context and hardirq context.
> --
> 
> --- Patch [4]: [PATCH v4 04/10] drm/mediatek: mtk_dsi: Enable interrupt at component bind time ---
> commit 0607d3868a389c4103df3225d2bc7a47d44df3b0
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> drm/mediatek: mtk_dsi: Enable interrupt at component bind time
> 
> This patch requests the DSI interrupt with IRQF_NO_AUTOEN and enables it only
> when binding the DSI to its display controller component master. This prevents
> interrupt storms and delays caused by timeouts during probe.
> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 8ab5c3431dbbc..e24e7b91a3618 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> [ ... ]
>> @@ -1090,7 +1091,13 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>>   	if (ret)
>>   		return ret;
>>   
>> -	return device_reset_optional(dev);
>> +	ret = device_reset_optional(dev);
>> +	if (ret)
>> +		return ret;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but does this error path leak
> the DRM encoder?
> 

That's right. I will send a patch to fix this outside of this series.

This series shall not be blocked by issues that were already present before.

> If device_reset_optional(dev) fails, it returns without calling
> drm_encoder_cleanup(&dsi->encoder). Because the component bind operation
> fails, the component framework will not invoke mtk_dsi_unbind(), meaning
> the encoder is never cleaned up.
> 
> If the DSI driver is subsequently unbound or removed, its locally managed
> memory is freed while the encoder is still linked in the DRM core's list,
> which could lead to a use-after-free or kernel panic when the list is
> traversed.
> 
>> +
>> +	enable_irq(dsi->irq);
>> +
>> +	return 0;
>>   }
> [ ... ]
>> @@ -1375,17 +1383,15 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>   
>>   	platform_set_drvdata(pdev, dsi);
>>   
>> +	ret = devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
>> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);
> 
> [Severity: High]
> This is a pre-existing issue, but is there a read-modify-write data race on
> dsi->irq_data between process context and hardirq context?
> 
> mtk_dsi_irq_data_clear() modifies dsi->irq_data using &= in process context
> (from mtk_dsi_host_transfer()) without disabling interrupts or using atomic
> bitwise operations. Concurrently, the hardirq handler mtk_dsi_irq() modifies
> the same variable using |=.
> 
> If a DSI interrupt fires during the process-context read-modify-write
> sequence, won't the flag set by the interrupt handler be silently
> overwritten and lost when the process context stores its computed value?
> 
> This could lead to hardware interrupt events being lost, causing timeouts
> in mtk_dsi_wait_for_irq_done() and potentially breaking display
> initialization or frame updates.
> 

That doesn't really happen for now, but it's a fair point. Will send a patch
to fix outside of this series.

This was not introduced by this series and shall not block it.

>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
>> +
> 

