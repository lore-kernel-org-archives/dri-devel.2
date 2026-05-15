Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E88CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 08:03:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5858010E419;
	Fri, 15 May 2026 08:03:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="nYPHGW4U";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 546F810E419
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 08:03:01 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 06C7D63C;
 Fri, 15 May 2026 10:02:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778832170;
 bh=BEKWtgaIVhEiq1VmEfN2oPMg1YJY/RV9AAVxvidyvKo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nYPHGW4UQIhJCre358b2q6pW4Zwj7YcqcngcihcTNnh+MGrNnKrkzPj08sfve3Fio
 YUOwX2G5twgcqYArSSenDzY9tXoiUUBw9xg6eCr0+lMiNo7LcbX8B0PqOicm0uvbrA
 tBSfJ74CcgMouz5xq3e9DWKRyZyIfyLIG124xo/E=
Message-ID: <6db159d9-56af-4d79-a1f1-9d5a6349b5ac@ideasonboard.com>
Date: Fri, 15 May 2026 11:02:55 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H
 DSC driver
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
 <20260514-rcar-du-dsc-v1-3-d65f7a9e9841@ideasonboard.com>
 <CAMuHMdVTgQp9WRiFpLX+pP7kOGF2v6oButALPu1B8QkYhVyvJA@mail.gmail.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <CAMuHMdVTgQp9WRiFpLX+pP7kOGF2v6oButALPu1B8QkYhVyvJA@mail.gmail.com>
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

Hi Geert,

On 15/05/2026 10:49, Geert Uytterhoeven wrote:
> Hi Tomi,
> 
> On Thu, 14 May 2026 at 14:25, Tomi Valkeinen
> <tomi.valkeinen+renesas@ideasonboard.com> wrote:
>> From: Marek Vasut <marek.vasut+renesas@mailbox.org>
>>
>> The Renesas DSC Display Stream Compression is a bridge embedded in the
>> Renesas R-Car V4H SoC. The bridge performs VESA DSC encoding of up to
>> 8k or 400 Mpixel/s . Add rudimentary driver, which currently acts as a
>> pass-through bridge and allows DSI1 to be operational on R-Car V4H.
>>
>> Signed-off-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
>> [tomi.valkeinen: use bridge->next_bridge, minor changes]
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> 
> Thanks for your patch!
> 
>> --- /dev/null
>> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c
> 
>> +
>> +static void rcar_dsc_atomic_enable(struct drm_bridge *bridge,
>> +                                  struct drm_atomic_state *state)
>> +{
>> +       struct rcar_dsc *dsc = bridge_to_rcar_dsc(bridge);
>> +
>> +       WARN_ON(clk_prepare_enable(dsc->clk));

Ah, just missed your comment and sent the v2.

> Who don't you use pm_runtime_resume_and_get() instead, like
> rcar_cmm.c? Then you don't need to get the clock at all, and the driver

Hmm, why wouldn't I need to get the clock? What does the runtime PM do 
on Renesas?

> will keep on working if the DSC ever ends up in a power domain.
I can add runtime PM. I just felt that it was overcomplicating a "dummy" 
driver that just needs to enable the clock when the video pipeline is 
enabled.

  Tomi

