Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E13C43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 11:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52C3B10E6AB;
	Thu,  9 Jul 2026 11:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="d9s/5a7C";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 807CC10F4F3
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 11:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783595458;
 bh=ApBrtV4Zk1vMOIRF4PFrz5yF0iT0J5bqhkZRZmYO4To=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=d9s/5a7CzcXq78v/5VAqzjyVuLk3p9/cbXnMrh6GmsrfJhjTx7UGjiyd6QhazjVZa
 pp8AfMES9pZcjdtg+nzihx9FiBQiCkCB/zLumVzI6bzrbPPfINilcTDl/yPw0H2znn
 oFzAZGTz54XIJuxzJitevUnGzuj25mDuiyXiZklc4hTGilmnd00KECd/9WJCRFe3Rj
 Uj3kS7at8sHfPM3fKeyW9byUukBqfsrIrvv2/z7nA6BXDSAZYfJ2p56BkvCqViypxC
 +avucc3E5pH+BMLxm58aBvMD7yPyc83dbjmrZFMeJhRRYtnNwp2OEVHs7e2l0deYAl
 pcGIfIdNvoLxQ==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id B093417E0886;
 Thu, 09 Jul 2026 13:10:57 +0200 (CEST)
Message-ID: <d745a43c-cc24-454b-91f0-79c72862656d@collabora.com>
Date: Thu, 9 Jul 2026 13:10:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and phy
 driver unregistration
To: sashiko-reviews@lists.linux.dev
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
References: <20260709103431.46616-1-angelogioacchino.delregno@collabora.com>
 <20260709103431.46616-4-angelogioacchino.delregno@collabora.com>
 <20260709104650.BFBE51F000E9@smtp.kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260709104650.BFBE51F000E9@smtp.kernel.org>
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

On 7/9/26 12:46, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Double free / use-after-free of mtk_dp->phy_dev on devm_phy_get error path.
> 
> Pre-existing issues:
> - [High] Asynchronous pm_runtime_put() used immediately before pm_runtime_disable() leaves hardware in incorrect power state.
> --
> 
> --- Patch [3]: [PATCH v3 03/11] drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration ---
> commit ee2a644d342bfbaa916286b22d4e54ddc62e5878
> Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> drm/mediatek: mtk_dp: Fix hdmi codec and phy driver unregistration
> 
> This commit adds devm actions to unregister the HDMI Codec and DisplayPort
> PHY platform devices during probe. This prevents multiple instances of these
> devices from being registered if the driver probe is deferred.
> 
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dp.c b/drivers/gpu/drm/mediatek/mtk_dp.c
>> index eefbc7e0f9c8d..fefd1fae44c90 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dp.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dp.c
> [ ... ]
>> @@ -2701,6 +2718,11 @@ static int mtk_dp_register_phy(struct mtk_dp *mtk_dp)
>>   		return dev_err_probe(dev, PTR_ERR(mtk_dp->phy_dev),
>>   				     "Failed to create device mediatek-dp-phy\n");
>>   
>> +	ret = devm_add_action_or_reset(dev, mtk_dp_unregister_pdevs, mtk_dp->phy_dev);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret,
>> +				     "Failed to add phy unregister devm action");
>> +
>>   	mtk_dp_get_calibration_data(mtk_dp);
>>   
>>   	mtk_dp->phy = devm_phy_get(&mtk_dp->phy_dev->dev, "dp");
>>   	if (IS_ERR(mtk_dp->phy)) {
>>   		platform_device_unregister(mtk_dp->phy_dev);

It's really too hot in July in Italy. Uff. :-)

> 
> [Severity: Critical]
> Does this create a double-free on the error path?
> 
> Looking at mtk_dp_register_phy() in drivers/gpu/drm/mediatek/mtk_dp.c, if
> devm_phy_get() fails (returning e.g. -EPROBE_DEFER), we manually call
> platform_device_unregister() here.
> 
> However, since we successfully added the devm action earlier in the function,
> returning the error from probe will cause the devres unwind mechanism to
> execute mtk_dp_unregister_pdevs().
> 
> Won't that call platform_device_unregister() a second time on the already-freed
> mtk_dp->phy_dev pointer, resulting in memory corruption?
> 
> [ ... ]
>> @@ -2870,9 +2892,6 @@ static void mtk_dp_remove(struct platform_device *pdev)
>>   	struct mtk_dp *mtk_dp = platform_get_drvdata(pdev);
>>   
>>   	pm_runtime_put(&pdev->dev);
>>   	pm_runtime_disable(&pdev->dev);
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but is it safe to call
> pm_runtime_put() immediately before pm_runtime_disable() here in
> mtk_dp_remove()?
> 
> Since pm_runtime_put() queues an asynchronous suspend, calling
> pm_runtime_disable() right after it cancels the pending suspend work.
> 
> Doesn't this leave the hardware in an active power state after the driver is
> removed? Should this be changed to pm_runtime_put_sync() to ensure the suspend
> completes before module unload?
> 

Nice. Yes.

>>   	if (mtk_dp->data->bridge_type != DRM_MODE_CONNECTOR_eDP)
>>   		timer_delete_sync(&mtk_dp->debounce_timer);
>> -	platform_device_unregister(mtk_dp->phy_dev);
>> -	if (mtk_dp->audio_pdev)
>> -		platform_device_unregister(mtk_dp->audio_pdev);
>>   }
> 

