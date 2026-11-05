Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 982D2606A31B
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 09:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=EHEVG93S
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D80EA112260;
	Thu,  5 Nov 2026 09:00:37 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6506112260
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 09:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793869229;
 bh=xUW3p4976DC2PBpXz3aw+f2y1/CP/AUXZ42/p8PrJHQ=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=EHEVG93SvO2MRQ9DqlNGT69xnJHgOChAl4GvABrnxnu6DRTM20aBAKXu0iZVBoxNv
 KgRR9dSB3fYPc+YlhHcfxLX53M6BHsy/9oQDScMSfFjYaYHhL2nSglo49d9x5GErIe
 bQPFlOCxfeacr6lrbh0FDCh/6J0IY9bN95uq0FkOij2bqZgIRQcnEDeERmlMx4Yf7p
 wloqNvk9ClFSjuJgZ0+3R8wa2SXSqfgUdwfST9EG9SNAQBV5kEmWnnQeutK/smBy07
 Q8MYyN30HYpN1yHXJh2+b01UP275QGYgKs441XpqVuQTXTXbqW1wgvWODZ8itTSBls
 Ti1iVBcoKMi1Q==
Received: from [100.64.1.21] (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange x25519) (No client certificate requested)
 (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id C676117E05D6;
 Thu, 05 Nov 2026 10:00:28 +0100 (CET)
Message-ID: <1c0e5b1a-b1a8-42a3-8dd1-75fceee078a2@collabora.com>
Date: Thu, 5 Nov 2026 10:00:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 05/13] drm/mediatek: mtk_dsi: Enable interrupt at
 component bind time
To: Roman Vivchar <rva333@protonmail.com>
Cc: chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, matthias.bgg@gmail.com, jitao.shi@mediatek.com,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 justin.yeh@mediatek.com, jason-jh.lin@mediatek.com,
 CK Hu <ck.hu@mediatek.com>
References: <20260916110825.102631-1-angelogioacchino.delregno@collabora.com>
 <20260916110825.102631-6-angelogioacchino.delregno@collabora.com>
 <hXDHNenOxP_1Fjv3k-eSNDIFG2yGsdvlxFOCpn0SMdRImzGWQfDVFE-0px1K0-Z472dL3IuLWE5BWIQeOo_U12SjzZOeJ3FNLIxus-KoGNE=@protonmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <hXDHNenOxP_1Fjv3k-eSNDIFG2yGsdvlxFOCpn0SMdRImzGWQfDVFE-0px1K0-Z472dL3IuLWE5BWIQeOo_U12SjzZOeJ3FNLIxus-KoGNE=@protonmail.com>
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

On 11/4/26 19:56, Roman Vivchar wrote:
> On Wednesday, September 16th, 2026 at 2:08 PM, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> wrote:
> 
>> Having the DSI interrupt enabled before actually binding the DSI
>> component to the display controller driver is both useless and
>> dangerous: the main purpose of this interrupt is to signal CMD
>> done, LP RX data ready, or VideoMode done, or to reset the HW
>> engine if this doesn't come.
>>
>> Should this interrupt come too late (during probe), the HW will
>> be reset only at the next occurrence of a timeout, which slows
>> down boot and may render artifacts to the DSI display.
>>
>> Moreover, clearing the DSI interrupt while the display controller
>> is not ready yet, may result in an interrupt storm.
>>
>> In order to prevent this from happening, request the interrupt
>> with IRQF_NO_AUTOEN, and enable it only when binding DSI to its
>> display controller component master.
>>
>> Reviewed-by: CK Hu <ck.hu@mediatek.com>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> This was necessary on mt6595, otherwise it would get stuck.
> 

Yep, I guess it was getting stuck before this because your platform's bootloader
has continuous splash functionality and leaves it on while booting Linux, right?

Just a curiosity... ;-)

Cheers,
Angelo

> Acked-by: Roman Vivchar <rva333@protonmail.com>
> Tested-by: Roman Vivchar <rva333@protonmail.com> # mt6595, mt6768
> 
>> ---
>>   drivers/gpu/drm/mediatek/mtk_dsi.c | 24 +++++++++++++-----------
>>   1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> index 28ba532210ff..6ac6daa61e68 100644
>> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
>> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
>> @@ -225,6 +225,7 @@ struct mtk_dsi {
>>   	int refcount;
>>   	bool enabled;
>>   	bool lanes_ready;
>> +	int irq;
>>   	u32 irq_data;
>>   	wait_queue_head_t irq_wait_queue;
>>   	const struct mtk_dsi_driver_data *driver_data;
>> @@ -1101,6 +1102,8 @@ static int mtk_dsi_bind(struct device *dev, struct device *master, void *data)
>>   		return ret;
>>   	}
>>
>> +	enable_irq(dsi->irq);
>> +
>>   	return 0;
>>   }
>>
>> @@ -1109,6 +1112,8 @@ static void mtk_dsi_unbind(struct device *dev, struct device *master,
>>   {
>>   	struct mtk_dsi *dsi = dev_get_drvdata(dev);
>>
>> +	disable_irq(dsi->irq);
>> +
>>   	drm_encoder_cleanup(&dsi->encoder);
>>   }
>>
>> @@ -1342,7 +1347,6 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>   {
>>   	struct mtk_dsi *dsi;
>>   	struct device *dev = &pdev->dev;
>> -	int irq_num;
>>   	int ret;
>>
>>   	dsi = devm_drm_bridge_alloc(dev, struct mtk_dsi, bridge,
>> @@ -1375,9 +1379,9 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>   	if (IS_ERR(dsi->phy))
>>   		return dev_err_probe(dev, PTR_ERR(dsi->phy), "Failed to get MIPI-DPHY\n");
>>
>> -	irq_num = platform_get_irq(pdev, 0);
>> -	if (irq_num < 0)
>> -		return irq_num;
>> +	dsi->irq = platform_get_irq(pdev, 0);
>> +	if (dsi->irq < 0)
>> +		return dsi->irq;
>>
>>   	dsi->host.ops = &mtk_dsi_ops;
>>   	dsi->host.dev = dev;
>> @@ -1386,17 +1390,15 @@ static int mtk_dsi_probe(struct platform_device *pdev)
>>
>>   	platform_set_drvdata(pdev, dsi);
>>
>> +	ret = devm_request_irq(&pdev->dev, dsi->irq, mtk_dsi_irq,
>> +			       IRQF_NO_AUTOEN, dev_name(&pdev->dev), dsi);
>> +	if (ret)
>> +		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
>> +
>>   	ret = mipi_dsi_host_register(&dsi->host);
>>   	if (ret < 0)
>>   		return dev_err_probe(dev, ret, "Failed to register DSI host\n");
>>
>> -	ret = devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
>> -			       IRQF_TRIGGER_NONE, dev_name(&pdev->dev), dsi);
>> -	if (ret) {
>> -		mipi_dsi_host_unregister(&dsi->host);
>> -		return dev_err_probe(&pdev->dev, ret, "Failed to request DSI irq\n");
>> -	}
>> -
>>   	dsi->bridge.of_node = dev->of_node;
>>   	dsi->bridge.type = DRM_MODE_CONNECTOR_DSI;
>>
>> --
>> 2.55.0
>>
>>
>>
