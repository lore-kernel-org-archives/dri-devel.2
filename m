Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37006C982CF
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:06:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1451710EEB0;
	Thu, 17 Sep 2026 13:06:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="kKlz4JYm";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="Tguo721q";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 359FB10EEB0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 13:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1789650366; bh=/89Pt9jfecmobhleE2QqkQL
 /53slzWSbnYjmKx8md1s=; b=kKlz4JYmN1tAnl6AcXGI8RJLKwMIe9dbodtgrI42M50pBPtkt5
 7bPlCp2ZaM6JsQeasBwY3fdxQUj3JQpVMRC3IQInHb1J7WjCM41UMK/O1dT3KKY0aEkyQ3nG0jP
 W1EPPayGmJDJWJ056LgZ+slxqgYy/QFGp3YosZc2P0xqhBAkeyM4o9hp7FRmY7BUga7RM2DC4dH
 7WFvMaKYanKgMqpdhRdxxRdn2Wi01rts1D4GlGQfcB9DV+gWj4QaczD4Rkd9jkRa6ssrFl1VayP
 pFIGpOmuOtSW6LPsK4Sk9O2o918Lb7mCuYO6swGKHtE9eqyYOe5KQ4tKrQfcV0BmuVA==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1789650366; bh=/89Pt9jfecmobhleE2QqkQL
 /53slzWSbnYjmKx8md1s=; b=Tguo721q8+vFl2tbEFSJfi5MwIopaMqhY+ossRwseds0htqIiQ
 3WQL09XRU5XlPGM9SRjpa6ErBv2byGhB3wBw==;
Message-ID: <0a6d59c7-006c-4cb9-98ff-e8d859489bc4@mainlining.org>
Date: Thu, 17 Sep 2026 16:06:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drivers: gpu: drm: panel: Add BOE NT51021 driver
To: sashiko-reviews@lists.linux.dev
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
References: <20260917-qcom-novatek-nt51021-panels-v4-0-30afbc35d70c@mainlining.org>
 <20260917-qcom-novatek-nt51021-panels-v4-2-30afbc35d70c@mainlining.org>
 <20260917130132.CEE401F00893@smtp.kernel.org>
Content-Language: ru-RU, en-US
From: Nickolay Goppen <setotau@mainlining.org>
In-Reply-To: <20260917130132.CEE401F00893@smtp.kernel.org>
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


17.09.2026 16:01, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] drm: panel: novatek-nt51021: UAF and crash due to premature devm_drm_panel_add()
> --
>
> commit 32c00aa725aa38b42eafcacc07a8f05495f7ed3d
> Author: Nickolay Goppen <setotau@mainlining.org>
>
>      drivers: gpu: drm: panel: Add BOE NT51021 driver
>      
>      Add driver for BOE NT51021-based 8-inch and 10-inch DSI video mode
>      panels used in Xiaomi Mi Pad 4, Mi Pad 4 Plus (xiaomi-clover)
>      and Amazon Fire HD 10 (2017) (amazon-suez) tablets.
>
>> diff --git a/drivers/gpu/drm/panel/panel-novatek-nt51021.c b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
>> new file mode 100644
>> index 0000000000000..94e7d6aaf0cb9
>> --- /dev/null
>> +++ b/drivers/gpu/drm/panel/panel-novatek-nt51021.c
> [ ... ]
>
>> +static int nt51021_novatek_probe(struct mipi_dsi_device *dsi)
>> +{
>> +	struct device *dev = &dsi->dev;
> [ ... ]
>
>> +	ctx->panel.prepare_prev_first = true;
>> +
>> +	ret = drm_panel_of_backlight(&ctx->panel);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get backlight\n");
>> +
>> +	ret = devm_drm_panel_add(dev, &ctx->panel);
>> +	if (ret)
>> +		return ret;
>> +
>> +	return devm_mipi_dsi_attach(dev, dsi);
> [Severity: High]
> Can this sequence lead to a use-after-free or kernel crash?
>
> By calling devm_drm_panel_add() before devm_mipi_dsi_attach(), the panel is
> published globally before DSI attachment completes.
>
> If a DRM consumer discovers the panel via of_drm_find_panel() during this
> window, it takes a reference on the panel. If devm_mipi_dsi_attach() then
> fails, the probe function returns an error and devres cleans up the allocated
> GPIO and regulator resources. However, the panel memory remains allocated
> because of the consumer's reference.
>
> When the consumer later calls drm_panel_prepare(), the panel driver will
> dereference the freed GPIO and regulator pointers, causing a use-after-free.
>
> Additionally, if a consumer calls drm_panel_prepare() before mipi_dsi_attach()
> completes, it will trigger DSI commands on an unattached device, crashing the
> DSI host.
>
> Should devm_mipi_dsi_attach() be called before devm_drm_panel_add() to prevent
> this race window?
Other drivers do the same sequence of add and attach functions as I did.
>> +}

-- 
Best regards,
Nickolay
