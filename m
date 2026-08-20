Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55913C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 17:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3D8210F14C;
	Thu, 20 Aug 2026 17:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="NuOzpepW";
	dkim-atps=neutral
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23CC10F14C
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 17:39:12 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org
 [IPv6:2001:67c:2050:b231:465::202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4hQrK94XXzz8v1Y;
 Thu, 20 Aug 2026 19:39:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1787247549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MN8dZCWstpgGLykuTbU1uGEtW2iVdaKsEn0Gd59Itxw=;
 b=NuOzpepWM2gXLDkS2wqvOz/3Mv9cWc+5wiMOJk90QDmOgEh4Lw2vV97t9ehGXtmlGGhtx5
 cFhsx0pEZn3IcSQBp7QWUA2v2MPVAtU8jc3cjjPnauDcZOVnCZKSQ2axMjX1TcRcPcTix1
 0PDH2Fz7H64+DwlbmHVGixQB1UJj5cV6YMo8O8X5Xs9Lire0FgyDao7xpOdgoL/Yuee3J8
 sikB+//2k2LSZZVwH9i/cbIqg/JkyRxsgBhB5X+3Bt0Pq0sFuh0rpLAsPm0FLNouHEcHWK
 AhY/cj2i2H/WcgZW3cs9/ZNOy5nYrGaGHSjYvGAXSu7RVxZ23sY1gxa2yc+bxA==
Message-ID: <f9f77c44-a36c-4b5e-afcb-78a5b5eb84ce@mailbox.org>
Date: Thu, 20 Aug 2026 19:39:04 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] drm/rcar-du: dsi: Implement DSI command TX using AXI
 memory access
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: dri-devel@lists.freedesktop.org, David Airlie <airlied@gmail.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Magnus Damm <magnus.damm@gmail.com>, Maxime Ripard <mripard@kernel.org>,
 Simona Vetter <simona@ffwll.ch>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20260809195831.842907-1-marek.vasut+renesas@mailbox.org>
 <20260810100451.GA2940644@killaraus.ideasonboard.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20260810100451.GA2940644@killaraus.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 1bd4199c2f0fca30007
X-MBO-RS-META: kujyzycna17ogju4pgdce9fpxu56de6f
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

On 8/10/26 12:04 PM, Laurent Pinchart wrote:

Hello Laurent,

[...]

>> @@ -1276,6 +1295,13 @@ static int rcar_mipi_dsi_probe(struct platform_device *pdev)
>>   	dsi->dev = &pdev->dev;
>>   	dsi->info = of_device_get_match_data(&pdev->dev);
>>   
>> +	dsi->cmd_axi_cpu = dma_alloc_coherent(&pdev->dev, SZ_4K, &dsi->cmd_axi_dma,
>> +					      GFP_KERNEL | GFP_DMA32);
> 
> I think setting the DMA mask for the device is preferred over using
> GFP_DMA32.

I will do so.

>> +	if (!dsi->cmd_axi_cpu) {
>> +		return dev_err_probe(&pdev->dev, -ENOMEM,
>> +				     "Failed to allocate DSI AXI Access command buffer\n");
>> +	}
> 
> No need for curly braces.

Are branckets { } not required for multi-line code ?
If this was a oneliner, I would drop them.

>> +
>>   	ret = rcar_mipi_dsi_parse_dt(dsi);
> 
> The allocated memory is leaking in error paths.

Fixed in V2, thanks !

[...]

-- 
Best regards,
Marek Vasut
