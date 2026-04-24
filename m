Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4FBFED3E6
	for <dri-devel@archiver.kernel.org>; Fri, 24 Apr 2026 17:29:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B30510F667;
	Fri, 24 Apr 2026 17:29:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=mainlining.org header.i=@mainlining.org header.b="Z8cy4U0o";
	dkim=permerror (0-bit key) header.d=mainlining.org header.i=@mainlining.org header.b="htZZZhYq";
	dkim-atps=neutral
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5570610E365
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 15:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1777045831; bh=5MfdXn4neewtBeoGofSafFV
 JRMgd66CxCyuNytqkaXg=; b=Z8cy4U0oISU8nWoUym5VEeB1uDhgk41Y9+k9pcTL1OTGicEuzT
 PI4RDd98yrGL32uzntdWauHnz5B2OwkLyDQXRGon9e+xJ3AlqJMUJkMnvCpFO9hpFjeSRf33cV0
 VBuQE+8u2gwS2ZKVqmrqFM3AWlRkvDSRK/BcUER7xt0BFj3H+IsPylCR7HXc9p5qY4Meo2JbG/G
 w473z6lkg+UPZc9acE38pazR9m3zWMUrmZSnflTur20aF7IstCB+z3C8+x7raxLTa/gzenwrmib
 tCPzSjBpVqDhZFaBXVceMd6R+PWldBUbJ09H4EtAwOtCwLPbdWya6R4RVKblITwoeSQ==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=From:To:Subject:Date:Message-ID; t=1777045831; bh=5MfdXn4neewtBeoGofSafFV
 JRMgd66CxCyuNytqkaXg=; b=htZZZhYq/aZSSSlv6IZmfPvtKftxQQ18W2qOc4cm8x3lSsuGn9
 OtqXEE5a8fUjas//mTR7FlcKKv6z01dEXYAQ==;
Message-ID: <0c0460c2-a2a0-4f61-8d23-80c3e9592cb5@mainlining.org>
Date: Fri, 24 Apr 2026 11:50:28 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panel/boe-tv101wum-nl6: set MIPI_DSI_MODE_LPM after
 sending panel disable cmds
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260421153147.4378-2-brady.norander@mainlining.org>
 <0cc98ad2-bce8-476a-8f27-2c201eed9828@linaro.org>
Content-Language: en-US
From: Brady Norander <brady.norander@mainlining.org>
In-Reply-To: <0cc98ad2-bce8-476a-8f27-2c201eed9828@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Apr 2026 17:29:28 +0000
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

On 4/24/26 05:30, Neil Armstrong wrote:
> On 4/21/26 17:31, Brady Norander wrote:
>> A recent change to Mediatek drm driver enabled HS mode support. With that
>> change, my MT8183-based krane sku176 chromebook display's colors would 
>> look darker
>> and desaturated after turning the display off and back on. Looking at 
>> other panel
>> drivers, it seems common to enable HS mode to send the disable 
>> commands and to
>> disable HS mode afterwards. However, the boe-tv101wum-nl6 driver would 
>> never
>> disable HS mode, leading to this issue. Update the behavior of 
>> boe_panel_disable
>> to match those other panel drivers. As a side note, I did also test 
>> removing the
>> line which enables HS mode during panel_disable. This worked fine for 
>> my device,
>> but just in case that doesn't work for other devices, I chose to keep 
>> that and
>> instead disable HS mode after sending the panel disable commands.
>>
>> Signed-off-by: Brady Norander <brady.norander@mainlining.org>
>>
>> diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/ 
>> gpu/drm/panel/panel-boe-tv101wum-nl6.c
>> index d5fe105bdbdd..f69b5bd776c0 100644
>> --- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
>> +++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
>> @@ -1326,6 +1326,8 @@ static int boe_panel_disable(struct drm_panel 
>> *panel)
>>       mipi_dsi_msleep(&ctx, 150);
>> +    boe->dsi->mode_flags |= MIPI_DSI_MODE_LPM;
>> +
>>       return ctx.accum_err;
>>   }
> 
> Could you add a Fixes tag ?
> 
> Neil

I can add a fixes tag and send a v2. Just one thing I'm not sure about, 
do I tag the mediatek drm commit which git bisect found, or do I tag the 
commit which added the panel driver since this faulty logic has existed 
since the driver was added?
