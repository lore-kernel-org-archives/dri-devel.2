Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43397CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:24:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A754110EF81;
	Tue,  2 Jun 2026 11:24:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nabladev.com header.i=@nabladev.com header.b="GGkXvpln";
	dkim-atps=neutral
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 78F3E10EF81
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:24:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EEEE411182A; Tue,  2 Jun 2026 13:24:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
 s=dkim; t=1780399445;
 h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:content-language:in-reply-to:references;
 bh=3SEWTdQyt2zyTo6u5upvFp5GM2EdzLG67A0e6CQEJ/k=;
 b=GGkXvplnHCBzZAEnVXRdmOLOp4oVkpIEAOk+bibLG0X0Akh+Ql+29CqDHlXXt4dr/nJGDl
 ZBSKATFx80EF0PtHjfTgmpBjdP6QIzNS3wyYyUB9z1Sd6PZSuv0g2fqhAtxSlizm44HikW
 RqjRJsb9cO6nsDMG+2PNeOMuQJmNf919tGdjRpxzJIu4hR9CFPD7VjK/ASjMake/6F7cXP
 IO5tHgQGWrtC9A9nFAJdiA+5O+7qvNybzRpFkSXP0omekswF9kVOFyFaVEy37Hll7BmH/A
 RaRZ1IkW8uRDdyc9ublvUT627WnqpbFbTRgCFKqHA9k9PimQHTkEeGIwpYSYTQ==
Message-ID: <f942df60-7c7e-4a62-b806-a2339d139aef@nabladev.com>
Date: Tue, 2 Jun 2026 13:24:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] drm/panel: simple: Add Displaytech DT050BTFT-PTS panel
To: Neil Armstrong <neil.armstrong@linaro.org>, dri-devel@lists.freedesktop.org
Cc: Kael D'Alcamo <dev@kael-k.io>,
 Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Rob Herring <robh@kernel.org>,
 Sam Ravnborg <sam@ravnborg.org>, Simona Vetter <simona@ffwll.ch>,
 Thierry Reding <thierry.reding@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260422210806.80948-1-marex@nabladev.com>
 <20260422210806.80948-3-marex@nabladev.com>
 <fbfdcb81-6293-47af-8d09-30bd18b9c815@linaro.org>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <fbfdcb81-6293-47af-8d09-30bd18b9c815@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
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

On 4/24/26 11:34 AM, Neil Armstrong wrote:
> On 4/22/26 23:07, Marek Vasut wrote:
>> Add support for the Displaytech DT050BTFT-PTS 5.0" (800x480) color TFT
>> LCD panel, connected over DPI. Timings are taken from the datasheet
>> from 16 Nov 2023 is available from Seacomp:
>>
>> https://www.seacomp.com/sites/default/files/datasheets/DT050BTFT- 
>> Displaytech-Spec.pdf
>>
>> Signed-off-by: Marek Vasut <marex@nabladev.com>
>> ---
>> Cc: "Kael D'Alcamo" <dev@kael-k.io>
>> Cc: Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>
>> Cc: Conor Dooley <conor+dt@kernel.org>
>> Cc: David Airlie <airlied@gmail.com>
>> Cc: Jessica Zhang <jesszhan0024@gmail.com>
>> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
>> Cc: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard <mripard@kernel.org>
>> Cc: Neil Armstrong <neil.armstrong@linaro.org>
>> Cc: Rob Herring <robh@kernel.org>
>> Cc: Sam Ravnborg <sam@ravnborg.org>
>> Cc: Simona Vetter <simona@ffwll.ch>
>> Cc: Thierry Reding <thierry.reding@gmail.com>
>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
>> Cc: devicetree@vger.kernel.org
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: linux-kernel@vger.kernel.org
>> ---
>>   drivers/gpu/drm/panel/panel-simple.c | 36 ++++++++++++++++++++++++++++
>>   1 file changed, 36 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/ 
>> panel/panel-simple.c
>> index 236bd56208ccf..9f4c907ae044e 100644
>> --- a/drivers/gpu/drm/panel/panel-simple.c
>> +++ b/drivers/gpu/drm/panel/panel-simple.c
>> @@ -1902,6 +1902,39 @@ static const struct panel_desc 
>> dataimage_scf0700c48ggu18 = {
>>       .connector_type = DRM_MODE_CONNECTOR_DPI,
>>   };
>> +static const struct display_timing displaytech_dt050btft_pts_timing = {
>> +    /* The TYP pixel clock are recalculated from tV * tH * 60 Hz */
>> +    .pixelclock = { 30000000, 33264000, 50000000 },
>> +    .hactive = { 800, 800, 800 },
>> +    .hfront_porch = { 16, 210, 354 },
>> +    /* Datasheet Figure 3 indicates, that tHPW is part of tHBP */
>> +    .hback_porch = { 41, 26, 6 },
>> +    .hsync_len = { 1, 20, 40 },
>> +    .vactive = { 480, 480, 480 },
>> +    .vfront_porch = { 7, 22, 147 },
>> +    /* Datasheet Figure 2 indicates, that tVPW is part of tVBP */
>> +    .vback_porch = { 22, 13, 3 },
>> +    .vsync_len = { 1, 10, 20 },
>> +    .flags = DISPLAY_FLAGS_HSYNC_LOW | DISPLAY_FLAGS_VSYNC_LOW |
>> +         DISPLAY_FLAGS_DE_HIGH | DISPLAY_FLAGS_PIXDATA_POSEDGE |
>> +         DISPLAY_FLAGS_SYNC_POSEDGE,
>> +};
>> +
>> +static const struct panel_desc displaytech_dt050btft_pts = {
>> +    .timings = &displaytech_dt050btft_pts_timing,
>> +    .num_timings = 1,
>> +    .bpc = 8,
>> +    .size = {
>> +        .width = 108,
>> +        .height = 65,
>> +    },
>> +    .bus_format = MEDIA_BUS_FMT_RGB888_1X24,
>> +    .bus_flags = DRM_BUS_FLAG_DE_HIGH |
>> +             DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
>> +             DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE,
>> +    .connector_type = DRM_MODE_CONNECTOR_DPI,
>> +};
>> +
>>   static const struct display_timing dlc_dlc0700yzg_1_timing = {
>>       .pixelclock = { 45000000, 51200000, 57000000 },
>>       .hactive = { 1024, 1024, 1024 },
>> @@ -5319,6 +5352,9 @@ static const struct of_device_id 
>> platform_of_match[] = {
>>       }, {
>>           .compatible = "dataimage,scf0700c48ggu18",
>>           .data = &dataimage_scf0700c48ggu18,
>> +    }, {
>> +        .compatible = "displaytech,dt050btft-pts",
>> +        .data = &displaytech_dt050btft_pts,
>>       }, {
>>           .compatible = "dlc,dlc0700yzg-1",
>>           .data = &dlc_dlc0700yzg_1,
> 
> Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Is it OK to apply those patches now ?

Thank you
