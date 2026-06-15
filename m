Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22439CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 12:15:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 745C210E3BB;
	Mon, 15 Jun 2026 12:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oU35YR8c";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ACEA10E3BB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 12:15:32 +0000 (UTC)
Received: from [192.168.88.20] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EDF7A227;
 Mon, 15 Jun 2026 14:14:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781525698;
 bh=S3qYVE+IsQdmBW/YqaJdxU4w3VEbDSI3GdWVg9g6mQk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=oU35YR8c4uvW8k5J9DXStw65+9RcZWov1x86+/Ngmm1XxbVSNrTiRvlsvhBwm7vMa
 Pa2A6WIuhWokS/xEamL1yqwj7z7rbfYIz4hh6l1IsL2Mvr5r+JgkgbG1P58AiMWRCt
 oSIvXrR4/whmh2cZ0W7qR/brvih6O459pa4yh9Ks=
Message-ID: <72189515-4566-46fb-9277-50570b8d28d6@ideasonboard.com>
Date: Mon, 15 Jun 2026 15:15:26 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] drm/rcar-du: dsi: Support DSC in the pipeline
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, linux-renesas-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
References: <20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com>
 <20260615-rcar-du-dsc-v4-4-93096a1b56a3@ideasonboard.com>
 <20260615091911.GB2821720@killaraus.ideasonboard.com>
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Content-Language: en-US
In-Reply-To: <20260615091911.GB2821720@killaraus.ideasonboard.com>
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

On 15/06/2026 12:19, Laurent Pinchart wrote:
> Hi Tomi,
> 
> Thank you for the patch.
> 
> On Mon, Jun 15, 2026 at 09:28:09AM +0300, Tomi Valkeinen wrote:
>> Enabling DSI clocks on rcar-du needs some tricks as the DU dot clock is
>> provided by the DSI. Thus, we call rcar_mipi_dsi_pclk_enable() from the
>> crtc, when enabling the crtc.
>>
>> With DSC (added in upcoming patch) in the pipeline, between the DU and
>> the DSI, the above call path is broken as the crtc tries to call
>> rcar_mipi_dsi_pclk_enable() on the DSC.
>>
>> To solve this problem, add checks to rcar_du_crtc_atomic_enable() and
>> rcar_du_crtc_atomic_disable() to detect the DSC via the bridge type, and
>> skip the DCS bridge when needed.
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>> ---
>>   drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c  | 18 ++++++++++++++++++
>>   drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c |  1 +
>>   2 files changed, 19 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
>> index 6c07c406f725..f14fd89f9104 100644
>> --- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
>> +++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_crtc.c
>> @@ -754,6 +754,15 @@ static void rcar_du_crtc_atomic_enable(struct drm_crtc *crtc,
>>   	     (BIT(RCAR_DU_OUTPUT_DSI0) | BIT(RCAR_DU_OUTPUT_DSI1)))) {
>>   		struct drm_bridge *bridge = rcdu->dsi[rcrtc->index];
>>   
>> +		/*
>> +		 * When we have a DSC block between the DU and the DSI,
>> +		 * the "bridge" points to the DSC. Detect the DSC by looking
>> +		 * at the bridge type, and skip the DSC if the bridge is not
>> +		 * the DSI bridge.
>> +		 */
>> +		if (bridge->type != DRM_MODE_CONNECTOR_DSI)
>> +			bridge = bridge->next_bridge;
>> +
> 
> Is there a reason you don't do this in rcar_du_encoder_init() instead ?
> It would avoid running this code on every enable/disable.
That works too.

Both options feel a bit confusing, in different ways. Your suggestion is 
less code and, I think, more correct as rcdu->dsi[] will always point to 
a DSI bridge (although that itself is a bit confusing, as one could 
expect it to point to a neighboring bridge from DU...), so I'll switch 
to that.

  Tomi

