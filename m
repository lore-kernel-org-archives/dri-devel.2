Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06BBFCDB475
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:31:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BBAF10E4EE;
	Mon, 22 Jun 2026 07:31:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="JnW1sIL9";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FADC10E4EE
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:31:41 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 1C94756D;
 Mon, 22 Jun 2026 09:31:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1782113461;
 bh=ol+3hMIshApUprdQMTjS1Gy1eVK1KNsU0DKxoEjwVeI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=JnW1sIL9ShNu054CyuWzUl6Hw1srISiWBnzM/vwHN5f4e11kZUPV2RU9rtwb/ZRW3
 3s+tYOInYo9COeVavBkr50/robnoVQ6SgdToNPs4cn5XIwiRuujWy/r3fblm1jcBsO
 7XLVWvAG3EVjsuhQqPdZzGMfD10nGqqdsVkOJJmc=
Message-ID: <8efe44d7-3864-45cb-bd79-f25f573b6432@ideasonboard.com>
Date: Mon, 22 Jun 2026 10:31:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
To: Andreas Kemnade <andreas@kemnade.info>
Cc: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
 <20260513-tc358762-fixes-v3-7-6698b55008b9@ideasonboard.com>
 <20260529203424.72199881@kemnade.info>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260529203424.72199881@kemnade.info>
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

Hi,

On 29/05/2026 21:34, Andreas Kemnade wrote:
> On Wed, 13 May 2026 16:10:16 +0300
> Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:
> 
>> Update comment about the number of lanes.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
>>   1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
>> index 7840ab3454f6..c5734c4df440 100644
>> --- a/drivers/gpu/drm/bridge/tc358762.c
>> +++ b/drivers/gpu/drm/bridge/tc358762.c
>> @@ -306,7 +306,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
>>   	ctx->dev = dev;
>>   	ctx->pre_enabled = false;
>>   
>> -	/* TODO: Find out how to get dual-lane mode working */
>> +	/*
>> +	 * When using DSI clk for pixel clock (only mode supported in the driver),
>> +	 * the pclk is derived directly from the DSI byteclk via simple divider,
>> +	 * which is either 2 or 3.
>> +	 * The required divider can be calculated with bitspp / 8 / nlanes. Thus,
>> +	 * for RGB888, only nlanes = 1 works as nlanes = 2 would require divider
>> +	 * of 1.5.
>> +	 */
>>   	dsi->lanes = 1;
>>   	dsi->format = MIPI_DSI_FMT_RGB888;
>>   	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
>>
> wondering: I am using lanes = 2 and RGB888. But I need to write something to
> SYSPLL3 register. Which somehow is sensitive to write to.... Do you have any
> information about that register?
If you have an external refclk, then you can use the tc358762 pll to 
generate the clock, which I guess you are using. SYSPLL3 configures some 
parts of the PLL, and the doc says the write to SYSPLL3 must be the last 
in the sequence.

  Tomi

