Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BA2ACD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 10:20:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F99310F124;
	Mon,  8 Jun 2026 10:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=samsung.com header.i=@samsung.com header.b="jxABCkWS";
	dkim-atps=neutral
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com
 [210.118.77.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 856B810F109
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:20:22 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20260608102019euoutp02a495e36787ce866797e813618bd1da6d~3E92KqK5b2919829198euoutp02G
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 10:20:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20260608102019euoutp02a495e36787ce866797e813618bd1da6d~3E92KqK5b2919829198euoutp02G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1780914019;
 bh=MwX2QwB3+58Yda8r88VDRC3U2MfXiXWf69QmRRXsBQc=;
 h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
 b=jxABCkWSyUh7FsGKgTYBpiU3QpLMDlM8fod8Cuta/WeqjjSPa/zm0+6C9rbnt83//
 26XV1QcQsi7S5V1kmCJyMx6GL+vC3O2lj7Zx2Q8yq/vVuIflRwZQ18vaqGsagf4djN
 o4wsaQry54j2ikTdpgRxWm2d7Y4p1ze0KnzdQQgs=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20260608102019eucas1p2d2d5aaeac17e5fe86a6e77b5f214d9c5~3E91nfe0Y0110601106eucas1p2b;
 Mon,  8 Jun 2026 10:20:19 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20260608102018eusmtip10272072f4c7e9dda37c4e1c049edc977~3E90jKOr91778017780eusmtip1S;
 Mon,  8 Jun 2026 10:20:18 +0000 (GMT)
Message-ID: <f44cd26b-782b-493f-b298-482629780385@samsung.com>
Date: Mon, 8 Jun 2026 12:20:16 +0200
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] drm/bridge: samsung-dsim: fix TE GPIO ownership
To: Alexander Stein <alexander.stein@ew.tq-group.com>, Inki Dae
 <inki.dae@samsung.com>, Jagan Teki <jagan@amarulasolutions.com>, Andrzej
 Hajda <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Marek Vasut <marex@denx.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <7255371.MhkbZ0Pkbq@steina-w>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260608102019eucas1p2d2d5aaeac17e5fe86a6e77b5f214d9c5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260605075148eucas1p1f6de1f1b3c9e063bc4e803da73cb2221
X-EPHeader: CA
X-CMS-RootMailID: 20260605075148eucas1p1f6de1f1b3c9e063bc4e803da73cb2221
References: <20260604114604.1422184-1-lgs201920130244@gmail.com>
 <CGME20260605075148eucas1p1f6de1f1b3c9e063bc4e803da73cb2221@eucas1p1.samsung.com>
 <7255371.MhkbZ0Pkbq@steina-w>
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

On 05.06.2026 09:51, Alexander Stein wrote:
> Am Donnerstag, 4. Juni 2026, 13:46:04 CEST schrieb Guangshuo Li:
>> samsung_dsim_register_te_irq() acquires the TE GPIO with
>> devm_gpiod_get_optional(), but the descriptor is released manually in the
>> request_threaded_irq() error path and in samsung_dsim_unregister_te_irq().
>> The devres entry remains registered and will release the same descriptor
>> again when the device is detached.
>>
>> Use the non-managed gpiod_get_optional() helper instead, so the GPIO
>> descriptor lifetime matches the existing manual cleanup paths. Also clear
>> dsi->te_gpio after each gpiod_put() to avoid leaving a stale descriptor
>> pointer around if the host is attached again.
> Shouldn't you use devm_gpiod_put instead of gpiod_put?

Not really. The dev pointer here is not the device that the $subject driver binds to, so using devm_* interface is a bit fragile. Similar issue was fixed long time ago by commit fedc89821990 ("drm/exynos: Search for TE-gpio in DSI panel's node"). I would prefer explicitly use non-devm api for it.


For the initial patch:

Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>

>> Fixes: e7447128ca4a ("drm: bridge: Generalize Exynos-DSI driver into a Samsung DSIM bridge")
>> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>> ---
>>  drivers/gpu/drm/bridge/samsung-dsim.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/bridge/samsung-dsim.c
>> index c3eb437ef1b0..2299b7dc0c04 100644
>> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
>> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
>> @@ -1862,7 +1862,7 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
>>  	int te_gpio_irq;
>>  	int ret;
>>  
>> -	dsi->te_gpio = devm_gpiod_get_optional(dev, "te", GPIOD_IN);
>> +	dsi->te_gpio = gpiod_get_optional(dev, "te", GPIOD_IN);
>>  	if (!dsi->te_gpio)
>>  		return 0;
>>  	else if (IS_ERR(dsi->te_gpio))
>> @@ -1875,6 +1875,7 @@ static int samsung_dsim_register_te_irq(struct samsung_dsim *dsi, struct device
>>  	if (ret) {
>>  		dev_err(dsi->dev, "request interrupt failed with %d\n", ret);
>>  		gpiod_put(dsi->te_gpio);
>> +		dsi->te_gpio = NULL;
>>  		return ret;
>>  	}
>>  
>> @@ -1886,6 +1887,7 @@ static void samsung_dsim_unregister_te_irq(struct samsung_dsim *dsi)
>>  	if (dsi->te_gpio) {
>>  		free_irq(gpiod_to_irq(dsi->te_gpio), dsi);
>>  		gpiod_put(dsi->te_gpio);
>> +		dsi->te_gpio = NULL;
>>  	}
>>  }
>>  
>>
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

