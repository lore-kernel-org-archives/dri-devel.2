Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1285FFF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 16:39:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CD3F10E816;
	Mon, 27 Apr 2026 16:39:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="BHF9E5yZ";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5926010E82F
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 16:39:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777307985;
 bh=f238bjapOZ8zpcnG+Q+ZHGREX5Zx5UvSKClStNdPxjw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BHF9E5yZ2esbtbd4p4gLa4dp9X79XhbP8MMTNq1IVqdI/jUxRqbEr7JFQv0Xkg7Ff
 yHpwPcmXQjEndOP/JJEWOc2B0jW50tvR3vqEbPaC+onIYVIACbp60JckRTDzR20cB3
 gxa1XL8+Wd5s2TnaSVfmuuS821QEErQLKodgbN/9ckxZ88OdQYFOwXLEpxewiLY9GK
 HYZ1BLKU4OAFF+CPUfuAHutyfh3/ARPS1+mmHwy9WDh2SjMM7J7VAsi9qPYD/w0sra
 wWHncdgXBicN0mN3o44yKCHZS95QepzhbC3Hf7BzmX7Za9yowxfhBM5G72xPE5/oDE
 LwajlnH5tEhzw==
Received: from [100.64.0.241] (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B9F417E0F33;
 Mon, 27 Apr 2026 18:39:45 +0200 (CEST)
Message-ID: <d3b5239b-e3d9-4d81-9220-d6057d670ff3@collabora.com>
Date: Mon, 27 Apr 2026 19:39:44 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/10] drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC
 scrambling and high TMDS clock ratio support
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Diederik de Haas <diederik@cknow-tech.com>,
 Maud Spierings <maud_spierings@hotmail.com>
References: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
 <20260426-dw-hdmi-qp-scramb-v5-5-d778e70c317b@collabora.com>
 <3826043.PYKUYFuaPT@phil>
Content-Language: en-US
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <3826043.PYKUYFuaPT@phil>
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

Hello Heiko,

Thanks for the quick reviews!

On 4/27/26 1:49 PM, Heiko Stuebner wrote:
> Am Sonntag, 26. April 2026, 02:20:17 Mitteleuropäische Sommerzeit schrieb Cristian Ciocaltea:
>> Enable HDMI 2.0 display modes (e.g. 4K@60Hz) by adding SCDC management
>> for the high TMDS clock ratio and scrambling, required when the TMDS
>> character rate exceeds the 340 MHz HDMI 1.4b limit.
>>
>> A periodic work item monitors the sink's scrambling status to recover
>> from sink-side resets.  On hotplug detect, if SCDC scrambling state is
>> out of sync with the driver, trigger a CRTC reset to re-establish the
>> link.
>>
>> Reject modes requiring TMDS rates above 600 MHz, as those fall in the
>> HDMI 2.1 FRL domain which is not supported. In no_hpd configurations,
>> further restrict to 340 MHz since SCDC requires a connected sink.
>>
>> Tested-by: Diederik de Haas <diederik@cknow-tech.com>
>> Tested-by: Maud Spierings <maud_spierings@hotmail.com>
>> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
>> ---
>>  drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c | 188 ++++++++++++++++++++++++---
>>  1 file changed, 172 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> index d649a1cf07f5..c482a8e7da25 100644
>> --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c
>> @@ -2,6 +2,7 @@
>>  /*
>>   * Copyright (c) 2021-2022 Rockchip Electronics Co., Ltd.
>>   * Copyright (c) 2024 Collabora Ltd.
>> + * Copyright (c) 2025 Amazon.com, Inc. or its affiliates.
> 
> I have no real clue about the inner workings of hdmi, but that line
> does make me curious, because no part of the patch authorship does
> mention Amazon ;-) .

That was intentional: although the code was written by Collabora, the copyright
belongs to Amazon.

> Also I think "or it's affiliates" might be way too broad, because this
> can be essentially everyone. So noone in the future will know who to
> ask on copyright questions.
> 
> Similarly when _somebody_ comes forward with "I hold a copyright on this"
> no-one could verify this claim as well.
> 
> I somehow expect _one_ entity being specified, not possibly hundreds.

Hmm, I followed the wording already used elsewhere in the kernel tree:

$ git grep 'Copyright.*Amazon.*affiliates' | wc -l
93

There appears to be only a single instance that omits “affiliates”:

$ git grep 'Copyright.*Amazon' | grep -v affiliates
drivers/power/supply/max14656_charger_detector.c: * Copyright (C) Amazon Technologies Inc. All rights reserved.

Which was added nearly ten years ago, so I’m not sure it makes sense to adopt
that form now.

Actually, this seems to be fairly common among other vendors as well:

$ git grep 'Copyright.*affiliates' | wc -l
1014

Regards,
Cristian
