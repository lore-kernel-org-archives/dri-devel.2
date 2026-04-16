Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B91FFF8A146
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 09:11:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1912110E012;
	Thu, 16 Apr 2026 09:11:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pwp6eOQo";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0E9310E012
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 09:11:03 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2a9296b3926so43727765ad.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 02:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776330663; x=1776935463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uts+5T2o2pECzjgqC6qN0D7jUAdgSuIUUSPWJQhrdKg=;
 b=pwp6eOQordoF50wF8unQdEUHiJIhmLsnJ6f9wMrpP3aKKL+7S2uFtSOml0yVI3OLkZ
 PXRfEScsggANL98I1lvQgtoXaRpBj56nULPQR6AejMNYJFfuOCPayx/kE3LAWZ+BTHrn
 FjSrdonpaHW0HSZaeotsC/9XuNmQBY3iG/CHtQDCosNNE+4yX0bWrVz05u2syerBlg2I
 W5p59M5JKFgSootoCIuEJeAINwZM+BpR+U7/6H7ERSaUU0sdxyEYlfVSs+xLM4GYb485
 aNR0HARP7/T+kG258AECmYIhKKJdyEOfey1u3prh9Yr6JfUs3mQqn8elKMcBkftHbq/J
 kuZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776330663; x=1776935463;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uts+5T2o2pECzjgqC6qN0D7jUAdgSuIUUSPWJQhrdKg=;
 b=Oq34OW3+WmkHKNjKjSCnPFwmmlaokFdGMlTkbcJPUDASvsF/TVfVMb0ai16CDmFBrU
 LvPsWuhmMn3rdnoEnwMfHUC0HBqLH3FwRpZoax7XI3eIcLXFM/uUY7MkpiENEbXUMGOj
 hTSVyrYe4x4DS7T75IIXVBhf63FbcGniM2lysGKyCXoIiCtUVIaqyOICM5b8c9Cknj5v
 4tNXqWTrkS0JM1yYIKRr57j27B1ga21WS8440AoDAaWgGu5Kl0K3aO5v+NAH8ocOCifN
 MMXww5pzz/Onxhycxa5b3nyEXYpRsZ7GXqDodN88zLEQi0ILYxQ5X0R0Sv/GD1eFOb3R
 whRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+E6jqJPFJBpTmYg7I40yYSC3J1+cwuoJmAjGGPA9G4zhXp5jezAkDY+BjvGKU9gqoVfS145I+mMU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcmPcVq74e9oM1qoARTosNb7/EclSfVb3Mz9ZKzxIWKYC3O5vz
 VHdtISoUqDj5dqpoV8/+YwCHLqp+tqwckXVjyjIKNzjl9eCLrwFtCrFu
X-Gm-Gg: AeBDies3bD41eNq73bpaOhfj8wClAvZN0jybhaCFhJWi3njJI7554gfnAxg7REll4Rq
 MxyTHsmOcW7n7ZIujRUwExt5OAfqXez6lesyO9ftNRMp61dOfJORKAM6Q1KD/kF/ZKV8pCbLkzE
 0qogRa6d6PR9htzOsllIT95BS7sRlFXDgEkrAvOXgxuVyFv03GRHhmAxiYutJfQjI5ga7zjF7o0
 +LQyseMEIkZJuzFdNglLx4IHLRc+7QZo9w0nYmLIOdh+Wi6iOH65/CbUK+jaz+ebm+thKGz6R04
 +1i3OwWat1sR3nMpdG+soVJwhuZOqmDgHaqe7+f/4lkwCH2eCcSSLLlEVeaYKPOYX0TAaqDrAZW
 8c4EdGV5Fn3U2SwP6qDPSzM+LBd5PMAFGM6QQd0BkFONizznt/n1R7hcjrNP0rbIxLuT7KtwU48
 mTtprsakxJ3iZUIg5y7mQqLPUiBgB0nlaAo8mQh1D28cqOPdyFrcf2CmBS1w==
X-Received: by 2002:a17:902:c94d:b0:2b2:5da8:14be with SMTP id
 d9443c01a7336-2b2d5a76e9amr256282835ad.41.1776330663005; 
 Thu, 16 Apr 2026 02:11:03 -0700 (PDT)
Received: from [172.16.20.13] ([136.226.252.245])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b4780ef429sm46710925ad.4.2026.04.16.02.10.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Apr 2026 02:11:02 -0700 (PDT)
Message-ID: <c4c33f14-0da0-447a-ab82-2e2f65c09c07@gmail.com>
Date: Thu, 16 Apr 2026 14:40:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] drm: bridge: ti-sn65dsi83: Fix DSI mode flags for
 stable LVDS output
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 marex@denx.de, valentin@compulab.co.il, philippe.schenker@toradex.com,
 alexander.stein@ew.tq-group.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260412053811.662461-1-tessolveupstream@gmail.com>
 <20260412053811.662461-2-tessolveupstream@gmail.com>
 <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
Content-Language: en-US
From: tessolveupstream@gmail.com
In-Reply-To: <DHTJJRKD65L4.1P7X5O20V1W2Q@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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



On 15-04-2026 12:43, Luca Ceresoli wrote:
> Hello Sudarshan,
> 
> On Sun Apr 12, 2026 at 7:38 AM CEST, Sudarshan Shetty wrote:
>> The current DSI mode configuration enables VIDEO_BURST and disables
>> horizontal front porch (HFP) and back porch (HBP) transmission using
>> MIPI_DSI_MODE_VIDEO_NO_HFP and MIPI_DSI_MODE_VIDEO_NO_HBP.
>>
>> However, the SN65DSI83/84 bridge relies on receiving full horizontal
>> timing information over DSI in order to correctly reconstruct the LVDS
>> output timings. When HFP and HBP are not transmitted, the bridge cannot
>> recreate the required timing parameters, resulting in unstable or
>> missing display output on some panels.
>>
>> Additionally, while burst mode is supported by the hardware, its use
>> depends on continuous clock behavior from the DSI host. In practice,
>> burst mode may introduce instability depending on the host controller
>> implementation, as the DSI link may transition to low-power state
>> between bursts.
>>
>> In testing, removing burst mode and ensuring full horizontal timing
>> transmission results in stable LVDS output across affected panels.
>>
>> Update the DSI mode flags to:
>>   - Drop MIPI_DSI_MODE_VIDEO_BURST
>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HFP
>>   - Drop MIPI_DSI_MODE_VIDEO_NO_HBP
>>
>> This aligns with common system configurations where non-burst mode is
>> preferred and full timing information is transmitted over DSI.
>>
>> Signed-off-by: Sudarshan Shetty <tessolveupstream@gmail.com>
> 
> Thanks for having gone into the details and provide a good explanation for
> the removal of these three flags.
> 
> It would be still great to have authoritative info from TI, possibly as an
> update to the documentation.
> 
> I managed to test on a board with i.MX93, a TI SN65DSI84 and a 1920x1080p60
> panel, and:
> 
>  - no image shown with the current mainline driver
>  - it works by removing only MIPI_DSI_MODE_VIDEO_BURST (my current setup)
>  - it works with this patch applied
> 
> Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com> # imx93 1920x1080p60
> 

Thanks for testing the patch and for the Tested-by tag. 
I’ll reach out to TI for clarification on the DSI mode flag behavior and
any documentation updates, and will share any feedback I receive, though I
cannot guarantee a response.
> Luca
> 
> --
> Luca Ceresoli, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

